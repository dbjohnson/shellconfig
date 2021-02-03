ZSH_THEME="ys"
#ZSH_THEME="miloshadzic"
ENABLE_CORRECTION="false"
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi
