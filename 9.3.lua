function count1(c)
	while true do
		io.write(1, " ")
		coroutine.yield(c)
	end
end

function count2(c)
	while true do
		io.write(2, " ")
		coroutine.yield(c)
	end
end

function count3(c)
	while true do
		io.write(3, " ")
		coroutine.yield(c)
	end
end

function dispatch()
	local t = threads[1]
	while true do
		status, t = coroutine.resume(t, transfer[t])
	end
end

function AddThread(t)
	local co = coroutine.create(t)
	table.insert(threads, co)
end

threads = {}
AddThread(count1)
AddThread(count2)
AddThread(count3)

transfer = {}
transfer[threads[1]] = threads[2]
transfer[threads[2]] = threads[3]
transfer[threads[3]] = threads[1]

dispatch()
