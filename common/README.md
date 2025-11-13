# 介绍

> - 公共基础层（utils + 通用组件）
> - 本文档会详细描述功能实现

## 目录结构
```
├── common/                 # 公共基础层（utils + 通用组件）
│   ├── src/main/java/com/trick/common/
│   │   ├── annotations/    # 通用注解（@Idempotent、@AuditLog、@RateLimit 等）
│   │   ├── aspect/         # AOP切面实现
│   │   ├── constants/      # 常量定义
│   │   ├── enums/
│   │   ├── exceptions/
│   │   ├── utils/          # 工具类（BeanCopy、Json、ThreadPool、DateUtil 等）
│   │   └── model/          # 通用响应对象 / 分页对象 / trace模型
│   └── pom.xml

```
## Todo
- [ ] 自定义注解 `@Idempotent`, `@RateLimit`, `@AuditLog`, `@Retryable`, `@SafeInvoke`
- [ ] AOP切面
- [ ] 全局异常基类，结合全局异常处理器 `@ControllerAdvice`、统一返回结构
- [ ] 通用工具类:封装 JSON、线程池、时间、加密、分页、反射、Bean 拷贝
- [ ] 通用响应模型 `Response<T>`、`PageResult<T>`、`ErrorCode` 枚举
- [ ] 所有服务应有 /health、/metrics、traceId 注入
- [ ] 关键业务操作的 Prometheus 指标（成功/失败/latency P95/P99）
- [ ] log 格式规范

## 思路

### 自定义注解
- 巴拉巴拉

### AOP切面
- 通过 `ThreadLocal<TraceContext>` 传递 traceId ？


