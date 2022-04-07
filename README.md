# Dotfiles

Install the following dependencies to get started.

1. set shell

   ```sh
   chsh -s /bin/zsh
   ```

2. install [homebrew](https://brew.sh)

3. install `git`

   ```sh
   brew install git
   ```

4. clone dotfiles

   ```sh
   git clone git@github.com:andybluntish/dotfiles.git "$HOME/Developer/dotfiles"
   cd "$HOME/Developer/dotfiles"
   ```

5. bootstrap dotfiles

   ```sh
   ./bootstrap.sh
   ```

6. setup useful key bindings and fuzzy completion for fzf

   ```sh
   $(brew --prefix)/opt/fzf/install --no-bash --no-fish
   ```

7. install Node.js

   ```sh
   node_version=16.14.2
   nodenv install $node_version
   nodenv global $node_version
   ```

8. install Ruby

   ```sh
   ruby_version=3.1.1
   rbenv install $ruby_version
   rbenv global $ruby_version
   ```

9. install Python

   ```sh
   python_version=3.10.4
   pyenv install $python_version
   pyenv global $python_version
   ```

10. enable Node, Ruby, and Python interfaces for NeoVim

    ```sh
    gem install neovim
    pip3 install pynvim
    yarn global add neovim
    ```

11. for writing JavaScript

    ```sh
    yarn global add eslint prettier typescript
    ```
