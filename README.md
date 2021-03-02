# Dotfiles

Install the following dependencies to get started.

1. install [homebrew](https://brew.sh)
2. install `git`

   ```bash
   brew install git
   ```

3. clone dotfiles

   ```bash
   git clone git@github.com:andybluntish/dotfiles.git "$HOME/Developer/dotfiles"
   cd "$HOME/Developer/dotfiles"
   ```

4. bootstrap dotfiles

   ```bash
   ./bootstrap.sh
   ```

5. install dependencies

   ```bash
   brew bundle
   ```

6. setup useful key bindings and fuzzy completion for fzf

   ```bash
   $(brew --prefix)/opt/fzf/install --all
   ```

7. set shell

   ```bash
   cat <<- EOF | sudo tee -a /etc/shells
   /opt/homebrew/bin/bash
   /opt/homebrew/bin/fish
   /opt/homebrew/bin/zsh
   EOF
   chsh -s /usr/local/bin/fish
   ```

8. install node.js

   ```bash
   node_version=14.16.0
   nodenv install $node_version
   nodenv global $node_version
   ```

9. install ruby

   ```bash
   ruby_version=3.0.0
   rbenv install $ruby_version
   rbenv global $ruby_version
   ```

10. for writing JavaScript

    ```bash
    npm i -g eslint prettier live-server terminal-image-cli typescript
    ```

11. enable Node and Python interfaces for NeoVim

    ```bash
    gem install neovim
    pip install neovim
    yarn global add neovim
    ```
