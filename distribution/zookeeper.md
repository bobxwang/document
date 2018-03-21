##### ZooKeeper Atomic Broadcast

> ZAB 原子协议, 要么全部成功要么全部失败 

##### 脑裂

> 两台主机互相竞争的情况

###### zk如何解决?

1. zk作为第三方集群参与到主备节点,当主备启动时在zk上竞争创建一个临时锁节点,成功则为主机其余为备机
2. 所有备机监听该临时锁节点,一旦主机与zk间session失效,则临时节点被删除
3. 一旦临时节点被删除备机开始重新申请创建临时锁节点,重新急用为主机
4. 在主机争节点后对根节点做一个ACL权限控制,则其它机器由于无法更新临时锁节点只有放弃成为备机 

##### 角色

* Leader
* follower
* observer

##### Znode

> 每个znode创建时都会带有一个ACL列表,用于决定谁可以对它执行何种操作

* PERSISTENT
* PERSISTENT_SEQUENTIAL
* EPHEMERAL 临时节点不能有子节点 
* EPHEMERAL_SEQUENTIAL