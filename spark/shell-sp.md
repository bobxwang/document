park ui is available on port 4040 in the driver node, a spark job represents a set of transformations triggered by an individual action 

既可以在内存中也可以磁盘上工作的执行引擎  

DAG 有向无环图，支持跨有向无环图的内存数据共享  

Shuffle 数据洗牌 

./bin/spark-shell 
sc.appName
sc.version 

RpcEndpoint 
RpcEndpointRef 
NettyRpcEndpointRef 

RpcEnv
NettyRpcEnv 

RDD是分布式的Java对象集合，而DataFrame是分布式的Row对象的集合，有个Schema 

RDD Resilient Distributed Datasets，弹性分布式数据集 

DataFrames: org.apache.spark.sql.DataFrame, is a table of data with rows and columns，是结构化数据，类似于DB中的表, has scheme 

Datasets: 

Partition, is a collection of rows that sit on one physical machine,A DataFrame consists of zero or more partitions 

shuffle -> transformation && action 

A schema defines the column names and types of a dataframe or dataset 

Before Spark2.0, Instead of SparkSession，two separate entry points (HiveContext/SQLContext) were used for Spark SQL，同样在2.0中，DataFrame跟Dataset的API会合并，可以理解成DataFrame是特殊类型的Dataset，DataFrame跟Dataset是建立在Spark SQL引擎之上，使用Catalyst优化器来生成优化过的逻辑计划跟物理查询计划。Dataset only exist in jvm languages, which means scala or java, in python can’t using it。Dataset中每个record存储的是一个强类型值而不是像DataFrame一样存储的是Row，因此DataSet可以在编译时进行类型检查。DataFrame是面向Spark SQL的接口。

In general add should not be manually created by users unless u have a very,very specific reason for doing, they r a much lower-level api that provider a lot of power but also lacks a lot of the optimizations that r available in the structured api. For most DataFrame will be more efficient

Spark has two built in Partitioners, a HashPartitioner for discrete values and a RangePartitioner

Application
Job
Stage -> ShuffleMapStage/ResultStage 
TaskSet
Task

Driver
Executor 两个都是运行时创建的组件，一旦用户程序结束，他们都会释放，等待下一个用户程序提交到集群而进行后续调度。

一个Application会启动一个Driver，一个Driver负责跟踪管理该Application运行过程中所有的资源和任务状态，一个Driver会管理一组Executor，一个Executor只执行属于一个Driver的Task。An executor is responsible for two things: executing the code assigned to it by the driver, reporting the state of the computation back to the driver node 

spark.read.format(“cvs”).schema(someSchema).option(“mode”,”FAILFAST”).option(“inferSchema”,”true”).load(“path/to/file”)
readMode: permissive/dropMalformed/failFast, the permissive is the default 
saveMode: append/overWrite/errorIfExists/ignore, the errorIfExists is the the default  

MLIib，SparkMLib目前支持四种常见学习问题：分类/回归/聚类/协同过滤 
监督学习  
	回归分析/统计分类，二元分类/多元分类 
无监督学习 
	学习模型是为了推断出数据的一些内在结构，应用场景包括关联规则的学习及聚类，目标是找到训练数据的近似点 
半监督学习 
	是模式识别和机器学习领域研究的重点问题



