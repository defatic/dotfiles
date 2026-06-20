--- Used below link as reference
--- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua

---- MONITORS ----

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@144",
    position = "0x0",
    scale = "1",
})

---- MY PROGRAMS ----

-- Set programs that you use
local terminal    = "ghostty --title=Ghostty"
local menu        = "rofi -c $HOME/.config/rofi/config.rasi -show drun"
local fileManager = "nautilus"
local windowBar   = "waybar"
local wallpaper   = "hyprpaper"
local ideler      = "hypridle"
local clipHist    = "copyq"
local games       = "steam"
local browser     = "helium-browser"
local email       = "betterbird"

---- AUTOSTART ----

hl.on("hyprland.start", function()
    hl.exec_cmd(windowBar)
    hl.exec_cmd(wallpaper)
    hl.exec_cmd(ideler)
    hl.exec_cmd(clipHist)
    hl.exec_cmd(email)
    hl.exec_cmd(games)
    hl.exec_cmd(browser)
    hl.exec_cmd(terminal)
    -- hl.exec_cmd(xsettingsd)
    -- hl.exec_cmd("keepassxc --minimized")
    -- hl.exec_cmd("nextcloud --background")
end)

---- ENVIRONMENT VARIABLES ----

hl.env("XCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_SIZE","12")
hl.env("SDL_VIDEODRIVER","wayland")
hl.env("CLUTTER_BACKEND","wayland")
-- XDG
hl.env("XDG_CURRENT_DESKTOP","Hyprland")
hl.env("XDG_SESSION_TYPE","wayland")
hl.env("XDG_SESSION_DESKTOP","Hyprland")
-- QT
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1")
hl.env("QT_WATLAND_DISABLE_WINDOWDECORATION","1")
hl.env("QT_QPA_PLATFORMTHEME","qt6ct")
-- Nvidia env settings
hl.env("LIBVA_DRIVER_NAME","nvidia")
hl.env("GBM_BACKEND","nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("__GL_GSYNC_ALLOWED","1")
hl.env("__GL_VRR_ALLOWED","0")

---- PERMISSIONS ----

---- LOOK AND FEEL ----

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,

        border_size = 1,

        col = {
            active_border = { 
                colors = {
                    "rgba(33ccffee)",
                    "rgba(00ff99ee)",
                },
                angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding = 0,
        rounding_power = 0,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeInOutCubic", style = "slide" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2.5,  bezier = "easeInOutCubic", style = "slide" })
-- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2.5,  bezier = "easeInOutCubic", style = "slide" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "popin" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "slidefadevert" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "slidefadevert" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

hl.config ({
    master = {
        new_status = "master",
        orientation = "right",
        mfact = 0.5,
        new_on_top = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

---- INPUT ----

hl.config({
    input = {
        kb_layout  = "se",
        kb_variant = "",
        kb_model   = "pc105",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device = ({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.xwayland = ({
    force_zero_scaling = true,
})

---- KEYBINDINGS ----

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- bind = $mainMod, Q, exec, $terminal
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT" .. " + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + b ", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + F ", hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + CTRL + arrow keys
hl.bind(mainMod .. " + CTRL" .. " + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL" .. " + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL" .. " + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL" .. " + j", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT" .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT" .. " + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT" .. " + H", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

---- WINDOWS AND WORKSPACES ----

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

--[[ Comment start
hl.window_rule({
     name = "move-hyprland-run",
     match = { class = "hyprland-run" },
 
     move = "",
     float = true,
})
Comment end ]]

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

hl.window_rule({
    name = "Steam Game Window",
    center = true,
    workspace = "10",
    match = { class = "steam_app_.*" },
})

hl.window_rule({
    name = "Hero Siege",
    center = true,
    workspace = "10",
    match = { title = "Hero Siege" },
})

hl.window_rule({
    name = "KeePassXC",
    float = true,
    center = true,
    size = "1200 770",
    match = { class = ".*KeePassXC" },
})

hl.window_rule({
    name = "Discord",
    float = true,
    center = true,
    size = "1300 850",
    match = { class = "discord" },
})

hl.window_rule({
    name = "Helium Save Dialog",
    float = true,
    center = true,
    size = "950 600",
    match = { class = "xdg-desktop-portal-gtk" },
})

hl.window_rule({
    name = "Only Office save dialog",
    float = true,
    center = true,
    size = "412 120",
    match = { class = "DesktopEditors" },
})
