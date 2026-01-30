# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

export EDITOR=nvim
export VISUAL=nvim

eval "$(oh-my-posh init zsh --config ~/Documents/atomic.omp.json)"

ZSH_HIGHLIGHT_STYLES[command]='fg=#7A7A7A,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FFAA88,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7A7A7A,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FFA,bold'
