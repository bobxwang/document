t is phantom read and which isolation level prevents it?
A phantom read is the situation where a transaction executes a query multiple times and get different data. Suppose a transaction is executing a query to get data based on a condition and then another transaction inserts a row that matches the condition. Now when same transaction will execute the query again, a new row will be part of the result set. This new row is referred as Phantom Row and this situation is termed as Phantom Read.

What is “dirty read” in JDBC? Which isolation level prevents dirty read?
When we work with transactions, there is a chance that a row is updated and at the same time other query can read the updated value. This results in a dirty read because the updated value is not permanent yet, the transaction that has updated the row can rollback to previous value resulting in invalid data.
Dirty Read is prevented by isolation levels TRANSACTION_READ_COMMITTED, TRANSACTION_REPEATABLE_READ and TRANSACTION_SERIALIZABLE.

 脏数据
　　脏读就是指当一个事务正在访问数据，并且对数据进行了修改，而这种修改还没有提交到数据库中，这时，另外一个事务也访问这个数据，然后使用了这
个数据。因为这个数据是还没有提交的数据，那么另外一个事务读到的这个数据是脏数据(Dirty Data)，依据脏数据所做的操作可能是不正确的。
 
 不可重复读
　　不可重复读是指在一个事务内，多次读同一数据。在这个事务还没有结束时，另外一个事务也访问该同一数据。那么，在第一个事务中的两次读数据之间，由于第二个事务的修改，那么第一个事务两次读到的数据可能是不一样的。这样就发生了在一个事务内两次读到的数据是不一样的，因此称为是不可重复读

