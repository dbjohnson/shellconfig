#ZSH_THEME="kolo"
ZSH_THEME="ys"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
setopt no_share_history
unsetopt inc_append_history
unsetopt share_history
plugins=(git, brew, python, pip)

export EDITOR=vim
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

# function that cd's into a directory and then immediately prints the contents of that directory
function cs(){
    cd $1 && ls
}

lfp() {  # look for process
    ps aux | grep -v grep | grep $1
}

kp() { # kill process
    kill $(ps aux | grep '$1' | awk '{print $2}')
}

# bind keys for ctrl up/down/left to up/back/forward in directories
alias ↩="pushd -q +1"
alias ↪="pushd -q -1"
alias ↑\="cd .."
bindkey -s '^u' "↑\n"
bindkey -s '^b' "↩\n"
bindkey -s '^f' "↪\n"
alias u="cd .."
