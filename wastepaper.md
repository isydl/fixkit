> 该文档内容均已不再使用，仅做归档处理

---


## 记忆型，随处可用的知识

* **看懂GC 日志、参数调优、内存分配日志：**
    * 使用工具看懂、能分析线上环境出现的CPU 100%、内存泄漏、线程死锁等问题的触发点。

## **功能模块梳理，从通用到具体**

**核心思路：** 功能逐级提升，并解决之前模块所代码的问题

### **单体服务通用设计**
*   自定义异常、分层封装、全局处理
*   自定义注解。
*   负载均衡（Nginx/LVS）、数据库主从分离

### **安全与数据库优化 (Security & DB Pool)**
*   通过`EXPLAIN`快速定位慢SQL瓶颈，并提出有效的优化方案。
*   MyBatis 动态SQL、ResultMap、插件机制
*   复杂业务逻辑，需保证事务一致性
    *   分布式事务（Seata、TCC、Saga）
    *   消息队列最终一致性（如 RocketMQ 事务消息）
    *   分库分表避免单点瓶颈

### **缓存与状态管理 (Caching & State)**
-   Redis 连接池、序列化、预热、过期策略
*   缓存穿透、击穿、雪崩防护。
*   数据库与缓存双写一致性，能设计补偿机制
*   高频写操作
    *   Redis 原子操作（`INCR/DECR`）
    *   分布式锁（Redlock、ZooKeeper）
    *   异步队列削峰（如 Kafka/RabbitMQ）
*   短时流量高峰导致的瞬时高并发
    * 限流（令牌桶、漏桶算法，如 Guava RateLimiter）
    * 服务降级（非核心功能临时关闭）

### 网络、IO和通讯
- 说出一个RPC请求从客户端发出到服务端处理并返回的完整数据流
- 大量用户保持长连接
    - WebSocket 替代 HTTP 短连接
    - Netty
    - 连接分片（按用户ID哈希到不同服务器）

### **内存与并发（Memory & Concurrency）**
*   Semaphore, CyclicBarrier, BlockingQueue
*   线程池拒绝策略、线程命名、监控
*   CompletableFuture链式异步调用、异常处理、组合
*   synchronized vs Lock vs StampedLock
*   高频率写入大量数据（如日志、IoT设备数据）
    * 消息队列异步处理（Kafka）
    * 批量写入 + 压缩（如 Elasticsearch Bulk API）
    * 时序数据库（InfluxDB、TDengine）
* 高并发复杂查询（如报表分析、用户行为统计）。
    * 读写分离
    * 缓存中间结果（Redis/MongoDB）

### **压力测试与瓶颈分析 (Stress Testing & Profiling)**
*   压力测试（JMeter）、应用监控（Arthas/JVisualVM）。
*   异步日志、分级输出，能做日志追踪

### **分布式架构初探 (Distributed Architecture)**
*   设计出合理的微服务拆分方案和技术选型。
*   自定义Starter
*   MQ:ACK机制、重试、死信队列。
*   RESTful规范、分页、错误码
*   搭建企业级项目结构
*   跨服务协调（如生成唯一订单号、防止重复支付）
    * 雪花算法（Snowflake）生成分布式ID。
    * Redis 集群模式（Redisson）。

### **微服务拆分 (Microservices Split)**
*   Spring Boot 生命周期
*   将一个单体应用进行容器化改造，并部署到K8s集群中。

### **分布式治理与韧性 (Resilience & Governance)**

*  当线上系统出现性能抖动时，从应用日志、JVM监控、系统指标和链路追踪中找到问题根因。

---
