What is phantom read and which isolation level prevents it?
A phantom read is the situation where a transaction executes a query multiple times and get different data. Suppose a transaction is executing a query to get data based on a condition and then another transaction inserts a row that matches the condition. Now when same transaction will execute the query again, a new row will be part of the result set. This new row is referred as Phantom Row and this situation is termed as Phantom Read.

What is “dirty read” in JDBC? Which isolation level prevents dirty read?
When we work with transactions, there is a chance that a row is updated and at the same time other query can read the updated value. This results in a dirty read because the updated value is not permanent yet, the transaction that has updated the row can rollback to previous value resulting in invalid data.
Dirty Read is prevented by isolation levels TRANSACTION_READ_COMMITTED, TRANSACTION_REPEATABLE_READ and TRANSACTION_SERIALIZABLE.

 脏数据
　　脏读就是指当一个事务正在访问数据，并且对数据进行了修改，而这种修改还没有提交到数据库中，这时，另外一个事务也访问这个数据，然后使用了这
个数据。因为这个数据是还没有提交的数据，那么另外一个事务读到的这个数据是脏数据(Dirty Data)，依据脏数据所做的操作可能是不正确的。
 
 不可重复读
　　不可重复读是指在一个事务内，多次读同一数据。在这个事务还没有结束时，另外一个事务也访问该同一数据。那么，在第一个事务中的两次读数据之间，由于第二个事务的修改，那么第一个事务两次读到的数据可能是不一样的。这样就发生了在一个事务内两次读到的数据是不一样的，因此称为是不可重复读

A:Atomicity
C:Consistency
I:Isolation
D:Durability

并发机制控制：锁/时间戳/MVCC 

分布式事务其实就是在不可靠的通信下实现事务的特性,各种形式的日志是保证事务几大特性的重要手段。
* 2PC，一个阻塞协议，也就是说在两阶段提交的执行过程中，如果事务的执行过程中协调者永久宕机，事务的一部分参与者将永远无法完成事务，它们会等待协调者发送 COMMIT 或者 ROLLBACK 消息，甚至会出现多个参与者状态不一致的问题。
	投票阶段
 	提交阶段
* 3PC，为解决2PC的问题，引入了超时机制跟准备阶段，如果协调者或者参与者在规定的之间内没有接受到来自其他节点的响应，就会根据当前的状态选择提交或者终止整个事务，准备阶段的引入其实让事务的参与者有了除回滚之外的其他选择。当参与者向协调者发送 ACK 后，如果长时间没有得到协调者的响应，在默认情况下，参与者会自动将超时的事务进行提交，不会像两阶段提交中被阻塞住。
* XA 事务 
* Saga 一种简化的分布式事务解决方案，它将一系列的分布式操作转化成了一系列的本地事务，在每一个本地事务中我们都会更新数据库并且向集群中的其他服务发送一条的新的消息来触发下一个本地的事务；一旦本地的事务因为违反了业务逻辑而失败，那么就会立刻触发一系列的回滚操作来撤回之前本地事务造成的副作用。 
* 消息机制

