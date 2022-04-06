# Dotfiles

Install the following dependencies to get started.

1. install [homebrew](https://brew.sh)
2. install `git`

   ```sh
   brew install git
   ```

3. clone dotfiles

   ```sh
   git clone git@github.com:andybluntish/dotfiles.git "$HOME/Developer/dotfiles"
   cd "$HOME/Developer/dotfiles"
   ```

4. bootstrap dotfiles

   ```sh
   ./bootstrap.sh
   ```

5. install dependencies

   ```sh
   brew bundle
   ```

6. setup useful key bindings and fuzzy completion for fzf

   ```sh
   $(brew --prefix)/opt/fzf/install --all
   ```

7. set shell

   ```sh
   cat <<- EOF | sudo tee -a /etc/shells
   /opt/homebrew/bin/zsh
   EOF
   chsh -s /opt/homebrew/bin/zsh
   ```

8. install Node.js

   ```sh
   node_version=14.16.0
   nodenv install $node_version
   nodenv global $node_version
   ```

9. install Ruby

   ```sh
   ruby_version=3.0.0
   rbenv install $ruby_version
   rbenv global $ruby_version
   ```

10. install Python

    ```sh
    python_version=3.9.4
    pyenv install $python_version
    pyenv global $python_version
    ```

11. enable Node, Ruby, and Python interfaces for NeoVim

    ```sh
    gem install neovim
    pip install pynvim
    pip3 install pynvim
    yarn global add neovim
    ```

12. for writing JavaScript

    ```sh
    yarn global add eslint prettier typescript
    ```
