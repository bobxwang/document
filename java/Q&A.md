- a = a +b 与 a += b 的区别

  > += 隐匿的将加操作的结果类型强制转换为持有结果的类型

- 3 * 0.1 == 0.3 将会返回什么？true 还是 false

  > False，因为有些浮点数不能完全精确的表示出来

- 构造器链？

  > 当你从一个构造器中调用另一个构造器，就是 JAVA 中的构造器链，只有在重载了类的构造器时会出现

- 怎么创建一个不可变对象？

  - immutable 对象的状态在创建后就不能发生改变，任何对它的改变都应该产生一个新的对象

  - 类的所有属性都应该是 final 的
  - 对象必须被正确创建，比如对象引用在对象创建过程中不能泄露
  - 对象应该是 final 的，以此来限制子类继承父类，避免子类改变了父类的 immutable 特性
  - 如果类中包含 mutable 对象，那返回给客户端的时候避免返回本身，<font color=blue>应返回该对象的一个拷贝</font>

- finalize 

  > 允许使用 finalize() 方法在垃圾收集器将对象从内存中清除出去前做必要的清理工作

- Serializable / Externalizable 

  > Ext... 允许你控制整个序列化过程，指定特定的二进制格式，增加安全机制

- Object 的公共方法？

  > clone equals hashcode wait notify notifyall finalize toString getClass

- JVM 处理异常机制？

  > Exception Table
  >
  > - from 可能发生异常的起始点
  > - to 可能发生异常的结束点
  > - target 上述 from/to 之间发生异常后的异常处理者位置
  > - type 异常处理者处理的异常的类信息