function multiload(...)
	local t = 1;
	local arg = {...}
	return load(function ()
		if type(arg[t]) == "function" then
			local str = arg[t]()
			if not str then
				t = t + 1
				return " "
			else
				return str
			end
		else
			t = t + 1
			return arg[t - 1]
		end
	end)
end

f = multiload("local x = 10;", io.lines("chunk.lua", "*L"), " print(x)")
print(f())
