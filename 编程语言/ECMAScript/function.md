#ES6
##箭头函数
###特性
- 没有this，super，arugments和new.target绑定
- 不能通过new关键字调用
- 没有原型
- 不可以改变this绑定
- 不支持arguments对象

###语法

```
let sum = (num1, num2) => num1 + num2;

let sum = (num1, num2) => {
	return num1 + num2;
}

//参数只有1个时可以省略括号
let reflect = value => value;

//没有参数时需要有括号或下划线
let getName = () => "Nicholas";
let getName = _ => "Nicholas";

//返回对象字面量时需要用括号包裹起来，避免和函数块混淆
let getTempItem = id => ({id: id, name: "Temp" });
```
###没有this绑定
没有this绑定应该理解为在创建函数时就固定了this绑定，能够用于代替bind的使用
