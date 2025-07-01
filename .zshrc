export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="aphrodite/aphrodite"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '\e[99~' autosuggest-accept

if which tmux >/dev/null 2>&1; then
  if [ "$TERM" != "screen-256color" ] && [ "$TERM" != "screen" ] && [ -z "$NVIM" ]; then
    tmux attach -t default || tmux new -s default
    exit
  fi
fi

export OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Jack Montgomery"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

alias nv='nvim .'
alias nvc='nvim -c "cd ~/.config" -c "Oil"'
alias nvo='nvim -c "cd $OBSIDIAN_VAULT" -c "edit Home.md"'

alias sp='source .venv/bin/activate'
alias jl='julia'
alias vim='nvim'
alias vi='nvim'

alias config='/usr/bin/git --git-dir=/Users/jackmontgomery/dotfiles/ --work-tree=/Users/jackmontgomery'
alias brew-save='brew bundle dump -f --file=~/.config/Brewfile'

[ -f ~/.secrets ] && source ~/.secrets
