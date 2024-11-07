# use ($nu.default-config-dir | path join 'completions/bat-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/cargo-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/curl-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/eza-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/gh-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/git-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/make-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/rustup-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/ssh-completions.nu') *
# use ($nu.default-config-dir | path join 'completions/vscode-completions.nu') *

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $fish_completer
    } | do $in $spans
}

# Update the Nushell configuration
export def --env "set completions" [] {
    $env.config.completions = {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: true    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
        algorithm: "prefix"    # prefix or fuzzy
        sort: "smart" # "smart" (alphabetical for prefix matching, fuzzy score for fuzzy matching) or "alphabetical"
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
            completer: $external_completer
        }
        use_ls_colors: true # set this to true to enable file/path/directory completions using LS_COLORS
    }
}

export module activate {
    export-env {
        set completions
    }
}

# Activate the theme when sourced
use activate