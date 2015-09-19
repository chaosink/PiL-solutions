ignore = io.open(arg[1])
text = io.open(arg[2])

local function allwords(file)
	local auxwords = function ()
		for line in file:lines() do
			for word in string.gmatch(line, "%w+") do
				coroutine.yield(word)
			end
		end
	end
	return coroutine.wrap(auxwords)
end

local ig = {}
for w in allwords(ignore) do
	ig[w] = true
end

local counter = {}
for w in allwords(text) do
	if not ig[w] then
		counter[w] = (counter[w] or 0) + 1
	end
end

local words = {}
for w in pairs(counter) do
	words[#words + 1] = w
end

table.sort(words, function (w1, w2)
	return counter[w1] > counter[w2] or
		counter[w1] == counter[w2] and w1 < w2
	end)

for i = 1, math.min(#words, (tonumber(arg[1]) or 10)) do
	print(words[i], counter[words[i]])
end
