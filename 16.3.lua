Account = {}
local mt = { -- create metatable
	__index = function ()
		error("unaccessable")
	end,
	__newindex = function ()
		error("unaccessable")
	end,
}

function Account:new(o)
	local table = o or {}
	if not table.balance then
		table.balance = 0
	end
	local proxy = {}
	function proxy.deposit(v)
		table.balance = table.balance + v
	end
	function proxy.withdraw(v)
		table.balance = table.balance - v
	end
	function proxy.getbalance()
		return table.balance
	end
	setmetatable(proxy, mt)
	return proxy
end

a = Account:new()
print(a.getbalance())
a.deposit(100)
print(a.getbalance())
