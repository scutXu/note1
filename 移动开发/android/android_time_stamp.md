millisecond 毫秒 10<sup>-3</sup> ms  
microsecond 微秒 10<sup>-6</sup> μs  
nanosecond 纳秒 10<sup>-9</sup> ns
```
System.nanoTime()								纳秒
System.currentTimeMillis()						毫秒

Handler.postDelayed(Runnable,long delay)		毫秒

MediaCodec.dequeueXXBuffer(...,long timeout)	微秒
MediaCodec.queueInputBuffer(...,long pts)		微秒	
MediaCodec.BufferInfo.presentationTimeUs		微秒

SurfaceTexture.getTimestamp()					纳秒

EGLExt.eglPresentationTimeANDROID(...,long pts)	纳秒
```
	
