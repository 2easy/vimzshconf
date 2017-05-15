export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git docker)

# User configuration
export PATH="${HOME}/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11R6/bin"

export PATH="${HOME}/Library/Python/2.7/bin:${PATH}"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Node environment
export NODE_ENV="development"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

alias imgcat="~/.imgcat.sh"
alias docker-bash='docker-compose run --rm dev bash -l'
alias devmen="adb shell input keyevent 82"
sp() { echo -e "\033]50;SetProfile=$1\a" }
fpath=(/usr/local/share/zsh-completions $fpath)

unsetopt share_history
