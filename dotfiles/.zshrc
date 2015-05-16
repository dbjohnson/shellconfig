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

look_for_process() {
    local ps_name=$1
    ps aux | grep -v grep | grep $ps_name
}

alias lfp='look_for_process'
#RPROMPT='[%D{%L:%M:%S %p}]'
