Stack = {}

function Stack:new()
	local o = {
		buffer = {}
		top = 0
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Stack:push(v)
	top = top + 1
	self.buffer[top] = v
end

function Stack:pop()
	local v = self.buffer[top]
	self.buffer[top] = nil
	return v
end

function Stack:top(v)
	return self.buffer[top]
end

function Stack:isempty(v)
	if top == 0 then 
		return true
	else
		return false
	end
end

s = Stack:new()
print(s:isempty())
s:push(1)
s:push(2)
print(s:top())
print(s:pop())
print(s:top())
print(s:isempty())
