FROM racket/racket:8.3-full
LABEL Description="This image is to used to house racket lang runtime" Version="1.0"

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
    tmux \
    vim \
    xvfb \
    zlib1g-dev \
    zsh

# Install oh my zsh
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true
# Install node for coc.nvim
RUN curl -sL install-node.vercel.app/lts | bash -s -- --yes

## For batmansay ##
RUN apt-get update && \
    apt-get -y install \
    bsdmainutils \
    figlet

RUN git clone https://github.com/FullstackGJJ/batmansay ~/.oh-my-zsh/plugins/batmansay
###################

# For racket completion in zsh
RUN git clone https://github.com/FullstackGJJ/shell-completion ~/.oh-my-zsh/plugins/racket-completion

COPY zshrc root/.zshrc
COPY init.vim root/.config/nvim/init.vim
COPY coc-settings.json root/.config/nvim/coc-settings.json
COPY config.json root/.docker/config.json

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install VIM plugins
RUN nvim --headless +PlugInstall +qall >> /dev/null

# Install racket language server
RUN raco pkg install --auto racket-langserver

# Install neovim 0.6.1
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN ln -sf /squashfs-root/AppRun /usr/bin/nvim
