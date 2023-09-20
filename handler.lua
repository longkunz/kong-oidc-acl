---@diagnostic disable: undefined-global
local ACL = {
    PRIORITY = 950,
    VERSION = "1.0",
}

---https://docs.konghq.com/konnect/reference/plugins/
local cjson = require("cjson")

function ACL:access(plugin_conf)
    local whitelist = plugin_conf.whitelist
    local userroles = GetUserRoles(plugin_conf.userinfo_header_name)

    if CheckValue(whitelist, userroles) then
        return
    else
        ---kong là một biến của Kong gateway
        return kong.response.exit(403, {
            message = "Access Denied!!!"
        })
    end

end

function CheckValue (tab, val)
    for _, value in ipairs(tab) do
        for _, val_value in ipairs(val) do
            if value == val_value then
                return true
            end
        end
    end

    return false
end

function SplitRequestHeader(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    local i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function GetUserRoles(userinfo_header_name)
    ---ngx được là biến trong module OpenResty
    local h = ngx.req.get_headers()
    for k, v in pairs(h) do
        if string.lower(k) == string.lower(userinfo_header_name) then
            local user_info = cjson.decode(ngx.decode_base64(v))
            local roles = table.concat(user_info["realm_access"]["roles"], ",")
            return SplitRequestHeader(roles, ",")
        end
    end

    return {}
end

return ACL