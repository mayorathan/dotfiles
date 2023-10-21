# Path to my oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="common"

# Plugins
plugins=(
	sudo
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="vi ~/.zshrc"
alias ls="exa"
alias la="exa -alh"
alias tree="exa --tree"
alias vi="nvim"
alias h="history"
alias cat="bat"
alias lg="lazygit"
alias ns="npm start"
alias python=python3
alias ssh"kitten ssh"

