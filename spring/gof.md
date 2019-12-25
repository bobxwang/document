#### 工厂方法模式

- BeanFactory / ApplicationContext 

#### 抽象工厂模式

- FactoryBean 

  > 帮助 Spring 构建它自己无法轻松构建的对象 

  - ProxyFactoryBean
  - JndiFactoryBean
  - LocalSessionFactoryBean 

#### 建造者模式 

- EmbeddedDatabaseBuilder
- UriComponentsBuilder
- BeanDefinitionBuilder

#### 适配器模式 

- JpaVendorAdapter
- HibernateJpaVendorAdapter
- MessageListenerAdapter
- WebMvcConfigurerAdapter

#### 桥接模式 

- ViewRendererServlet ，主要针对 Portlet MVC 的支持 

#### 装饰器模式

- BeanDefinitionDecorator 通过自定义属性增强 Bean 的定义  
- WebSocketHandlerDecorator 

#### 责任链模式

- Spring Security 

#### 解释器模式 

- SpEL 

#### 观察者模式

- ApplicationEvent / ApplicationListener 