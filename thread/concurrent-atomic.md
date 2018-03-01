> 所有的原子操作都依赖于sun.misc.Unsafe这个类,是C++实现,利用指针实现数据操作 

### CAS

> 一种无锁机制，比较并交换, 操作包含三个操作数 —— 内存位置（V）、预期原值（A）和新值(B)。如果内存位置的值与预期原值相匹配，那么处理器会自动将该位置值更新为新值。否则，处理器不做任何操作。无 论哪种情况，它都会在 CAS 指令之前返回该位置的值。CAS 有效地说明了“我认为位置 V 应该包含值 A；如果包含该值，则将 B 放到这个位置；否则，不要更改该位置，只告诉我这个位置现在的值即可

#### AtomicBoolean

#### AtomicInteger

#### AtomicLong

#### AtomicReference

#### AtomicStampedReference