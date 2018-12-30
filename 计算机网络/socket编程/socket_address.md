###地址族
```
<sys/types.h>
typedef __uint16_t __sa_family_t;

<sys/socket.h>
typedef __sa_family_t sa_family_t;

AF_INET
AF_INET6
AF_UNIX
...
```
###端口号
```
#include <netinet/in.h>
typedef __uint16_t	in_port_t;
```
###ipv4地址
```
#include <netinet/in.h>
typedef __uint32_t	in_addr_t;

/* Address to accept any incoming messages.  */
#define	INADDR_ANY		((in_addr_t) 0x00000000)

/* Address to send to all hosts.  */
#define	INADDR_BROADCAST	((in_addr_t) 0xffffffff)

/* Address indicating an error return.  */
#define	INADDR_NONE		((in_addr_t) 0xffffffff)

/* Network number for local host loopback.  */
#define INADDR_LOOPBACK	((in_addr_t) 0x7f000001) 

struct in_addr
{
  in_addr_t s_addr;
};
```
###ipv4套接字地址
```
#include <netinet/in.h>

#define __SOCK_SIZE__	16
struct sockaddr_in
{
  sa_family_t sin_family;	//地址族，2bytes
  in_port_t sin_port;		//端口号，2bytes
  struct in_addr sin_addr;	//ipv4地址，4bytes

  unsigned char  __pad[__SOCK_SIZE__ - sizeof(short int)
			- sizeof(unsigned short int) - sizeof(struct in_addr)];
};
```
###ipv4通用套接字地址（仅作为参数类型）
```
#include <sys/socket.h>

struct sockaddr {
  sa_family_t sa_family;	//地址族
  char sa_data[14];			//传输协议相关的地址
};
```
###ipv6地址
```
<netinet/in.h>

struct in6_addr
{
  union
    {
      uint8_t 	  __s6_addr[16];
      uint16_t 	  __s6_addr16[8];
      uint32_t 	  __s6_addr32[4];
    } __u6;
#define s6_addr		__u6.__s6_addr
#define s6_addr16	__u6.__s6_addr16
#define s6_addr32	__u6.__s6_addr32
};
```
###ipv6套接字地址
```
<netinet/in.h>

struct sockaddr_in6
{
  sa_family_t sin6_family;		//地址族，2bytes
  in_port_t sin6_port;			//端口号,2bytes
  uint32_t sin6_flowinfo;		//
  struct in6_addr sin6_addr;	//ipv6地址，16bytes
  uint32_t sin6_scope_id;		//
};
```
###ipv6通用套接字地址（仅作为参数类型）
```
<sys/socket.h>

#define _SS_MAXSIZE 128	
#define _SS_ALIGNSIZE (sizeof (int64_t))
#define _SS_PAD1SIZE (_SS_ALIGNSIZE - sizeof (sa_family_t))
#define _SS_PAD2SIZE (_SS_MAXSIZE - (sizeof (sa_family_t) \
		      + _SS_PAD1SIZE + _SS_ALIGNSIZE))

struct sockaddr_storage {
  sa_family_t ss_family;
  char _ss_pad1[_SS_PAD1SIZE];
  int64_t __ss_align;
  char _ss_pad2[_SS_PAD2SIZE];
};
```
###字节排序函数###
```
#include  <netinet/in.h>
uint16_t htons(uint16_t host16bitvalue);
uint32_t htonl(uint32_t host32bitvalue);
uint16_t ntohs(uint16_t net16bitvalue);
uint32_t ntohs(uint32_t net32bitvalue);

h : host
n : network
s : short
l : long
```
##地址转换函数###
- ipv4转换函数
 
```
#include <arpa/inet.h>

//点分十进制字符串转ipv4地址
int inet_aton (const char *cp, 
			   struct in_addr *inp)
			   
#return
0	//error
1	//success


//ipv4地址转点分十进制字符串（返回的字符串在静态内存中，所以该函数不可重入）
char *inet_ntoa (struct in_addr __in)
```
- 通用地址转换函数

```
#include <arpa/inet.h>

```
	

