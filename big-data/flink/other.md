Flink / Spark Stream

- spark：task运行依赖 driver/executor/worker，而 driver/executor 还依赖于集群管理器 standalone/yarn，是微批需要指定批处理时间

- flink：JobManager/TaskManager/TaskSlot，基于事件驱动

  - DataSet Api 静态数据抽象成的分布式数据集，Java/Scala/Python
    - DataStream Api 流式数据抽象成的分布式数据集，Java/Scala
    - Table Api 将结构化数据抽象成关系表，Java/Scala

- 任务调度上，Spark 构建 DAG（DAGSchedule划分 Stage，生成 TaskSet）由TaskSchedule提交给 worker 来执行这些 task；而 Flink 先生成 StreamGraph，接着生成 JobGraph，然后将 jobGraph 提交给 JobManager，由它来完成 jobGraph 到 ExecutionGraph 的转变

- 时间机制上，Spark Stream只支持处理时间，不过 Structured stream 则支持了事件时间跟 watermark 机制；而 flink 支持三种时间机制，注入/处理时间，同时支持 watermark 机制来处理滞后数据。WaterMark 是 Flink 为了处理 EventTime窗口计算提出的一种机制，本质上是一种时间戳，用于处理乱序事件

- 容错机制，Spark stream 通过保存 Offset 跟事务而 Flink 使用两阶段协议来保证 exactly-once

- Flink 架构中的角色职责

  - JobManager 协调者，负责接收 Job，调度组成 Job 的多个 Task 执行 ，同时还负责收集 Job 的状态信息，管理集群中从节点的 TaskManager
  - TaskManager 实际负责执行计算的 worker，在其上执行 Job的一组 Task，每个TaskManager负责管理其所在节点上的资源信息，如内存/磁盘，在启动的时候将资源向 JobManager 汇报，同时也负责做数据传输
  - Client 当用户提交一个Flink程序时，会先创建一个Client，对程序进行预处理，由它来从程序配置中获得JobManager的地址负责建立一个连接，Client会将用户提交的程序组装成一个JobGraph进行提交，一个 JobGraph 包含了 JobID/JobName等

- 分区策略

  - Flink
    - GlobalPartitioner，输出到下游 Operator 的第一个实例
    - ShufflePartitioner，随机输出到下游 Operator
    - RebalancePartitioner，以循环方式输出到下游 Operator
    - RescalePartitioner，基于上下游Operator的并行度，以循环方式输出到下游 Operator
    - BroadcastPartitioner，
    - ForwardPartitioner，要求上下游算子的并行度一样，同属一个 SubTasks
    - KeyGroupStreamPartitioner
    - CustomPartitioner
  - Spark
    - 宽依赖
    - 窄依赖

- Flink 并行度

  - 操作算子层面 Operator Level
  - 执行环境层面 Execution Environment Level
  - 客户端层面 Client Level
  - 系统层面 System Level

- Flink 重启策略

  > 控制在发生故障时如何重新启动作业 ，通过在 flink-conf.yml 定义一个 key 为 restart-strategy

    - 固定延迟重启 Fixed Delay Restart Strategy
    - 故障率重启 Failure Rate Restart Strategy
    - 无重启 No Restart Strategy
  - Fallback Restart Strategy

- Flink 分布式缓存

  放在 taskManager 节点中，防止 task 重复拉取。程序注册一个文件或目录(hdfs/s3)，通过 ExecutionEnvironment 注册缓存文件并为它起一个名称，当程序执行时Flink自动将文件或目录复制到所有taskManager节点的本地文件系统中(仅执行一次)，用户可通过这个指定的名称查找文件或目录然后从 taskManager 节点的本地文件系统访问它

- 广播变量

- 窗口

  - Session Window
  - Tumbling Count Window
  - Sliding Time Window
  - Tumbling Time Window
  - Raw Stream data

- State Backends

  - CheckpointedFunction
  - Flink 内部提供如下状态后端
    - MemoryStateBackend
    - FsStateBackend
  - RocksDBStateBackend

- 序列化

  - Flink 实现了自己的序列化，是通过偏移量来进行存取，类型信息由 TypeInformation 类表示

- 数据倾斜

  - 指的是不同窗口内积赞的数据量不同，主要由源头数据的产生速度导致的差异，解决办法的核心思路如下
    - 重新设计 Key
  - 在窗口前做预聚合

- 数据反压

  - Flink
  - Spark