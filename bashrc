
case $- in
  *i*) ;;
  *) return ;;
esac

set -o vi
set -o noclobber

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s histappend
shopt -s nocaseglob

# History settings
HISTFILE="$HOME/.cache/bash/histfile"
HISTSIZE=10000
SAVEHIST=10000

# clear () { printf '[H[2J'; }

# General aliases
alias ls='ls --color=auto'
alias la='ls -lAh --color=auto'
alias ll='ls -ghSX --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias c='clear'
alias eb='vim $HOME/.bashrc'

command -v vim &>/dev/null && alias vi=vim

alias iotop='sudo iotop -oPa'
alias iftop='sudo iftop -i enp3s0'
alias nethogs='sudo nethogs enp3s0'

# Mutt aliases
alias mbsync='mbsync -c "$HOME/.mutt/isync/mbsyncrc" -a'
alias mutt='mutt -F $HOME/.mutt/muttrc'

export REPOS="$HOME/repos"
export SCRIPTS="$REPOS/dotfiles/scripts"
export KN="$REPOS" # Knowledge Node repo

# Golang paths
export GOPRIVATE="github.com/$GITUSER/*"
export GOPATH="$HOME/.local/go"
export GOBIN="$HOME/.local/go/bin"
export GOPROXY="direct"
export CGO_ENABELD=0

# Default programs
export EDITOR="vi"
export VISUAL="vi"
export EDITOR_PREFIX="vi"
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

# Path
pathappend() {
  for arg in "$@"; do
    test -d "${arg}" || continue
    PATH=${PATH//:${arg}:/:}
    PATH=${PATH/#${arg}:/}
    PATH=${PATH/%:${arg}/}
    export PATH="${PATH:+"${PATH}:"}${arg}"
  done
}

pathprepend() {
  for arg in "$@"; do
    test -d "${arg}" || continue
    PATH=${PATH//:${arg}:/:}
    PATH=${PATH/#${arg}:/}
    PATH=${PATH/%:${arg}/}
    export PATH="${arg}${PATH:+":${PATH}"}"
  done
}

# be sure NOT to add ./ in PATH cuz it's unsafe
# Last arg will be first in path
# pathprepend \

pathappend \
  $HOME/.local/bin \
  /home/dennis/.config/coc/extensions/coc-clangd-data/install/12.0.0/clangd_12.0.0/bin \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/games \
  /usr/sbin \
  /usr/bin \
  /snap/bin \
  /sbin \
  /bin

# be sure not to remove ./ in CDPATH or stuff gets weird
export CDPATH=./:\
$REPOS:\
$REPOS/dotfiles:\
$HOME

# Colors and escapes
escape=$'\e'
reset=$'\e[0m'
bold=$'\e[1m'
underline=$'\e[4m'
blinkon=$'\e[5m'
blinkoff=$'\e[25m'
inverse=$'\e[7m'
inverseoff=$'\e[27m'
normal=$'\e[39m'
normalbg=$'\e[49m'

black=$'\e[30m'
red=$'\e[31m'
green=$'\e[32m'
yellow=$'\e[33m'
blue=$'\e[34m'
magenta=$'\e[35m'
cyan=$'\e[36m'
white=$'\e[37m'

brblack=$'\e[90m'
brred=$'\e[91m'
brgreen=$'\e[92m'
bryellow=$'\e[93m'
brblue=$'\e[94m'
brmagenta=$'\e[95m'
brcyan=$'\e[96m'
brwhite=$'\e[97m'

# Colored man pages
export LESS_TERMCAP_mb=$magenta
export LESS_TERMCAP_md=$yellow
export LESS_TERMCAP_me=$reset
export LESS_TERMCAP_se=$reset
export LESS_TERMCAP_so=$blue
export LESS_TERMCAP_ue=$reset
export LESS_TERMCAP_us=""

export KEYTIMEOUT=1

# Values for shader caching for use in gaming.
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH='/tmp/nvidia-shaders'
export __GL_THREADED_OPTIMIZATION=1

# Format for the time command
export TIMEFMT=$'\n%U\tuser\n%S\tsystem\n\n%P cpu %*E total'

# Task promt
task_indicator() {
  TASK="task"
  if [[ $($TASK +READY +OVERDUE count) -gt '0' ]]; then
    echo -e "${red}O!${reset}"
    # notify-send -u critical "Overdue!" "You have Overdue tasks."
  elif [[ $($TASK +READY +DUETODAY count) -gt '0' ]]; then
    echo -e "${green}!${reset}"
    # notify-send -u normal "Due Today!" "You have tasks due today."
  elif [[ $($TASK +READY +TOMORROW count) -gt '0' ]]; then
    echo -e "${yellow}¡${reset}"
  elif [[ $($TASK +READY urgency -gt 10 count) -gt '0' ]]; then
    echo -e "${red}U!${reset}"
  else
    echo -e '#'
  fi
}

# Tab completion stuff in bash
if test -r /usr/share/bash-completion/bash_completion; then
  . /usr/share/bash-completion/bash_completion
fi

# eval "$(dircolors -b)"
type dircolors &>/dev/null && . <(dircolors -b)
type gh &>/dev/null && . <(gh completion -s bash)
type pandoc &>/dev/null && . <(pandoc --bash-completion)
# type yq &>/dev/null && . <(yq shell-completion bash)

# Set promt
source "$HOME/.git-prompt.sh"
function my_prompt() {
  local tNum="$(task status:pending count)"
  export PS1=" ${yellow}$tNum${reset} $(task_indicator) ${cyan}\W${red}$(__git_ps1 ':%s') ${yellow}\$${reset} "
}

export PROMPT_COMMAND="my_prompt"

# Pacman aliases
# Update the system
alias pacupg='sudo pacman -Syyu'
# Install packages
alias pacins='sudo pacman -S'
# Remove (uninstall) packages, configurationfiles and dependencies
alias pacrem='sudo pacman -Rnus'
# Remove Orphin packages
alias pacro='pacman -Qtdq > /dev/null ; sudo pacman -Rns $(pacman -Qtdq | sed -e ":a;N;$!ba;s/ / /g")'
# Clear Cache of not installed packages
alias pacclear='sudo pacman -Sc'
alias paccc="sudo paccache -ruk0 && pacclear"
# Search the local database for a named package
alias paclsea='pacman -Qs'

# Pacman AUR aliases
# Install packages from AUR
alias aurins='yay'
# Update the system with AUR packages
alias aurupg='yay -Syyu'
# Search for packages Official and in the AUR
# alias pacsea='pacaur -Ss'
