<p align="center">
  <span>中文 | <a href="./README.en.md">English</a></span>
</p>

---

# fixkit 项目待办列表

## 模块计划（已完成 1/2）

- [x] ~~测试~~

- [ ] 通用模块功能设计
    - [ ] 幂等
    - [ ] 分布式锁
    - [ ] 缓存
    - [ ] 消息可靠性
    - [ ] 限流
    - [ ] 监控
    - [ ] 链路追踪
    - [ ] 统一日志
    - [ ] 配置中心
    - [ ] 任务调度
    - [ ] 重试机制
    - [ ] 安全策略
    - [ ] 文件上传
    - [ ] 搜索
- [ ] 每个服务都应实现：traceId 注入 + Prometheus 指标 + structured logging（JSON）+ health checks


## 实现思路

### 幂等
- 请求入参生成唯一签名 (userId+bizKey)，存入 Redis Set；执行前检查是否存在；存在则拒绝执行。注解 `@Idempotent` 封装。

### 分布式锁
- 用 Redisson 获取锁（含租约与看门狗），封装为 `@DistributedLock` 注解；失败时自动快速失败。
- 
### 缓存
- 所有缓存访问经 `CacheTemplate`；支持读写穿透、缓存击穿、批量加载、异步刷新；缓存Key命名约定 `{service}:{biz}:{id}`。
- 
### 消息可靠性
- Outbox 表 + MQ producer；事务提交后异步发送；失败自动重试；消费者幂等消费（offset + 消息ID）。
- 
### 限流
- Redis + Lua 实现滑动窗口限流；注解 `@RateLimit` 注入规则。
- 
### 监控
- 每个服务内置 Prometheus 指标：QPS、RT、ErrorRate、ConsumerLag、CacheHit；通过统一 `MetricsRegistry` 注册。
- 
### 链路追踪
- 全链 traceId 注入 MDC；MQ、异步任务、HTTP 请求上下文自动透传。
- 
### 统一日志
- JSON 格式日志；包含 traceId、userId、path、latency。通过 `LogAspect` 统一打印入口/出口。
- 
### 配置中心
- 外部化配置管理（Spring Cloud Config / Nacos）；支持灰度参数热更新。
- 
### 任务调度
- 定时任务基于 XXL-Job 或 Spring Scheduler；任务状态 + metrics 监控
- 
### 重试机制
- 使用 `@Retryable` 注解配合 Spring Retry；支持指数退避策略。
- 
### 安全策略
- 接口鉴权通过 JWT 或 OAuth2；XSS、SQL 注入统一防护。

### 文件上传
- 本地存储 / OSS SDK + CDN 缓存

### 搜索
- Elasticsearch + 双写（数据库 + ES） + 异步同步任务

