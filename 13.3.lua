local index = {} -- create private index
local mt = { -- create metatable
	__index = function (t, k)
		print("*access to element " .. tostring(k))
		return t[index][k] -- access the original table
	end,
	__newindex = function (t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		t[index][k] = v -- update original table
	end,
	__pairs = function (t)
		return function (t, k)
			return next(t[index], k)
		end, t
	end,
	__ipairs = function (t)
		return function (t, k)
			k = k + 1
			if not t[index][k] then
				k = nil
			end 
			return k, t[index][k]
		end, t, 0
	end
}
function track(t)
	local proxy = {}
	proxy[index] = t
	setmetatable(proxy, mt)
	return proxy
end
t = {}
t = track(t)
t[2] = "world"
t[1] = "hello"
t[4] = "hi"
for k, v in ipairs(t) do
	print(k, v)
end
