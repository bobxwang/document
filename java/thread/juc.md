#### 多线程

- 有序性
- 可见性
- 原子性

#### synchronized

> 基于 Monitor 实现，Monitor 是基于 C++实现，由 ObjectMonitor 实现，意味着一次内核态的切换

- 同步方法
  - ACC_SYNCHRONIZED
- 同步代码码
  - monitorenter
  - monitorexit

#### collecitons

- Queue
  - ConcurrentLinkedQueue
  - BlockingQueue
    - ArrayBlockingQueue
    - DelayQueue
    - LinkedBlockingQueue
    - PriorityBlockingQueue
    - SynchronousQueue
  - Deque
    - ArrayDeque
    - InentityLinkedList
    - LinkedList
    - BlockingDeque
      - LinkedBlockingDeque
- CopyOnWriteArrayList
- CopyOnWriteArrsySet
- ConcurrentSkipListSet
- ConcurrentMap 
  - ConcurrentHashMap
  - ConcurrentNavigableMap
    - ConcurrentSkipListMap 

#### executor

- Future
  - RunnableFuture
    - RunnableScheduledFuture
    - FutureTask
  - ScheduledFuture
- Callable
- Executor
  - ExecutorService 
    - ScheduledExecutorService
    - ThreadPoolExecutor
    - ScheduledThreadPoolExecutor
- CompletionService
  - ExecutorCompletionService
- RejectedExecutionhandler
  - DiscardPolicy
  - DiscardOldestPolicy
  - CallerRunsPolicy
  - AbortPolicy
- TimeUnit

#### tools

- CountDownLatch
- CyclicBarrier
- Semaphore
- Executors
- Exchanger

#### locks

- Lock

  - ReentrantLock，通过构造传参确定是否是公平锁
    - ReadLock
    - WriteLock

- Condition

- ReadWriteLock

  - ReentrantReadWriteLock

- LockSupport

- AbstractQueuedSynchronizer

  - 双向链表

  - 类型状态

    ![](./sync-lock.jpeg)

#### aotmic

- AtomicBoolean
- AtomicInteger
- AtomicIntegerArrray
- AtomicLong
- AtomicLongArray
- AtomicReference 

### 多线程同步

> Object.wait，释放CPU资源，同时释放锁，可中断方法，被中断后抛出异常
>
> Thread.sleep，释放CPU资源，但不释放锁，当前线程，可中断方法，被中断后抛出异常
>
> Thread.join
>
> Thread.yield，释放CPU的执行权，但依然保留执行资格。举个例子：很多人排队上厕所，刚好排上yield了，但yield说，出让这次机会，与更急的人一起比赛谁能更快进入厕所。这个比赛结果可能是其他人也可能就是yield本身，也是当前线程
>
> LockSupport.park

####InterruptedException

> 当阻塞方法收到中断请求的时候就会抛出此异常

#### 线程状态 

![](./thread-state.png)

- New 这个状态主要是线程未被Thread.start()调用前的状态，此时线程与普通的 java 对象没有什么区别，仅仅是堆内存中的一个对象 
- Runnable，线程具备所有运行条件在队列中准备OS的调度或者正在 JVM 中运行。这个状态的线程不能停留太久，如果运行时间很长(存在性能问题)或者一直在队列得不到运行(存在线程饥饿问题)
- Blocked，被阻塞等待一个 monitor 锁，即线程正在等待进入方法临界区
- Waiting，由于调用了 Object.wait(0)/Thread.join(0)/LockSupport.park 的线程状态，正在等待某个事件发生(notify/notifyAll)，只有特定条件满足才能执行
- Timed_Waiting，调用了 Object.wait(long)/Thread.join(long)/LockSupport.parkNanos/LockSupport.parkUntil 的线程状态，当等待时间过去后会自动恢复运行 
- Terminated，线程终止 

