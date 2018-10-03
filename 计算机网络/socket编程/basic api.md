##errno##
```
#include <sys/errno.h>

extern int errno;
```
```
include <stdio.h>
void perror (const char * s)
```
##socket

```
#include <sys/socket.h>

int socket (int __family,		//协议族（地址族）
		    int __type,			//套接字类型
			int __protocol);	//协议类型

#family
AF_INET				//IPv4协议
AF_INET6
AF_LOCAL
AF_ROUTE
AF_KEY

#type
SOCK_STREAM			//字节流套接字（TCP）
SOCK_DGRAM			//数据报套接字（UDP）
SOCK_SEQPACKET		//有序分组套接字
SOCK_RAW			//原始套接字

#protocol
IPPROTO_TCP			//TCP传输协议
IPPROTO_UDP			//UDP传输协议
IPPROTO_SCTP		//SCTP传输协议
0					//根据family和type自动判断

#return
套接字描述符
-1					//error

#errno
EACCES
EAFNOSUPPORT
EINVAL
EMFILE
ENOBUFS/ENOMEM
EPROTONOSUPPORT
```
##bind
```
#include <sys/socket.h>

int bind(int sockfd,	
		 const struct sockaddr * myaddr,		//特定于某种协议的本地套接字地址
		 socklen_t addrlen)					//地址的长度
		 
#retrun
0
-1
```

- 对于TCP而言，可以指定一个端口号，或指定一个IP地址，或两者都指定，或两者都不指定

##connect
```
#include <sys/socket.h>
int connect (int sockfd,
			 const struct sockaddr *servaddr,		//服务器套接字地址
			 socklen_t addrlen);

#return
0					//sucess
-1					//error

#errno
ETIMEDOUT						SYN没有响应，目的ip地址不存在
ECONNREFUSED					SYN响应是RST，目的端口没有进程在监听
EHOSTUNREACH/ENETUNREACH
EINPROGRESS                     非阻塞connect
```
- 调用connect（阻塞或非阻塞），当连接成功建立时，描述符变为可写，当连接建立遇到错误时，描述符变为既可读又可写。
- 不能根据描述符是否既可读又可写来判断非阻塞connect是否成功，因为在调用select前对端可能已经发送了数据，导致描述符变为可读。具体判断连接是否成功参考P353
- 阻塞式connect的超时时间由内核决定（取决于不同内核实现，从75秒到数分钟）。可以通过非阻塞connect和对selec指定时间限制实现一个自定义的connect超时时间
- 阻塞式connect可能被系统信号中断（EINTR），这不代表连接失败。在这种情况下，为了获取connect的状态，可以使用select

##listen

```
int listen (int sockfd,			//监听套接字描述符
			int backlog);		//未完成连接队列和已完成连接队列总和的最大值

#return
0
-1
```

- 未完成连接队列：接收了SYN请求，但未完成三路握手（处于SYN_received状态）的套接字队列
- 已完成连接队列：完成三路握手（处于的Established状态）的套接字队列

##accpet
```
int accept (int sockfd,						//监听套接字描述符
			struct sockaddr *cliaddr,		//客户端地址
			socklen_t *addrlen);			//客户端地址长度

#return
连接套接字描述符
-1

#errno
EAGAIN/EWOULDBLOCK						//非阻塞模式下已完成连接队列中没有可返回的连接套接字
ECONNABORTED							//三路握手完成后，accpet调用前，对端发送了RST（连接中止）
EINTR                                   //阻塞模式下，被系统信号中断
```
- accpet会从已完成连接队列中返回一个套接字给进程
- 源自Berkeley的内核实现不会将ECONNABORTED返回给程序，对连接终止的套接字直接移除

##close##
```
#include <unistd.h>

int close(int sockfd)

#return
0
-1
```
- 默认情况下，close会马上返回，tcp负责发送写缓冲区中的剩余内容，并接着发送FIN


