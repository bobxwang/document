> 切片是对数组的抽象,数组长度不可改变,而切片就是一种动态数组,其长度不固定,可以追加元素

#### 定义切片

```go
var identifier []type  // 切片不需要声明长度
/* 也可以使用 make 函数来创建切片 */
var slice1 []type = make([]type, len)
```

#### 切片初始化

```go
s := [] int{1,2,3} 
s := arr[:] // 初始化切片,是数组 arr 的引用 
s := arr[startIndex:endIndex] // 将arr从下标startIndex到endIndex-1下的元素创建为一个新的切片 
```

#### len/cap 函数 

> 切片是可索引的, len() 方法获取其长度  
>
> cap() 是用来测量切片最长可以达到多少,即计算容量的 

```go
func main() {
  var numbers = make([]int,3,5)
  printSlice(numbers)
}
func printSlice(x []int) {
  fmt.Printf("len=%d cap=%d slice=%v\n", len(x),cap(x), x)
}
```

以上将会打印出如下结果

```
len=3 cap=5 slice=[0 0 0]
```

#### 切片截取

```go
s[lower-bound:upper-bound]
```

#### append/copy 函数 

```go
func main() {
  var numbers []int
  // 允许追加空切片
  numbers = append(numbers, 0)
  // 添加一个元素
  numbers = append(numbers, 1)
  // 同时添加多个元素
  numbers = append(numbers, 2, 3, 4)
  // 创建一个新切片, 是之前切片容量的两倍
  numbers1 := make([]int, len(numbers), (cap(numbers) * 2))
  // 拷贝 numbers 的内容到 numbers1 
  copy(numbers1, numbers)
}
```

