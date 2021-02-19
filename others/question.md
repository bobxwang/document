- 装箱/拆箱

- Synchronized/lock 区别，使用场景 

- Minor/Full GC 触发机制

- SPI

  基于接口的编程 + 策略模式 + 配置文件 组合实现的一个动态加载机制 

  ```java
  java.util.ServiceLoader
  // 缺点：
  // 1，只能遍历，如果不想用某些类也会被加载，造成浪费。
  // 2，多个并发多线程使用时类的实例是不安全的。
  ```

- JVM

- 缓存 

- volatile

- happen-before

- 并发锁

- aop

- 动态代理/cglib 

- ioc

- http

- tcp

- session/cookie 

- 最熟悉的项目

- 项目使用了什么架构，亮点是什么

- 平时主要学习什么课程 

- 索引数据结构

  - B+ Tree

- 最左前缀优化原则 

- 联合索引 

- 

#### 高频百分二十问

- 集合类

- IO

  - NIO 

    - Selector，多路复用器，这块是阻塞的监听 IO 事件变更，只是这种方式没有让客户端等待，而是 Selector 自己在等待 IO 返回，并通知客户端去获取数据。

    - poll
    - epoll 

- Reactor

- Proactor 

- 泛型 

- 类加载机制

- 双亲委派

- JVM 内存模型 

- GC

- 并发编程

- 线程池

- Spring

- Mybatis 

- Docker

- CAP

- 分布式锁

- 分布式事务

- Redis

- Dubbo

- RabbitMQ