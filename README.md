# dotfiles

My personal config files, managed via `~/.config`.

## Install

Clone and run the install script:

```sh
git clone --recurse-submodules https://github.com/mayorathan/dotfiles.git ~/.config
~/.config/install.sh
```

The script will:
- Install **Homebrew** (if not present)
- Install all packages from `brew/Brewfile` (neovim, lazygit, lsd, starship, atuin, zoxide, fzf, bottom, ghostty, JetBrains Mono Nerd Font)
- Initialize **zsh plugin** submodules
- Symlink `~/.zshenv → ~/.config/.zshenv`
- Set **zsh** as the default shell

## Manual setup

If you already have Homebrew and just need the shell env wired up:

```sh
ln -s ~/.config/.zshenv ~/.zshenv
```

Add the following to `~/.zshenv` so zsh picks up configs from this directory:

```sh
export ZDOTDIR=$HOME/.config/zsh
```
