export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias grep="grep --color"
alias rm="rm -f"
alias ls="ls -lah"
alias find="find 2>/dev/null"
alias vi="vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias weather="curl http://wttr.in/ann%20arbor"
alias moon="curl http://wttr.in/moon"
alias fortune="fortune|ponysay"

function random {
	openssl rand -base64 $1
}

# git
alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gis="git status"
alias gid="git diff --ignore-space-change"
alias gic="git commit -am"
alias gicu="git reset HEAD^"
alias gipo="git checkout master; git pull origin master"
alias gilog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"  --all --decorate' #--oneline '

alias docker-reset="docker-machine rm -f default; docker-machine create --driver virtualbox default; eval $(docker-machine env default)"

# kubernetes
alias kubelist="kubectl get po -L app -L worker -L role"
alias kubecurl="kubectl exec curlpod -- curl"

function kubekill {
	kubectl delete deployments,po,rc -l app="$1"
}

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

export PATH="/usr/local/bin:$PATH"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon scipy
