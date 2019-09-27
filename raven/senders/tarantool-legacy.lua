local util = require 'raven.util'
local http = require 'http.client'

local _M = {}
local mt = {}
mt.__index = mt

function mt:send(body)
	local headers = {
		['Content-Type'] = 'applicaion/json',
		['User-Agent'] = "raven-lua-tarantool-legacy/" .. util._VERSION,
		['X-Sentry-Auth'] = util.generate_auth_header(self),
	}

	local json_str = box.cjson.encode(body)

	local res = http.post(self.server, json_str,
		{
			headers = headers,
			timeout = self.timeout,
		}
	)
	if res.status ~= 200 then
		return nil, box.cjson.encode(res)
	end

	return true
end

function _M.new(conf)
	local obj, err = util.parse_dsn(conf.dsn)
	if not obj then
		return nil, err
	end

	obj.timeout = conf.timeout or 1

	return setmetatable(obj, mt)
end

return _M
