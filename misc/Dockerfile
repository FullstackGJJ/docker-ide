FROM ubuntu:latest
LABEL Description="This image is to used to house IDE tooling" Version="1.0"

RUN apt-get update && \
    apt-get -y install \ 
    neovim \
    git \
    zsh \
    tmux \
    openssh-client \
    bash \
    libncurses5-dev \
    libncursesw5-dev \
    curl \
    less \
    man

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

# Install Vim Plug for plugin management
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
# RUN nvim +PlugInstall +qall >> /dev/null

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
# RUN .tmux/plugins/tpm/bin/install_plugins
