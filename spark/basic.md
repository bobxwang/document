##### RDD(Resillient Distributed Dataset)

> 是一个不可变的带分区的记录集合

* 宽依赖 (依赖多个分区)
* 窄依赖

##### 专业术语

* DataFrame

  > 泛型的RDD,有对列的描述即Schema 

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

