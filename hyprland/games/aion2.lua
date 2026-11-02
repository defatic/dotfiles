-- Aion 2 DPS meter window rules
hl.window_rule({
    name = "aion-dps-meter",
    match = {
        class = "^(a2tools-dps-meter)$",
    },
    float = true,
    pin = true,
    no_blur = true,
    no_anim = true,
    no_shadow = true,
    persistent_size = true,
    border_size = 0,
    suppress_event = "fullscreen maximize fullscreenoutput",
    move = { "1835", "1107" },
})

hl.window_rule({
    name = "aion-dps-meter-settings",
    match = {
        class = "^(a2tools-dps-meter)$",
        title = "^.*(Settings|Battle History|Fight)$",
    },
    float = true,
    center = true,
    no_blur = true,
    no_anim = true,
    no_shadow = true,
    border_size = 0,
})

hl.window_rule({
    name = "aion-dps-meter-plugin",
    match = {
        class = "^(a2tools-dps-meter)$",
        title = "^.*\\(plugin\\)$",
    },
    float = true,
    no_blur = true,
    no_anim = true,
    no_shadow = true,
    border_size = 0,
    size = { "348", "230" },
    move = { "1506", "134" },
})
