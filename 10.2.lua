local N = 8
local a = {1, 2, 3, 4, 5, 6, 7, 8}
local s = 0

function permgen(a, n)
	n = n or #a
	if n <= 1 then
		coroutine.yield(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n]
			permgen(a, n - 1)
			a[n], a[i] = a[i], a[n]
		end
	end
end

function permutations(a)
	return coroutine.wrap(function () permgen(a) end)
end

-- check whether position (n, c) is free from attacks
local function ok(a)
	local n = #a
	for i = 1, n - 1 do -- for each queen already placed
		for j = i + 1, n do
			if (a[i] - i == a[j] - j) or   -- same diagonal?
			(a[i] + i == a[j] + j) then -- same diagonal?
				return false
			end
		end
	end
	return true -- no attacks; place is OK
end

-- print a board
local function printsolution(a)
	for i = 1, N do
		for j = 1, N do
			io.write(a[i] == j and "X" or "-", " ")
		end
		io.write("\n")
	end
	io.write("\n")
end

for p in permutations(a) do
	if ok(p) then
		printsolution(p)
		s = s + 1
	end
end

print(s)
