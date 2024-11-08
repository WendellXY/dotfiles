def "git tag inc" [
    --patch (-p),
    --minor (-m),
    --major (-M)
] {
    # check if current folder is a git repository
    let git = git rev-parse --is-inside-work-tree

    let current_tag = (git tag | lines | last)
    let tag = if $patch {
        $current_tag | inc --patch
    } else if $minor {
        $current_tag | inc --minor
    } else if $major {
        $current_tag | inc --major
    } else {
        $current_tag | inc --patch
    }

    print $"Current tag is ($current_tag), a new tag will be created: ($tag)"

    git tag $tag
}