FROM racket/racket:8.3-full
LABEL Description="This image is to used to house racket lang runtime" Version="1.0"

ENV TMUX_PLUGIN_MANAGER_PATH="/.tmux/plugins"

# For zshrc
RUN apt-get update && \
    apt-get -y install \ 
    bash \
    curl \
    git \
    zsh

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

# For batmansay
RUN apt-get update && \
    apt-get -y install \ 
    bsdmainutils \
    figlet \
    ruby \
    lolcat

RUN git clone https://github.com/busyloop/lolcat
WORKDIR "lolcat/bin"
RUN gem install lolcat

WORKDIR "/"
RUN git clone https://github.com/FullstackGJJ/batmansay ~/.oh-my-zsh/plugins/batmansay

# For racket completion in zsh
RUN git clone https://github.com/FullstackGJJ/shell-completion ~/.oh-my-zsh/plugins/racket-completion

COPY zshrc root/.zshrc
