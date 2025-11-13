# 介绍

> - 发布/编辑/删除 Post
> - 本文档会详细描述功能实现

## 目录结构
```
src/main/java/com/trick/service/post
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
- [ ] 对发布接口的输入校验使用注解（长度、敏感词检测标记可用自定义`@SensitiveCheck`在切面中实现）
- [ ] 用 `@Transactional` 保证写入 post + outbox 的原子性
- [ ] 点赞、评论数量使用**Redis 原子计数**（INCR/DECR），并在 off-peak 时批量入库
- [ ] 发布高并发时，入库使用写队列（先写 MySQL，然后 outbox->MQ），UI 不要等待所有 fanout 写完才返回。返回成功给用户后，异步完成 fanout，并在失败时补偿或发 DLQ。
- [ ] 对编辑/删除采用乐观锁（version）防止并发修改覆盖
## 功能设计

### 数据库主从分离
- 避免频繁访问数据库。
- 描述产生的问题 -> 追加解决方案 -> 描述新产生的问题 -> 追加解决方案 -> ...

