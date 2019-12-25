#### ThreadPoolExecutor 

> 类图

![executor](Executor.png)

> 基于jdk8分析 

```
public ThreadPoolExecutor(int corePoolSize, // 核心线程数
                              int maximumPoolSize,  // 最大线程数
                              long keepAliveTime,  // 最大空闲时间,针对超过核心线程数的线程
                              TimeUnit unit,
                              BlockingQueue<Runnable> workQueue, // 任务队列
                              ThreadFactory threadFactory,
                              RejectedExecutionHandler handler // 拒绝策略) {
        if (corePoolSize < 0 ||
            maximumPoolSize <= 0 ||
            maximumPoolSize < corePoolSize ||
            keepAliveTime < 0)
            throw new IllegalArgumentException();
        if (workQueue == null || threadFactory == null || handler == null)
            throw new NullPointerException();
        this.corePoolSize = corePoolSize;
        this.maximumPoolSize = maximumPoolSize;
        this.workQueue = workQueue;
        this.keepAliveTime = unit.toNanos(keepAliveTime);
        this.threadFactory = threadFactory;
        this.handler = handler;
    }
```

##### 最大线程数 = 核心线程数 + 非核心线程数

##### execute(runnable)

* 如果当前线程数小于核心线程数,则直接创建一个线程,用于执行新加进来的任务,即使线程池中其它线程是空闲

* 如果当前线程数已超过核心线程数则放入任务队列

  > **corePoolSize < 运行的线程数 < maximumPoolSize: ** 仅当队列满时才创建新线程
  >
  > **corePoolSize = 运行的线程数 = maximumPoolSize:**  创建固定大小的线程池

  * 如果任务队列是有界并已满 
    * 如果此时线程数小于最大线程数,则直接创建一个线程(非核心线程)执行该任务
    * 如果此时线程数大于最大线程数,则采用拒绝策略 

##### ctl

> 是ThreadPoolExecutor的一个重要属性,记录着ThreadPoolExecutor的线程数量和线程状态 

```
private final AtomicInteger ctl = new AtomicInteger(ctlOf(RUNNING, 0));
```

> Integer有32位,其中三位用于记录线程状态,后29位用于记录线程数量

```
private static final int COUNT_BITS = Integer.SIZE - 3;  // 线程数量占用的位数
```

##### addWorker(Runnable firstTask, boolean core)

> addWorker有2种情况,一种就是线程数量不足核心线程数,另一种就是核心线程数已满同时任务队列已满但是线程数不足最大线程数,参数 core 就是用来区分上述两种情况的 