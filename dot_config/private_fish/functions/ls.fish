# A function, not an abbr: the command line keeps `ls` instead of expanding
function ls --wraps eza --description 'eza, directories first'
    set -l flags
    # OSC 8 links (cmd+click in Ghostty). eza's --hyperlink=auto doesn't
    # detect Ghostty or herdr, and `always` would leak escapes into pipes.
    isatty stdout; and set flags --hyperlink=always
    command eza --group-directories-first --icons=auto $flags $argv
end
