export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias python="uv run python"
alias ipython="uv run ipython"
alias ip="uv run ipython"
alias ips="screen -S ipython ipython"
alias pip="uv pip"
alias grep="grep --color"
alias rm="rm -f"
alias ls="ls -lah"
alias find="find 2>/dev/null"
alias vi="nvim"
alias vim="nvim -v"
alias diff="diff --side-by-side --suppress-common-lines --width=200"
alias weather="curl http://wttr.in/ann%20arbor"
alias moon="curl http://wttr.in/moon"
alias fortune="fortune|ponysay"
alias dc="docker compose"

function random {
  openssl rand -base64 $1
}

# git
function gipo {
  main=$(git branch | egrep -o "master|main")
  git checkout $main
  git pull origin $main
}

alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gis="git status"
alias gid="git diff --ignore-space-change"
alias gic="git commit -am"
alias gicu="git reset HEAD^"
alias gilog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"  --all --decorate' #--oneline '
alias gp="pull"
alias reset="git reset --hard @{upstream}"

# clear out all merged branches
alias gitpurge='git branch -D `git branch --merged | grep -v \* | xargs`'
# rebase preferring local changes
alias rebase='git rebase -X theirs'

function pull() {
  git pull origin $(git rev-parse --abbrev-ref HEAD)
}

function push() {
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

# convenience funcs
function cs() {
  cd $1 && ls
}

lfp() { # look for process
  ps aux | grep -v grep | grep $1
}

kp() { # kill process
  pid=$(lfp $1 | awk 'NR==1{print $2}')
  if [ ! -z "$pid" ]; then
    kill $pid
  fi
}

function ssh-send-key {
  pubkey=$1
  host=$2

  ssh $host 'test -d $HOME/.ssh || mkdir -m 0700 $HOME/.ssh && test -f $HOME/.ssh/authorized_keys || touch $HOME/.ssh/authorized_keys; chmod 600 $HOME/.ssh/authorized_keys && cat >>$HOME/.ssh/authorized_keys' <$pubkey
}

function socks-proxy-mini {
  # not sure why this hangs....
  timeout 30 ssh -t bryan@mini.local bash -lic vpnup
  ssh -D 8080 -fCqN bryan@mini.local
  networksetup -setsocksfirewallproxy "Wi-Fi" localhost 8080
}

function socks-open {
  socks-proxy-mini
}

function socks-close {
  networksetup -setsocksfirewallproxystate "Wi-Fi" off
  ssh -t bryan@mini.local bash -lic '"vpn -s disconnect"'
  kp "ssh -D 8080"
}

# path, etc
export PYTHONSTARTUP="$HOME/.pythonrc"
export PYTHONPATH=".:./src:$PYTHONPATH"
export PATH=".:/usr/local/bin:$PATH"
export PATH=".:/usr/.local/bin:$PATH"
export PATH="$PATH:/usr/local/spark/bin"
export PATH="$PATH:/Users/bryan/.cargo/bin"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export PATH="/Users/bryan/android-platform/${PATH+:$PATH}"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
# needed for weasyprint
# https://github.com/Kozea/WeasyPrint/issues/2427#issuecomment-2845051857
export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_FALLBACK_LIBRARY_PATH

alias activate="source .venv/bin/activate"

# local credentials
CREDSFILE=$HOME/.credentials
if [ -f $CREDSFILE ]; then
  source $CREDSFILE
fi

. "$HOME/.local/bin/env"

function conda-init {
  deactivate # deactivate current venv
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}
