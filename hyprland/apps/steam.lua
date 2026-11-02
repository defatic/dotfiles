-- Main steam window rules
hl.window_rule({
    name = "Steam",
    tag = "+steam",
    workspace = "2 silent",
    match = { class = "[S|s]team" },
})

hl.window_rule({
    name = "Steam Friends List",
    float = true,
    match = { tag = "steam", title = "Friends List" },
})

-- Where and how to start game windows
hl.window_rule({
    name = "Steam Game Window",
    -- fullscreen = true,
    center = true,
    workspace = "10",
    border_size = 0,
    no_blur = true,
    no_anim = true,
    no_shadow = true,
    match = { class = "steam_app_.*" },
})
