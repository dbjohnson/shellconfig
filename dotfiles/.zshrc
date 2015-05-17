#ZSH_THEME="kolo"
ZSH_THEME="ys"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
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
    local ps_name=$1
    ps aux | grep -v grep | grep $ps_name
}


# bind keys for ctrl up/down/left to up/back/forward in directories
alias ↩="pushd -q +1"
alias ↪="pushd -q -1"
alias ↑\="cd .."
bindkey -s '^u' "↑\n"
bindkey -s '^b' "↩\n"
bindkey -s '^f' "↪\n"
alias u="cd .."
