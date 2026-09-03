hl.window_rule({
    name = "move spotify to workspace",
    match = {
        initial_class = "Spotify",
    },
    workspace = "special:s silent"
})
