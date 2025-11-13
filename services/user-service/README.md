# 介绍

> - 用户注册/登录/关注
> - 本文档会详细描述功能实现

## 目录结构
```
src/main/java/com/trick/service/user
├── api/             # 控制器 + DTO
├── service/         # 业务逻辑层（含事务边界）
├── domain/          # 领域模型（实体（Entity）、模型（Model）、值对象（Value Object））
├── repository/      # 持久化层
├── mq/         
# 事件生产者/消费者
├── cache/           # 缓存加载器与策略
├── config/          # 本地配置、AOP、TaskExecutor
└── UserServiceApplication.java

```
## Todo
- [ ] 个人信息
  - [ ] 读优先缓存;
- [ ] 关注
  - [ ] 列表:Redis 列表/SortedSet（按关注时间为score）缓存
  - [ ] 关注、取关:幂等，构造 followerId+followeeId 作为唯一 key，应用层捕获唯一违反异常并转换为幂等成功
  - [ ] 并发关注：对关注写入用异步 outbox：写 DB + outbox 在同一事务，再由 worker 推 MQ 更新 Redis follower list（减小主路径延迟）

## 功能设计

### 数据库主从分离
- 避免频繁访问数据库。
- 描述产生的问题 -> 追加解决方案 -> 描述新产生的问题 -> 追加解决方案 -> ...

