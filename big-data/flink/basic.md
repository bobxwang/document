https://flink-learning.org.cn/

Flink 的前世今生
流批本质   准确/快速，业务延时的不同，每条记录触发计算，某一段（时间/计数）触发计算，数据结束触发计算
流计算核心   延时问题/计算撤回/容错续跑(有状态/状态持久化 State & Checkpoint/Savepoint)/透明升级/乱序问题(EventTime/IngestionTime/ProcessingTime/  Watermark)/正确性(At-least-once/Exactly-once)/部署问题/弹性扩容
应用场景 事件驱动型（是一类有状态的应用，根据事件流触发计算更新状态或进行外部操作）/ 数据分析型应用（原始数据->提取->目标）/ 数据管道型应用（ETL --> 多源/噪音/聚合) /

批是流的特例  Flink，Native-Streaming，数据集合是无穷的，Early-fire
流是批的特例  Spark，Micro-Batching，数据集合是有限的

1.11 后的新功能
Unaligned Checkpoints 消除了不用等待的时间
Watermark Idleness Detection 水印生成的空闲检测
Batch and Streaming Unification(Source) 流批接口统一
Application Mode Deployments
Change Data Capture(CDC) 数据迁移场景
Pandas UDF PyFlink


Stream Processing with Flink
有状态变量 RichFunction
State 申明成实例变量,有状态变量只能使用于富函数
在Open方法中为State赋值
  创建一个 StateDescriptor
  getRuntimeContext().getState(sumDescriptor);
进行State值的更新

Runtime -- 分布式数据处理引擎
JobMaster
TaskExecutor
ResourceManager

Client
  web
  console
Master
  Dispatcher
    JobMaster，作业控制中心，分布式状态快照，任务调度，出错恢复，作业状态查询
      Schedule
      ScheduleStrategy 调度策略
        事件驱动
          作业开始调度
          任务状态发生变化
          任务产出的数据可消费
          失败任务需要重启
            出错恢复策略 FailoverStrategy
              RestartPipelinedRegionFailover***
              RestartAllFailover***
        策略
          Eager，Streaming Job
          Lazy form sources ，一般是批处理
          (WIP) Pipelined region based
  ResourceManager，管理 TaskExecutor
    SlotManger，通过心跳管理 Slot 状态
  Rest Server
Worker
  TaskExecutor
    Slot，任务运行的逻辑容器，需要满足任务的资源需求

Fault-tolerancer in Flink
  有状态的流计算
    去重
    窗口计算
    访问历史数据
    全局快照
      Chandy-Lamport 算法

Flink-Connector
  jdbc
  kafka
  es
    key handling
      upset / append 两种模式
  hbase
  Hive
    hive source
    hive sink
  filesystem
    Local
    Hadoop
    S3
    OSS
  1.10 新增了 Legacy Connector Options
Flink-Format
  csv
  json
  apache avro
Flink-Catalog
  metadata
Flink-Table Factory
  CatalogTable