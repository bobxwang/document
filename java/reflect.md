反射使程序代码能够接入装载到JVM中的类的内部信息，允许在编译时与执行时，而不是源代码中选定的类协作的代码，总的 来说，就是以开发效率换运行效率的一种手段。这使反射成为构建灵活应用的主要工具。

反射最终还是走 native 的方法，比如

```java
class.getDeclaredFields
private native Field[] getDeclaredFields0(boolean publicOnly);
```

