FROM haskell:9.0.1
LABEL Description="This image is to used to house haskell runtime tools" Version="1.0"

RUN apt-get update && \
    apt-get -y install \ 
    bash
    zsh \

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

COPY zshrc root/.zshrc
COPY stack.yaml root/.stack/global-project/stack.yaml
COPY package.yaml root/.stack/global-project/package.yaml

# Install ghcid
RUN stack install ghcid

# Install retrie
RUN stack install retrie
