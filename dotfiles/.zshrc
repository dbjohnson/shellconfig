ZSH_THEME="ys"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
setopt no_share_history
unsetopt inc_append_history
unsetopt share_history
plugins=(git brew python pip)

export EDITOR=vim
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"

# opencode
export PATH=/Users/bryan/.opencode/bin:$PATH

# Disable virtualenv indicator in prompt
export PROMPT=${PROMPT/\$\(virtenv_prompt\)/}
