###生成器
生成器是一种返回迭代器的函数，通过function关键字后的星号`(*)`来表示

```
function *generator(items) {
	for(let i = 0; i < items.length; i ++) {
		yield items[i];
	}
}
```

###迭代器
迭代器是一种特殊对象，每个迭代器对象都有一个`next()`方法，每次调用都会返回一个结果对象。

```
let iterator = generator([1, 2, 3]);
console.log(iterator.next()) // "{ value: 1, done: false}"
console.log(iterator.next()) // "{ value: 2, done: false}"
console.log(iterator.next()) // "{ value: 3, done: false}"
console.log(iterator.next()) // "{ value: undefined, done: true}"
```
###理解生成器和迭代器
生成器的作用是定义逻辑内容和创建迭代器，迭代器用于执行逻辑，每个迭代器都会记录一个属于自己的当前执行状态。
###闭包实现
可以看出迭代器对数据集合`(items)`持有的是弱引用，且每个迭代器对象都有一个独立的当前状态`(i)`

```
function generator(items) {
	var i = 0;
	return {
		next: function() {
			var done = (i >= items.length)
			var value = !done ? items[i++] : undefined;
			return {
				done: done,
				value: value
			};
		}
	};
}
```
