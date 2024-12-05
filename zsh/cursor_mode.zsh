function zle-keymap-select zle-line-init zle-line-finish
{
  case $KEYMAP in
      vicmd)      print -n '\033[1 q';; # block cursor
      viins|main) print -n '\033[3 q';; # line cursor
  esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
