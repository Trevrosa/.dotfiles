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

--- Create a notification with multiple values
function M.debug(...)
    local args = {}
    for i, v in ipairs({ ... }) do
        args[i] = M.stringify(v)
    end
    hl.notification.create({ text = table.concat(args, " "), timeout = 5000 })
end

--- Convert a value into a string
function M.stringify(val)
    local str = ""
    if type(val) == "table" then
        str = "{ "
        local i = 0
        local len = M.table_len(val)
        for key, value in pairs(val) do
            str = str .. M.stringify(key) .. " = " .. M.stringify(value)
            i = i + 1
            if i < len then str = str .. ", " end
        end
        str = str .. " }"
    elseif type(val) == "number" then
        str = tostring(math.floor(val))
    else
        str = tostring(val)
    end
    return str
end

--- Get the number of entries in a table
---@param t table
---@return number
function M.table_len(t)
    local i = 0
    for _, _ in pairs(t) do
        i = i + 1
    end
    return i
end

return M
