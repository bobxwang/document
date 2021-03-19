在开发的过程中activiti提供了比较丰富的API，同时也提供执行SQL语句的API，例如下面的例子，模糊查找前面任务提交的内容，如用户填写的表单，表单的内容放在流程变量里面，会遇到刷选的功能，下面简单介绍一下

``` java
// 变量里面模糊查找 search （有可能存在重复， 如，appliName， Catagrory 中都包含申请）
String selectClause = "select * from "
      + managementService.getTableName(HistoricTaskInstanceEntity.class) + " T, "
      + managementService.getTableName(HistoricVariableInstanceEntity.class)
      + " V  where V.EXECUTION_ID_ in "
      + exectionIds.toString().replace("[", "(").replace("]", ")")
      + " and  V.TEXT_ like '%" + search + "%'";
// activiti中提供了Native相关的操作sql语句的接口
List<HistoricTaskInstance> tasks = historyService
                    .createNativeHistoricTaskInstanceQuery().sql(selectClause).list();
```

