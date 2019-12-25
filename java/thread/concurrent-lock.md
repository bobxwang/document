##### Condition

```
Lock lock = new ReentrantLock(); // 可重入锁
Condition condition = lock.newCondition();
```

##### Lock/ReadWriteLock

```
interface ReadWriteLock {
  Lock readLock();
  Lock writeLock();
}
```

##### LockSupport

> 工具类操作对象是线程,基于Unsafe类实现 

##### Semaphore

> 可以看成一个有限有共享锁, 即只能被有限数量的线程使用的共享锁 

##### Exchanger

> 可以看做双向数据传输的SynchronousQueue，即没有生产者和消费者之分，任意两个线程都可以交换数据。
>
> 在JDK5中Exchanger被设计成一个容量为1的容器，存放一个等待线程，直到有另外线程到来就会发生数据交换，然后清空容器，等到下一个到来的线程。
>
> 从JDK6开始，Exchanger用了类似ConcurrentMap的分段思想，提供了多个slot，增加了并发执行时的吞吐量。
>
> Exchanger不存在公平不公平的模式，因为没有排队的情况发生，只要有两个线程就可以发生数据交换。

##### Phaser

> JDK 7 后新添加 