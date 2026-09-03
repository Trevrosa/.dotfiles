local consts = require("./custom/consts")
local mainMod = consts.mainMod
local apps = consts.apps

local exec = hl.dsp.exec_cmd

-- poweroff: bind like close hyprland (m)
hl.bind(mainMod .. " + SHIFT + M", exec("poweroff"))

-- (p)in a window
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

-- (Print)screen
hl.bind("Print", exec("grimblast copysave area"))

-- (l)ock (+SHIFT) suspend
hl.bind(mainMod .. " + L", exec("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + L", exec("loginctl lock-session & systemctl start suspend-then-poweroff"))

-- ctrl (v)
hl.bind(mainMod .. " + V", exec("fuzzel-paste"))

-- (b)rowser
hl.bind(mainMod .. " + B", exec(apps.browser))

-- (f)ullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- special workspaces [(s)potify, d [general-purpose], e(x)cute]
-- the x workspace runs the menu picker on creation
for _, char in ipairs({ "s", "d", "x" }) do
    hl.bind(mainMod .. " + " .. char, hl.dsp.workspace.toggle_special(char))
    hl.bind(mainMod .. " + SHIFT + " .. char, hl.dsp.window.move({ workspace = "special:" .. char }))
end

-- move windows by keys
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mainMod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end

-- move to workspace silent [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = key, follow = false }))
end
