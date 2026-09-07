local utils = require("./custom/utils")
local dispatch_many, debug = utils.dispatch_many, utils.debug
local matches = string.find
local window = hl.dsp.window

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

local x_existed = false

-- run fuzzel when special:x is created
---@param ws HL.Workspace?
hl.on("workspace.created", function(ws)
    if ws ~= nil and ws.name == "special:x" then
        hl.exec_cmd("fuzzel", { workspace = "special:x" })
        x_existed = true
    end
end)

-- kill fuzzel when special:x is removed
hl.on("workspace.removed", function(ws)
    if x_existed then
        hl.exec_cmd("killall fuzzel")
        x_existed = false
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

-- -- remove weird blurry overlay on popups in winapps apps
-- ---@param w HL.Window?
-- hl.on("window.title", function (w)
-- 	if w ~= nil and w.title == "ActiproWindowChromeShadow" then
-- 		hl.dispatch(window.close(w))
-- 	end
-- end)
