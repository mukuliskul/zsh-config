export PATH="$(brew --prefix python@3.12)/libexec/bin:$PATH"
export PATH="/Applications/WezTerm.app/Contents/MacOS:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/Users/joseanmartinez/.spicetify

export PATH="$HOME/.rbenv/shims:$PATH"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source <(curl -s https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh)

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# Created by `pipx` on 2025-02-07 18:32:59
export PATH="$PATH:/Users/mukul/.local/bin"

# Custom aliases
alias python=python3
alias swapkeys="~/Documents/scripts/swap-caps-ctrl.sh"
alias awslogin='~/Documents/scripts/aws-docker-login.sh'

# Docker aliases
alias dcd="docker compose down -v"
alias dcu="docker compose up --build -d"
alias dcp="docker compose pull"
alias dcdu="docker compose down -v && docker compose up --build -d"
alias dcdpu="docker compose down -v && docker compose pull && docker compose up --build -d"

# Poetry aliases
alias prt="poetry run tox"
alias prr="poetry run ruff check app/ --fix && poetry run ruff check tests/ --fix && poetry run ruff check alembic/admin/env.py --fix && poetry run ruff check alembic/client/env.py --fix" 
alias prtt="poetry run tox -- -e typeChecker"
alias prtl="poetry run tox -- -e linter"
alias prtpsc="poetry run tox -- -e pytest-skip-container"
alias prtmsc="poetry run tox -- -e migration-skip-container"
alias prc="poetry run coverage html --skip-covered && open -a 'Google Chrome' htmlcov/index.html"

# Tmux aliases
alias tma="tmux attach -t"
alias tmn="tmux new -s"
alias tmk="tmux kill-session -t"

# Theme
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
eval "$(starship init zsh)"
