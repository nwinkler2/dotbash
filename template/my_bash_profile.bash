#!/bin/bash

## Shell and OS check

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

if [[ "$OSTYPE" == "darwin10.0" ]]
then
    export OS="mac"
    export GVIM="open -a MacVim"
elif [[ "$OSTYPE" == "linux-gnu" ]]
then
    export OS="linux"
    export GVIM="gvim"
else
    echo "Don't know what to do with '$OSTYPE' operating system"
    exit 1
fi

## Vim

# Set my editor and git editor
if [[ "$OS" == "mac" ]]
then
    # brew install --head macvim
    # cp -r /usr/local/Cellar/macvim/HEAD/MacVim.app /Applications/
    ## 1. Using MacVim makes copy/paste work from within Terminal
    ## 2. Using compiled MacVim enables ruby, python Vim-scripting
    export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim'
else
    export EDITOR='vim'
fi

## Python
export VIRTUALENV_USE_DISTRIBUTE=1
export WORKON_HOME="$HOME/local/virtualenvs"
mkdir -p $WORKON_HOME
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"

## Ruby
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
export PATH=$HOME/.gem/ruby/1.8/bin:$PATH

## Bash

# Path to the bash it configuration
export BASH=$HOME/code/dotbash

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_THEME='my'

## Git

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@github.com:swaroopch'

## System

if [[ "$OS" == "mac" ]]
then
    # brew doctor
    # http://mxcl.github.com/homebrew/
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

export PATH="$HOME/bin:$PATH"

# Don't check mail when opening terminal.
unset MAILCHECK

## Get Everything

# Load Bash It
if [[ "$TERM" != "dumb" ]] # To prevent tput errors when someone scps to this box
then
    source $BASH/bash_it.sh
fi

## Cleanup

unset OS
