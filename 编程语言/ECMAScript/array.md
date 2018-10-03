###Array构造函数

```
var colors = new Array();
var colors = new Array(3);
var colors = new Array("red, "green", "blue")
var colors = Array();
var colors = Array(3);
var colors = Array("red, "green", "blue")

```

###字面量

```
var colors = [];
var colors = ["red, "green", "blue"];
```

###数组长度

```
var colors = ["red, "green", "blue"];
console.log(colors.length);            //3

colors[colors.length] = "yellow"       //追加项

colors[99] = "black"
console.log(colors.length);            //100
```
###检测数组

```
var colors = [];
var num = 0;

console.log(Array.isArray(colors));    //true
console.log(Array.isArray(num));       //false
```
###栈方法
###队列方法
###重排序方法
###操作方法
###位置（查找）方法

```
var numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1]

//从位置0往后查找第一个值为4的下标
console.log(numbers.indexOf(4));

//从位置numbers.length - 1往前查找第一个值为4的下标
console.log(numbers.lastIndexOf(4));

console.log(numbers.indexOf(4, 4));

console.log(numbers.indexOf(4));

//数据比较使用"==="操作符
```
###迭代方法
###归并方法