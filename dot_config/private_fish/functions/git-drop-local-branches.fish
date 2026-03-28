function git-drop-local-branches --wraps=git\ branch\ --merged\ \|\ grep\ -v\ \\\*\ \|\ xargs\ git\ branch\ -D --description alias\ git-drop-local-branches=git\ branch\ --merged\ \|\ grep\ -v\ \\\*\ \|\ xargs\ git\ branch\ -D
  git branch --merged | grep -v \* | xargs git branch -D $argv; 
end
