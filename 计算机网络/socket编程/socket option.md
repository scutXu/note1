##get/set sockopt
##fcntl
##ioctl
```
#include <sys/ioctl.h>
int ioctl (int fd,
		   int request, 
		   ...)				//总是一个指针，指针的类型取决于request
		   
#return
0
-1

#errno
EINVAL
```
```
#include <sys/types.h>
typedef char *__caddr_t;
```
```
#include <net/if.h>

struct ifconf
  {
    int	ifc_len;						// buffer字节大小（值-结果参数）
	union
	{
		__caddr_t ifcu_buf;
		struct ifreq *ifcu_req;
	} ifc_ifcu;
  };
# define ifc_buf	ifc_ifcu.ifcu_buf	/* Buffer address.  */
# define ifc_req	ifc_ifcu.ifcu_req	/* Array of structures.  */



#define IF_NAMESIZE	16
struct ifreq
{
	# define IFHWADDRLEN	6
	# define IFNAMSIZ	IF_NAMESIZE
	union
	{
		char ifrn_name[IFNAMSIZ];			/* Interface name, e.g. "en0".  */
	} ifr_ifrn;

	union
	{
		struct sockaddr ifru_addr;
		struct sockaddr ifru_dstaddr;
		struct sockaddr ifru_broadaddr;
		struct sockaddr ifru_netmask;
		struct sockaddr ifru_hwaddr;
		short int ifru_flags;
		int ifru_ivalue;
		int ifru_mtu;
		struct ifmap ifru_map;
		char ifru_slave[IFNAMSIZ];			/* Just fits the size */
		char ifru_newname[IFNAMSIZ];
		__caddr_t ifru_data;
	} ifr_ifru;
};
```

