#### RestTemplate 

* 当被@LoadBalanced注解修饰后，通过其发送REST请求，会被 LoadBalanceInterceptor 类拦截，进行负载均衡及请求地址的转换 

#### AbstractLoadBalancerRule implements IRule  

* RandomRule 随机数索引 
* RoundRobinRule 线性轮询，默认
* RetryRule 
* WeightedResponseTimeRule 对RoundRobinRule的扩展，增加了根据实例的运行情况来计数权重，内部有个定时任务去统计各实例的权重 
* ClientConfigEnableRoundRobinRule 
* BestAvailableRule，忽略短路的服务器，选择并发数较低的服务器
* PredicateBasedRule
* AvailableFilteringRule，可用性筛选
* ZoneAvoidanceRule，以区域可用服务器进行选择，使用Zone对服务进行分类

#### RibbonAutoConfiguration

* interface LoadBalancerClient extends ServiceInstanceChooser 
* class RibbonLoadBalancerClient implements LoadBalancerClient 
* ZoneAwareLoadBalancer extends DynamicServerListBalancer extends BaseLoadBalancer extends AbstractLoadBalancer implements ILoadBalancer 
  > DynamicServerListBalancer 是对基础负载均衡的扩展，实现了服务实例清单在运行期的动态更新能力，同时还具备了实例清单的过滤功能 

#### ServerListFilter
  > 服务过滤

* ServerListSubsetFilter extends ZoneAffinityServerListFilter extends AbstractServerListFilter 

#### IPing 
  > 心跳检测

* DummyPing，默认简单实现，认为所有服务都是存活状态
* NIWSDiscoveryPing
* NoOpPing，啥都不干
* PingConstant
* PingUrl

