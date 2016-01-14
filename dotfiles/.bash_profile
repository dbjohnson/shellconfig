export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias grep="grep --color"
alias rm="rm -f"
alias ls="ls -lah"
alias find="find 2>/dev/null"
alias vi="vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias ipython="ipython --colors=linux"


alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gis="git status"
alias gid="git diff --ignore-space-change"
alias gic="git commit -am"
alias gicu="git reset HEAD^"
alias gipo="git checkout master; git pull origin master"
alias gilog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"  --all --decorate' #--oneline '


export PYTHONSTARTUP="$HOME/.pythonrc"
source $HOME/.credentials

# added by Anaconda 2.1.0 installer
#export PATH="/Users/bryan/anaconda/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

export REX_APSIM_WORKDIR=/Users/bryan/Desktop/rex
eval "$(docker-machine env default)"

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
#source /Users/bryan/anaconda/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper.sh
workon scipy
