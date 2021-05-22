# Startx X server on login on TTY 1
[[ -z $DISPLAY && "$XDG_VTNR" -eq 1 ]] && exec startx

if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
  fi
fi
