[TOC]

#### 基础常识

> Redis做为基于K-V的数据库,具有高性能,丰富的数据结构,持久化,高可用,分布式,支持复制等特性,应用场景也是百花齐放.有会话缓存（Session cache）全页缓存（FPC）手机验证码、访问频率限制/黑白名单、消息队列、发布与订阅、消息通知、排名/排行榜/最新列表、计数器（比如微博的转评赞计数、阅读数（浏览数，视频播放计数）、博文数（发帖数）、粉丝数、关注数（喜欢商品数）、未读数（动态数））、共同好友/喜好/标签、推送、下拉刷新、私信、商品库存管理（限时的优惠活动信息）、证券指标实时计算，发号器/UUID、以及随着LBS（基于位置服务）的发展，加入的GEO（地理信息定位）的功能和基于Lua自定义命令或功能等
>
> Memcache把数据存放在内存里，如果断电则丢失，同时它不支持主从也不支持分片，而Redis可以在后台保存到磁盘中，主从分片都支持。
>
> 每秒可以处理10万次读写操作,单个Value的最大限制是 1 个 G

#### 数据结构

* String(字符串)  二进制安全，意味着没有任何特殊终端字符来确定长度，可存储任何长度为512M的字符串

  > <font color=red>SDS(Simple Dynamic String)</font>

  ```c
  struct sdshdr {
    int free; 	// buf[]数组未使用字节的数量
    int len;  	// buf[]数组所保存的字符串长度
    char buf[]; // 保存字符串的数组
  }
  ```

  相比 C 的字符串，SDS 的优点有哪些呢？

  - 效率高，使用 strlen 命令得到一个字符串长度，直接用 len 值，复杂度是 O(1)
  - 数据溢出，
  - 内存重新分配，
    - 空间预分配
    - 惰性空间释放
  - 数据格式多样性，C 字符串的字符必须符合某些特定的编码格式，如不能包含 \0，因为这个是标识一个字符串结束，否则会被认为是多个(所以只能保存文本数据)，像音视频/图片这种就不行，而 redis 会以二进制的方式处理 Buf 数组中的数据，所以对存入其中的数据未做任何限制过滤，只要存进去什么样，出来还是什么样。

* Hash(哈希)  字符串字段和字符串值之间的映射，HMSET**，**HGETALL

* List(列表)  lpush，lrange，列表最大长度为2`32 - 1个元素

* Set(集合)  sadd，smembers，无序，元素具有唯一性，成员最大数量为2`32 - 1个元素

* Zset(有序集合)  zadd，zrange，以某个条件为权重进行排序

  > 有序集合也是集合，只是其每个元素都会关联一个double类型的分数，redis正是通过分数来为集合中的成员进行从小到大的排序，其成员是唯一的，但分数却可以重复

* Bitmap

