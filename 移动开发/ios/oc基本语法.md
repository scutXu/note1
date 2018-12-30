interface代表类的声明。

```
//MyClass类继承NSObject
@interface MyClass : NSObject
{
	
}

//以+号为前缀的方法为静态方法，以-号为前缀的方法为成员方法
- (void)memberFunc;
+ (void)staticFunc;
@end
```

implement代表类的实现

```

```

oc函数语法

```
//函数声明
- (returnType) functionNamePart0: (arg0Type)arg0Name functionNamePart1: (arg1Type)arg1Name 
- (void) setName: (NSString*)name andAge: (int)age

//函数调用
[obj functionNamePart0: arg0Value functionNamePart1: arg1Value];
[obj setName: @"jack" andAge: 10];
```

oc的协议才是通常意义上的接口

```
//声明协议
@protocol MyProtocol

- (void) protocolFunc;
@end

//MyClass继承NSObject并实现MyProtocol协议
@interface MyClass : NSObject <MyProtocol>
@end

//MyClass需要实现协议的方法
@implement MyClass
- (void) protocolFunc;
@end
```

使用property定义成员变量的好处是能够自动生成getter和setter方法，并且可以通过设置property的特性来控制getter和setter的行为。使用object.value = 5对属性赋值时，会隐式调用setter函数

```
@interface MyClass : NSObject
//
@property(nonatomic, assign) int value
@end
```