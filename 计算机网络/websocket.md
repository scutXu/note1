##协议升级
一次http会话的流程是：

1. 客户端发起tcp连接，并发送http请求报文。
2. 服务端接收并解析http请求报文后，向客户端发送http响应报文
3. 服务端关闭tcp套接字

websocket连接的流程是：

1. 客户端发起tcp连接，发送一个头部带Websocket相关字段的http请求报文
2. 服务端识别到这是一个请求升级到Websocket连接的报文后，发送一个头部带Webskcoet相关字段的http响应报文
3. tcp套接字继续保持打开，服务端和客户端基于此tcp套接字建立起全双工的Websocket协议连接

请求升级websocket的http报文

```
GET ws://websocket.example.com/ HTTP/1.1
Origin: http://example.com
Connection: Upgrade
Host: websocket.example.com
Upgrade: websocket
```
