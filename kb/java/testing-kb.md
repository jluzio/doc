# Integration tests with Spring Cloud
If Load Balancer is used, it might return a "ServiceInstance is null" for mocked apis.
Can disable it with:
@EnableAutoConfiguration(exclude = LoadBalancerAutoConfiguration.class)
