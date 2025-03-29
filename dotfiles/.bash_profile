export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias python="python3"
alias ipython="python3 -m IPython"
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
alias dc="docker-compose"
alias ipy="screen -S ipython ipython"

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
	git pull origin `git rev-parse --abbrev-ref HEAD`
}

function push() {
	git push origin `git rev-parse --abbrev-ref HEAD`
}

# convenience funcs
function cs(){ 
    cd $1 && ls
}

lfp() {  # look for process
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

# path, etc
export PYTHONSTARTUP="$HOME/.pythonrc"
export PYTHONPATH=".:$PYTHONPATH"
export PATH=".:/usr/local/bin:$PATH"
export PATH="$PATH:/usr/local/spark/bin"
export PATH="$PATH:/Users/bryan/.cargo/bin"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_NO_AUTO_UPDATE=1;
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";


alias activate="source .VENV/bin/activate"

# local credentials
CREDSFILE=$HOME/.credentials
if [ -f $CREDSFILE ]
then
	source $CREDSFILE 
fi
