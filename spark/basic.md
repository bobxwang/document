##### RDD(Resillient Distributed Dataset)

> 是一个不可变的带分区的记录集合

* 宽依赖 (依赖多个分区)
* 窄依赖

##### DAG(有向无环图)

* Stage(阶段)
* Partition(分区)
* Pipeline(流水线)
* Task
* Cache 

##### 故障恢复

* Linage 通过数据的血缘关系再执行一遍前面处理
* Checkpoint 将数据集存储到持久存储中

##### 运行部署模式 

* standalone
* yarn
* meson

##### RDD在Spark中运行步骤

##### ![](./rdd-dag-task-worker.png =100x100)