FROM alpine:latest
LABEL Description="This image is to used to house generic terminal tools such as nvim, tmux, in zsh shell" Version="1.0"

ENV TMUX_PLUGIN_MANAGER_PATH="/.tmux/plugins"

RUN apk add -U --no-cache \
    bash \
    curl \
    docker \
    git \
    less \
    less-doc \
    man-pages \
    mandoc \
    mandoc-apropos \
    ncurses \
    neovim \
    openssh-client \
    tmux \
    zsh

COPY zshrc root/.zshrc
COPY init.vim root/.config/nvim/init.vim
COPY tmux.conf root/.tmux.conf
COPY config.json root/.docker/config.json

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

# Install Vim Plug for plugin management
RUN curl -fLo root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
RUN nvim --headless +PlugInstall +qall >> /dev/null

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
RUN .tmux/plugins/tpm/bin/install_plugins
