FROM node:16-alpine
LABEL Description="This image is to used to house node 16 runtime and necessary environment for ts-portal" Version="1.0"

RUN apk add -U --no-cache \
    bash \
    build-base \
    curl \
    git \
    less \
    less-doc \
    make \
    man-pages \
    mandoc \
    mandoc-apropos \
    python2 \
    zsh

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

## For batmansay ##
RUN apt-get update && \
    apt-get -y install \
    util-linux \
    figlet

RUN git clone https://github.com/FullstackGJJ/batmansay ~/.oh-my-zsh/plugins/batmansay
###################

COPY zshrc root/.zshrc
