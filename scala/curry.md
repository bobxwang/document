#### Curry/Partially Function

##### 柯里化

> 把函数定义中原有的一个参数列表转变成接收多个参数列表, 在FP中, 一个参数列表包含多个参数的函数都是柯里函数,可以进行柯里化 

```
def cycle(r:Array[Float],cacl:Float=>Float) = {
  val rs:Map[Float,Float] = Map()
  r.foreach(x => rs += (x -> cacl(x)))
  rs
}
println("圆周长：" + cycle(Array(1.0f, 2.3f, 4.5f), e => 2 * 3.14f * e))
println("圆面积：" + cycle(Array(1.0f, 2.3f, 4.5f), e => 3.14f * e * e))
```

> 将上面cycle进行柯里化

```
def cycle2(r: Array[Float])(cacl: Float => Float) = {
    var rs: Map[Float, Float] = Map()
    r.foreach(x => rs += (x -> cacl(x)))
    rs
}
println("圆周长：" + cycle2(Array(1.0f, 2.3f, 4.5f))(e => 2 * 3.14f * e))
println("圆面积：" + cycle2(Array(1.0f, 2.3f, 4.5f))(e => 3.14f * e * e))
```

##### 不全函数 

> 就是它的参数还未完全确定,你想要使用还要继续告知它未知的参数

```
val c2 = cycle2(Array(1.0f, 2.0f, 3.0f)) _
println( c2(x=> 3.14f * x * x))
println( c2(x=> 2x))
```

> 可以看到,柯里化为不全函数做了铺垫,同是提升代码的简洁,像上面第一个入参一样的情况下我们就可以定义个c2来,再用c2来进行处理 

