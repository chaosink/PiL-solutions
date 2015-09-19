List = {}
function List.new()
	return {fist = 0, last = 0}
end
function List.pushfirst(list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end
function List.pushlast(list, value)
	local last = list.last
	list.last = last + 1
	list[last] = value
end
function List.popfirst(list)
	local first = list.first
	if first == list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil -- to allow garbage collection
	list.first = first + 1
	return value
end
function List.poplast(list)
	local last = list.last
	if list.first == last then error("list is empty") end
	local value = list[last - 1]
	list[last - 1] = nil -- to allow garbage collection
	list.last = last - 1
	return value
end