* HyperLogLog

  > 一般用来做基数统计，其优点是在输入元素数量或体积非常大时，计算基数所需空间总是固定并且很小，每个HyperLogLog銉只需花费12KB内存，就可计算接近2`64个不同元素的基数，但其只根据输入元素来计算基数，不会存储输入元素本身，所以不能像集合一样返回输入的各个元素，场景可以用来做网站每天访问IP统计，不像集合占用内存大

* GEO(地理位置信息定位)

#### 配置优化

* vm-enabled 设置成 no
* maxmemory 设置下, 该项告诉redis使用了多少物理内存后拒绝后续写入请求,可保护不会 swap 

#### 集群
* Redis Sentinel（哨兵）3.0版本之前的解决方案,着眼于高可用在master宕机时会自动将slave提升为master继续提供服务
* Redis Cluster 3.0后官方版本,着眼于可扩展性,单个redis内存不足时,使用Cluster进行分片存储
  
  > slot(槽): 使用数据分片而非一致性哈希,一个redis集群包含 16384 个哈希槽,是一个逻辑意义上的,实际并不存在,在存取key时会进行key-slot的映射, HASH_SLOT(key) = CRC16(key) % 16384 

#### 关注问题

* 安全问题
  
  > 用非root用户启动,尽量不要暴露在外网,配置认证项,开启危险命令认证
* 容量问题
  
  > 合理评估,使用内存分配策略（no-enviction、allkeys-random、allkeys-lru、volatile-random、volatile-ttl、volatile-lru）水平拆分
* big-key问题
  
  > 可能会引起慢查或带宽瓶颈,拆成小key
* hot-key问题
  
  > redis是单进程,节点实例容易成为系统短板,如果只是简单k-v,可使用memcached
* 使用姿势问题
  
  > 避免使用阻塞操作（如：flushall、flushdb、keys *等）尽量使用Pipeline
* Key过期问题
  
  > 合理设置过期时间,如有许多过期key没及时删除可使用scan,hscan,sscan,key 遍历来删除
* 配置上
  
  > 开启tcp-keepalive, tcp-backlog, 关闭NUMA, swap, transparent_hugepage 

#### redis-server

* 启动redis

#### redis-cli

* redis-cli -h host -p port -a password 

#### 数据淘汰策略
* volatile-lru：从已设置过期时间的数据集（server.db[i].expires）中挑选最近最少使用的数据淘汰
* volatile-ttl：从已设置过期时间的数据集（server.db[i].expires）中挑选将要过期的数据淘汰
* volatile-random：从已设置过期时间的数据集（server.db[i].expires）中任意选择数据淘汰
* allkeys-lru：从数据集（server.db[i].dict）中挑选最近最少使用的数据淘汰
* allkeys-random：从数据集（server.db[i].dict）中任意选择数据淘汰
* no-enviction（驱逐）：禁止驱逐数据

#### publish/subscribe

#### transcation 

允许一组命令在单一步骤中执行，事务中的所有命令做为单个独立操作顺序执行

* MULTI 发起事务请求，之后传递需要在事务中和整个事务中
* EXEC 提交整个事务请求
* discard 取消事务
* unwatch 为事务刷新所有以前关注过的銉
* watch 标记要关注事务给定銉的条件执行

> 关系型数据库中主要通过乐观锁跟悲观锁进行数据库事务的控制，而redis中通过watch加乐观锁对数据进行并发控制，redis是使用单线程串行方式来执行事务
>
> redis不能回滚事务，但可以使用discard命令放弃事务queue中的执行语句，执行时只是顺序执行队列的命令，如果有失败后面的命令也会继续执行，并不会回滚

#### 脚本

EVAL，解释执行Lua

#### 备份

SAVA命令后，将在redis目录中创建一个dump.rdb文件

BGSAVE 此命令将启动备份过程并在后台运行

#### 恢复

只要将dump.rdb文件放到redis目录中，并启动服务器，要知道redis目录在什么位置，只要执行 CONFIG get dir

#### 安全

CONFIG get requirepass 

CONFIG set requirepass "upassword"

#### 性能测试

redis-benchmark -n 10000 将通过调用10000次命令来检查redis

#### 客户端最大连接数

redis.conf配置文件中有个 maxclients，描述了可以连接到redis的客户的最大数量 

CONFIG get maxclients

#### 管道

客户端可以一次发多个请求给服务器，而不等待全部响应，最后在单个步骤中读取所有响应，可提高性能 

#### 分区

> 没有采用一致性哈希,而是使用数据分片,引入了哈希槽(hash slot)实现

#### 常见问题

- 不应该使用 keys pattern 指令来查找符合某一条件的 key，它会一次性返回所有的 key，造成卡顿，应使用 scan 

- 分布式锁，SETNX 虽然原子性，但不支持传入 EXPIRE 参数，从2.6.12版本开始，可使用 SET 操作，它将 SETNX跟 EXPIRE 融合在一起 
  
  > SET KEY value [EX seconds] [PX milliseconds] [NX|XX]
  
- Pub/Sub缺点，消息发布是无状态的，无法保证可达，对发布者来讲，消息是即发即失的。

- 持久化，RDB是通过保存某个时间点的全量数据快照来实现，如果数据量太大会影响性能，而AOF是通过保存写状态来记录数据的，以增量的形式。4.0版本后推出了混合模式

- 主从模式，一个Master节点来进行写操作，若干个Slave进行读操作，数据不一定是即时同步，但会最终一致。

- INFO commandstats，命令统计工具可查看所有命令统计的快照 

- try/except 块，确保关键性数据放入实例，因为大多数采用的是发送即忘策略，有可能并没真正放入

#### 使用规范
- 冷热数据区分 
- 业务数据分离
- 消息大小限制，严禁超50KB的单条记录，消息过大会引起网络带宽的高占用，持久化到磁盘的IO问题
- 连接数据限制
- 必须设置KEY的过期时间
- 如果是缓存，不能有中间态，就是去掉缓存后业务逻辑不应发生改变
- 严禁使用 Flush，DBA 应该 rename 此命令
- 严禁将 redis 当消息队列使用
- KEY 规范

#### 如何使用 Redis 更节省内存

- 控制Key长度
- 关注 value 的大小 (bigKey)，字符串尽量控制在10K而List/Hash等尽量将元素控制在1W以下
- 选择合适的数据类型
- 当缓存使用而不是数据库，尽量设置过期时间 
- 配置最大内存maxmemory避免无限占用内存，同时设置数据淘汰策略
- 可以将数据压缩后再写入

####如何持续发挥 redis 的高性能

- 如果真有 bigKey，将其拆分成多个小 key 存储
- 如果无法避免 bigKey，开启 lazy-free 机制（4.0+版本支持）
- 避免使用复杂度过高的命令，比如聚合等命令，放在客户端实现
- 批量命令代替单个命令

- 避免集中过期Key，增加随机值 
- 只使用 db0，拆分多个实例存储来达到按不同业务线存储数据
- 关闭OS内存大页机制 

#### 如何保证 Redis 的可靠性

###### 资源隔离

- 按业务线部署实例

###### 多副本

- 主从避免单点
- 合理配置主从复制参数
  - 设置合理的 repl-backlog 参数
  - 设置合理的 slave client-output-buffer-limit

###### 故障恢复 

- 哨兵集群，只有主从当故障发生时无法自动切换，通过部署奇数个哨兵来实现

#### 日常运维注意事项

- 禁止使用 keys/flushall/flushdb 等命令，因为其会长时间阻塞 redis 主线程
- 扫描线上实例时，设置休眠时间
- 慎用 Monitor 命令
- 从库必须设置为 slave-read-only，避免从库写入数据，导至数据不一至
- 合理配置 timeout 跟 tcp-keepalive 参数 

#### 安全问题

- 不使用默认端口 6379
- 以普通用户启动redis而不是root用户
- 限制 redis 配置文件的目录访问权限 

#### 监控预警

- 做好机器 CPU/内存/带宽等资源的监控，不足时及时报警 
- 设置合理的 slowlog 阈值，并对其进行监控，slowlog 过多及时报警
- 做好实例运行时监控，重点关注 expired_keys、evicted_keys、latest_fork_usec 指标，这些指标短时突增可能会有阻塞风险







