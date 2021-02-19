#### 缓存

``` java
interface Cache
class PerpetualCache
// 各种装饰器，最终都 delegate 到 PerpetualCache
// 淘汰策略的缓存：WeakCache/SoftCache/LruCache/FifoCache
// 装饰策略：SerializedCache/BlockingCache/LoggingCache/SynchronizedCache/TransactionCache
```

##### 一级缓存

基于 SqlSession

默认开启，不能关闭。但是提供了一个参数 localCacheScope，可以控制一级缓存的级别。其值有 SESSION/STATEMENT。

- 一级缓存同一个会话共享数据

- 同一个会话如有更新操作则缓存清除

- 一级缓存在多个会话间会导致脏读

  - 开启两个会话
  - 第一个读
  - 第二个改数据
  - 第一个再读，将不会走数据库，直接缓存读，导致脏读

  <font color=red>更改 localCacheScope值，置为 STATEMENT，这样缓存只对当前执行语句有效，语句执行后缓存就会被清空。</font>

##### 二级缓存 

基于 Mapper，默认关闭，需要手动打开。

``` xml
<setting name="cacheEnabled" value="true" />
```

解决一级缓存不能跨会话共享的问题，范围是 namespace 级别。

``` java
class CachingExecutor implements Executor 
```

如果需要多个 namespace 共享，则使用 <cache-ref> 来解决。

