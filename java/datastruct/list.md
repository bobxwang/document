#### BlockingQueue

``` java
interface BlockQueue<E> entends Queue<E> {
  E poll(long timeout, TimeUnit unit) throws InterruptedException; // 等待给定超时时间
  boolean offer(E e, long timeout, TimeUnit unit) throws InterruptedException; // 超时等待
  E remove(); // 队列为空时抛出 NoSuchElementException
  E poll();   // 为空时返回 null
  E take() throws InterruptException; // 一直等待直到队列不为空
  void put(E e) throws InterruptedException; // 一直等待
  boolean add(E e);    // 队列满时会抛出 IllegalStateException
  boolean offer(E e);  // 满时会返回 false 
} // 不接受 null 元素，可限定容量，线程安全，因此被用于生产者-消费者队列
```

#### ArrayBlockingQueue

> 基于 ReentrantLock 实现线程安全，有界队列实现类 

#### LinkedBlockingQueue 

> 基于 head/tail, 因此不同于 ArrayBlockingQueue, 在这中有两把锁来进行控制，可以是有界也可以是无界

#### PriorityBlockingQueue

> 支持优先级排序的无界阻塞队列

#### SynchronousQueue

> 一种很特别的BlockingQueue，任何一个添加元素的操作都必须等到另外一个线程拿走元素才会结束。也就是SynchronousQueue本身不会存储任何元素，相当于生产者和消费者手递手直接交易。有一个fair选项，如果fair为true，称为fair模式，否则就是unfair模式。

#### DelayQueue

> 支持延时获取元素的使用优先级队列实现的无界阻塞队列 

#### CopyOnWriteArrayList/CopyOnWriteArraySet

> 适合读多写少的场景,且数据量不大,因为需要复制原先存储数据的数组 