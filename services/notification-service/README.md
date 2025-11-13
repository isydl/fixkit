# 介绍

> - 通知推送
> - 本文档会详细描述功能实现

## 目录结构
`
src/main/java/com/trick/service/user
├── api/             # 控制器 + DTO
├── service/         # 业务逻辑层（含事务边界）
├── domain/          # 领域模型（实体（Entity）、模型（Model）、值对象（Value Object））
├── repository/      # 持久化层
├── mq/              # 事件生产者/消费者
├── cache/           # 缓存加载器与策略
├── config/          # 本地配置、AOP、TaskExecutor
└── Main.java

`
## Todo
- [ ] 发送邮件/Push 要幂等
  - [ ] 记录 notificationId，并为每次发送记录状态（pending/sent/failed）
  - [ ] 有重试逻辑：指数退避 + 最大重试次数，最终写入 DLQ 并人工/自动处理。对重要通知（支付相关）优先级更高并可启用确认机制

## 功能设计

### 发送邮件/Push
- 

