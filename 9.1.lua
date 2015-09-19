function combgen(a, m, n, b)
	if n == 0 then coroutine.yield(b) return end
	if m < n then return end
	b[#b + 1] = a[m]
	combgen(a, m - 1, n - 1, b)
	b[#b] = nil
	combgen(a, m - 1, n, b)
end

function combinations(a, n)
	return coroutine.wrap(function () combgen(a, #a, n, {}) end)
end

function printResult(c)
	for i = 1, #c do
		io.write(c[i], " ")
	end
	io.write("\n")
end

a = {1, 2, 3, 4, 5, 6}
n = 2
for c in combinations(a, n) do
	printResult(c)
end
