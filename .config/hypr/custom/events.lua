local utils = require("./custom/utils")
local dispatch_many = utils.dispatch_many
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

-- run fuzzel when special:x is created
---@param ws HL.Workspace?
hl.on("workspace.created", function(ws)
    if ws ~= nil and ws.name == "special:x" then
        hl.exec_cmd("fuzzel", { workspace = "special:x" })
    end
end)

-- kill fuzzel when special:x is removed
hl.on("workspace.removed", function(ws)
    if hl.get_workspace("special:x") == nil then
        hl.exec_cmd("killall fuzzel")
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
