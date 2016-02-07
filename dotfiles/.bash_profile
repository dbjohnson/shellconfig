export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias grep="grep --color"
alias rm="rm -f"
alias ls="ls -lah"
alias find="find 2>/dev/null"
alias vi="vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"


# git
alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gis="git status"
alias gid="git diff --ignore-space-change"
alias gic="git commit -am"
alias gicu="git reset HEAD^"
alias gipo="git checkout master; git pull origin master"
alias gilog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"  --all --decorate' #--oneline '

# kubernetes
alias kubelist="kubectl get po -L app -L worker -L role -l kubinator=true"
alias kubecurl="kubectl exec curlpod -- curl"

function kubepod {
    kubelist | grep "$1.*$2" | cut -f1 -d' '
}

function kubelogs {
    kubectl logs -f $(kubepod $1 $2)
}

function kubeconfig {
    kubectl get po $(kubepod $1 $2) -o yaml
}

# convenience funcs
function cs(){
    cd $1 && ls
}

lfp() {  # look for process
    ps aux | grep -v grep | grep $1
}

kp() { # kill process
	kill $(ps aux | grep -v grep | grep $1 | awk '{print $2}') 
}

# bind keys for ctrl up/down/left to up/back/forward in directories
alias ↩="pushd -q +1"
alias ↪="pushd -q -1"
alias ↑\="cd .."
bindkey -s '^u' "↑\n"
bindkey -s '^b' "↩\n"
bindkey -s '^f' "↪\n"
alias u="cd .."

# path, etc
export PYTHONSTARTUP="$HOME/.pythonrc"
source $HOME/.credentials

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon scipy
