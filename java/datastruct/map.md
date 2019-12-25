#### HashMap

- 非线程安全，体现在 put 操作引起扩容时会死循环

#### HashTable

- 线程安全，利用 synchronized 来保证，但线程激烈的情况下效率低，因为共用一把锁

#### ConcurrentMap

```java
interface ConcurrentMap<K,V> extends Map<K,V>
```

#### ConcurrentHashMap 

> 读操作完全并发执行，不需要加锁 

- jvm 7

  > 锁分段，由 Segment 数据结构跟 HashEntry 数组结构组成，Segment 是一种可重入锁 ReentrantLock，在这里扮演锁的角色，保护不同段的数据。而 HashEntry 则用于存储键值对数据

  ```java
  static final class Segment<K,V> extends ReentrantLock implements Serializable
  ```

- jvm8 

  > Node 结构，同 7 中的 HashEntry，摒弃了 Segment 段锁的概念，利用 CAS 算法来解决并发，里面可以发现使用了大量 U.compareAndSwapXXX 方法

  - Traverser 类 

    > 主要用于遍历操作，子类有 BaseIterator/KeySpliterator/ValueSpliterator/EntrySpliterator

  - CollectionView 类

    > 抽象视图操作，子类有KeySetView/ValueSetView/EntrySetView