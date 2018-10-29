#### 健壮后端服务
大部分服务都是如下结构，既要使用第三方提供的，又要给使用方，在中间又穿插了各种业务，算法，数据等，那如何来避免故障健壮自己的服务呢，总结下来就是：怀疑第三方，防备使用方，做好自己。
1，怀疑第三方
	做好降级
	做好快速失败，设置超时时间
	结合自己业务跟异常来判断是否重试
2，防备使用方
	接口最少暴露原则
	流量控制，按服务分流
3，做好自己
	单一职责
	控制资源使用（CPU/Memory/Network）
	避免单点

#### 常见性能监控
top
ps -ef 
netstat 
iostat 
sar -- 监控CPU使用率跟空闲情况
vmstat -- 虚拟内存监控 


#### 架构师
* 知识广度，方便技术选型
* 抽象能力，对业务跟技术进行抽象
* 知识深度，
* 学习能力，