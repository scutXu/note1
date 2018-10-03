#Concept
![](flex.png)
#Container

```
{
	flex: 1,
	flexDirection: row | row-reverse | column | column-reverse,
	flexWrap: nowrap | wrap | wrap-reverse,
	flexFlow: 
	justifyContent: flex-start | flex-end | center | space-between | space-around,
	alignItems:flex-start | flex-end | center | baseline | stretch,
	alignContent:
}
```

###flexDirection
项目排列（主轴）方向

- row：水平，从左到右（CSS默认）
- row-reverse：水平，从右到左
- column：垂直，从上到下（React Native默认）
- column：垂直，从下到上

###flexWrap
项目换行（次轴/交叉轴）方向

- nowrap：不换行，项目强制挤压到同一行内（默认）
- wrap：换行，交叉轴从上到下或从左到右
- wrap-reverse：换行，交叉轴从下到上或从右到左

###flexFlow
同时定义flexDirection和flexWrap

###justifyContent
项目在主轴上的对齐方式

- flex-start：对齐main-start，紧密排列
- flex-end：对齐main-end，紧密排列
- center：居中对齐，紧密排列
- space-between：两端对齐，项目间间隔相等，项目和边框无间隔
- space-around：两端对齐，项目间间隔相等，项目和边框间隔为项目之间间隔的一半

###alignItems
项目在交叉轴上的对齐方式

- flex-start：
- flex-end：
- center：居中对齐
- baseline：项目的第一行文字的基线对齐
- stretch：如果项目未设置相对于次轴方向的尺寸的或设为auto，将拉伸直到占满整个次轴的长度（默认）

###alignContent
多根轴线（换行）时，项目在交叉轴上的对齐方式

#Item

```
{
	order: <integer>,
	flexGrow: <number>, /* default 0 */
	flexShrink: <number>, /* default 1 */
	flexBasis: flex-basis: <length> | auto, /* default auto */
	flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
	alignSelf: auto | flex-start | flex-end | center | baseline | stretch
}
```

###order
###flexGrow
项目的放大比例，默认为0，即如果存在剩余空间，也不放大
###flexShrink
###flexBasis
###flex
###alignSelf