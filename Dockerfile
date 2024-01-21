FROM ubuntu:latest

ARG TERM=xterm-256color

# Define variables for the username, user ID, and group ID
ARG USER_NAME
ARG USER_ID
ARG GROUP_ID
ARG TZ

# Language version
ARG ASDF_TAG=v0.14.0
ARG NODE_VERSION=20.11.0
ARG RUBY_VERSION=3.2.3
ARG PYTHON_VERSION=3.12.1
ARG DELTA_VERSION=0.16.5

# Create a new group and user using GROUP_ID and USER_ID
RUN useradd -u ${USER_ID} -g ${GROUP_ID} -m ${USER_NAME}

WORKDIR /home/${USER_NAME}

# Set the locale
ENV LANG en_AU.UTF-8
ENV LANGUAGE en_AU:en
ENV LC_ALL en_AU.UTF-8

# Install packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
      build-essential \
        autoconf \
        patch \
        rustc \
        libssl-dev \
        libyaml-dev \
        libreadline6-dev \
        zlib1g-dev \
        libgmp-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm6 \
        libgdbm-dev \
        libdb-dev \
        uuid-dev \
      sudo \
      locales \
      tzdata \
      curl \
      wget \
      zsh \
      zsh-syntax-highlighting \
      tmux \
      git \
      neovim \
      bat \
      fd-find \
      ripgrep \
      direnv \
      lua5.4 \
    && \
    locale-gen en_AU.UTF-8 && \
    apt-get clean
    #rm -rf /var/lib/apt/lists/*

# Set the timezone
ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Add the new user to the sudo group
RUN usermod -aG sudo ${USER_NAME}

# Allow members of the sudo group to use sudo without a password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set the default shell to Zsh
SHELL ["/bin/zsh", "-c"]

# Install git-delta
RUN curl -fLo "/tmp/git-delta_${DELTA_VERSION}_arm64.deb" https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_arm64.deb && \
  dpkg -i /tmp/git-delta_${DELTA_VERSION}_arm64.deb

# Switch backto the non-root user
USER ${USER_NAME}

# Shell config from grml (https://grml.org/zsh/)
RUN curl -fLo "${HOME}/.zshrc" https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

# Copy dotfiles
RUN mkdir -p .config/nvim
COPY --chown=${USER_NAME}:${USER_NAME} zshrc.pre .zshrc.pre
COPY --chown=${USER_NAME}:${USER_NAME} zshrc.local .zshrc.local
COPY --chown=${USER_NAME}:${USER_NAME} zshrc.custom.local .zshrc.custom.local
COPY --chown=${USER_NAME}:${USER_NAME} asdfrc .asdfrc
COPY --chown=${USER_NAME}:${USER_NAME} gemrc .gemrc
COPY --chown=${USER_NAME}:${USER_NAME} gitconfig .gitconfig
COPY --chown=${USER_NAME}:${USER_NAME} gitignore .gitignore
COPY --chown=${USER_NAME}:${USER_NAME} hushlogin .hushlogin
COPY --chown=${USER_NAME}:${USER_NAME} irbrc .irbrc
COPY --chown=${USER_NAME}:${USER_NAME} config/nvim/init.vim .config/nvim/init.vim

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  ~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch ${ASDF_TAG}

# Node
RUN source "${HOME}/.zshrc" && \
  asdf plugin add nodejs "https://github.com/asdf-vm/asdf-nodejs.git" && \
  asdf install nodejs ${NODE_VERSION} && \
  asdf global nodejs 20.11.0 && \
  npm install -g \
    pnpm \
    yarn \
    pure-prompt \
  && \
  pnpm add --global \
    tldr \
    neovim \
    eslint \
    prettier \
    typescript \
  && \
  asdf reshim nodejs

# Ruby
RUN source "${HOME}/.zshrc" && \
  asdf plugin add ruby "https://github.com/asdf-vm/asdf-ruby.git" && \
  asdf install ruby "${RUBY_VERSION}" && \
  asdf global ruby "${RUBY_VERSION}" && \
  gem install \
    neovim \
    bundler \
  && \
  asdf reshim ruby

# Python
RUN source "${HOME}/.zshrc" && \
  asdf plugin-add python "https://github.com/danhper/asdf-python.git" && \
  asdf install python "${PYTHON_VERSION}" && \
  asdf global python "${PYTHON_VERSION}" && \
  pip install --upgrade pip && \
  pip install \
    pynvim \
  && \
  asdf reshim python

# Setup Neovim
RUN curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN source "${HOME}/.zshrc" && \
  nvim --headless +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +TSUpdateSync +MasonUpdate +qa

WORKDIR /home/${USER_NAME}/mnt

# Start Zsh when running a container interactively
CMD ["/bin/zsh"]
