function combgen(a, m, n, b)
	if n == 0 then print(table.unpack(b)) return end
	if m < n then return end
	b[#b + 1] = a[m]
	combgen(a, m - 1, n - 1, b)
	b[#b] = nil
	combgen(a, m - 1, n, b)
end

function combinations(a, n)
	combgen(a, #a, n, {})
end

a = {1, 2, 3, 4, 5, 6}
combinations(a, 4)
