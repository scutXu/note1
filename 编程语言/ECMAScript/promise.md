Promise构造函数接受一个函数作为参数，假设为a，a的参数也是一个函数，假设为b（resolve）。a的作用是调用异步操作，b的作用是作为异步操作的回调处理函数。

在创建Promise时，a的内容必须已经明确。b可以后续通过对Promise对象调用then方法传入。

async和await是替代then的一种写法，调用async函数，执行完Promise中的异步调用后，函数直接返回，后续的逻辑放在在Promise异步代码完成后继续接着执行。

```
//then写法
let promise = new Promise(resolve => {
	setTimeout(() => {
		resolve("hello");
	}, 2000);
});

promise.then(result => {
	console.log(result);  //"hello"
});
```

```
//async/await写法
async function asyncCall() {
	let result = await new Promise(resolve => {
		setTimeout(() => {
			resolve("hello");
		}, 2000);
	});
	console.log(result); // "hello"
}
```

