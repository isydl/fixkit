# 介绍

> - 时间线生成 Pull/Push 混合
> - 本文档会详细描述功能实现

- 对普通用户使用 **预计算 Push**（在作者发帖后将 postId 推到粉丝的 Redis timeline），对超大粉丝（大V）使用 **Pull**（不做全量 Push，写 global hot stream + 用户拉时裁剪）
- 让 Push/Pull 切换成为运行时策略（配置化，按 author threshold）——这很关键
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
- [ ] 设计全局热点数据:Redis ZSET 存 top m个
- [ ] 存储策略
  - [ ] Redis cluster 分槽设计，用户 timeline key 按 userId hash 布局，避免单槽热点。
  - [ ] 若多key原子操作需使用 hash tag 或保证在同一槽

## 功能设计

### 全局热点数据


