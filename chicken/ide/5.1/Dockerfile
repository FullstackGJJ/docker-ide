FROM debian:sid-20220316
LABEL Description="This image is to used to house chicken nvim configuration and various terminal tooling" Version="1.0"

# For nvim, zshrc and other terminal tools
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
    libssl-dev \
    lsb-release \
    man \
    neovim \
    openssh-client \
    ripgrep \
    tmux \
    vim \
    xvfb \
    zlib1g-dev \
    zsh

# For SVN
RUN apt-get update && \
    apt-get -y install \
    apache2 \
    subversion \
    subversion-tools \
    libapache2-mod-svn \
    libsvn-dev

# For chicken scheme
RUN apt-get update && \
    apt-get -y install \ 
    build-essential \
    chicken-bin

# Install oh my zsh
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

## For batmansay ##
RUN apt-get update && \
    apt-get -y install \
    bsdmainutils \
    figlet

RUN git clone https://github.com/FullstackGJJ/batmansay ~/.oh-my-zsh/plugins/batmansay
###################

COPY zshrc root/.zshrc
COPY init.vim root/.config/nvim/init.vim
COPY config.json root/.docker/config.json
COPY csirc root/.csirc

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install VIM plugins
RUN nvim --headless +PlugInstall +qall >> /dev/null

# Install neovim 0.6.1
# Doesn't work on M1 chip Mac
# RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
# RUN chmod u+x nvim.appimage
# RUN ./nvim.appimage --appimage-extract
# RUN ln -sf /squashfs-root/AppRun /usr/bin/nvim

# Install chicken-docs and other repl tools
RUN chicken-install srfi-1 srfi-13 srfi-14 srfi-18 srfi-69
RUN chicken-install linenoise
RUN chicken-install apropos chicken-doc introspect trace schematic

# Install repl-imports
RUN git clone https://github.com/FullstackGJJ/repl-imports.git
WORKDIR repl-imports/
RUN chicken-install
WORKDIR /
RUN rm -rf repl-imports
