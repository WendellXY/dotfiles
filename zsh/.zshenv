# -------------------------------
# Zsh Directory Configuration
# -------------------------------
# Define the root directory for Zsh configuration files
export ZDOTDIR="$HOME/.config/zsh"

# -------------------------------
# History Configuration
# -------------------------------
# Define the location and size of the history file
export HISTFILE="$ZDOTDIR/.history"
export HISTSIZE=10000              # Maximum number of commands in memory
export SAVEHIST=10000              # Maximum number of commands in the history file

# -------------------------------
# Editor Configuration
# -------------------------------
# Set the default editor
export EDITOR="nvim"               # Default editor for CLI tools
export VISUAL="nvim"               # Default editor for visually interactive tools

# -------------------------------
# Key and Search Settings
# -------------------------------
export KEYTIMEOUT=1                # Reduce delay for mode switching
export HISTORY_SUBSTRING_SEARCH_PREFIXED=1  # Enable prefixed substring search