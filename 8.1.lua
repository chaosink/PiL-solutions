function loadwithprefix(p, l)
	local t = 1;
	return load(function ()
		if t == 1 then
			if type(p) == "function" then
				local str = p()
				if not str then
					t = t + 1
					return ""
				else
					return str
				end
			else
				t = t + 1
				return p
			end
		elseif t == 2 then
			if type(l) == "function" then
				local str = l()
				if not str then
					t = t + 1
					return ""
				else
					return str
				end
			else
				t = t + 1
				return l
			end
		else
			return nil
		end
	end)
end

f = loadwithprefix("return ", io.lines("chunk.lua", "*L"))
print(f())
