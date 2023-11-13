ZSH_THEME="ys"
#ZSH_THEME="miloshadzic"
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

# bun completions
[ -s "/Users/bryan/.bun/_bun" ] && source "/Users/bryan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
