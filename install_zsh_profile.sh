# Fail on any command
set -eux pipefail

# Install plug-ins (you can git-pull to update them later)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions)

# Replace the configs with the saved one
sudo cp configs/.zshrc ~/.zshrc

# Install prompt
wget -O $ZSH_CUSTOM/themes/common.zsh-theme https://raw.githubusercontent.com/jackharrisonsherlock/common/master/common.zsh-theme

# Switch the shell
chsh -s $(which zsh)
