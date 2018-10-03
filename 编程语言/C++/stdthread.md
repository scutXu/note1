###启动线程
线程在构造函数执行后启动，std::thread接收任何callable的类型作为构造函数参数

```
#include <thread>

void threadFunc() {}

struct Callable {
	void operator()() {}
}

int main() {
	std::thread t1(threadFunc);
	
	Callable c;
	std::thread t2(c);
	
	std::thread t3([] {
		...
	});
}
```
std::thread是Movable但Non-Copyable的

```
#include <thread>

std::thread makeThread() {
	callable c;
	return std::thread(c);
}

int main() {
	std::thread t1 = makeThread();	/*该语句实际进行了两次move*/
	std::thread t2 = t1;			/*error*/
}
```
向线程传递参数的方式有两种，在std::thread的参数中直接传入或使用std::function。这些参数和函数对象会以**复制**的方式保存在std::thread对象中。
###结束线程
在std::thread对象销毁前，程序应该对其调用join或detach，否则析构函数会对其调用terminate
###互斥量
```
#include <mutex>

std::mutex m;

void func() {
	...

	m.lock();
	...
	m.unlock();
	
	...
}

void func() {
	...
	{
		std::lock_guard<std::mutex> lg(m);
		...
	}
	...
}
```
###条件变量
由于std::lock_ guard在其生命周期过程中不允许释放锁，但是std::condition_ variable::wait可能需要对锁进行释放，因此std::conditio_ variable应该结合std::unique_ lock使用

```
#include <mutex>
#include <condition_variable>

std::mutex m;
std::condition_variable cv;
Queue queue;

void producer() {
	{
		std::unique_lock<std::mutex> ul(m);
		cv.wait(ul,[] {
			return !queue.full();
		});
		queue.push();
	}
	cv.notify_one();
}

void consumer() {
	{
		std::unique_lock<std::mutex> ul(m);
		cv.wait(ul,[] {
			return !queue.empty();
		});
		queue.pop();
	}
	cv.notify_one();
}
```


