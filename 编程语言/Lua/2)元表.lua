prototype = {x = 0, y = 0, width = 100, height = 100}
mt = {}    -- create a metatable

创建一个表并设置元表
function new ()
	o = {}
	setmetatable(o, mt)
	return o
end

定义元表的__index项
mt.__index = function (_, key)
	return prototype[key]
end

__index项可以是一个函数，也可以是一个表
mt.__index = prototype


访问表的项时，lua会进行以下操作：
while(true) do
	if(表中存在项) then
		return 项
	else if(not 表设置了元表) then
		return nil
	else if(not 元表定义了__index) then
		return nil
	else if(__index是一个函数) then
		return __index(表，项名)
	else
		表 = 元表
	end
end


