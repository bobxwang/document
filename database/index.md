#### 聚集索引/非聚集索引
* 聚集索引一个表只能有一个,而非聚集索引一个表可以存在多个
* 聚集索引存储记录物理上连续,而非聚集索引只是逻辑上连续
* 聚集索引有唯一性约束,但其可以创建在任何一列上,即便该列存在重复数据
* 索引是通过二叉树形式进行描述,聚集索引叶子节点就是最终数据,而非聚集索引叶子仍然是索引节点,但它有个指向最终数据的指针 

#### Mysql

- 单例索引 

  ```mysql
  create index index_name on tbl_name(index_col_name);
  alter table tbl_name add index index_name on (index_col_name);
  ```

- 复合索引 

  > 在多个字段上创建索引，遵守"最多前缀"原则，其列顺序很重要，另外只要有一列值为 NULL，那么这一列对复合索引来就是无效的，<font color=red>因此在DB设计时，除非特别的原因，尽量不要让字段的默认值是 NULL。 </font>

  ``` mysql
  create index index_name on tbl_name(index_col_name,...);
  alter table tbl_name add index index_name on (index_col_name,...);
  ```

- 唯一索引

  > 跟单例类似，主要区别是限制列的值必须唯一，但允许有空值，对于多个字段，则列值的组合必须唯一 

  ```mysql
  create unique index index_name on tbl_name(index_col_name,...);
  alter table tbl_name add unique index index_name on (index_col_name,...);
  ```

- 主键索引 

  > 特殊的唯一索引，不允许有空值，此处不能用 create 来创建，只能用 alter table 来创建 

  ```mysql
  alter table tbl_name add primary key(index_col_name,...);
  ```

- 强制索引

  > 有时因为使用 mysql 的优化器机制，本应使用索引的优化器反而走了全表扫描，此时可通过强制索引的方式来引导优化器采取正确的执行计划，使用强制后，sql 语句只能使用建立在 index_col_name 上的索引，而不能使用其它。

  ``` mysql
  select * from tbl_name force index(index_col_name) ...
  ```

- 全文索引 

  > 在 mysql 中是一个 fulltext 的索引，在 5.6 版本后支持 innodb，而在之前只支持 myisam 

  ```mysql
  alter table tbl_name add fulltext key index_name(index_col_name);
  ```