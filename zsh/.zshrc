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
bindkey -v                          # Use vi keybindings
source "$ZDOTDIR/alias.zsh"         # Load custom aliases
source "$ZDOTDIR/cursor_mode.zsh"   # Load cursor mode settings
# -------------------------------
# PATH Configuration
# -------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

if [[ "$(uname -sm)" == "Darwin arm64" ]]; then
  # Homebrew
  export PATH="/opt/homebrew/bin:$PATH"
  # Ghostty CLI
  export PATH="$GHOSTTY_BIN_DIR:$PATH"
fi

# Ruby gem
export PATH="$HOME/.gem/ruby/3.3.0/bin:$PATH"

# -------------------------------
# Zsh Autoload and Plugins
# -------------------------------
# Autoload functions and modules
autoload -U compinit; compinit        # Initialize Zsh completion system
zmodload zsh/complist                 # Enhanced completion features
autoload -Uz edit-command-line        # Command line editor widget
zle -N edit-command-line

# -------------------------------
# Zsh Functions
# -------------------------------
# Load custom Functions
for file in "$ZDOTDIR"/functions/*.zsh; do
  source "$file"
done

# -------------------------------
# fpath Configuration
# -------------------------------
fpath=("$HOME/.config/zsh/completions" $fpath)
fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
fpath=("$(brew --prefix)/share/zsh-abbr" $fpath)

# Source external plugins
source "$ZSHAREDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/themes/catppuccin_ansi-z-sy-h.zsh"  # Load syntax highlighting

source "$ZSHAREDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

source "$ZSHAREDIR/zsh-history-substring-search/zsh-history-substring-search.zsh"

source "$(brew --prefix)/share/zsh-abbr/zsh-abbr.zsh"

source "$(brew --prefix)/share/zsh-autosuggestions-abbreviations-strategy/zsh-autosuggestions-abbreviations-strategy.zsh"

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

# -------------------------------
# npm: Node Package Manager
# -------------------------------
if type npm &>/dev/null; then

	# Check if npm prefix is not set to ~/.npm-global
	if [ "$(npm config get prefix)" != "$HOME/.npm-global" ]; then
		npm set prefix "$HOME/.npm-global"
	fi

	# Update PATH
	export PATH="$HOME/.npm-global/bin:$PATH"

fi

# -------------------------------
# Initial Commands
# -------------------------------
if [[ -t 1 ]] && type tabs &>/dev/null; then
  tabs -2 &>/dev/null
fi

source "$ZDOTDIR/initial.zsh"
# -------------------------------
