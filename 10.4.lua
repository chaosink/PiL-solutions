function allwords()
	local line = io.read() -- current line
	local pos = 1          -- current position in the line
	return function ()      -- iterator function
		while line do
			local s, e = string.find(line, "%w+", pos)
			if s then
				pos = e + 1
				return string.sub(line, s, e)
			else
				line = io.read()
				pos = 1
			end
		end
		return nil
	end
end

function prefix(word)
	local r = word[1]
	for i = 2, #word do
		r = r .. " " .. word[i]
	end
	return r
end

local statetab = {}

function insert(index, value)
	local list = statetab[index]
	if list == nil then
		statetab[index] = {value}
	else
		list[#list + 1] = value
	end
end

function progress(word, w)
	for i = 1, #word - 1 do
		word[i] = word[i + 1]
	end
	word[#word] = w
end



local N = arg[1] or 3
local MAXGEN = 10000
local NOWORD = "\n"

-- build table
local word = {}
for i = 1, N do
	word[i] = NOWORD
end

for w in allwords() do
	insert(prefix(word), w)
	progress(word, w)
end
insert(prefix(word), NOWORD)

-- generate text

for i = 1, N do
	word[i] = NOWORD
end

for i = 1, MAXGEN do
	local list = statetab[prefix(word)]
	-- choose a random item from list
	local r = math.random(#list)
	local nextword = list[r]
	if nextword == NOWORD then return end
	io.write(nextword, " ")
	progress(word, nextword)
end
