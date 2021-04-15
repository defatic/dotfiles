[[ -z $DISPLAY && "$XDG_VTNR" -eq 1 ]] && exec startx

eval "$(gh completion -s bash)"
