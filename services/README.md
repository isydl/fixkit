# 介绍

> - 微服务目录
> - 本文档会详细描述功能实现

## 目录结构
```
├── services/               # 微服务目录
│   ├── user-service/
│   ├── post-service/
│   ├── feed-service/
│   ├── interaction-service/
│   ├── recommend-service/
│   ├── notification-service/
│   └── media-service/

```
## Todo
- [ ] Service 层负责事务控制，外层由注解切面保证幂等
- [ ] 缓存策略通过 `CacheTemplate` 封装，读取时优先 Redis，未命中则回源 DB。
- [ ] MQ 事件采用 outbox 模式，确保消息一致性。
- [ ] 异步任务通过 `ThreadPoolExecutor` 执行，结合指标监控线程池饱和度。

## 思路

### 事务控制
- 巴拉巴拉

### 网络 
- 登录/注册接口加速率限制（per IP + per account），网关做粗粒度限流，服务内用 Redis 令牌桶做精细化限流
- 

### 设计要点
- cache hit rate > 80% 
- 对发布接口的输入校验使用注解
- 发布高并发时，入库使用写队列（先写 MySQL，然后 outbox->MQ），UI 不要等待所有 fanout 写完才返回。返回成功给用户后，异步完成 fanout，并在失败时补偿或发 DLQ
- 对编辑/删除采用乐观锁（version）防止并发修改覆盖。删除需要软删除字段 + 异步物理删除，便于回滚与审核。
- 大量 PostCreated 消息使用压缩（producer compression）和分区策略（按 authorId hash）以保持写均衡与消费顺序（如果需要顺序）
- 日志/trace 切面统一注入 traceId。
- 直接把热点列表存在单一 DB 表并频繁 full-scan → 改为 Redis timeline + 分页
- 把重试放在 controller 层直接重试外部调用（会阻塞请求线程）→ 改为异步任务 + quick failure + retry worker。
- 大量同步 fanout 在主请求线程 → 一律异步队列化，主请求返回时只确保写入主 DB/outbox 成功
- 