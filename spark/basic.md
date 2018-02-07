> Spark 2.0后引入SparkSession概念,为用户提供一个统一的切入点来使用Spark的各项功能

##### RDD/Dataset/DataFrame

> Spark 2.0 后 DF/DS的统一API会为Spark开发者带来许多方面的好处 

###### 何时使用RDD

* 希望对数据进行最基本的转换处理控制
* 你的数据是非结构化的,比如流媒体或字符流

###### 何时使用DS/DF

* 需要丰富的语义,高级抽象和特定领域专用的API
* 想在编译时就有高度的类型安全

##### 专业术语

* Dataset

  > 1.6后引入


* DataFrame

  > 泛型的Dataset,有对列的描述即Schema,即 Dataset[Row], 每一行类型都是Row 

* RDD(Resillient Distributed Dataset)

  > 是一个不可变的带分区的记录集合
  >
  > * 宽依赖 (依赖多个分区)
  > * 窄依赖

##### DAG(有向无环图 - Directed Acycle graph)

* Stage(阶段)
* Partition(分区)
* Pipeline(流水线)
* Task
* Cache 

##### 故障恢复

* Linage 通过数据的血缘关系再执行一遍前面处理
* Checkpoint 将数据集存储到持久存储中

##### 运行部署模式 

* local 多用于测试 


* standalone spark自带的资源调度器
* yarn
* meson

##### RDD在Spark中运行步骤

##### ![运行流程](https://github.com/bobxwang/document/blob/master/spark/rdd-dag-task-worker.png)

* DAGScheduler切割Job, 划分Stage, 通过sumbitStage来提交一个stage对应原tasks 
* TaskScheduler(Driver)

