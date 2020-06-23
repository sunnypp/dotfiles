brew install zsh zsh-completions
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s /usr/local/bin/zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
brew install neovim
brew install tmux

# For copying
brew install reattach-to-user-namespace

# FZF
# from https://github.com/junegunn/fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Deoplete
brew install python3
pip3 install neovim

# command auto-correction
brew install thefuck

# for lua (using z.lua)
brew install lua

# for git-lfs
brew install git-lfs

# next gen ls
brew install lsd

# ctags
# brew install ctags
# curl -Ss http://vim-php.com/phpctags/install/phpctags.phar > /usr/local/bin/phpctags
# chmod 777 /usr/local/bin/phpctags

# Typscript
# sudo npm install -g typescript
# npm install --global git+https://github.com/Perlence/tstags.git

# backup and remove
cp ~/.zshrc{,backup}
rm ~/.zshrc
cp ~/.vimrc{,backup}
rm ~/.vimrc
cp ~/.tmux.conf{,backup}
rm ~/.tmux.conf

# symlinks
ln -s $HOME/dotfiles/zshrc ~/.zshrc
ln -s $HOME/dotfiles/vimrc ~/.vimrc
ln -s $HOME/dotfiles/tmux.conf ~/.tmux.conf
ln -s $HOME/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
ln -s $HOME/dotfiles/init.vim ~/.config/nvim/init.vim
