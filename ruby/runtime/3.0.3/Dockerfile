FROM ruby:3.0.3-alpine3.15
LABEL Description="This image is to used to house ruby 3.0.3 runtime and necessary environment for staffing portal backend" Version="1.0"

# Necessary for staffing portal backend
RUN apk add -U --no-cache \
    libpq-dev \
    postgresql

EXPOSE 3001

# Necessary downloads for terminal quality of life
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
    zsh

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

COPY zshrc root/.zshrc

RUN gem install bundler:2.2.33
