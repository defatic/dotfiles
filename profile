if test -n "$BASH_VERSION"; then
  if test -f "$HOME/.bashrc"; then
    . "$HOME/.bashrc"
  fi
fi

# [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && exec startx
if test -z "$DISPLAY"; then
    if test "$XDG_VTNR" -eq 1; then
        exec start-hyprland
        # exec startx
    fi
fi
