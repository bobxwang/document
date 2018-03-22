> 当我们创建一个 goroutine 后, 会先存话在全局运行队列中,等等Go运行时的调度器进行调度,把他们分配给其中一个逻辑处理器,并放到这个逻辑处理器对应的本地运行队列中,最终等着被逻辑处理器执行 

* 全局运行队列 

  > 所有刚创建的 goroutine 都会放在这里

* 本地运行队列

  > 逻辑处理器的 goroutine 队列 

* 并发

  > 同时管理很多事情,但同一时刻只有一个事情在做 

* 并行

  > 同时可以做很多事情

##### 代码示例

```go
package main

import (
	"fmt"
  	"sync"
)

var wg sync.WaitGroup

func Afunction(shownum int) {
  	fmt.Println(shownum)
   	wg.Done // 任务完成,将任务队列中的任务数量-1,其实.Done就是.Add(-1)
}

func main() {
	for i := 0; i < 10; i++ {
		wg.Add(1) 	//每创建一个goroutine,就把任务队列中任务的数量+1
		go Afunction(i)
	}
	wg.Wait() //.Wait()这里会发生阻塞，直到队列中所有的任务结束就会解除阻塞
}
```

##### 资源同步代码示例

```go
package main

import (
  	"fmt"
  	"runtime"
  	"sync"
  	"sync/atomic"
)

var (
	count int32
  	wg sync.WaitGroup
)

func main () {
  	wg.Add(2)
  	go incCount()
  	go incCount()
  	wg.Wait()
  	fmt.Println(count)
}

func incCount() {
  	defer wg.Done()
	for i := 0; i < 2; i++ {
		value := atomic.LoadInt32(&count)
		runtime.Gosched()  // 让当前goroutine暂停,退回执行队列,让其它等待的goroutine运行
		value++
		atomic.StoreInt32(&count,value)
	}
}  // atomic 包中还有很多原子化的函数保证并发下资源同步访问个性的问题
```

上面使用了atomic的包来做同步, 但相对简单,支持数据类型也有限,我们可以使用锁机制

```go
package main
import (
	"fmt"
	"runtime"
	"sync"
)
var (
	count int32
	wg sync.WaitGroup
	mutex sync.Mutex
)
func main() {
	wg.Add(2)
	go incCount()
	go incCount()
	wg.Wait()
	fmt.Println(count)
}
func incCount() {
	defer wg.Done()
	for i := 0; i < 2; i++ {
		mutex.Lock()
		value := count
		runtime.Gosched()
		value++
		count = value
		mutex.Unlock()
	}
}
```

除了原子函数跟互斥锁,还可以利用通道 chan 在多个goroutine进行同步 

