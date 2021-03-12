#### Grapql

##### Type

> 数据类型抽象

- Scalar Type

  > 内置标量，简单类型

- Object Type

- IType Modifier

  - [Type]! 列表本身非空，但里面元素可以为空
  - [Type!] 列表本身可以为空，但里面元素不能为空
  - [Type!]! 列表本身跟内部元素都不能为空 

##### Schema

> 数据操作逻辑

- query
- mutation
- subscription  当希望更改数据时，进行一个消息推送

##### Resolver

> 解析函数 

