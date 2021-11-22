FROM haskell:9.0.1
LABEL Description="This image is to used to house haskell IDE tooling" Version="1.0"

ENV TMUX_PLUGIN_MANAGER_PATH=".tmux/plugins"

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

COPY zshrc root/.zshrc
COPY init.vim root/.config/nvim/init.vim
COPY stack.yaml root/.stack/global-project/stack.yaml
COPY package.yaml root/.stack/global-project/package.yaml
COPY tmux.conf .tmux.conf

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
RUN nvim +PlugInstall +qall >> /dev/null

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
RUN .tmux/plugins/tpm/bin/install_plugins

# Stack setup to get matching GHC for stack
# RUN stack setup

# Install ghcid
RUN stack install ghcid

# Install retrie
RUN stack install retrie
