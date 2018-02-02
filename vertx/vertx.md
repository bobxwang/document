##### Vertical

>一个vert.x实例/进程内有多个Eventloop和Worker线程,每个线程会部署多个Verticle对象并对应执行Verticle内的Handler,每个Verticle内有多个Handler,普通Verticle会跟Eventloop绑定,而Worker Verticle对象则会被Worker线程所共享,被依次顺序访问,但不会被并发同时访问,如果声明为Multiple Threaded Worker Verticle则没有此限制,不过需要开发者手工处理并发冲突,一般并不推荐这类操作.

* Stardand Verticle：这是最常用的一类 Verticle,它们永远运行在 Event Loop 线程上。

* Worker Verticle：这类 Verticle 会运行在 Worker Pool 中的线程上。一个实例绝对不会被多个线程同时执行。但它可以在不同时间由不同线程执行。

* Multi-Threaded Worker Verticle：这类 Verticle 也会运行在 Worker Pool 中的线程上。一个实例可以由多个线程同时执行（译者注：因此需要开发者自己确保线程安全）

   > 一个Multi-threaded Worker Verticle 近似普通的 Worker Verticle,但是它可以由不同的线程同时执行。

