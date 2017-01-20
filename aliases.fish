alias rcat='find . -type f -exec cat \{\} \;'

function hubpr
  if git rev-parse --abbrev-ref HEAD | grep master
    echo YOURE ON MASTER YOU IDIOT. NOT PUSHING.
  else
    git push origin (git rev-parse --abbrev-ref HEAD); and hub pull-request -m (git log -1 --pretty=%B) | tail -n 1 | xargs open
  end
end


###### Sublime alias
alias sublime=/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl

###### Pants convenience alias
alias pants=./pants

###### git utilities
alias gtheirs='git checkout --theirs'
alias gours='git checkout --ours'
alias recbranch='git for-each-ref --sort=-committerdate --format="%(refname:short)" refs/heads/'

alias finame='find . -iname'
alias gs='git status'
alias ga='git add -u'
alias gc='git commit -m'
alias gca='git commit --amend -m (git log -1 --pretty=%B)'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gsh='git stash'
alias gshp='git stash pop'
alias grs='git review submit -C (git log --author mbileschi --format=format:%H | head -1)'
function gconb
  git checkout -b "mbileschi/$argv[1]"
end
function gpo
  if git rev-parse --abbrev-ref HEAD | grep master
    echo YOURE ON MASTER YOU IDIOT. NOT PUSHING.
  else
    git push -f origin (git rev-parse --abbrev-ref HEAD)
  end
end
alias gitall='git add -u; and and git commit -m \fixup\; and git rebase -i master'
alias gcl='git checkout master; and git pull; and git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias intellij='open -a /Applications/IntelliJ\ IDEA\ 15.app'
alias ij='intellij'
alias fd='find . | grep'

[ -f /opt/twitter/share/autojump/autojump.fish ]; and . /opt/twitter/share/autojump/autojump.fish