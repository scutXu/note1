```
tcpdump [ -AbdDefhHIJKlLnNOpqStuUvxX# ] [ -B buffer_size ] 
         [ -c count ] [ -C file_size ] 
         [ -E spi@ipaddr algo:secret,... ] 
         [ -F file ] [ -G rotate_seconds ] [ -i interface ] 
         [ --immediate-mode ] [ -j tstamp_type ] [ -m module ] 
         [ -M secret ] [ --number ] [ --print ] [ -Q in|out|inout ] 
         [ -r file ] [ -s snaplen ] [ -T type ] [ --version ] 
         [ -V file ] [ -w file ] [ -W filecount ] [ -y datalinktype ] 
         [ -z postrotate-command ] [ -Z user ] 
         [ --time-stamp-precision=tstamp_precision ] 
         [ expression ] 
```

```
-D 打印所有网络接口

-i 指定监听的网络接口

-A 以ASCII码格式打印数据

-s 指定每个分组截取的字节长度，默认为262144字节，0表示读取所有数据


```