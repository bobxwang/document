#### Nested Methods

```
def factorial(x: Int): Int = {
   def fact(x: Int, accumulator: Int): Int = {
     if (x <= 1) accumulator
     else fact(x - 1, x * accumulator)
   }  
   fact(x, 1)
}
println("Factorial of 3: " + factorial(3)) // will print 6
```

#### 伴生对象/伴生类 

> 静态字段(类)从严格意义上来讲是破坏了面向对象的纯洁性, 在scala中借助伴生对象来支持类级的属性跟操作

```
class Person private (val name: String) {  // 私有构造
    private def getUniqueSkill() = name + "的必杀技：" + Person.uniqueSkill
}
object Person {
    private val uniqueSkill = "Scala！"
    private val person = new Person("小强")
    def printUniqueSkill() = println(person.getUniqueSkill())
}
Person.printUniqueSkill()
```

#### [特质](trait.md) 

#### 高阶函数 High-order Function

> 至少满足下列两个条件: 接受函数作为输入; 输出一个函数 

#### 模式匹配

```
val pattern = """^(S|s)cala-(\d+\.\d+\.\d+)""".r
List("Scala", "Scala-2.11.6", "Golang", "PHP").foreach {lang =>
    lang match {
        case "Scala" => println("多面者Scala~") //匹配普通的字面量
        case pattern(_, version) => println("你的Scala版本是：" + version) //匹配正则
        case item if (item.length == 6) => println("八成是干净简洁的Go") //守卫模式,对条件做过滤
        case _ => println(lang + "语言呢？") //处理前面未匹配的项
    }
}
```

#### 并发编程 

> Actor模型
>
> * “一切皆是参与者”,且各个actor间是独立的
> * 发送者与已发送消息间解耦,这是Actor模型显著特点,据此实现异步通信
> * actor是封装状态和行为的对象,通过消息交换进行相互通信,交换的消息存放在接收方的邮箱中
> * actor可以有父子关系,父actor可以监管子actor,子actor唯一的监管者就是父actor
> * 一个actor就是一个容器,它包含了状态,行为,一个邮箱（邮箱用来接受消息,子actor和一个监管策略