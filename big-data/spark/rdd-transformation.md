#### Transformation

* map(func)

* flatMap(func)

* mapPartitions(func)

  > func 的类型: Iterator[T] => Iterator[U]
  >
  > 假设有N个元素,M个分区,那么map函数将会被调用N次,而mapPartitions被调用M次,当在映射的过程中不断的创建对象时就可以使用mapPartitions比map的效率要高很多,比如当向数据库写入数据时,如果使用map就需要为每个元素创建connection对象,但使用mapPartitions的话就需要为每个分区创建connetcion对象

* mapPartitionsWithIndex(func)

  > func 的类型: (Int, Iterator[T]) => Iterator[U]
  >
  > 跟mapPartitions类似,不过多了个索引参数