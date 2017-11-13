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

# ctags
brew install ctags


# symlinks
ln -s zshrc ~/.zshrc
ln -s vimrc ~/.vimrc
ln -s tmux.conf ~/.tmux.conf
