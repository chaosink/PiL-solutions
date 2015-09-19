function baiscSerialize(o)
	if type(o) == "number" then
		return tostring(o)
	else -- assume it is a string
		return string.format("%q", o)
	end
end

function serialize(o, used)
	io.write("{")
	local used = used or {}
	for k, v in pairs(o) do
		if not used[v] then
			io.write(baiscSerialize(v), ", ")
			used[v] = true
		end
	end
	io.write("}")
end

serialize({1, 2, '3', 1})
