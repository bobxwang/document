设计模式 

- Builder 模式，SqlSessionFactoryBuilder/XMLConfigBuilder

- Factory 模式，SqlSessionFactory/ObjectFactory/MapperProxyFactory

- 单例模式，ErrorContext/LogFactory 

- 代理模式，Mybatis 实现的核心

  ```java
  public class MapperProxy<T> implements InvocationHandler {}
  final class ConnectionLogger extends BaseJdbcLogger implements InvocationHandler {}
  ```

- 组合模式

  ```java
  public interface SqlNode {}
  ```

- 模板方法

  ```java 
  public abstract class BaseExecutor implements Executor {}
  public class BatchExecutor extends BaseExecutor {}
  public class ReuseExecutor extends BaseExecutor {}
  public class SimpleExecutor extends BaseExecutor {}
  
  public abstract class BaseTypeHandler<T> extends TypeReference<T> implements TypeHandler<T> {}
  public class IntegerTypeHandler extends BaseTypeHandler<Integer> {}
  ```

- 适配器模式，Log的Mybatis接口和它对jdbc、log4j等各种日志框架的适配实现

- 装饰者模式

  ``` java
  public class LruCache implements Cache {}
  ```

- 迭代器模式

  ``` java
  public class PropertyTokenizer implements Iterator<PropertyTokenizer> {}
  ```

  