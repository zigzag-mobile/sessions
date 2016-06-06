local json = require('json')
local sBox = require '/lua/sBox'

local function rendSuccess(req, data)
    return req:render { json = { status = 'success', data = data } }
end

local function rendError(req, message, code)
    return req:render { json = { status = 'error', message = message, code = code } }
end

local function tuple2Json(tuple)
    local ip, info = tuple[sBox.col.ip], tuple[sBox.col.info] -- optional cols
    return {
        token = tuple[sBox.col.token],
        user_id = tuple[sBox.col.userId],
        create = tuple[sBox.col.create],
        activity = tuple[sBox.col.activity],
        ip = ip and ip or json.NULL,
        info = info and info or json.NULL
    }
end

local function urlDecode(str)
    str = string.gsub(str, "+", " ")
    str = string.gsub(str, "%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    return str
end


local function new(req)
    local userId, ip, info = req:param('user_id'), req:param('ip'), req:param('info') -- info is optional
    if (not tonumber(userId)) then return rendError(req, 'invalid userId', 'invalid_user_id') end
    return rendSuccess(req, tuple2Json(sBox.space:insert {
        require('uuid').str(),
        math.floor(userId),
        ip,
        os.time(),
        os.time(),
        info and urlDecode(info) or nil
    }))
end

return {
    new = new
}