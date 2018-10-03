##Android.mk
	LOCAL_PATH := $(call my-dir)
	LS_CPP=$(subst $(1)/,,$(wildcard $(1)/*.cpp))		#自定义函数LS_CPP

	include $(CLEAR_VARS)								#模块开始，清理全局变量
	LOCAL_C_INCLUDES := ?:/?/?							#依赖库头文件路径
	LOCAL_C_INCLUDES += ?:/?/?
	LOCAL_MODULE := ...									#模块名
	LOCAL_SRC_FILES := $(call LS_CPP,$(LOCAL_PATH))		#源文件
	LOCAL_LDLIBS := -landroid -llog						#依赖库（动态链接库或静态链接库，不需要编译）
	LOCAL_STATIC_LIBRARIES := android_native_app_glue	#附加依赖项（需要编译）
	include $(BUILD_SHARED_LIBRARY)						#模块结束，编译成动态链接库

	$(call import-module,android/native_app_glue)		#编译android_native_app_glue模块
###LOCAL_LDLIBS
- 默认搜索路径为

```
<ndk_path>/platforms/android-xx/arch-xxx/usr/lib
```
	
- 添加搜索路径

```
LOCAL_LDLIBS += -L?:?/?
LOCAL_LDLIBS += -L$(LOCAL_PATH)/../??	Android.mk所在路径的相对路径
```
	
- 名字对应关系

```
-landroid				libandroid.so
-lOgreMainStatic		libOgreMainStatic.a
...
```

##Application.mk
	APP_ABI := armeabi-v7a
	APP_PLATFORM := android-9

	#APP_STL := stlport_static
	APP_STL := gnustl_static

