hl.window_rule({
    name = "Betterbird",
    tag = "+email",
    workspace = "3 silent",
    match = { class = ".*Betterbird" },
})

hl.window_rule({
    name = "Write email",
    float = true,
    size = "1200 770",
    match = { tag = "email", title = "Write:.*" },
})

hl.window_rule({
    name = "eMail Message Filters",
    float = true,
    center = true,
    size = "930 360",
    match = { tag = "email", title = "Message Filters" },
})
