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
