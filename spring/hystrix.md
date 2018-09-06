##### CircuitBreaker
* boolean attemptExecution() 
  > forceOpen 强制开启，所有请求都执行降级逻辑 
  > forceClose 强制关闭，所有请求都执行正常逻辑
  > circuitOpened 熔断开关，默认为-1，请求执行正常逻辑，如果发生熔断，该值会成为0，请求执行阶级逻辑
  > HALF_OPEN 熔断半开，即熔断后，会每隔一段时间进行试探 

