#### 特质

> 类似java中的接口,用来解决编程中的横切关注点,可以在类或实例中混入(Mixin)

```
abstract class Programmer {
	def getSkill() = "所有程序员者至少掌握一门程序设计语言\n"
}
trait PHPer extends Programmer {
	override def getSkill() = super.getSkill() + "我掌握PHP。"
}
trait Scalaer extends Programmer {
	override def getSkill() = super.getSkill() + "我掌握Scala。"
}
trait Gopher extends Programmer {
    override def getSkill() = super.getSkill() + "我掌握Golang。"
}
trait CSharpter extends Programmer {
    override def getSkill() = super.getSkill() + "我掌握CSharp。"
}

val programmer1 = new Programmer with Scalaer with Gopher
val programmer2 = new Programmer with Scalaer with Gopher with PHPer
val programmer3 = new Programmer with Scalaer with Gopher with CSharpter
val programmer4 = new Programmer with Scalaer with Gopher with PHPer with CSharpter
println(programmer1.getSkill())
println(programmer2.getSkill())
println(programmer3.getSkill())
println(programmer4.getSkill())
```

> 先定义了一个Programmer抽象类.最后定义了四个不同程序员的Trait,且都继承自Programmer抽象类,然后通过不同的特质进行混入看看我们产生的结果是什么样子的:

```
所有程序员者至少掌握一门程序设计语言。
我掌握Scala。我掌握Golang。
所有程序员者至少掌握一门程序设计语言。
我掌握Scala。我掌握Golang。我掌握CSharp。
...
```

> 通过混入不同的特质,不同程序员都可以用合适的词来介绍自己

* 上而代码中,特质通过 **with** 进行混入
* 为什么信息可以传递呢? 答案就在 super.getSkill 上, 该调用不是对父类的调用,而是对其左边混入的 Trait 的调用, 如果到左边第一个就调用 Programmer 抽象类的 getSkill 方法. 这是 Trait 的一个链式延时绑定特性