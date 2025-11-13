# 介绍

> - 点赞/评论
> - 本文档会详细描述功能实现

## 目录结构
```
src/main/java/com/trick/service/user
├── api/             # 控制器 + DTO
├── service/         # 业务逻辑层（含事务边界）
├── domain/          # 领域模型（实体（Entity）、模型（Model）、值对象（Value Object））
├── repository/      # 持久化层
├── mq/              # 事件生产者/消费者
├── cache/           # 缓存加载器与策略
├── config/          # 本地配置、AOP、TaskExecutor
└── Main.java

```
## Todo
- [ ] 点赞/评论这种短平快接口可使用 `@Validated` 注解做参数检查
- [ ] 点赞/转发计数在 Redis 做原子 INCR/DECR（或 ZINCRBY），并异步更新 MySQL。
- [ ] 评论列表：Redis 缓存最近 N 条（分页），历史评论从 DB 查询。评论写入时同时更新评论 count 缓存。
- [ ] 大量互动并发：把互动事件（like/comment）先入 mq，异步处理计数合并与推荐权重更新（降低 DB 写压力）
  -[ ] 对 UI 体验，点赞可以先在 Redis 做即时反应，后端最终一致落库
- [ ]点赞限流，防止刷量:Redis sliding window 或令牌桶。

## 功能设计

### 点赞
- 

