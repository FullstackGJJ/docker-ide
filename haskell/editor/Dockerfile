FROM debian:bullseye
LABEL Description="This image is to used to house haskell editor tools" Version="1.0"

ENV TMUX_PLUGIN_MANAGER_PATH="/.tmux/plugins"

RUN apt-get update && \
    apt-get -y install \ 
    bash \
    ca-certificates \
    curl \
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

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Setup stable docker repository
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
RUN apt-get update && \
    apt-get -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true
RUN curl -sL install-node.vercel.app/lts | bash -s -- --yes

COPY zshrc root/.zshrc
COPY init.vim root/.config/nvim/init.vim
COPY tmux.conf root/.tmux.conf
COPY config.json root/.docker/config.json
COPY tmux.conf .tmux.conf

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins with vim until neovim fixes asynchronous installer
RUN vim +PlugInstall +qall >> /dev/null

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
RUN .tmux/plugins/tpm/bin/install_plugins
