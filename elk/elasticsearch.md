##### Elasticsearch

###### 使用领域

* 搜索

* Josn文档数据库

  > 相对于MongoDB,读写性能更佳且支持丰富的地理位置查询

* 时序数据处理

  > 日志处理,监控数据存储,分析可视化

###### 关键概念

* 节点,物理概念,一个运行的ES实例,一般是一台机器上的一个进程 
* 索引,逻辑概念,包括配置信息mapping和倒排正排数据文件,其数据文件可能会分布于一台机器也可能分布于多台机器 
* 分片,为支持更大数据,索引会按某个维度分成多个部分,每个部分就是一个分片
* 副本(Replica),同一个分片的备份数据 

###### 集群架构

* 混合部署

  > node既是Transport同时也是Data, 此模式不支持集群的热更新

* 分层部署

  > node角色的隔离, Transport接收请求转发到Data 


elasticsearch，默认集群名称是elasticsearch，在生产环境上一定要修改成其它名称，另外不同环境和不同集群名称要保证不相同，监控集群节点情况，如有未知节点加入，一定要及时预警。

index 索引
文档的集合，根据实际业务逻辑进行划分，通常会把相对独立且具有相似结构或性质的数据作为文档，放在一起，形成索引，类似关系型数据库的DB概念

type 类型
是索引内部的一个逻辑划分，在一个索引内部可定义多个类型，类型将一个索引在逻辑上划分为多个集合，每个类型包含多个属性/字段 

document 文档
是索引的基本单元，与关系数据库中的一条记录相类似，包含一组属性信息，同时包含一个唯一标识这一组属性值的ID

shards/replicas 分片/副本 
一个索引是很多文档的集合，将一个索引进行分割，分成多个片段，每个片段称为一个分片，一个索引可以在一个或多个shard上面，同时一个shard也可能会有多个replicas 

对于熟悉关系型数据库的童鞋，我们可以这样认为，一个Index就是一个DB，Document就是一行数据，Field就是Table的Column，而Mapping就是Table的定义，而Type就是一个Table。对于Type，其实它的存在就是为更好的查询，举个例子，一个Index，可能一部分数据我们想这样查，而另一部分数据我们想使用另一种查询方式，于是就有了两种Type。

###### text/keyword 存储类型区别

> text 类型的字段会被分词，同时生成索引，此数据类型不能用来排序和聚合。而 keyword 不会分词建立索引，可以用来排序和聚合，默认存入整个对象，只能用其本身进行查询

- match

  > 会分词，查 keyword 类型时，需完全匹配，当查询 text 类型时，只有 match 的分词结果跟 text 字段的分词结果有相同的才会匹配 

- match_phrase

  > 会分词，查 keyword 类型时，需完全匹配，当查询 text 类型时，match_phrase的分词结果必须在text字段分词中都包含，而且顺序必须相同且必须都是连续的

- query_string

  > 无法查询 keyword 类型的字段，查询 text 字段时，跟 match_phrase 区别的一点是，不需要连续而且顺序也可以不一样 

- term

  > 不分词，属精确查询，查 keyword 类型时，需完全匹配，查 text 类型时，因为 text 被分词了，如果想查到结果，那么 term 的查询条件必须是 text 字段分词后的某一个  


默认端口是9200，修改http.port来绑定HTTP协议的9200，内部通信9300，修改transport.tcp.port。如果不需要http端口干脆禁用
http://127.0.0.1:9200/_cat/nodes?v
http://127.0.0.1:9200/_cat/health?v　
http://127.0.0.1:9200/_cat/indices?v

<REST Verb> /<Index>/<Type>/<ID>　

在存储灵活性上mongo完秒es，用es做存储时你要想清楚，因为mapping是不可变，mapping是不可变，mapping是不可变。

http://127.0.0.1:9200/twitter/tweet/1?pretty  查看索引是twitter并且type是tweet的id值为1的数据
http://127.0.0.1:9200/customer/external/2/_source 查看索引是customer并且type是external的id值为2的数据,只显示document的值 

ES支持通过_all（全部）和*（通配）符来进行批量操作索引，在生产环境有点危险，可通过action.destructive_requires_name：true来禁用

path.data
path.logs
cluster.name
node.name
network.host 



