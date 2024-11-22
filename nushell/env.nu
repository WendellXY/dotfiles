# Nushell Environment Config File
#
# version = "0.99.1"

$env.EDITOR = "nvim"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

$env.CARGO_HOME = ($env.HOME | path join '.cargo')

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

use std "path add"

path add /opt/homebrew/bin
path add ($env.CARGO_HOME | path join "bin")
path add ($env.HOME | path join ".rbenv" "shims")
path add ($env.HOME | path join ".local" "bin")

zoxide init nushell | save -f ($nu.default-config-dir | path join "zoxide.nu")
atuin init nu | save -f ($nu.default-config-dir | path join "atuin.nu")

$env.STARSHIP_CONFIG = (([$env.HOME '.config' 'starship' 'starship.toml'] | path join) | path expand)

$env.LS_COLORS = (vivid generate catppuccin-mocha | str trim)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')
