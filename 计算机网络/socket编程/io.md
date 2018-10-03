##服务器进程终止
服务器进程终止相当于服务器主动连对连接套接字调用close或shutdown(SHUT_RDWR)。
若服务器只进行了读半关闭，则客户端调用write发送的数据将会被服务器确认（ACK）并悄然丢弃。
若服务器只进行了写半关闭，则客户端通过write发送的数据会被服务器正常接收。
若服务器关闭了套接字，则客户端调用write会导致服务器发送RST，若客户端在接收到此RST后（而不是等到通过read读取到ECONNRESET后才）继续调用write，会引发SIGPIPE信号。
##服务器崩溃
##服务器崩溃后重启
##服务器关机
##read
```
ssize_t read (int fd,
			  void *buf, 
			  size_t nbytes)	//请求读取的字节数
			  
#return
0								//eof（FIN）
-1								//error
实际读取的字节数

#errno
EAGAIN/EWOULDBLOCK					//非阻塞模式下读取缓冲区中没有数据
ECONNRESET							//套接字已经接收到RST
ETIMEDOUT							//之前调用的某个write等待ACK超时
EHOSTUNREACH/ENETUNREACH			//之前调用的某个write得到了某个路由器相应的“目的地不可达”的ICMP消息
```
- read函数一旦读取到数据就会返回，而不是等到读取到请求读取的字节数
- 非阻塞模式下，若读取缓冲区中没有数据，read函数会立即返回-1，且errno会被设为EAGAIN或EWOULDBLOCK
- 阻塞模式下，若在套接字连接过程中，对方主机崩溃（没有发送FIN），且本地正阻塞于read，则该函数永远不会返回，因此需要对read设置超时返回
- 若在套接字连接过程中，对方主机崩溃后调用了write，则该本地TCP会持续重传数据分节直到超时，或者某个中间路由器判断对方主机不可达，相应了一个ICMP消息，这些错误都会在接下来调用的read函数中获得
##write

```
ssize_t write (int fd, 
			   const void *buf, 
			   size_t n)			//请求写入的数据大小
			   
#errno
EPIPE								//套接字已经接收到RST
EAGAIN/EWOULDBLOCK
```

- 阻塞模式下，一般而言，write函数会阻塞直到发送缓冲区剩余空间足够容纳所有的请求写入数据。而在非阻塞模式下，若发送缓冲区剩余空间不够大，write函数会写入一部分数据，并返回写入数据的字节数。若发送缓冲区剩余空间为0,write函数会返回0，且errno会被设为EAGAIN或EWOULDBLOCK
- 阻塞模式下，若进程阻塞于write函数时，对方关闭了套接字（不仅是发送了FIN），则write函数会将剩余缓冲区填满并返回所写的字节数（此操作会导致对方发送RST）
- 向一个已经关闭的远端套接字发送数据会导致远端服务器发送一个RST。当本地套接字接收RST后（RST的到达可以通过调用read得知），对其调用write函数会引发SIGPIPE信号，函数将返回-1,且errno会被置为EPIPE

