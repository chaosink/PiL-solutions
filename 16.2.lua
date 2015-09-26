Stack = {}

function Stack:new()
	local o = {
		buffer = {},
		top_ptr = 0
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Stack:push(v)
	self.top_ptr = self.top_ptr + 1
	self.buffer[self.top_ptr] = v
end

function Stack:isempty(v)
	if self.top_ptr == 0 then 
		return true
	else
		return false
	end
end

function Stack:pop()
	if self:isempty() then error("empty") end
	local v = self.buffer[self.top_ptr]
	self.buffer[self.top_ptr] = nil
	self.top_ptr = self.top_ptr - 1
	return v
end

function Stack:top(v)
	if self:isempty() then error("empty") end
	return self.buffer[self.top_ptr]
end



StackQueue = Stack:new()
StackQueue.bottom_ptr = 1

function StackQueue:isempty()
	if self.bottom_ptr > self.top_ptr then
		return true
	else
		return false
	end
end

function StackQueue:bottom()
	if self:isempty() then error("empty") end
	return self.buffer[self.bottom_ptr]
end

function StackQueue:insertbottom(v)
	self.bottom_ptr = self.bottom_ptr - 1
	self.buffer[self.bottom_ptr] = v
end

s = StackQueue:new()
print(s:isempty())
s:push(1)
s:push(2)
print(s:top())
print(s:pop())
print(s:top())
print(s:isempty())
s:insertbottom(3)
print(s:bottom())
