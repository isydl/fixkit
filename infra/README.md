# 介绍

> - 基础设施层（中间件封装）
> - 本文档会详细描述功能实现

## 目录结构
```
├── infra/                  # 基础设施层（中间件封装）
│   ├── src/main/java/com/trick/infra/
│   │   ├── cache/          # Redis 封装与缓存模板
│   │   ├── mq/             # Kafka / RabbitMQ 封装（Producer/Consumer 模板）
│   │   ├── db/             # MyBatisPlus、分页插件、雪花ID生成器
│   │   ├── lock/           # 分布式锁封装（基于 Redisson）
│   │   ├── eventbus/       # 领域事件总线封装（内存+异步）
│   │   └── observability/  # Prometheus 指标、日志追踪、链路追踪封装
│   └── pom.xml

```
## Todo
- [ ] RedisTemplate 封装 + CacheTemplate
- [ ] RabbitMQ 封装
- [ ] MyBatisPlus + 分页 + 数据源配置
- [ ] Redisson 分布式锁封装
- [ ] eventbus事件总线 
- [ ] observability指标与日志链路封装

## 思路

### 缓存
- 使用 `@Cacheable` + `@CacheEvict` 组合，Spring AOP 统一管理
- 常见架构：**Guava（本地） + Redis（二级）**
- 防击穿：加空值缓存
- 防雪崩：随机过期时间 + 异步刷新
- 防穿透：布隆过滤器提前拦截。
- 更新策略：先删缓存后写数据库，写入成功后异步通知刷新
- Key 设计示例（规范化）：`user:profile:<userId>`, `user:followers:<userId>`, `user:following:<userId>`。

### RabbitMQ 封装
- 统一 Producer/Consumer 模板
- 自动注册 topic
- 重试机制
- 死信队列策略
- Outbox模式：事务内写出一条“待发送消息”，由后台任务投递MQ。
- 消费幂等：消费端记录`messageId` + 状态表。
- 顺序性：分区键（例如订单号）一致投递。
- 失败补偿：DLQ + 定时补偿任务。
- 性能：批量发送、异步ack。

### MyBatisPlus + 分页 + 数据源配置
- 封装分库分表路由
- 提供 BaseMapper 扩展
- 分页方言适配

### Redisson 分布式锁封装
- 提供 `LockTemplate`，支持注解`@DistributedLock` 自动加锁释放

### eventbus事件总线
- 实现轻量级异步发布订阅

### observability指标与日志链路封装
- 统一接入 Prometheus 指标、traceId、MDC 日志追踪