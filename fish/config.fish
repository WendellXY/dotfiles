if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Zoxide Configs
zoxide init fish --cmd cd | source

# Fzf Configs
fzf --fish | source

# Starship Configs
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
