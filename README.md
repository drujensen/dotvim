# dotvim

## Setup

### Linux (Ubuntu/Debian)
```
sudo apt update
sudo apt install git curl vim neovim -y
git clone git@github.com:drujensen/dotvim.git ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -sf ~/.vim/init.lua ~/.config/nvim/init.lua
```

### Linux (Fedora)
```
sudo dnf install git curl vim neovim
git clone git@github.com:drujensen/dotvim.git ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -sf ~/.vim/init.lua ~/.config/nvim/init.lua
```

### macOS
```
brew install neovim git curl
git clone git@github.com:drujensen/dotvim.git ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -sf ~/.vim/init.lua ~/.config/nvim/init.lua
```

### Windows (PowerShell as Admin)
```
# Install Neovim via winget or chocolatey
winget install Neovim.Neovim
# or choco install neovim

git clone git@github.com:drujensen/dotvim.git $HOME\.vim
New-Item -ItemType SymbolicLink -Path $HOME\.vimrc -Target $HOME\.vim\vimrc
mkdir -p $HOME\.config\nvim
New-Item -ItemType SymbolicLink -Path $HOME\.config\nvim\init.lua -Target $HOME\.vim\init.lua
```

## Fonts

For proper display of icons in NeoTree and airline, install a Nerd Font.

### Linux (Ubuntu/Debian)
```
sudo apt install fonts-hack-nerd-font
# Or download from https://github.com/ryanoasis/nerd-fonts/releases and install manually
```

### Linux (Fedora)
```
sudo dnf install nerd-fonts
# Or download from https://github.com/ryanoasis/nerd-fonts/releases and install manually
```

### macOS
```
brew install --cask font-hack-nerd-font
```

### Windows
```
# Using chocolatey
choco install nerd-fonts-hack
# Or download from https://github.com/ryanoasis/nerd-fonts/releases and install manually
```

Set the font in your terminal: Hack Nerd Font
