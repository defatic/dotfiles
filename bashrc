#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set VI mode in bash
set -o vi

# History settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000

# eval commands
eval $(dircolors -b)

# General aliases
alias ls="ls --color=auto"
alias la="ls --color=auto -lAh"
alias ll="ls --color=auto -gSX"
alias l1="ls -1 --color=auto"
alias grep="egrep --color=auto"
alias egrep="egrep --color=auto"
alias vi="vim"
alias c="clear"
alias ca="c ; archey_clone.py ; task"
alias eb="vi ~/.bashrc"

alias iotop="sudo iotop -oPa"
alias iftop="sudo iftop -i enp3s0"
alias nethogs="sudo nethogs enp3s0"

# Mount aliases
alias musb="sudo mount /dev/sde1 /mnt/usb/"
alias umusb="sudo umount /mnt/usb/"
alias mypass="sudo mount -t ntfs-3g /dev/sdd1 /mnt/myPassport -o force"

# Pacman aliases
# Remove Orphin packages
alias pacro="pacman -Qtdq > /dev/null ; sudo pacman -Rns $(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g') && notify-send 'Done!' 'Done with removing orphan packages.'"
# Update the system
alias pacupg="sudo pacman -Syyu ; notify-send 'Update Done!' 'Done with updating the system with official packages.'"
# Install packages
alias pacins="sudo pacman -S"
# Remove (uninstall) packages, configurationfiles and dependencies
alias pacrem="sudo pacman -Rnus"
# Clear Cache of not installed packages
alias pacclear="sudo pacman -Sc ; notify-send 'Done!' 'The packages Cache has been cleared.'"
alias paccc="sudo paccache -ruk0 ; pacclear"

# Pacman AUR aliases
# Install packages from AUR
alias aurins="pacaur -S"
# Update the system with AUR packages
alias aurupg="pacaur -Syyu && notify-send 'Update Done!' 'Done with updating the system with AUR packages.'"
# Search for packages Official and in the AUR
alias pacsea="pacaur -Ss"
# Search the local database for a named package
alias paclsea="pacman -Qs"

# Git aliases
alias fullclean="make clean && rm -f config.h && git reset --hard origin/master"

# Fun stuff
alias weather="curl wttr.in/kallhall"
getip() { curl ifconfig.me; printf "\n" ;}

# Check sshd
alias check_sshd="journalctl -xe | egrep -i sshd"

# Kill jackd so I can get sound again
alias kjackd="ps ax | grep jackd | grep -v grep | awk '{print $1}' | xargs -n1 kill -9"

# Add $HOME/bin to $PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:${PATH}"
export MANPATH="/usr/local/man:$MANPATH"

export REPOS="$HOME/repos"

# Default programs
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="less"

# Clean up $HOME
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"

export KEYTIMEOUT=1

# Format for the time command
export TIMEFMT=$'\n%U\tuser\n%S\tsystem\n\n%P cpu %*E total'

# nnn file manager options
export NNN_OPTS='edHx'

# task promt function
task_indicator() {
  TASK="task"
  if [[ `$TASK +READY +OVERDUE count` -gt '0' ]]; then
    echo "O!"
    # notify-send -u critical 'Overdue!' 'You have Overdue tasks.'
  elif [[ `$TASK +READY +DUETODAY count` -gt '0' ]]; then
    echo "!"
    # notify-send -u normal 'Due Today!' 'You have tasks due today.'
  elif [[ `$TASK +READY +TOMORROW count` -gt '0' ]]; then
    echo "¡"
  elif [[ `$TASK +READY urgency -gt 10 count` -gt '0' ]]; then
    echo "U!"
  else
    echo '#'
  fi
}

# Set promt
PS1=" $(task_indicator) \W $ "

if [ -r /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

archey_clone.py

# Transmission CLI functions
alias tmrstart=" transmission-daemon -c ~/downloads/dotTorrents ; notify-send 'Transmission Server' 'Transmission deamon started!'"
tmrlst() {  transmission-remote -l ;}
tmradd() {  transmission-remote -a "$1" ;}
tmrrem() {  transmission-remote -t "$1" -r ;}
tmrsta() {  transmission-remote -t "$1" --start ;}
tmrsto() {  transmission-remote -t "$1" --stop ;}
tmrcli() {  transmission-remote-cli ;}
tmrkill() {  sudo pkill transmission-da ;}

# Streamlink Functions
sl() { streamlink -p vlc "$1" best ;}
