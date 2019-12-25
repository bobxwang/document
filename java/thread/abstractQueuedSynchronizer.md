#### Lock&synchronized 

```
public interface Lock {
    void lock(); // 获取锁前一直阻塞,并不受线程中断响应
    void lockInterruptibly() throws InterruptedException;
    boolean tryLock(); // 尝试获取锁不管成不成功立即返回,返回结果代表是否成功获取锁 
    boolean tryLock(long var1, TimeUnit var3) throws InterruptedException;
    void unlock();
    Condition newCondition(); // 可知Condition和生产它的锁是息息相关绑定在一起的 
}
```

#### Condition&Object#wait/notify/notifyAll

```
public interface Condition {
    void await() throws InterruptedException;
    void awaitUninterruptibly();
    boolean await(long time, TimeUnit unit) throws InterruptedException;
    boolean awaitUntil(Date deadline) throws InterruptedException;
    void signal();
    void signalAll();
}
```

* await#signal方法跟Object的wait#notify是相对应的 
* signalAll 唤醒所有处于await的线程,跟Object的nofityAll对应 

#### AbstractQueuedSynchronizer 

###### 锁异性部分

* tryAcquire  向AQS解释怎么获取一把独占锁
* tryRelease  向AQS解释怎么释放一把独占锁
* tryAcquireShared   向AQS解释怎么获取一把共享锁
* tryReleaseShared   向AQS解释怎么释放一把共享锁

###### 锁共性部分

* acquire 获取独占锁
* release  释放独占锁 
* acquireShared  获取共享锁
* releaseShared  翻译共享锁 

###### 状态属性 state

> 从上面几个方法中,参数全是int参数,其实这是AbstractQueuedSynchronizer将获取锁的过程量化对数字的操作,而state变量就是用于记录当前数字值的.
>
> 以独占锁为例:
>
> * state = 0 表示该锁未被其它线程获取 
> * state > 1 一旦有线程想获取锁,就对其进行CAS增量操作,可以是任意值不过一般取1,也就是说一旦获得锁此值就变成了1
> * 其它线程发现当前state值非0就表示锁已被其它线程获取,自动进入AQS管理流程 
> * 一旦获取锁的线程想释放锁,就对state进行自减操作,即减到0此时其它线程又可以去获取锁了 

* compareAndSetState(int expect, int update) 线程安全设置状态
* setState(int newState) 非线程安全 
* getState 获取状态值  

###### FIFO

```
public final void acquire(int arg) {
    if (!tryAcquire(arg) &&
        acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
        selfInterrupt();
}
```

* 先tryAcquire尝试获取独占锁 
* 如果获取失败则进入队列,交给AQS来处理 
  * 将当前线程包装成Node节点放到队列中进行排队

###### ConditionObject 