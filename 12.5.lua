function basicSerialize(o)
	if type(o) == "number" then
		return tostring(o)
	else -- assume it is a string
		return string.format("%q", o)
	end
end

function serialize(o, indent, saved)
	if type(o) == "number" then
		io.write(o)
	elseif type(o) == "string" then
		io.write(string.format("%q", o))
	elseif type(o) == "table" then
		saved[o] = true
		io.write("{")
		local space = string.rep(" ", indent * 4)
		local first = true
		for k, v in pairs(o) do
			local space_d = string.rep(" ", 4)
			if not saved[v] then
				if first then
					io.write("\n")
					first = false
				end
				if type(k) == "string" and string.format("%q", k) == '"' .. k .. '"' then
					io.write(space, space_d, k, " = ")
				else
					io.write(space, space_d, "[")
					serialize(k, intent)
					io.write("] = ")
				end
				serialize(v, indent + 1, saved)
				io.write(",\n")
			end
		end
		io.write(space .. (indent == 0 and "}\n" or "}"))
	else
		error("cannot serialize a " .. type(o))
	end
end

function save_d(name, value, saved)
	saved = saved or {} -- initial value
--	io.write(name, " = ")
	if type(value) == "number" or type(value) == "string" then
--		io.write(basicSerialize(value), "\n")
	elseif type(value) == "table" then
		if saved[value] then -- value already saved?
--			io.write(saved[value], "\n") -- use its previous name
		else
			serialize(value, 0, saved)
			saved[value] = name -- save name for next time
--			io.write("{}\n") -- create a new table
			for k, v in pairs(value) do -- save its fields
				k = basicSerialize(k)
				local fname = string.format("%s[%s]", name, k)
				save_d(fname, v, saved)
			end
		end
	else
		error("cannot save a " .. type(value))
	end
end

function save_dd(name, value, saved)
	saved = saved or {} -- initial value
--	io.write(name, " = ")
	if type(value) == "number" or type(value) == "string" then
--		io.write(basicSerialize(value), "\n")
	elseif type(value) == "table" then
		if saved[value] then -- value already saved?
			io.write(name, " = ", saved[value], "\n") -- use its previous name
		else
			saved[value] = name -- save name for next time
--			io.write("{}\n") -- create a new table
			for k, v in pairs(value) do -- save its fields
				k = basicSerialize(k)
				local fname = string.format("%s[%s]", name, k)
				save_dd(fname, v, saved)
			end
		end
	else
		error("cannot save a " .. type(value))
	end
end

function copyTable(st)
	local tab = {}
	for k, v in pairs(st or {}) do
		if type(v) ~= "table" then
			tab[k] = v
		else
			tab[k] = copyTable(v)
		end
	end
	return tab
end

function save(name, value, saved)
	io.write(name, " = ")
	saved_d = copyTable(saved)
	save_d(name, value, saved_d)
	save_dd(name, value, saved)
end

a = {x = 1, y = 2, {3, 4, 5}}
a[2] = a -- cycle
a.z = a[1]
save("a", a)

print("--------------------")

a = {{"one", "two"}, 3}
b = {k = a[1]}
save("a", a)
save("b", b)

print("--------------------")

local t = {}
save("a", a, t)
save("b", b, t)
