export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=~/.vim/bin:$PATH:~/workspace/depot_tools

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git thefuck)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.bashrc

alias vi='nvim'
alias vz='nvim ~/.zshrc && source ~/.zshrc'
alias q='exit'
alias wa='osascript ~/workspace/whatsapp-applescript/whatsapp.scpt '

k="$HOME/workspace/KotlinDemo/"
g="$HOME/workspace/GoodNotes-5/"

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


###-tns-completion-start-###
if [ -f /Users/sunnypun/.tnsrc ]; then 
    source /Users/sunnypun/.tnsrc 
fi
###-tns-completion-end-###

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sunnypun/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/sunnypun/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sunnypun/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/sunnypun/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/.fastlane/bin:$PATH"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

eval "$(lua /Users/sunny/workspace/z.lua/z.lua --init enhanced zsh)"
alias zz='z -c'      # restrict matches to subdirs of $PWD
alias zi='z -i'      # cd with interactive selection
alias zf='z -I'      # use fzf to select in multiple matches
alias zb='z -b'      # quickly cd to the parent directory

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias pw='pwd | pbcopy'
alias gmd='git merge develop'
alias gmm='git merge master'
alias gcne='git commit --no-edit'

alias an='open -a /Applications/Android\ Studio.app'

alias refresh_brave='osascript -e "tell application \"Brave Browser\" to tell the active tab of its first window
    reload
end tell"'

alias refresh_chrome='osascript -e "tell application \"Chrome\" to tell the active tab of its first window
    reload
end tell"'

alias omg='fuck'

function hot {
  if (( $# < 2 )); then
    echo 'USAGE: hot <command> <file1> [<file2> ... <fileN>]'
    echo '<command> will be run once when any of the files listed is changed (i.e. ls -l <file> has its output changed)'
  else
    script=$1
    shift
    a='';
    while true; do
      b=`ls -l $*`
      [[ $a != $b ]] && a=$b && eval $script;
      sleep .5;
    done
  fi
}

function gif {
  if (( $# < 1 )); then
    echo 'USAGE: gif <input file>'
    echo '<input file> will be passed to ffmpeg for converting to GIF'
  else
    file=$1
    ffmpeg -i "$file" -pix_fmt rgb8 -r 10 -filter:v scale=512:-1 output.gif && gifsicle -O3 output.gif -o output.gif
  fi
}
