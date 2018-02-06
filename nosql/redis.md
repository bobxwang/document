> redis做为基于K-V的数据库,具有高性能,丰富的数据结构,持久化,高可用,分布式,支持复制等特性,应用场景也是百花齐放.有会话缓存（Session cache）全页缓存（FPC）手机验证码、访问频率限制/黑白名单、消息队列、发布与订阅、消息通知、排名/排行榜/最新列表、计数器（比如微博的转评赞计数、阅读数（浏览数，视频播放计数）、博文数（发帖数）、粉丝数、关注数（喜欢商品数）、未读数（动态数））、共同好友/喜好/标签、推送、下拉刷新、私信、商品库存管理（限时的优惠活动信息）、证券指标实时计算，发号器/UUID、以及随着LBS（基于位置服务）的发展，加入的GEO（地理信息定位）的功能和基于Lua自定义命令或功能等 

###### 数据结构

* String
* Hash
* List
* Set
* Zset
* Bitmap
* HyperLogLog
* GEO(地理位置信息定位)

###### 高可用

* Redis Sentinel

###### 关注问题

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

###### 数据分片

> 没有采用一致性哈希,而是使用数据分片,引入了哈希槽(hash slot)实现