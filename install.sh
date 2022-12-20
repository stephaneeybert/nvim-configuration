#!/bin/bash

printf "\nGetting sudo out of the way\n"
sudo echo &> /dev/null

printf "\nInstalling some dependencies\n"
sudo apt-get install -y git curl gcc python3-pip cmake python-is-python3 > /dev/null

if ! command -v npm &> /dev/null
then
  printf "\nPlease install npm\n"
  exit 1
fi

if ! command -v yarn &> /dev/null
then
  printf "\nPlease install yarn\n"
  exit 1
fi

if ! command -v nvim &> /dev/null
then
  printf "\nInstalling Neovim\n"
  sudo curl -o /usr/bin/nvim -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage > /dev/null
  sudo chmod a+x /usr/bin/nvim > /dev/null
fi

if ! command -v node &> /dev/null
then
  printf "\nInstalling NodeJS\n"
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - > /dev/null
  sudo apt install -y nodejs > /dev/null
fi

if ! command -v yarn &> /dev/null
then
  printf "\nInstalling Yarn\n"
  sudo npm install -g yarn > /dev/null
  yarn global add stylefmt
fi

if [ -d $HOME/.config/nvim ] && [ ! -d $HOME/.config/nvim-bak ]; then
  printf "\nBacking up an existing Neovim configuration if any\n"
  mv  ~/.config/nvim ~/.config/nvim-bak > /dev/null
fi

if [ ! -d $HOME/.config/nvim ]; then
  printf "\nDownloading my Neovim configuration\n"
  git clone --recurse-submodules -j8 git@github.com:stephaneeybert/nvim-configuration.git ~/.config/nvim > /dev/null
fi

if [ ! -f $HOME/.local/share/fonts/'Literation Mono Nerd Font Complete.ttf' ]; then
  if [ ! -d $HOME/.local/share/fonts ]; then
    mkdir $HOME/.local/share/fonts
  fi
  printf "\nInstalling a font\n"
  cd $HOME/.local/share/fonts
  curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/LiberationMono.zip > /dev/null
  unzip -o "LiberationMono.zip" > /dev/null
fi

if ! command -v rg &> /dev/null
then
  printf "\nInstalling the ripgrep program used by the Telescope plugin\n"
  sudo apt-get install -y ripgrep > /dev/null
fi

if ! command -v fd &> /dev/null
then
  printf "\nInstalling the fd-find program used by the Telescope plugin\n"
  sudo apt-get install -y fd-find > /dev/null
  # Create a symlink to offer the program to Telescope under the name fd
  mkdir -p $HOME/.local/bin
  ln -sf $(which fdfind) ~/.local/bin/fd
fi

if ! command -v prettier &> /dev/null
then
  printf "\nInstalling the prettier program used by the null-ls plugin\n"
  npm install -g --save-dev --save-exact prettier
fi

if [ ! -d $HOME/.local/share/nvim/lsp_servers/jdtls/ ]; then
  printf "\nInstalling the LSP servers"
  export NVIM_LSP_SERVERS=$HOME/.local/share/nvim/lsp_servers
  mkdir -p $HOME/.local/share/nvim/lsp_servers/
  nvim --headless -c "LspInstall --sync sumneko_lua jsonls tsserver jdtls " -c q
fi

if ! command -v lazygit &> /dev/null
then
  printf "\nInstalling the lazygit client\n"
  sudo add-apt-repository -y ppa:lazygit-team/release
  sudo apt-get update
  sudo apt-get install -y lazygit
fi
if ! command -v git-delta &> /dev/null
then
  printf "\nInstalling the git-delta diff pager\n"
  sudo apt-get install -y git-extras
  printf "\nConfiguring git-delta\n"
fi
CONFIG=~/.gitconfig
EDITED=~/.gitconfig.edited
if [ ! -f ${CONFIG} ]; then
  printf "\nCreating the $CONFIG file\n"
  touch $CONFIG
fi
if ! grep -q "\[core\]" $CONFIG; then
  printf "\nAdding core section to the $CONFIG file\n"
  echo "[core]" | tee --append $CONFIG
