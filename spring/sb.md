pring 

https://github.com/eugenp/tutorials  java open source   

@Configuration 相当于加载某个xml文件，进行bean解析注入

java -jar app.jar —name=“spring”
java -Dname=“spring” -jar app.jar 

—spring.config.name=application.yml
—spring.config.location=classpath:/default.yml,classpath:/override.yml
the default search path is classpath:,classpath:/config,file:,file:config/ this places will always used 
—spring.profiles.active=dev 

BeanFactoryUtils
WebApplicationContext webApplicationContext = RequestContextUtils.findWebApplicationContext((HttpServletRequest) request);
ApplicationContext applicationContext = webApplicationContext.getParent();
Map<String, SimplePushConsumer> maps = applicationContext.getBeansOfType(SimplePushConsumer.class);
for (Map.Entry<String, SimplePushConsumer> item : maps.entrySet()) {
    System.out.println(item);
}

servlet的requestbody以及response的body一旦流被读取了，就无法再次消费了，因此这对于有要拦截请求，记录相关信息的时候，带来一个潜在的坑。那么如何处理这个呢，利用filter，wrapper一层，然后proceed，最后response完之后在把cached的body设置回原始响应。ContentCachingRequestWrapper/ContentCachingResponseWrapper的作用就是为了让你可以继续消费 

RequestAttributes reqAttr = RequestContextHolder.getRequestAttributes();
HttpServletRequest req = ((ServletRequestAttributes) reqAttr).getRequest();

XML Configuration 
<bean id=“***” name=“***” />
Java Based Configuration
@Configuration
public class A { @Bean public B b() {return new B(); } }
Annotation Based Configuration
use @Service,@Component and so on 

Auto wire -> byName/byType/byConstructor 

Does Spring Bean provide thread safety?
The default scope of Spring bean is singleton, so there will be only one instance per context. That means that all the having a class level variable that any thread can update will lead to inconsistent data. Hence in default mode spring beans are not thread-safe.

ContextLoaderListener implements ServletContextListener，do init or destroy things  

ResourceBundleMessageSource/ReloadableResourceBundleMessageSource  资源国际化 

Spring Framework is using a lot of design patterns, some of the common ones are:
1. Singleton Pattern: Creating beans with default scope.
2. Factory Pattern: Bean Factory classes
3. Prototype Pattern: Bean scopes
4. Adapter Pattern: Spring Web and Spring MVC
5. Proxy Pattern: Spring Aspect Oriented Programming support
6. Template Method Pattern: JdbcTemplate, HibernateTemplate etc
7. Front Controller: Spring MVC DispatcherServlet
8. Data Access Object: Spring DAO support
9. Dependency Injection and Aspect Oriented Programming

HandlerMethodArgumentResolver -> RequestParamMethodArgumentResolver/PathVariableMethodArgumentResolver/RequestHeaderMethodArgumentResolver
 and so on 

@InitBinder

Spring Bean Lifecycle
1，实现InitializingBean和DisposableBean接口，不推荐，因为这样会将这个Bean跟Spring框架耦合在一起 
2，在bean的配置文件中指定init-method和destroy-method方法，需要注意的是自定义的init-method和destroy-method方法可以抛异常但是不能有参数。
3，使用@PostConstruct和@PreDestroy注解
4，实现***Aware接口 在Bean中使用Spring框架的一些对象，ApplicationContextAware/BeanFactoryAware/BeanNameAware/ResourceLoaderAware
5，BeanPostProcessor 

https://stackoverflow.com/questions/29953157/spring-boot-actuator-without-spring-boot?noredirect=1&lq=1 










