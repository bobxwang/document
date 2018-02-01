#### 提取器

> 跟构造器相反的效果,构造器从给定参数列表中创建一个对象,而提取器却是从传递给它的对象中提取出构造该对象的参数

##### 提取单个值 

```
trait User { def name:String }
class FreeUser(val name:String) extends User
class PremiumUser(val name:String) extends User
object FreeUser {
  def unapply(user:FreeUser):Option[String] = Some(user.name)
}
object PremiumUser {
  def unapply(user:PremiumUser):Option[String] = Some(user.name)
}
```

现在我们就可以在REPL中使用

```
scala> FreeUser.unapply(new FressUser("hello"))
res0: Option[String] = Some(hello)
```

在使用模式匹配时,Scala会隐式调用提取器的 **unapply** 方法

```
val user = new PremiumUser("hello")
user match {
  case FreeUser(name) => s"Hello${name}"
  case PremiumUser(name) => s"Welcome back,${name}"
}
```

##### 提取多个值 

```
def unapply(object: S): Option[(T1, ..., T2)]
```

##### 布尔提取器

> 有时候进行模式匹配并不是为了提取参数而是为了检查其是否匹配

```
def unapply(object: S):Boolean
```

##### 列表提取器

> 不同于上述提取器,是解析成一个列表并且这个列表的长度在编译期不确定 

```
def unapplySeq(object: S): Option[Seq[T]]
def unapplySeq(object: S): Option[(T1, .., Tn-1, Seq[T])]
```

##### 中缀表达方式 

> 解构列表,流的方法与创建它们的方法类似,都是使用cons操作符:  **::**, **#::**

``` 
val xs = 58 #:: 43 #:: 93 #:: Stream.empty
xa match {
  case first #:: secnod #:: _ => first - second
  case _ => -1
}
```