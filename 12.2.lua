function serialize(o, indent)
	if type(o) == "number" then
		io.write(o)
	elseif type(o) == "string" then
		io.write(string.format("%q", o))
	elseif type(o) == "table" then
		io.write("{\n")
		local space = string.rep(" ", indent * 4)
		for k, v in pairs(o) do
			local space_d = string.rep(" ", 4)
			io.write(space, space_d, "[")
			serialize(k, intent)
			io.write("] = ")
			serialize(v, indent + 1)
			io.write(",\n")
		end
		io.write(space .. (indent == 0 and "}\n" or "}"))
	else
		error("cannot serialize a " .. type(o))
	end
end

a = {a=1, b="2"}
b = {a=1, b="2", a}
c = {a=1, b="2", b}
serialize(c, 0)
