```
import (
	"encoding/json"
)
```

结构体里，被导出的变量（大写开头）才会被编码到json中

结构体标签可以用于指定编码到json文件时的一些行为

- 指定变量在json文件中的键名（默认使用变量的命名）
- 当变量为0值的时候，应该输出0值到json还是直接忽略该项

若为了调试方便，需要编码出可读性高的json文件，可以使用`json.MarshalIndent`


为什么将json object映射为struct而不是map