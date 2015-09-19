Set = {}
local mt = {}
-- create a new set with the values of a given list
function Set.new(l)
	local set = {}
	setmetatable(set, mt)
	for _, v in ipairs(l) do set[v] = true end
	return set
end
function Set.union(a, b)
	local res = Set.new{}
	for k in pairs(a) do res[k] = true end
	for k in pairs(b) do res[k] = true end
	return res
end
function Set.intersection(a, b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end
function Set.difference(a, b)
	local res = Set.new{}
	for k in pairs(a) do
		if b[k] then
			res[k] = nil
		else
			res[k] = true
		end
	end
	return res
end
function Set.element_number(a)
	local n = 0
	for k, v in pairs(a) do
		n = n + 1
	end
	return n
end
-- presents a set as a string
function Set.tostring(set)
	local l = {} -- list to put all elements from the set
	for e in pairs(set) do
		l[#l + 1] = e
	end
	return "{" .. table.concat(l, ", ") .. "}"
end
-- print a set
function Set.print(s)
	print(Set.tostring(s))
end
s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
mt.__add = Set.union
mt.__mul = Set.intersection
mt.__sub = Set.difference
mt.__len = Set.element_number
s3 = s1 + s2
Set.print(s3)
Set.print(s3 * s1)
Set.print(s1 - s2)
print(#s1)
