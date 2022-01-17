FROM debian:bullseye
LABEL Description="This image is to used to house haskell editor tools" Version="1.0"

ENV TMUX_PLUGIN_MANAGER_PATH="/.tmux/plugins"

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
    tmux \
    vim \
    zlib1g-dev \
    zsh


# Install oh my zsh
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true
# Install node for coc.nvim
RUN curl -sL install-node.vercel.app/lts | bash -s -- --yes
# Install haskell stack to be able to use haskell language server
RUN curl -sSL https://get.haskellstack.org/ | sh
# Install ghcup to be able to install haskell language server
RUN zsh -c "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"

COPY zshrc root/.zshrc
COPY stack.yaml root/.stack/global-project/stack.yaml
COPY init.vim root/.config/nvim/init.vim
COPY coc-settings.json root/.config/nvim/coc-settings.json
COPY tmux.conf root/.tmux.conf
COPY config.json root/.docker/config.json
COPY tmux.conf .tmux.conf

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install VIM plugins
RUN nvim --headless +PlugInstall +qall >> /dev/null

# Install haskell language server
RUN $HOME/.ghcup/bin/ghcup install hls

## Currently rely on system's TMUX instead of wanting docker container tmux
# Install Tmux Plugin Manager
# RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
# RUN .tmux/plugins/tpm/bin/install_plugins
