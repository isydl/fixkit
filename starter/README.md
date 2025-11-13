# 介绍

> - 自动装配层（Spring Boot Starter，用于复用）
> - 本文档会详细描述功能实现

## 目录结构
```
├── starter/                # 自动装配层（Spring Boot Starter，用于复用）
│   ├── cache-spring-boot-starter/
│   ├── mq-spring-boot-starter/
│   └── pom.xml

```
## Todo
- [ ] `@EnableCacheSupport`
- [ ] `@EnableMqSupport`
- [ ] `@EnableLockSupport`
- [ ] `@EnableObservability`

## 思路

### 每个 Starter 模块都提供
- `AutoConfiguration` 自动装配
- 配置属性类（`CacheProperties`, `MqProperties`）等
- 在新项目中，只要引入依赖 + 注解启用，无需重复配置，即可拥有统一能力。

### 校验
- @Valid

### 