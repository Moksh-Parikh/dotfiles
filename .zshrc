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

# export PATH="$PATH:~/.local/bin:~/Apps/spotify:~/Games/WarThunder/:~/Apps/DrMemory/DrMemory-Linux-2.6.0/bin"
eval "$(oh-my-posh init zsh --config ~/Documents/atomic.omp.json)"
