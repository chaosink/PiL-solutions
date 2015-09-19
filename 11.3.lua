local function name2node(graph, name)
	local node = graph[name]
	if not node then
		-- node does not exist; create a new one
		node = {name = name, arc = {}}
		graph[name] = node
	end
	return node
end

local function name2arc(graph, label, to)
	local arc = graph[label]
	if not arc then
		-- node does not exist; create a new one
		arc = {label = label, to = to}
		graph[label] = arc
	end
	return arc
end

function readgraph()
	local graph = {}
	for line in io.lines() do
		-- split line in two names
		local namefrom, nameto, label = string.match(line, "(%S+)%s+(%S+)%s+(%d)")
		-- find corresponding nodes
		local from = name2node(graph, namefrom)
		local to = name2node(graph, nameto)
		local arc = name2arc(graph, label, to)
		-- adds 'to' to the adjacent set of 'from'
		from.arc[arc] = true
	end
	return graph
end

function findpath(curr, to, path, visited)
	path = path or {}
	visited = visited or {}
	if visited[curr] then  -- node already visited
		return nil         -- no path here
	end
	visited[curr] = true   -- mark node as visited
	path[#path + 1] = curr -- add it to path
	if curr == to then     -- final node?
		return path
	end
	-- try all adjacent nodes
	for arc in pairs(curr.arc) do
		local p = findpath(arc.to, to, path, visited)
		if p then return p end
	end
	path[#path] = nil      -- remove node from path
end

function printpath(path)
	for i = 1, #path do
		print(path[i].name)
	end
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
p = findpath(a, b)
if p then printpath(p) end
