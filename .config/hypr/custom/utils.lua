local M = {}

--- Wraps a `color` value in "rgba()"
--- @param color string
--- @return string
function M.rgba(color)
    return "rgba(" .. color .. ")"
end

--- Dispatch multiple dispatchers
---@param dispatchers HL.Dispatcher[]
function M.dispatch_many(dispatchers)
    for _, dsp in ipairs(dispatchers) do
        hl.dispatch(dsp)
    end
end

--- Create a notification with text `log`
---@param val any
---@param duration number?
function M.debug(val, duration)
    duration = duration or 5000
    hl.notification.create({ text = tostring(val), timeout = duration })
end

return M