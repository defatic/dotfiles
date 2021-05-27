#!/usr/bin/bash

[[ $- != *i* ]] && return

# first whatever the system has (required for completion, etc.)
if [ -e /etc/bashrc ]; then
  source /etc/bashrc
fi

# Set VI mode in bash
set -o vi

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

# Set some termial colors
red='\033[0;31m'
green='\033[0;32m'
orange='\033[0;33m'
cyan='\033[0;36m'
resetc='\033[0m'

# History settings
HISTFILE="$HOME/.cache/bash/histfile"
HISTSIZE=10000
SAVEHIST=10000

# General aliases
alias ls="ls --color=auto"
alias la="ls -lAh --color=auto"
alias ll="ls -ghSX --color=auto"
alias ..="cd .."
alias c="clear"
alias eb="vim $HOME/.bashrc"

which vim $>/dev/null && alias vi=vim

alias iotop="sudo iotop -oPa"
alias iftop="sudo iftop -i enp3s0"
alias nethogs="sudo nethogs enp3s0"

alias apt="sudo apt"

## Pacman aliases
## Update the system
#alias pacupg="sudo pacman -Syyu && notify-send 'Update Done!' 'Done with updating the system with official packages.'"
## Install packages
#alias pacins="sudo pacman -S"
## Remove (uninstall) packages, configurationfiles and dependencies
#alias pacrem="sudo pacman -Rnus"
## Remove Orphin packages
#alias pacro="pacman -Qtdq > /dev/null ; sudo pacman -Rns $(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g') && notify-send 'Done!' 'Done with removing orphan packages.'"
## Clear Cache of not installed packages
#alias pacclear="sudo pacman -Sc && notify-send 'Done!' 'The packages Cache has been cleared.'"
#alias paccc="sudo paccache -ruk0 && pacclear"
## Search the local database for a named package
#alias paclsea="pacman -Qs"
#
## Pacman AUR aliases
## Install packages from AUR
#alias aurins="pacaur -S"
## Update the system with AUR packages
#alias aurupg="pacaur -Syyu && notify-send 'Update Done!' 'Done with updating the system with AUR packages.'"
## Search for packages Official and in the AUR
#alias pacsea="pacaur -Ss"

# Git aliases
alias fullclean="make clean && git reset --hard origin/master"

# Check sshd
alias check_sshd="journalctl -xe | egrep -i sshd"

export REPOS="$HOME/repos"
export KN="$REPOS" # Knowledge Node repo

# be sure NOT to add ./ in PATH cuz it's unsafe
export PATH=\
/usr/local/bin:\
$HOME/bin:\
$HOME/.local/bin:\
$REPOS/dotfiles/scripts:\
$PATH

# be sure not to remove ./ in CDPATH or stuff gets weird
export CDPATH=\
./:\
$REPOS:\
$HOME

# Default programs
export EDITOR="vim"
export VISUAL="vim"
export EDITOR_PREFIX="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="less"

export GITUSER="$(git config --global user.name)"

# Clean up $HOME
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"

# Colors
export escape=$'\033'
export reset=$'\033[0m'
export bold=$'\033[1m'
export underline=$'\033[4m'
export blinkon=$'\033[5m'
export blinkoff=$'\033[25m'
export inverse=$'\033[7m'
export inverseoff=$'\033[27m'
export normal=$'\033[39m'
export normalbg=$'\033[49m'

export black=$'\033[30m'
export red=$'\033[31m'
export green=$'\033[32m'
export yellow=$'\033[33m'
export blue=$'\033[34m'
export magenta=$'\033[35m'
export cyan=$'\033[36m'
export white=$'\033[37m'

export brblack=$'\033[90m'   # brblack
export brred=$'\033[91m'     # brred
export brgreen=$'\033[92m'   # brgreen
export bryellow=$'\033[93m'  # bryellow
export brblue=$'\033[94m'    # brblue
export brmagenta=$'\033[95m' # brmagenta
export brcyan=$'\033[96m'    # brcyan
export brwhite=$'\033[97m'   # brwhite

export clear=$'\033[H\033[2J'
clear () { echo -n $clear; }

# Here's your colored man pages right here.
export LESS_TERMCAP_mb=$magenta
export LESS_TERMCAP_md=$yellow
export LESS_TERMCAP_me=$reset
export LESS_TERMCAP_se=$reset
export LESS_TERMCAP_so=$blue
export LESS_TERMCAP_ue=$reset
export LESS_TERMCAP_us=""

# Golang paths
export GOPRIVATE="github.com/$GITUSER/*"
export GOPATH="$HOME/.local/go"
export GOBIN="$HOME/.local/go/bin"
export GOPROXY="direct"
export CGO_ENABELD=0

export KEYTIMEOUT=1

# Format for the time command
export TIMEFMT=$'\n%U\tuser\n%S\tsystem\n\n%P cpu %*E total'

# task promt function
task_indicator() {
  TASK="task"
  if [[ $($TASK +READY +OVERDUE count) -gt '0' ]]; then
    echo -e "${red}O!${resetc}"
    # notify-send -u critical "Overdue!" "You have Overdue tasks."
  elif [[ $($TASK +READY +DUETODAY count) -gt '0' ]]; then
    echo -e "${green}!${resetc}"
    # notify-send -u normal "Due Today!" "You have tasks due today."
  elif [[ $($TASK +READY +TOMORROW count) -gt '0' ]]; then
    echo -e "${orange}¡${resetc}"
  elif [[ $($TASK +READY urgency -gt 10 count) -gt '0' ]]; then
    echo -e "${red}U!${resetc}"
  else
    echo -e '#'
  fi
}

# Tab completion stuff in bash
if [ -r /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# eval commands
eval "$(dircolors -b)"
eval "$(gh completion -s bash)" # Bash completion for the gh command (github cli)

# Set promt
function my_prompt() {
  source "$HOME/.git-prompt.sh"
  #local tNum="$(task list | tail -1 | sed 's/ [a-z]\+//')"
  local tNum="$(task status:pending count)"
  export PS1=" ${orange}$tNum${resetc} $(task_indicator) ${cyan}\W${resetc}${red}$(__git_ps1 ':%s')${resetc} ${orange}\$${resetc} "
}
export PROMPT_COMMAND="my_prompt"

# better which command
#which() { (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions "$@"; }