fi
if ! grep -q "\[delta\]" $CONFIG; then
  printf "\nAdding [delta] section to the $CONFIG file\n"
  echo "[delta]" >> $CONFIG
fi
if ! grep -q "pager = delta" $CONFIG; then
  printf "Adding the pager in the core section"
  sed -e '/\[core\]/a\' -e "\  pager = delta" $CONFIG > $EDITED
  mv -f $EDITED $CONFIG
fi
if ! grep -q "line-numbers" $CONFIG; then
  printf "\nToggling line numbers on"
  sed -e '/\[delta\]/a\' -e "\  line-numbers = true" $CONFIG > $EDITED
  mv -f $EDITED $CONFIG
fi
if ! grep -q "side-by-side" $CONFIG; then
  printf "\nDisplaying side by side"
  sed -e '/\[delta\]/a\' -e "\  side-by-side = true" $CONFIG > $EDITED
  mv -f $EDITED $CONFIG
fi
if ! grep -q "light" $CONFIG; then
  printf "\nDisplaying in a dark theme"
  sed -e '/\[delta\]/a\' -e "\  light = false" $CONFIG > $EDITED
  mv -f $EDITED $CONFIG
fi
if ! grep -q "navigate" $CONFIG; then
  printf "\nNavigating chunks with n and N keys"
  sed -e '/\[delta\]/a\' -e "\  navigate = true" $CONFIG > $EDITED
  mv -f $EDITED $CONFIG
fi

if [ ! -f $HOME/.local/share/nvim/lsp-debuggers/vscode-chrome-debug/out/src/chromeDebug.js ]; then
  printf "\nInstalling the VSCode Chrome debugger"
  printf "\n  The VSCode Chrome debugger is deprecated and has been replaced by the VSCode JS debugger"
  printf "\n  The VSCode JS debugger is compatible with all browsers"
  printf "\n  But the VSCode JS debugger is not DAP compliant"
  printf "\n  So the VSCode Chrome debugger is still being used for now\n"
  mkdir -p ~/.local/share/nvim/lsp-debuggers/
  cd ~/.local/share/nvim/lsp-debuggers/
  git clone git@github.com:microsoft/vscode-chrome-debug.git
  cd vscode-chrome-debug
  npm install
  npm run build
fi

if [ ! -f $HOME/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar ]; then
  printf "\nInstalling the Java debug adapter\n"
  TEMP_DIR="$(mktemp -d)"
  cd $TEMP_DIR
  curl -o jdt-language-server-1.9.0-202203031534.tar.gz https://download.eclipse.org/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz > /dev/null
  gzip -d jdt-language-server-1.9.0-202203031534.tar.gz
  tar -xvf jdt-language-server-1.9.0-202203031534.tar
  mkdir -f $HOME/.local/share/nvim/lsp_servers/jdtls/plugins/
  mv org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar $HOME/.local/share/nvim/lsp_servers/jdtls/plugins/
fi

if [ ! -f $HOME/.local/share/nvim/lsp-debuggers/jdtls/com.microsoft.java.debug.plugin-0.37.0.jar ]; then
  printf "\nInstalling the Java debugger\n"
  TEMP_DIR="$(mktemp -d)"
  cd $TEMP_DIR
  git clone https://github.com/microsoft/java-debug.git
  cd java-debug
  chmod u+x mvnw
  ./mvnw clean install
  mkdir -p ~/.local/share/nvim/lsp-debuggers/jdtls
  cp com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar ~/.local/share/nvim/lsp-debuggers/jdtls
  rm -rf $TEMP_DIR
fi

if [ ! -f $HOME/.local/share/nvim/lsp-debuggers/jdtls/com.microsoft.java.test.plugin-0.35.0.jar ]; then
  printf "\nInstalling the Java Test debugger\n"
  TEMP_DIR="$(mktemp -d)"
  cd $TEMP_DIR
  git clone https://github.com/microsoft/vscode-java-test.git
  cd vscode-java-test
  yarn
  yarn build-plugin
  mkdir -p ~/.local/share/nvim/lsp-debuggers/jdtls
  cp server/*.jar ~/.local/share/nvim/lsp-debuggers/jdtls
  rm -rf $TEMP_DIR
fi

printf "\n"
