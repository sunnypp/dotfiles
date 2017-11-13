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
