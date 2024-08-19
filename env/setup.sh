#!/bin/bash

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off

# Install apps or libraries (mandatory)
brew install --cask iterm2 visual-studio-code rectangle
brew install curl tree zsh git tig macvim cmake tmux go htop reattach-to-user-namespace jq

# Install apps or libraries (optional)
# brew install --cask docker google-chrome notion slack
# brew install aspell awscli aws-vault
# brew install kubectl helm terraform k9s

# Install fonts
brew tap homebrew/cask-fonts
brew install --cask font-d2coding

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy .zshrc to ~/.zshrc
rsync .zshrc ~/.zshrc
exec zsh

# Copy .tmux.conf to ~/.tmux.conf
rsync .tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy .vimrc to ~/.vimrc
rsync .vimrc ~/.vimrc
vim +PluginInstall +qall
vim +GoInstallBinaries
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --go-completer
cd -

# Install vscode extensions
cat vscode_extensions | xargs -n 1 code --install-extension

# Copy vscode settings.json
rsync vscode_settings.json ~/Library/Application\ Support/Code/User/settings.json

# Disable ApplePressAndHoldEnabled
defaults write -g ApplePressAndHoldEnabled -bool false
