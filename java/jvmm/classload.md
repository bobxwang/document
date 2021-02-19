![avatar](./classload.jpg)

- 加载

  > 加载阶段的主要工作就是，把class二进制文件加载到内存后，将类中定义的静态变量、常量、类信息等数据存放到方法区，并在堆内存中创建一个代表这个类的Class对象，作为方法区中这个类的数据信息的访问入口，程序猿可以持有这个Class对象。

  - 资源定位，根据包名加类名定位到class文件位置，获得二进制流
  - 将流代表的静态存储结构转为方法区的运行时数据结构
  - 在堆内存生成一个代表此类的对象，作为方法区中这个类的各种数据访问入口

- 验证

  > 确保class文件中包含的信息是符合虚拟机要求的，且不会危害虚拟机安全。验证阶段是一个非常重要、但不是一定必要的阶段。如果所运行的全部代码都已经被反复使用和验证过了，那么就可以使用虚拟机参数 -Xverify:none 来关闭大部分的类验证措施，以缩短类加载的时间

- 准备

  > 准备阶段的主要工作是为类的静态变量分配内存并设置变量的初始默认值

- 解析

  > 解析阶段是虚拟机将常量池内的符号引用替换为直接引用的过程

- 初始化 

  > 初始化阶段是类加载过程的最后一步。在前面的类加载过程中，除了加载阶段我们可以通过自定义的类加载器参与之外，其余的阶段都是虚拟机自动完成的。到了初始化阶段，才真正开始执行我们程序中定义的Java代码。初始化阶段的主要工作是给类的静态变量赋予我们程序中指定的初始值。也就是上面准备阶段提到的，变量a的值从0变为1的过程。这个阶段我们程序指定初始值包括两种手段：
  >
  > - 声明静态变量时显式的复制。例如：public static int a = 1; 在初始化阶段会把1赋给变量a
  > - 通过静态代码块赋值。例如：static { a = 2 }; 变量a 的初始值赋为2

##### 双亲委派

- Bootstrap ClassLoader

- Extension ClassLoader

- Application ClassLoader 

- 打破双亲

  - Tomcat WebApp ClassLoader 

    > 解决加载各自应用下的 WEB-INF/class 跟 WEB-INF/lib

  - Tomcat Catalina ClassLoader 

    > ${catalina.base}/lib,${catalina.base}/lib/*.jar${catalina.home}/lib,${catalina.home}/lib/*.jar

  - Tomcat Common ClassLoader

    > ${catalina.home}/lib,${catalina.home}/lib/*.jar

