if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Initialize various tools and plugins
# zoxide: Fast directory navigation tool
zoxide init fish --cmd cd | source

# fzf: Fuzzy finder configuration
fzf --fish | source
set -Ux FZF_DEFAULT_COMMAND "rg --files"
set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Starship: Cross-shell prompt with extensive customization
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
