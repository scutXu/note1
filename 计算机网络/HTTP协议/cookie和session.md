###http识别机制

- HTTP请求报文首部中存储的用户信息
- 客户端IP地址
- 胖URL（URL重写）
- cookie

###Cookie
- 用户首次访问时，服务器在响应报文首部中添加Set-Cookie字段。
- 一个cookie记录了一个服务器自定义的键-值对（id="34294"）和若干个可选的cookie属性（domain="joes-hardware.com"）
- 一份响应报文可以通过在首部添加多个Set-Cookie字段来传送多个cookie

```
HTTP/1.0 200 OK
Set-cookie: id="34294"; domain="joes-hardware.com"
Set-cookie: time="1007884800"; domain="joes-hardware.com"
Content-type: text/html
Content-length: 1903
...
```
###Session

- 不论客户端使用何种技术标志用户，服务器都需要存储对应的标志内容，称之为session。
- 取决于服务端的设计，session可以存储在内存或硬盘中


###实例


```
<form action="/authenticate", method="post">
	...
</form>
```

```
func authenticate(writer http.ResponseWriter, request *http.Request) {
	...
	cookie := http.Cookie{
		Name:      "id", 
		Value:     id,
		HttpOnly:  true,
	}
	http.SetCookie(writer, &cookie)	//往响应头部写入cookie
	http.Redirect(writer, request, "/", 302) //往响应头部写入location
}

mux := http.NewServeMux()
mux.HandleFunc("/authenticate", authenticate)
```