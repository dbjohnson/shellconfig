export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias grep="grep --color"
alias rm="rm -f"
alias ls="ls -lah"
alias find="find 2>/dev/null"
alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

export PATH=~/anaconda/bin:$PATH

# added by Anaconda 2.1.0 installer
export PATH="/Users/bryan/anaconda/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PYTHONSTARTUP="$HOME/.pythonrc"

#export FL_API_DB="postgres://u42qdjlonkh9i8:pd2846voprk99hbbq3k7kak6u2l@ec2-54-221-248-187.compute-1.amazonaws.com:5652/dcf881lel4nsr7"
export FL_API_DB="postgres://u8ckfgtbl9bkb3:p7m9c2i949i0c5bn08lo022sek1@ec2-184-73-251-166.compute-1.amazonaws.com:5822/dcf881lel4nsr7"
export ISO_DB="postgres://x1gxa8ofrjcbmqaa:jeajtpox7gtfkgaa@stage-iso-data.czas5cnicq66.us-east-1.rds.amazonaws.com:5432/iso_data"
