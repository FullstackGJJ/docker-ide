FROM debian:buster-20220328
LABEL Description="This image is to used to house idris2 nvim configuration and various terminal tooling" Version="1.0"

# For nvim, zshrc and other terminal tools
RUN apt-get update && \
    apt-get -y install \ 
    bash \
    curl \
    git \
    man \
    neovim \
    openssh-client \
    ripgrep \
    rlwrap \
    tmux \
    vim \
    zsh

# For installing idris required dependencies
RUN apt-get update && \
    apt-get -y install \ 
    build-essential \
    chezscheme \
    clang \
    libgmp3-dev

# Install Idris2
RUN git clone https://github.com/idris-lang/Idris2.git
WORKDIR /Idris2
RUN git checkout v0.5.1
ENV SCHEME=chezscheme
ENV PATH="$PATH:/root/.idris2/bin" 
RUN make bootstrap
RUN make install
WORKDIR /

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

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install VIM plugins
RUN nvim --headless +PlugInstall +qall >> /dev/null

# Install neovim 0.6.1
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN ln -sf /squashfs-root/AppRun /usr/bin/nvim
