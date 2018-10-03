this代表函数的调用者，当作为全局函数调用时，this指向全局对象，在浏览器中为window对象

```
function f1() {
  return this;
}

// In a browser:
f1() === window; // true 

// In Node:
f1() === global; // true
```
当作为对象的方法调用时，this指向该对象

```
var o = {
  prop: 37,
  f: function() {
    return this.prop;
  }
};

console.log(o.f()); // 37
```
此特性并不受函数的定义方式影响，对于上述的例子，我们可以先简单的声明一个函数，后将函数与对象的域关联

```
var o = {prop: 37};

function independent() {
  return this.prop;
}

o.f = independent;

console.log(o.f()); // 37
```
指定this对象不一定必须通过成员方法调用来实现，也可以使用function的call或apply方法实现。这两者的功能完全相同，只是参数传入的方式不同

```
function add(c, d) {
  return this.a + this.b + c + d;
}

var o = {a: 1, b: 3};

add.call(o, 5, 7); // 16

add.apply(o, [10, 20]); // 34
```
对函数调用bind，会返回一个新的函数，该函数不论如何被调用，this对象都指向bind方法的参数。bind还可以用于指定固定参数，类似placeholder。（bind的作用和std::bind基本一致

```

```