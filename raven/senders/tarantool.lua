local util = require 'raven.util'
local http = require 'http.client'
local json = require 'json'

local _M = {}
local mt = {}
mt.__index = mt

function mt:send(body)
	local headers = {
		['Content-Type'] = 'applicaion/json',
		['User-Agent'] = "raven-lua-tarantool/" .. util._VERSION,
		['X-Sentry-Auth'] = util.generate_auth_header(self),
	}

	local json_str = json.encode(body)

	local ok, response = pcall(
		http.request, 'POST', self.server, json_str,
		{
			headers = headers,
			timeout = self.timeout,
		}
	)
	if not ok or response.status ~= 200 then
		return nil, json.encode(response)
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
