function stringrep(s, n)
	local r = ""
	if n > 0 then
		while n > 1 do
			if n % 2 ~= 0 then
				r = r .. s
			end
			s = s .. s
			n = math.floor(n / 2)
		end
		r = r .. s
	end
	return r
end

function gen_stringrep_n(n)
	code = "function stringrep_" .. n .. "(s) return stringrep(s, " .. n .. ") end"
	load(code)()
end

gen_stringrep_n(5)
print(stringrep_5("1"))
