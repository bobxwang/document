0，OOP -> FP
	继承 -> 包含，委托
	封装
	多态
1, 常用数据结构
2，HashMap, 碰撞，线程安全，concurrent package
3，JVM内存结构，类加载机制，GC，YGC，FGC，jstack/jmap，老年代/新生代设比
	jstack 可以看到应用的所有线程情况
4，http 协议，
5，spring 
	IOC/DI
	BeanFactory/ApplicationContext/
	ApplicationEvent
	Bean dependency-check(none,simple,object,all)
	Scope
	 Sinagle/Prototype/Request/Session/GlobalSession
	LifeCycle
	 BeanDefinition/属性注入/BeanNameAware/BeanFactoryAware/BeanPostProcessors.processBeforeInitialization/InitializingBean.afterPropertiesSet/init-method/BeanPostProcessors.processaAfterInitializtion/DisposableBean.destory/destory-method
	AOP
   	 编译时增强 AspectJ
 	 运行时增强 CGLib
	 ProxyFactoryBean
	 BeanNameAutoProxyCreator/DefaultAdvisorAutoProxyCreater
	 NameMatchMethodPointcutAdvisor/RegExpMethodPointcutAdvisor 
	JDBC 
	 PlatformTransactionManager 
	 TransactionStatus 
  	 传播行为
	   Mandatory 方法必须在一个事务中进行，否则抛出异常 
	   Nested 在一个嵌套的事务中进行，如果不是，则相当于 Required
   	   Never 不应该在事务中进行，如果有事务则抛出异常
	   Not_Supported 不应该在事务中进行，如果有则暂停现在的事务
	   Required 支持现在的事务，如果没有则建立一个新事务
 	   Requires_New 建立一个新事务，如果有现存一个事务就暂停它
	   Supports 支持现在的事务，如果没有则以非事务方式执行
	  TransactionAttributeSource
  	  TransactionAttribute 
     	WebMvc
	 WebApplicationContext/ContextLoaderListener/
  	 DispatchServlet -> HandlerMapping -> HandlerExecutionChain -> HandlerInterceptor -> HandlerAdapter -> Controller 
	 Validator/PropertyEditor  
	基于请求驱动，前端控制器
6，mybatis
	缓存
	  一级缓存作用域是同一个SqlSession，默认开启
  	  二级缓存作用域是Mapper级别，基于Executor对象上做文章 
7，redis 存储类型，事物，使用场景
8，dubbo 
	超时是针对消费端，因为是一种NIO模式，拿到的是一个ResponseFuture，然后轮询直至超时或收到服务响应，如果服务端配置了超时，那么消费端可以不设置，默认采用服务端的时间设置值，设置超时时间，是为了避免因为某种原因导致线程被长时间占用，最终出现线程池用户返回拒绝服务的异常。
	降级
	重连机制 retties 设置为0，即关闭重试机制
9，保障请求执行顺序
10，分布式事物，分布式锁
11，ZK
12，AIO/BIO/NIO 
13，幂等
14，线程池构造类入参，无界阻塞队列
15，共享变量的原子性如何保证
16，水平拆分，垂直拆分
17，JVM 退出只有两种情况
	* 所有非 daemon 进程完全终止
	* 某个线程调用了 System.exit 或 Runtime.exit 

CAS - ABA - AtomicStampedReference 

一面都是基础
线程池核心参数，数据库隔离级别，死锁的四个必要条件，java反射，重载和重写的区别
Jvm有哪些区域，简述垃圾回收过程，G1和CMS有啥区别。
Coding：
戳气球（leetcode 312）
一个集合A，一个集合B，找出其中B中不在A中的元素。

二面：
一个java方法如何执行的，对应在内存区域是哪一部分。为什么要进行系统调用？啥是中断，为什么要中断，中断表了解吗？虚拟内存是干嘛的？
进程线程的区别，进程的通信方式，管道和消息队列的区别？
Mysql如何走索引？不走怎么办？如何排查？
写sql：
学生表成绩表 课程表 找出学生平均成绩大于60语文高于80的人。
单例模式：饿汉，懒汉，double check怎么写。
目前有一张表想要直接改其中的字段，会产生什么问题，如何避免？
写代码：
最长不重复子串？
三面：
给定一个数，写一个B+树的精确查询，数据结构自己定义。
旋转单调非减数组，给定一个数找到，比这个数小一点的数。
给定前序中序写出这个二叉树。
你说你熟悉mysql，那你熟悉到什么程度？
熟悉redis，熟悉到什么程度？