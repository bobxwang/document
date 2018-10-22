1, 常用数据结构
2，HashMap, 碰撞，线程安全，concurrent package
3，JVM内存结构，类加载机制，GC，YGC，FGC，jstack/jmap，老年代/新生代设比
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
6，mybatis 分页，缓存 
7，redis 存储类型，事物，使用场景
8，dubbo 超时重试
9，保障请求执行顺序
10，分布式事物，分布式锁
11，ZK
12，AIO/BIO/NIO 
13，幂等
14，线程池构造类入参，无界阻塞队列
15，共享变量的原子性如何保证
16，水平拆分，垂直拆分

