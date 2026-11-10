// Selects macOS input sources on request from kanata. kanata runs as root and
// can't switch the user's input source, so its config sends the source ID with
// push-msg; this agent runs in the user session, listens on kanata's TCP
// server and selects that source in-process (no process spawn per keypress).
// Built and started by run_onchange_after_install-kanata.sh.tmpl.

import Carbon
import Foundation

let port: UInt16 = 5829

func select(_ id: String) {
    let filter = [kTISPropertyInputSourceID as String: id] as CFDictionary
    guard let list = TISCreateInputSourceList(filter, false)?.takeRetainedValue() as? [TISInputSource],
        let source = list.first
    else {
        FileHandle.standardError.write("unknown input source \(id)\n".data(using: .utf8)!)
        return
    }
    TISSelectInputSource(source)
}

func connectToKanata() -> Int32? {
    let fd = socket(AF_INET, SOCK_STREAM, 0)
    guard fd >= 0 else { return nil }
    var addr = sockaddr_in()
    addr.sin_family = sa_family_t(AF_INET)
    addr.sin_port = port.bigEndian
    addr.sin_addr.s_addr = inet_addr("127.0.0.1")
    let ok = withUnsafePointer(to: &addr) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            connect(fd, $0, socklen_t(MemoryLayout<sockaddr_in>.size))
        }
    }
    if ok != 0 {
        close(fd)
        return nil
    }
    return fd
}

// Handles one newline-terminated JSON message. kanata sends a push-msg atom
// as a one-element list: {"MessagePush":{"message":["com.apple.keylayout.ABC"]}}
func handle(_ line: Data) {
    guard let json = try? JSONSerialization.jsonObject(with: line) as? [String: Any],
        let push = json["MessagePush"] as? [String: Any],
        let id = (push["message"] as? [String])?.first ?? push["message"] as? String
    else { return }
    DispatchQueue.main.async { select(id) }
}

Thread.detachNewThread {
    while true {
        // kanata restarts with launchd; keep retrying
        guard let fd = connectToKanata() else {
            sleep(1)
            continue
        }
        var buffer = Data()
        var chunk = [UInt8](repeating: 0, count: 4096)
        while true {
            let n = read(fd, &chunk, chunk.count)
            if n <= 0 { break }
            buffer.append(contentsOf: chunk[0..<n])
            while let newline = buffer.firstIndex(of: UInt8(ascii: "\n")) {
                handle(buffer[buffer.startIndex..<newline])
                buffer.removeSubrange(buffer.startIndex...newline)
            }
        }
        close(fd)
        sleep(1)
    }
}

RunLoop.main.run()
