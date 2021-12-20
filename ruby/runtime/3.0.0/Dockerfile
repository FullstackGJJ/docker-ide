FROM debian:11
LABEL Description="This image is to used to house node 14 runtime and necessary environment for ts-portal" Version="1.0"

# Install ruby-build required stuff
RUN apt-get update && apt-get -y install \
    autoconf \
    bison \
    build-essential \
    curl \
    git \
    libdb-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm6 \
    libncurses5-dev \
    libpq-dev \
    libreadline6-dev \
    libssl-dev \
    libyaml-dev \
    zlib1g-dev

# Install terminal quality of life stuff
RUN apt-get -y install \ 
    bash \
    postgresql \
    zsh 

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

## For batmansay ##
RUN apt-get update && \
    apt-get -y install \
    bsdmainutils \
    figlet

RUN git clone https://github.com/FullstackGJJ/batmansay ~/.oh-my-zsh/plugins/batmansay
###################

COPY zshrc root/.zshrc

RUN git clone https://github.com/rbenv/ruby-build.git

ENV PREFIX="/usr/local"
RUN ./ruby-build/install.sh

RUN ruby-build 3.0.0 /root/local/ruby-3.0.0
ENV PATH="/root/local/ruby-3.0.0/bin:${PATH}"

RUN gem install bundler:2.2.33
