# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Lines configured by zsh-newuser-install
HISTFILE="$HOME/.histfile"
HISTSIZE=1000
SAVEHIST=2000

bindkey -v
export KEYTIMEOUT=1

autoload -U colors && colors

# Set some termial colors
red='\033[0;31m'
green='\033[0;32m'
orange='\033[0;33m'
cyan='\033[0;36m'
resetc='\033[0m'

zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

task_indicator() {
  TASK="task"
  if [[ `$TASK +READY +OVERDUE count` -gt '0' ]]; then
    echo -e "${red}O!${resetc}"
    # notify-send -u critical 'Overdue!' 'You have Overdue tasks.'
  elif [[ `$TASK +READY +DUETODAY count` -gt '0' ]]; then
    echo -e "${green}!${resetc}"
    # notify-send -u normal 'Due Today!' 'You have tasks due today.'
  elif [[ `$TASK +READY +TOMORROW count` -gt '0' ]]; then
    echo -e "${orange}¡${resetc}"
  elif [[ `$TASK +READY urgency -gt 10 count` -gt '0' ]]; then
    echo -e "${red}U!${resetc}"
  else
    echo -e '#'
  fi
}

# Set prompt
# PS1=" $(task_indicator) ${cyan}\W${resetc} ${orange}\$${resetc} "
PROMPT='$ '
