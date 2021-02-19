> 可靠是一个相对的概念,在条件范围内系统所能确保的多少个9的可靠性 

##### AMQP
- 消息从生产者出发到达交换机Exchange
- 交换机根据路由规则将消息转发到对应的队列Queue上
- 消息在队列Queue上存储
- 消费者订阅队列并进行消费

所以所谓的可靠性也从这四个方面来进行探讨

##### Phase 1
> 消息从生产者到达交换机,中间可能发生网络丢包等造成消息丢失
- 事务机制
> 使用此机制会吸干rabbitmq的性能,使发送端阻塞
  * channel.txSelect
  * channel.txCommit
  * channel.txRollback
- 发送方确认机制 
> 异步

  * channel.confirmSelect

> 事务机制跟发送方确认机制是互斥的,不能共存,这两个机制可以确保消息被正确发往到rabbitmq的交换机

##### Phase 2
> mandatory是channel.basicPublish的参数,immediate此参数在rabbitmq3.0版本后被去掉,当mandatory参数为true时,如果交换机找不到一个符合条件的队列,会返回Basic.Return给生产者,如果是false那么消息直接被丢弃,生产者可以通过addReturnListener来添加监听器实例
```java
public void handleReturn(int replyCode,String replyText,String exchange,String routingKey,AMQP.BasicProperties bp,byte[] body) {
     	 String message = new String(body);
	 System.out.println("Basic.Return 返回了:" + message);
     }
})
```


##### Phase 3
> 持久化提高消息可靠性,通过在申明队列时将durable参数设置为true实现,队列的持久化能保证其本身元数据不会因异常情况而丢失,但不能保证内部所存储的消息不会丢失,如果要确保消息不会丢失,需要将消息的投递模式(BasicProperties中的deliveyMode设置为2才行)
>
> 引入镜像队列,相当于配置了副本

##### Phase 4
> 消息确认机制(mesaage acknowledgement),设置autoAck为false,rabbitmq不会为未确认的消息设置过期时间,它判断消息是否需要重新投递的唯一依据是消费者是否已断开连接,这样设计的原因是rabbitmq允许消费者消费一条消息的时间可以很久很久 
