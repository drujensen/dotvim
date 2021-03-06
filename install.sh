# curl -sL https://raw.githubusercontent.com/egalpin/apt-vim/master/install.sh | sh
apt-vim install -y \
  git://github.com/rking/ag.vim.git \
  git://github.com/bling/vim-airline.git \
  git://github.com/Chiel92/vim-autoformat.git \
  git://github.com/tpope/vim-bundler.git \
  git://github.com/rhysd/vim-crystal.git \
  git://github.com/kien/ctrlp.vim.git \
  git://github.com/tpope/vim-cucumber.git \
  git://github.com/tpope/vim-fugitive.git \
  git://github.com/airblade/vim-gitgutter.git \
  git://github.com/gregsexton/gitv.git \
  git://github.com/pangloss/vim-javascript.git \
  git://github.com/mxw/vim-jsx.git \
  git://github.com/JamshedVesuna/vim-markdown-preview.git \
  git://github.com/terryma/vim-multiple-cursors.git \
  git://github.com/ddollar/nerdcommenter.git \
  git://github.com/scrooloose/nerdtree.git \
  git://github.com/jistr/vim-nerdtree-tabs.git \
  git://github.com/tpope/vim-rails.git \
  git://github.com/vim-ruby/vim-ruby.git \
  git://github.com/isaacsloan/vim-slang.git \
  git://github.com/scrooloose/syntastic.git \
  git://github.com/majutsushi/tagbar.git \
  git://github.com/drujensen/vim-test-recall.git \
  git://github.com/jgdavey/tslime.vim.git \
  git://github.com/tpope/vim-salve.git \
  git://github.com/tpope/vim-projectionist.git \
  git://github.com/tpope/vim-dispatch.git \
  git@github.com:tpope/vim-classpath.git \
  git://github.com/tpope/vim-fireplace.git \
  git@github.com:kien/rainbow_parentheses.vim.git

# Use package feature to install coc.nvim
# for vim8
mkdir -p ~/.vim/pack/coc/start
cd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
# https://github.com/neoclide
npm install coc-marketplace
npm install coc-solargraph #ruby gem install solargraph
npm install coc-java
npm install coc-python
npm install coc-eslint
npm install coc-css
npm install coc-yaml
npm install coc-json
npm install coc-jest
npm install coc-go
npm install coc-conjure
