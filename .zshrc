# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PS1="$([[ ! -z "${UPTERM_ADMIN_SOCKET}"  ]] && echo -e '\xF0\x9F\x86\x99 ')$PS1" # Add an emoji to the prompt if `UPTERM_ADMIN_SOCKET` exists

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
plugins=(
  aliases
  git
  fzf
  ripgrep
  docker
  docker-compose
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


source $HOME/.aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfgg='gg --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfa='dotfiles add $HOME/.config/astronvim/lua/user/**/*.lua && dotfiles add $HOME/.config/lvim/**/*.lua && dotfiles add -u && dotfiles add $HOME/.config/lvim/lua/* && dotfiles add $HOME/.config/nvim/*' 
alias dfc='dotfiles add -u && dotfiles commit -m $1'
alias dfs='dotfiles status'
alias dfu="dotfiles add -u && dotfiles add $HOME/.config/lvim/**/*.lua"
alias dfd="dotfiles diff"
alias dfp="dotfiles push"
alias gg="lazygit"
alias ns='npm start'
alias n='pnpm'
alias rider='open -na "Rider.app" --args $1'
alias ridereap='open -na "Rider EAP.app" --args $1'
alias tmnhn='tmux attach -t nhn || tmux new -s nhn'
alias tmvar='tmux attach -t variant || tmux new -s variant'
alias tmpriv='tmux attach -t priv || tmux new -s priv'
alias tmstart='(tmux new -s nhn -d && tmux new -s variant -d && tmux new -s priv -d) &> /dev/null'
alias tmn='tmux attach -t $1 || tmux new -s $1'
alias lc='exa -la --icons'
alias ll='lsd -l'
alias lla='lsd -la'
alias exat='exa -T --icons --git-ignore'
alias lzd='lazydocker'
alias drawio='/Applications/draw.io.app/Contents/MacOS/draw.io'
alias neovide='/Applications/Neovide.app/Contents/MacOS/neovide'
alias vim='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# --files: List files that would be searched but do not search
# # --no-ignore: Do not respect .gitignore, etc...
# # --hidden: Search hidden files and folders
# # --follow: Follow symlinks
# # --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

bindkey "ç" fzf-cd-widget

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$(yarn global bin)"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/source/erlang_ls/_build/default/bin"
export GOPATH="$HOME/go"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions


export PATH="/usr/local/opt/node@14/bin:$PATH"
PATH=/usr/local/bin:$PATH
# To make R work properly
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval "$(zoxide init zsh)"

eval $(opam env)

export GPG_TTY=$(tty)

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

autoload -U compinit promptinit


promptinit
compinit

autoload -U +X bashcompinit && bashcompinit

eval "$(zoxide init zsh)"
