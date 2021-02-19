##### IOC&&DI

* BeanFactory/ApplicationContext/WebApplicationContext
* MessageSource(支持国际化),ResourceLoader,ApplicationEventPubliser,
* BeanDefinition的Resource定位(ClassPathResource),loadBeanDefinitions,parseBeanDefinitionElement,registerBeanDefinition 
* Bean 依赖检查 -- None, Simple, object, all 四种模式,Bean定义中设置dependency-check属性
* Bean 对IOC容器的感知 -- BeanNameAware, BeanFactoryAware, MessageSourceAware, ApplicationEventPublisherAware, ResourceLoaderAware 
* 定义一个Bean时，设置其parent属性表明此bean继承自另一个bean，或者设置其abstract属性为true，表明此Bean是一个基类
* BeanPostProcessor 后置处理器的一个监听器，postProcessBefore/AfterInitializaiton
* BeanFactoryPosProcessor#CustomEditorConfigurer#PropertyPlaceholderConfigurer
* Autowiring -- byname/bytype
* scope -- singleton,prototype,针对web应用，还有request(请求阶段),session(会话阶段),globalSession(基于Portlet的Web应用程序会话阶段)
* lifecycle -- InitalizingBean的afterPropertiesSet，
* 构造器注入/属性注入，经验法则强制依赖使用构造器可选依赖则使用属性
* IOC,控制反转，依赖关系的转移，程序不依赖于具体实现，但程序与实现都依赖于抽象，实现IOC有两种模式，一种是DI，一种是Service Loader,而Spring采用的是DI 
* 属性注入，构造注入，Method Injection(设置Bean的lookup-method)
* CustomEditorConfigurer继承自隱FactoryPostProcessor，可以将字符串值转换为指定类型的对象

##### MVC

* DispatcherServlet,前置处理器，继承自FrameworkServlet，HttpServletBean，HttpServlet
* org.springframework.web.context.ContextLoaderListener，上下文件监听器，继承自ContextLoader
* HandlerMapping: SimpleUrlHanlerMapping,ControllerBean/ClassNameHandlerMapping,DefaultAnnotationHandlerMapping(已过时)被RequestMappingHandlerMapping替换,BeanNameUrlHandlerMapping
* HandlerMapping -- HandlerExecutionChain(包含一个Handler对象，多个HandlerInterceptor对象)
* HandlerAdapter -- 把处理器包装为适配器，从而支持多种类型处理器，即适配器设计模式的应用，从而容易支持多种类型的处理器 
* HandlerInterceptor -- 
* Controller -- MultiActionController, BaseCommandController, SimpleFormController
* HandlerMethodArgumentResolver 
* Converter#GenericConverter#HttpMessageConverter 
* HandlerMethodReturnValueHandler
* ViewResolver
* MultipartResolver
* Validator/PropertyEditor 
* PropertyEditorSupport -- 自定义类型转换
* Validator -- 校验 

##### AOP

- proxy-target-class，设置为 true 则强制走 CGLIB 代理 
- expose-proxy，设置为 true 解决对象内部 this 调用无法被切面增强的问题

- AspectJAutoProxyBeanDefinitionParser 

* JDK — InvocationHandler

  > 基于实现目标类的接口创建，故只有接口会被代理，其它方法不会被代理 

* CGLIB — DynamicAdvisedInterceptor

  > 基于继承目标类实现，所以不能被继承的方法（final/private）是不会被代理的 

* TargetSource

* ProxyFactoryBean/ProxyFactory

* MethodBeforeAdvice/AfterReturningAdvice/MethodInterceptor/ThrowsAdvice

* NameMatchMethodPointcutAdvisor/RegExpMethodPointcutAdvisor/ControlFlowPointcut/Pointcuts

* IntroductionInterceptor/DelegatingIntroductionInterceptor

* Autoproxing/BeanNameAutoProxyCreator/DeafultAdvisorAutoProxyCreator

##### DB

* PlatformTransactionManager 
* TransactionDefinition/DefaultTranscationDefinition
* DataSourceTransactionManager -> AbstractPlatformTransactionManager -> PlatformTransactionManager -> TransactionInterceptor ->
* TransactionAspectSupport
* TransactionAttrubuteSourceAdvisor，TransactionStatus，TransactionAttributePointcut(读取TransactionAttribute)，TransactionAttributeSource
* isolation/propagation(事务隔离级别/传播行为)
* 回滚规则(rollback-for/no-rollback-for) 
* @Transactional -> 持久化上下文/事务，里面可以设置传播行为，隔离级别，是否只读，超时时间，回滚规则
  * 传播行为 
    * Mandatory，方法必须在一个现存的事务中进行，否则抛出异常
    * Nested，在一个嵌入的事务中进行，如果不是，则跟Required行为一样
    * Never，方法不应该在事务中进行，否则抛出异常
    * Not_Supported，方法不应该在事务中进行，如果有就暂停现存的事务
    * Required，支持现存的事务，如果没用则新建一个
    * Required_New，需要在一个新事务中运行，如果现存有一个事务就暂停它
    * Supports，支持现存的事务，如果没有则以非事务方式运行
  * 隔离级别
    > 脏读 某事务更新一份数据，另一个事务此时读取了同一份数据，然而由于某些原因，前一个事务做了回滚，则后面这个读取的即为脏数据
    >
    > 不可重复读 在一个事务的两次查询中读取到的数据不一致，可能是两次查询中间插入了一个事务更新的原有数据
    * Default，使用底层数据库的隔离层级
    * Read_Committed，允许事务读取其他并行的事务已提交的数据，可以防止脏读
    * Read_UnCommitted，允许事务读取其它并行的事务还没提交的数据，会发生Dirty,Nonrepeatable,Phantom Read等问题
    * Repeatable_Read，要求多次读取的数据必须相同，除非事务本身自己更新数据，可防止Dirty,Nonrepeatable等问题
    * Seralizable，完整的隔离级别，可防止一切，但会锁定相应的数据表格，效率会降低 
    
##### Others
* ClassPathScanningCandidateComponentProvider
* PropertySourceFactory
* NamespaceHandler
* BeanDefinitionParser 解析XML中的element的内容 
* Spring 中定时任务 fixedRate 任务两次执行时间间隔是任务的开始点，而 fixedDelay 的间隔是前次任务的结束与下次任务的开始
* MethodInvokingFactoryBean
