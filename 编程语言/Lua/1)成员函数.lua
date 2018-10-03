不合适的函数定义方式
Account = {balance = 0}
function Account.withdraw (v)
	Account.balance = Account.balance - v
end

a, Account = Account, nil
a.withdraw(100.00)      -- ERROR!



用 . 符号定义函数
function Account.withdraw (self, v)
	self.balance = self.balance - v
end

a1 = Account; Account = nil
a1.withdraw(a1, 100.00)   -- OK



用 : 符号定义函数
function Account:withdraw (v)
	self.balance = self.balance - v
end

a1 = Account; Account = nil
a:withdraw(100.00)

使用 : 符号定义函数，相当于增加一个self形参
使用 : 符号调用函数，相当于增加一个self实参


用 . 定义的函数可以使用 : 进行调用，反之亦然
function Account:deposit (v)
	self.balance = self.balance + v
end
Account.deposit(Account, 200.00)