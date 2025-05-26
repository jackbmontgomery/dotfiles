export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="aphrodite/aphrodite" # set by `omz`

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '\e[99~' autosuggest-accept

# Always work in a tmux session if Tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t default || tmux new -s default; exit
  fi
fi

alias nv='nvim .'
alias nvc='nvim -c "cd ~/.config" -c "Oil"'
alias nvo='nvim -c "cd ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Jack Montgomery" -c "Oil"'

alias sp='source .venv/bin/activate'
alias jl='julia'

alias config='/usr/bin/git --git-dir=/Users/jackmontgomery/dotfiles/ --work-tree=/Users/jackmontgomery'
