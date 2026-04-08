if [[ -o interactive ]] \
  && [[ -t 1 ]] \
  && [[ -z "${FASTFETCH_DISABLE_AUTO:-}" ]] \
  && [[ -z "${TMUX:-}" ]] \
  && [[ -z "${FASTFETCH_SHOWN:-}" ]] \
  && (( ${SHLVL:-0} == 1 )) \
  && (( $+commands[fastfetch] )); then
  # fastfetch is informational only, so keep nested shells responsive.
  export FASTFETCH_SHOWN=1
  fastfetch --detect-version false --structure Title:OS:Host:Kernel:CPU:GPU:Memory:Disk:Battery
fi
