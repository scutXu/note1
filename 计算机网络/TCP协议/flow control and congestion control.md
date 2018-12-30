#流量控制
##定义
In data communications, flow control is the process of managing the rate of data transmission between two nodes to prevent a fast sender from overwhelming a slow receiver.
##目的
It provides a mechanism for the receiver to control the transmission speed, so that the receiving node is not overwhelmed with data from transmitting node.
##实现方式
###Stop-and-wait  
当发送方收到确认帧后才能发送一个新的数据帧。
###Sliding Window
发送窗口：已经发送但未接收对应ACK的Packet的最大区域。  
接收窗口：已经接收但未发送对应ACK的Packet的最大区域。  
实现机制：a receiver gives a transmitter permission to transmit data until a (receive)window is full  
自动重传请求（automatic repeat-request）：
- Go Back N： 
- Selective Repeat：
##TCP实现
TCP使用滑动窗口进行流量控制，TCP头部中的Windows Size指接收窗口当前还能继续接收的数据大小，单位为字节。  
#拥塞控制
##定义
###Congestive collapse
The condition in which congestion prevents or limits useful communication
###Congestion control
##目的
Avoid congestive collapse resulting from oversubscription
##实现方式
###Slow start
##TCP实现







