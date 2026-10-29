# A function, not an abbr: the command line keeps `ls` instead of expanding
function ls --wraps eza --description 'eza, directories first'
    command eza --group-directories-first --icons=auto $argv
end
