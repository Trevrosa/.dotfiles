local matches = string.find
local window = hl.dsp.window

--- Create a notification with text `log`
---@param val any
---@param duration number?
local function debug(val, duration)
    duration = duration or 5000
    hl.notification.create({ text = tostring(val), timeout = duration })
end

--- Dispatch multiple dispatchers
---@param dispatchers HL.Dispatcher[]
local function dispatch_many(dispatchers)
    for _, dsp in ipairs(dispatchers) do
        hl.dispatch(dsp)
    end
end

-- float bitwarden popups
---@param w HL.Window?
hl.on("window.title", function(w)
    if w ~= nil and matches(w.title, "Extension: .+ Bitwarden .+ Firefox") then
        dispatch_many({
            window.float(w),
            window.resize({
                x = -362,
                y = -405,
                relative = true,
                window = w,
            }),
            window.center(w)
        })
    end
end)

-- -- float google sign in popups
-- ---@param w HL.Window?
-- hl.on("window.title", function(w)
--     if w ~= nil and matches(w.title, "Sign in - Google Accounts .+ Firefox") then
--         dispatch_many({
--             window.float(w),
--             window.resize({
--                 x = -375,
--                 y = -346,
--                 relative = true,
--                 window = w,
--             }),
--             window.center(w)
--         })
--     end
-- end)

-- run fuzzel when special:x is created
---@param ws HL.Workspace?
hl.on("workspace.created", function(ws)
    if ws ~= nil and ws.name == "special:x" then
        hl.exec_cmd("nohup fuzzel &")
    end
end)

-- FIXME
-- kill fuzzel when special:x is removed
---@param ws HL.Workspace?
hl.on("workspace.removed", function(ws)
    if ws ~= nil and ws.name == "special:x" then
        hl.exec_cmd("killall fuzzel")
    end
end)

-- -- remove weird blurry overlay on popups in winapps apps
-- ---@param w HL.Window?
-- hl.on("window.title", function (w)
-- 	if w ~= nil and w.title == "ActiproWindowChromeShadow" then
-- 		hl.dispatch(window.close(w))
-- 	end
-- end)
