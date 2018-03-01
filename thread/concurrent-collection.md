##### ConcurrentMap

```
interface ConcurrentMap<K,V> extends Map<K,V>
```

##### ConcurrentHashMap

> 对于HashMap来说，有一个Entry数组，根据Key的hash值对数组长度取模得到数组下标，找到Entry，遍历整个Entry链表，用equals比较来确定key所在的Entry。
>
> ConcurrentHashMap的基本思想是采取分块的方式加锁，分块数由参数“concurrencyLevel”来决定（和HashMap中的“initialCapacity”类似，实际块数是第一个大于concurrencyLevel的2的n次方）。每个分块被称为Segment，Segment的索引方式和HashMap中的Entry索引方式一致（hash值对数组长度取模）。

```
static final class Segment<K,V> extends ReentrantLock implements Serializable
```

##### BlockingQueue

``` 
interface BlockQueue<E> entends Queue<E> {
  E take() throws InterruptException; // 一直等待直到队列不为空
  E poll(long timeout, TimeUnit unit) throws InterruptedException; // 等待给定超时时间
  E remove(); // 队列为空时抛出 NoSuchElementException
  E poll();  // 为空时返回 null
  void put(E e) throws InterruptedException; // 一直等待
  boolean offer(E e, long timeout, TimeUnit unit) throws InterruptedException; // 超时等待
  boolean add(E e); // 队列满时会抛出 IllegalStateException
  boolean offer(E e);  // 满时会返回 false 
}
```

* ArrayBlockingQueue

  > 基于 ReentrantLock 实现线程安全

* LinkedBlockingQueue 

  > 基于 head/tail, 因此不同于 ArrayBlockingQueue, 在这中有两把锁来进行控制  

* SynchronousQueue

  > 一种很特别的BlockingQueue，任何一个添加元素的操作都必须等到另外一个线程拿走元素才会结束。也就是SynchronousQueue本身不会存储任何元素，相当于生产者和消费者手递手直接交易。有一个fair选项，如果fair为true，称为fair模式，否则就是unfair模式。

##### CopyOnWriteArrayList/CopyOnWriteArraySet

> 适合读多写少的场景,且数据量不大,因为需要复制原先存储数据的数组 

