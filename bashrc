
case $- in
  *i*) stty -ixon ;; # make ctrl-s work for i-search, instead of suspendeing the terminal
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
HISTCONTROL=ignorespace
SAVEHIST=10000

clear () { printf '[H[2J'; }

# General aliases
alias ls='ls --color=auto'
alias la='ls -lAph --color=auto'
alias ll='ls -ghSX --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias c='clear'
alias df='df -h'

alias ?='ddg'

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
# Search and Install packages from AUR with yay
alias aurins='yay'
# Update the system with AUR packages
alias aurupg='yay -Syyu'

command -v vim &>/dev/null && alias vi=vim

alias iotop='sudo iotop -oPa'
alias iftop='sudo iftop -i enp3s0'
alias nethogs='sudo nethogs enp3s0'

# Mutt aliases
alias mbsync='mbsync -c "$HOME/.mutt/isync/mbsyncrc" -a'
alias mutt='mutt -F $HOME/.mutt/muttrc'

export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

export REPOS="$HOME/repos"
export SCRIPTS="$REPOS/dotfiles/scripts"
export KN="$REPOS" # Knowledge Node repo

# Golang paths
export GOPRIVATE="github.com/$GITUSER/*"
export GOPATH="$HOME/.local/go"
export GOBIN="$HOME/.local/go/bin"
export GOPROXY="direct"
export CGO_ENABELD=0

# C Flags
export CFLAGS="-Wall -Wextra -Werror"

# Default programs
export EDITOR="vi"
export VISUAL="vi"
export EDITOR_PREFIX="vi"
export TERMINAL="alacritty"
export BROWSER="brave-browser"
export READER="less"

export GITUSER="$(git config --global user.name)"

# Clean up $HOME
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"

source "$HOME/.passenv"

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

  #/home/dennis/.config/coc/extensions/coc-clangd-data/install/12.0.0/clangd_12.0.0/bin \
pathappend \
  $HOME/.local/bin \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/local/go/bin \
  /usr/games \
  /usr/sbin \
  /usr/bin \
  /sbin \
  /bin

# be sure not to remove ./ in CDPATH or stuff gets weird
export CDPATH=./:\
$REPOS:\
$REPOS/dotfiles:\
$HOME/programming:\
$HOME

# Colors and escapes
escape=$'\[\]'
reset=$'\[[0m\]'
bold=$'\[[1m\]'
underline=$'\[[4m\]'
blinkon=$'\[[5m\]'
blinkoff=$'\[[25m\]'
inverse=$'\[[7m\]'
inverseoff=$'\[[27m\]'
normal=$'\[[39m\]'
normalbg=$'\[[49m\]'

black=$'\[\e[30m\]'
red=$'\[[31m\]'
yellow=$'\[[33m\]'
blue=$'\[[34m\]'
magenta=$'\[[35m\]'
cyan=$'\[[36m\]'
white=$'\[[37m\]'

brblack=$'\[[90m\]'
brred=$'\[[91m\]'
brgreen=$'\[[92m\]'
bryellow=$'\[[93m\]'
brblue=$'\[[94m\]'
brmagenta=$'\[[95m\]'
brcyan=$'\[[96m\]'
brwhite=$'\[[97m\]'

# Colored man pages
less_reset=$'[0m'
less_magenta=$'[35m'
less_yellow=$'[33m'
less_blue=$'[34m'

export LESS_TERMCAP_mb=$less_magenta # $magenta
export LESS_TERMCAP_md=$less_yellow # $yellow
export LESS_TERMCAP_me=$less_reset # $reset
export LESS_TERMCAP_se=$less_reset # $reset
export LESS_TERMCAP_so=$less_blue # $blue
export LESS_TERMCAP_ue=$less_reset # $reset
export LESS_TERMCAP_us=''

export KEYTIMEOUT=1

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

complete -C tmr tmr
complete -C zet zet
complete -C tgo tgo
complete -C ? ?
complete -C tslive tslive
complete -C tsl tsl
complete -C pomo pomo
complete -C vpn vpn

# eval "$(dircolors -b)"
type dircolors &>/dev/null && . <(dircolors -b)
type gh &>/dev/null && . <(gh completion -s bash)
type pandoc &>/dev/null && . <(pandoc --bash-completion)
type yq &>/dev/null && . <(yq shell-completion bash)

# Set promt
source "$HOME/.git-prompt.sh"
function my_prompt() {
  local tNum="$(task status:pending count)"
  export PS1=" ${yellow}$tNum${reset} $(task_indicator) ${cyan}\W${red}$(__git_ps1 ':%s')${yellow} \$ ${reset}"
#   export PS1=" ${cyan}\W${red}$(__git_ps1 ':%s') ${yellow}\$${reset} "
}

export PROMPT_COMMAND="my_prompt"
