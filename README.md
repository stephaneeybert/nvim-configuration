# nvim-configuration

My custom configuration based on the [Vim from Scratch](https://github.com/LunarVim/Neovim-from-scratch.git) videos series

## Installation

Remove the existing vim if any

sudo apt-get remove neovim
```
mv ~/.config/nvim ~/trash
```

Install the latest version
mkdir -p ~/programs/nvim;
cd ~/programs/nvim;
rm -fr ~/trash/nvim-linux64;
mv nvim-linux64 ~/trash/;
mv nvim-linux64.tar.gz ~/trash/
Download https://github.com/neovim/neovim/releases/latest/ the nvim-linux64.tar.gz archive
rm -f nvim-linux64.tar;
gzip -d nvim-linux64.tar.gz;
tar -xvf nvim-linux64.tar

Install some plugins:
sudo apt install xsel # copy paste
pip install pynvim # python
npm i -g neovim # node

Install yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list;
sudo apt update;
sudo apt install --no-install-recommends yarn

Remove the existing vim configuration if any as it conflicts with the lua configuration
mv ./.config/nvim/init.vim ./.config/nvim.bak/init.vim;
rm -fr .local/share/nvim/site/*

Clone my configuration
git clone https://github.com/stephaneeybert/nvim-configuration  ~/.config/nvim

Install the configuration
cd ~/.config/nvim;
./install.sh

The nvim editor is not the vim nor the vi applications
which nvim

Starting the editor
nvim
