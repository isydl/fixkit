# 介绍

> - 基于行为的排序；推荐
> - 本文档会详细描述功能实现

> G了，不知道咋做 

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
- [ ] 自定义异常、分层封装、全局处理
- [ ] 自定义注解
- [ ] 负载均衡（Nginx/LVS）、数据库主从分离

## 功能设计

### 数据库主从分离
- 避免频繁访问数据库。
- 描述产生的问题 -> 追加解决方案 -> 描述新产生的问题 -> 追加解决方案 -> ...

