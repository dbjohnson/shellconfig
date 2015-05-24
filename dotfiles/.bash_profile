export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias grep="grep --color"
alias rm="rm -f"
alias ls="ls -lah"
alias find="find 2>/dev/null"
alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gis="git status"
alias gid="git diff"
alias gic="git commit -am"
alias gip="git push"

export PATH=~/anaconda/bin:$PATH

# added by Anaconda 2.1.0 installer
export PATH="/Users/bryan/anaconda/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PYTHONSTARTUP="$HOME/.pythonrc"

source $HOME/.credentials
