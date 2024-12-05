# -------------------------------
# Zsh Options
# -------------------------------
setopt AUTO_CD                      # Automatically change directories
setopt INTERACTIVE_COMMENTS         # Allow comments (#) in interactive mode
setopt HIST_FCNTL_LOCK              # Lock history file during writes
setopt HIST_IGNORE_ALL_DUPS         # Ignore duplicate commands in history
setopt SHARE_HISTORY                # Share history across sessions
unsetopt AUTO_REMOVE_SLASH          # Keep trailing slashes on paths
unsetopt HIST_EXPIRE_DUPS_FIRST     # Don't prioritize duplicates for removal
unsetopt EXTENDED_HISTORY           # Disable timestamps in history

source "$ZDOTDIR/alias.zsh"         # Load custom aliases
source "$ZDOTDIR/cursor_mode.zsh"   # Load cursor mode settings
# -------------------------------
# PATH Configuration
# -------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

if [[ "$(uname -sm)" == "Darwin arm64" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# -------------------------------
# fpath Configuration
# -------------------------------
fpath=("$HOME/.config/zsh/completions" $fpath)
fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
fpath=("$(brew --prefix)/share/zsh-abbr" $fpath)

# -------------------------------
# Zsh Autoload and Plugins
# -------------------------------
# Autoload functions and modules
autoload -U compinit; compinit        # Initialize Zsh completion system
zmodload zsh/complist                 # Enhanced completion features
autoload -Uz edit-command-line        # Command line editor widget
zle -N edit-command-line

# Source external plugins
if [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source "$ZDOTDIR/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"  # Load syntax highlighting
fi

if [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -f "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

if [[ -f "$(brew --prefix)/share/zsh-abbr/zsh-abbr.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-abbr/zsh-abbr.zsh"
fi

if [[ -f "$(brew --prefix)/share/zsh-autosuggestions-abbreviations-strategy/zsh-autosuggestions-abbreviations-strategy.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions-abbreviations-strategy/zsh-autosuggestions-abbreviations-strategy.zsh"
fi

ZSH_AUTOSUGGEST_STRATEGY=( abbreviations $ZSH_AUTOSUGGEST_STRATEGY )

# -------------------------------
# Zsh Completion Settings
# -------------------------------
zstyle ":completion:*:*:*:*:*" menu select
zstyle ":completion:*" use-cache yes
zstyle ":completion:*" special-dirs true
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" file-sort change
zstyle ":completion:*" matcher-list \
    "m:{[:lower:][:upper:]}={[:upper:][:lower:]}" \
    "r:|=*" \
    "l:|=* r:|=*"

# -------------------------------
# fzf: Fuzzy Finder Configuration
# -------------------------------
if type fzf &>/dev/null; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# -------------------------------
# Starship Prompt
# -------------------------------
if type starship &>/dev/null; then
  export STARSHIP_CONFIG="$(readlink -f "$HOME/.config/starship")/starship.toml"
  eval "$(starship init zsh)"
fi

# -------------------------------
# zoxide: Smart Directory Navigation
# -------------------------------
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# -------------------------------
# Atuin: Shell History Manager
# -------------------------------
if type atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

# -------------------------------
# rbenv: Ruby Version Manager
# -------------------------------
if type rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi
