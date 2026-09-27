ZSH_THEME="ys"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
setopt no_share_history
unsetopt inc_append_history
unsetopt share_history
plugins=(git python pip)
[[ "$OSTYPE" == darwin* ]] && plugins+=(brew)

export EDITOR=vim
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile
[[ "$OSTYPE" == darwin* ]] && export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# opencode
[ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"

# Disable virtualenv indicator in prompt
export PROMPT=${PROMPT/\$\(virtenv_prompt\)/}

# move unsightly completion files
export ZSH_COMPDUMP=${ZSH_COMPDUMP/${HOME}/${HOME}\/.cache}

[ -f ~/.venv/bin/activate ] && source ~/.venv/bin/activate

# pnpm
if [[ "$OSTYPE" == darwin* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
[ -d "$BUN_INSTALL/bin" ] && export PATH="$BUN_INSTALL/bin:$PATH"

# user-local bin + mise (claude, etc.)
export PATH="$HOME/.local/bin:$PATH"
command -v mise >/dev/null && eval "$(mise activate zsh)"
