##### 设计原则

* 阻止任何单一的第三方依赖使用掉整个容器的全部用户线程
* 快速失败而不是在队列中积压请求
* 提供fallback错误回调机制
* 任何第三方依赖之间相互隔离
* 通过近实时的监控和报警及时发现系统中的问题

##### 常规属性

* hystrix.command.default.execution.isolation.strategy  隔离策略,默认是Thread,可选Thread｜Semaphore

* hystrix.command.default.execution.isolation.thread.timeoutInMilliseconds 命令执行超时时间,默认1000ms

* hystrix.command.default.execution.timeout.enabled 执行是否启用超时,默认启用true

* hystrix.command.default.execution.isolation.thread.interruptOnTimeout 发生超时是是否中断,默认true

* hystrix.command.default.execution.isolation.semaphore.maxConcurrentRequests 最大并发请求数

  > 默认10，该参数当使用ExecutionIsolationStrategy.SEMAPHORE策略时才有效。如果达到最大并发请求数，请求会被拒绝。理论上选择semaphore size的原则和选择thread size一致，但选用semaphore时每次执行的单元要比较小且执行速度快（ms级别），否则的话应该用thread。

* hystrix.command.default.fallback.isolation.semaphore.maxConcurrentRequests 如果并发数达到该设置值，请求会被拒绝和抛出异常并且fallback不会被调用。默认10

* hystrix.command.default.fallback.enabled 当执行失败或者请求被拒绝，是否会尝试调用hystrixCommand.getFallback() 。默认true

##### Circuit Breaker 相关的属性

* hystrix.command.default.circuitBreaker.enabled 用来跟踪circuit的健康性,如果未达标则让request短路。默认true

* hystrix.command.default.circuitBreaker.requestVolumeThreshold 

  > 一个rolling window内最小的请求数。如果设为20，那么当一个rolling window的时间内（比如说1个rolling window是10秒）收到19个请求，即使19个请求都失败，也不会触发circuit break。默认20

* hystrix.command.default.circuitBreaker.sleepWindowInMilliseconds 触发短路的时间值

  > 当该值设为5000时，则当触发circuit break后的5000毫秒内都会拒绝request，也就是5000毫秒后才会关闭circuit。默认5000

* hystrix.command.default.circuitBreaker.errorThresholdPercentage错误比率阀值，如果错误率>=该值，circuit会被打开，并短路所有请求触发fallback。默认50

* hystrix.command.default.circuitBreaker.forceOpen 强制打开熔断器，如果打开这个开关，那么拒绝所有request，默认false

* hystrix.command.default.circuitBreaker.forceClosed 强制关闭熔断器 如果这个开关打开，circuit将一直关闭且忽略circuitBreaker.errorThresholdPercentage