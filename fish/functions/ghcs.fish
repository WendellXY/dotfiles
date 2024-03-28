function ghcs --description 'Wrapper around `gh copilot suggest` to suggest a command based on a natural language description of the desired output effort.'
    set FUNCNAME ghcs
    set TARGET shell
    set GH_DEBUG $GH_DEBUG

    set -l __USAGE "Wrapper around `gh copilot suggest` to suggest a command based on a natural language description of the desired output effort.
Supports executing suggested commands if applicable.

USAGE
$FUNCNAME [flags] <prompt>

FLAGS
-d, --debug              Enable debugging
-h, --help               Display help usage
-t, --target target      Target for suggestion; must be shell, gh, git
                         default: \"$TARGET\"

EXAMPLES

- Guided experience
\$ $FUNCNAME

- Git use cases
\$ $FUNCNAME -t git \"Undo the most recent local commits\"
\$ $FUNCNAME -t git \"Clean up local branches\"
\$ $FUNCNAME -t git \"Setup LFS for images\"

- Working with the GitHub CLI in the terminal
\$ $FUNCNAME -t gh \"Create pull request\"
\$ $FUNCNAME -t gh \"List pull requests waiting for my review\"
\$ $FUNCNAME -t gh \"Summarize work I have done in issues and pull requests for promotion\"

- General use cases
\$ $FUNCNAME \"Kill processes holding onto deleted files\"
\$ $FUNCNAME \"Test whether there are SSL/TLS issues with github.com\"
\$ $FUNCNAME \"Convert SVG to PNG and resize\"
\$ $FUNCNAME \"Convert MOV to animated PNG\""

    set -l OPTIND 1

    for arg in $argv
        switch $arg
            case -d --debug
                set GH_DEBUG api
                set -e argv[$OPTIND]
            case -h --help
                echo "$__USAGE"
                return 0
            case -t --target
                set TARGET $argv[(math $OPTIND + 1)]
                set -e argv[$OPTIND]
                set -e argv[(math $OPTIND + 1)]
        end
        set OPTIND (math $OPTIND + 1)
    end

    set TMPFILE (mktemp gh-copilotXXX)
    function cleanup --on-variable TMPFILE
        rm -f $TMPFILE
    end

    if env GH_DEBUG="$GH_DEBUG" gh copilot suggest -t "$TARGET" $argv --shell-out $TMPFILE
        if test -s $TMPFILE
            set FIXED_CMD (cat $TMPFILE)
            history merge
            echo
            eval $FIXED_CMD
        end
    else
        return 1
    end
end
