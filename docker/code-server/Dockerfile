FROM codercom/code-server:3.11.1

# install apps
RUN apt update \
 && apt install -y \
    wget \
    tmux \
    tig \
    tree \
    aspell \
    ctags \
 && rm -rf /var/lib/apt/lists/*

# install golang
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.7.linux-amd64.tar.gz
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile

# setup tmux config
COPY .tmux.conf .

# install oh-my-zsh and plugins
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
COPY .zshrc .zshrc

# install vundle and plugins
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY .vimrc .
RUN vim +PluginInstall +qall
RUN vim +GoInstallBinaries

# setup git config
COPY .gitconfig .

# install vscode extensions and setup preferences
COPY vscode_extensions .
COPY vscode_settings.json .local/share/code-server/User/settings.json
RUN cat vscode_extensions | xargs -n 1 code-server --install-extension