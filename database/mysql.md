1，很多查询优化工作实际上就是遵循一些原则让优化器按照预想的合理方式运行而已

2，如果查询语句很长，可能会抛出错误，需要设置 max_allowed_packet 参数

3，查询缓存，如果查询中包含UDF，存储函数，用户变量，临时表等，那么其查询均不会进行缓存，可通过 SQL_CACHE/SQL_NO_CACHE 来控制某语句是否缓存 

4，语法解析/预处理，使用基于成本的优化器，show status like 'last_query_cost' 获得当前查询成本

5，查询执行引擎 

6，表锁有 MySql Server 实现，而行锁由存储引擎实现。

##### 优化
* 表结构设计与数据类型选择，采用小而简单原则
* 创建高性能索引
  * 索引最左原则
  

##### 存储引擎对比 

> MyISAM 可被压缩，存储空间小，在筛选大量数据时非常快 
>
> InnoDB 需要更多存储空间，会在内存中建立专用的缓冲池用于高速缓冲数据跟索引 

|              | MyISAM | InnoDB |
| ------------ | ------ | ------ |
| 事务         | 不支持 | 支持   |
| 外键         | 不支持 | 支持   |
| 行级锁       | 不支持 | 支持   |
| 自动奔溃恢复 | 不支持 | 支持   |
|              |        |        |

##### Mac Brew Mysql Forget Pass

``` shell
vim /usr/local/etc/my.cnf
// 在最后添加 skip-grant-tables 这一行，:wq 保存退出，这一行目的是跳过密码验证
mysql.server restart  // service mysql stop/start
mysql -u root -p  // 直接回车，因前面配置了跳过密码验证
select version(); // 确认当前版本
flush privileges; // 刷新
user mysql;
alter user‘root‘@‘localhost‘ IDENTIFIED BY ‘aBc@123456‘;
vim /usr/local/etc/my.cnf // 删掉刚开始加的那一行，恢复密码验证
mysql.server restart // 重启 brew services start/stop/restart mysql
mysql -u root -p // 输入 aBc@123456 进行登录
```

