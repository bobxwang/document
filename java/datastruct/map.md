### Map

本质是个散列表，那么就离不开散列函数，哈希冲突，扩容方案。

- 哈希函数，计算 key 在数组中的下标(散列是否均匀,计算是否简单)
- 哈希冲突，开放地址法/再哈希/公共溢出表法/链地址法
- 扩容方案，装载因子(默认0.75)

#### HashMap

- 非线程安全，体现在 put 操作引起扩容时会死循环
- 对 key 对象的 hashcode 进行扰动(随机性更高)，同时取模(不会让key聚集提高散列度)求得数组下标
- 初始化指定长度(默认16)/扩容时长度增量，这两种方案控制数组长度为2的整数次幂
- 效率低下是因为其用 synchronized 关键字对 put 等操作进行加锁

#### LinkHashMap

记录插入顺序的 Map

#### TreeMap

给 key 排序的 Map

#### HashTable

- 线程安全，利用 synchronized 来保证，但线程激烈的情况下效率低，因为共用一把锁

#### ConcurrentMap

```java
interface ConcurrentMap<K,V> extends Map<K,V>
```

#### ConcurrentHashMap 

> 读操作完全并发执行，不需要加锁 
>
> CAS/自旋锁

- jvm 7

  > 锁分段，由 Segment 数据结构跟 HashEntry 数组结构组成，Segment 是一种可重入锁 ReentrantLock，在这里扮演锁的角色，保护不同段的数据。而 HashEntry 则用于存储键值对数据
  >
  > 简单来讲，1.7中的 ConcurrentHashMap 是一个 Segment 数组(默认是16个，初始化后不可扩容)，能扩容的是每个 Segment 中的数量，Segment 内部是由数组+链表组成，采用的是 Segment + HashEntry + ReentrantLock 的方式进行实现，锁的粒度是基于 Segment
  >
  > - initialCapacity，初始容量，实际操作时需平均分给每个 Segment
  > - loadFactor，负载因子

  ```java
  static final class Segment<K,V> extends ReentrantLock implements Serializable {}
  private Segment<K,V> ensureSegment(int k) {
    // 初始槽，其并发操作使用 CAS 进行控制
  }
  private HashEntry<K,V> scanAndLockForPut(K key, int hash, V value) {
  	// 获取 segment 的独占锁，如果需要还会顺便实例化一下 node
  }
  private void rehash(HashEntry<K,V> node) {
    // 方法参数 node 是这次扩容后，需要添加到新数组中的数据
  }
  ```

- jvm8 

  > Node 结构，同 7 中的 HashEntry，摒弃了 Segment 段锁的概念，利用 CAS 算法来解决并发，里面可以发现使用了大量 U.compareAndSwapXXX 方法，其锁的粒度抛弃了 Segment进而采用的是 HashEntry 结合了 synchronized，因为锁粒度的降低，复杂度也就增加了
>
  > get 操作全程不加锁是因为Node的成员val是用volatile修饰的，数组用volatile修饰主要是保证在数组扩容的时候保证可见性 

  - Traverser 类 

    > 主要用于遍历操作，子类有 BaseIterator/KeySpliterator/ValueSpliterator/EntrySpliterator

  - CollectionView 类
  
    > 抽象视图操作，子类有KeySetView/ValueSetView/EntrySetView
  
  ``` java
  final V putVal(K key, V value, boolean onlyIfAbsent) {}
  private final Node<K,V>[] initTable() {}
  private final void treeifyBin(Node<K,V>[] tab, int index) {
    // 链表转红黑树
  }
  private final void tryPresize(int size) { 
  	// 扩容
  }
  private final void transfer(Node<K,V>[] tab, Node<K,V>[] nextTab) { 
  	// 数据迁移
  }
  ```

