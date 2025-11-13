# 介绍

> - API Gateway（Spring Cloud Gateway or Nginx）
> - 本文档会详细描述功能实现

## Todo
- [ ] 鉴权
- [ ] 限流
- [ ] 灰度
- [ ] CORS
- [ ] 路径转发

## 功能设计思路

### 限流
- 集成 Redis-based 限流器（Lua 计数 + key 粒度 = userId + API path）

### 鉴权
- Spring Security 注解


