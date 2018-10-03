<!---->
	JNIEXPORT void JNICALL XX_JAVA_ClassName_cppFunc(JNIEnv* pEnv,
													 jobject pObject);
	/*--------------------
	JNIEnv *:jni环境，所有jni函数的接口
	jobject：this对象
	--------------------*/
#类型映射#
##基本类型
<!---->
	jni				java			c

	jint			int			
	jbyte			byte
	jshort			short			short
	jlong			long
	jfloat			float
	jdouble			double			double
	jchar			char			unsigned short
	jboolean		boolean			unsigned char
	...				...
##引用类型（需要对映射后的类型进行转换）
<!---->
	jni				java			c						转换后

	jobject			Object			struct _jobject *
	jstring			String			struct _jobject *		char *
	jdoubleArray	double []		struct _jobject *		jdouble *
	jobjectArray
###utf-8字符串转换
<!---->
	char* GetStringUTFChars(JNIEnv*,
							jstring,
							jboolean * iscopy)

	void ReleaseStringUTFChars(JNIEnv *env,
							   jstring string,
							   const char *utf);

	jstring NewStringUTF(JNIEnv*, char*)
###基本数组转换
<!---->
	//映射jni数组对象为c数组
	jdouble* GetDoubleArrayElements(JNIEnv *,
							  jintArray,
							  jboolean * iscopy)

	//释放对c数组的引用（不会释放对应的jni数组的内存）
	void ReleaseDoubleArrayElements(JNIEnv *,
									jintArray,
									jint *,
									jint mode);

	//创建jni数组对象
	jdoubleArray NewDoubleArray(JNIEnv *,
								jsize length);

	//从c数组复制数据到jni数组对象
	void SetDoubleArrayRegion(JNIEnv *,
							  jdoubleArray,
							  jsize start,
							  jsize length,
							  const jdouble * buffer);

	//从jni数组对象复制数据到c数组
	void GetDoubleArrayRegion(JNIEnv *,
							  jdoubleArray,
							  jsize start,
							  jsize length,
							  jdouble * buffer);
###java.nio.Buffer转换
	void* GetDirectBufferAddress(JNIEnv* env,
								 jobject buf);

	jobject NewDirectByteBuffer(JNIEnv* env,
								void* address,
								jlong capacity);

	jlong GetDirectBufferCapacity(JNIEnv* env,
								  jobject buf);
##访问类对象##
<!---->
	//获得this对象的类类型
	jclass GetObjectClass(JNIEnv *,
						  jobject obj);


	//获得成员变量的ID
	jfieldID GetFieldID(JNIEnv *,
						jclass cls,
						const char *name,
						const char *sig); //变量类型
	
	//
	...
##创建类对象
<!---->
	//根据包名+类名获取类ID
	jclass FindClass(JNIEnv *env, const char *name);
	//例子
	Integer			"java/lang/Integer"
	Integer []		"[Ljava/lang/Integer"
	Integer [] []	"[[Ljava/lang/Integer"
	int []			"[I"

	//根据类ID,函数名，函数签名获取成员函数ID
	jmethodID GetMethodID(JNIEnv *env,
							jclass clazz,
							const char *name,
							const char *sig);

	//参数例子
	函数						sig															name
	void func(int,int)		 "(II)V"													"func"	
	int func()				 "()I"														"func"
	构造函数(int)			  "(I)V"													"<init>"
	String func(String [])	 ([Ljava/lang/String;)Ljava/lang/String;					"func"

	//创建类对象
	jobject NewObject(JNIEnv *env,
						jclass clazz,		//类ID
						jmethodID methodID,	//调用的构造函数ID
						...);				//构造函数参数
##创建对象数组##
	jobjectArray NewObjectArray(JNIEnv *env,
								jsize length,				//数组长度
								jclass elementClass, 		//类ID
								jobject initialElement);	//初始化的模板值，可以为NULL

	jobject GetObjectArrayElement(JNIEnv *env, jobjectArray array, jsize index);
   	// Returns an element of an Object array.
 
	void SetObjectArrayElement(JNIEnv *env, jobjectArray array, jsize index, jobject value);
   	// Sets an element of an Object array.



	

	