FROM node:18-bullseye-slim
LABEL Description="This image is to used to house node 18 related tooling to create NodeJS command line application" Version="1.0"

# For zshrc
RUN apt-get update && \
    apt-get -y install \ 
    bash \
    ca-certificates \
    curl \
    git \
    gnupg \
    less \
    libgmp-dev \
    libicu-dev \
    libncurses-dev \
    libncurses5-dev \
    libncursesw5-dev \
    lsb-release \
    man \
    neovim \
    openssh-client \
    ripgrep \
    vim \
    xvfb \
    zlib1g-dev \
    zsh

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

COPY zshrc root/.zshrc
COPY init.vim root/.config/nvim/init.vim

# Install neovim latest stable
# RUN curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
# RUN apt install ./nvim-linux64.deb

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install VIM plugins
RUN nvim --headless +PlugInstall +qall >> /dev/null

# Install neovim 0.6.1
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN ln -sf /squashfs-root/AppRun /usr/bin/nvim
