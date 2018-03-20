#### HelloWorld

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello,World")
}
```

#### package

- 在同一个包下面的文件属于同一个工程文件，不用 `import` 包，可以直接使用
- 在同一个包下面的所有文件的package名，都是一样的
- 在同一个包下面的文件 `package` 名都建议设为是该目录名，但也可以不是

#### import 

* 点操作

  ```go
  import (
  	. "fmt"
  )
  ```

  这个点操作就是后面在写的时候可以省略掉前缀的包名, 示例中的代码就可以由 `fmt.Println` 改成 `Println`

* 别名操作

  ```go
  import (
  	f "fmt"
  )
  ```

  那么可以变成 `f.Println()`

#### main/init

> 程序的初始化和执行都起始于main包。
>
> 如果main包还导入了其它的包，那么就会在编译时将它们依次导入。有时一个包会被多个包同时导入，那么它只会被导入一次（例如很多包可能都会用到fmt包，但它只会被导入一次，因为没有必要导入多次）。当一个包被导入时，如果该包还导入了其它的包，那么会先将其它包导入进来，然后再对这些包中的包级常量和变量进行初始化，接着执行init函数（如果有的话），依次类推。等所有被导入的包都加载完毕了，就会开始对main包中的包级常量和变量进行初始化，然后执行main包中的init函数（如果存在的话），最后执行main函数。

- 这两个函数在定义时不能有任何的参数和返回值
- 虽然一个package里面可以写任意多个init函数，但推荐只用一个
- Go程序会自动调用init()和main()
- 每个package中的init函数都是可选的，但package main就必须包含一个main函数
- 先调用init函数，再调用main函数
- 运行程序，必须要运行存在main函数的go文件

#### 运行

在GOPATH下创建 `src` 目录, 在 `src` 目录下创建 `HelloWorld` 目录, 将上面代码保存在这个目录下并命名为

`HelloWorld.go` 文件

* 源码执行

  `go run src/HelloWorld/HelloWorld.go` 

* 编译执行

  `go install HelloWorld`

  会在 `src` 同级产生一个 `bin` 目录, 里面会有一个可执行文件 HelloWorld

  `./bin/HelloWorld` 

