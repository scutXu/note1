##位置
##对齐
##尺寸与自适应
layout size可能为以下几种值：

- AUTO（默认）：根据内容自动计算，内容可能是文字，图片，或是子元素。如果父元素开启了flex，且alignItems为stretch，会根据父元素的尺寸拉伸
- PIXELS：DIP
- PERCENTAGE：相对于父元素的百分比

--

layout size及`Dimensions.get()`使用的单位是dip，可以通过`PixelRatio.getPixelSizeForLayoutSize`转换成px

```
const dimensions = Dimensions.get('window');
const imageHeight = Math.round(dimensions.width * 9 / 16);
const imageWidth = dimensions.width;

return (
   <Image
     style={{ height: imageHeight, width: imageWidth }}
   />
);
//这种写法不适用于支持屏幕宽高在运行时发生改变（如转屏）的app
```

```
var image = getImage({
  width: PixelRatio.getPixelSizeForLayoutSize(200),
  height: PixelRatio.getPixelSizeForLayoutSize(100),
});
<Image source={image} style={{width: 200, height: 100}} />
```
--

和CSS不同，react native默认使用flex布局，在样式表中添加{flex: n}的作用是使该元素及其兄弟元素能够完全填充父元素。注意这里和css父元素中的{flex: 1}并非同一个概念，而是类似于子元素的{flex: 'flex-grow'}。

假设有3个元素，其父元素具有属性 flexDirection: 'row'

```
child 1 has width 50

child 2 has flex 1 (or any other number, but 1 is common practice)

child 3 has width 50
```
则中间元素会被拉伸，保证这三个元素水平铺满父元素