
<p align="center">
  <span>中文 | <a href="./README.en.md">English</a></span>
</p>

---

- 本项目是为了梳理自身技能所创建，不定期更改。
- 本文档是计划练习实现的模块功能，并不代表会作为待办模块功能。
- 本项目由[isdl](https://github.com/isydl)和[da1kim](https://github.com/da1kim)共同维护

---

为了更好的串联各个模块功能，特此设计了一个Feed流图文项目作为载体。

## 项目结构目录
```
fixkit/
├── README.md
├── pom.xml
│
├── common/                 # 公共基础层（utils + 通用组件）
├── infra/                  # 基础设施层（中间件封装）
├── starter/                # 自动装配层（Spring Boot Starter，用于复用）
│   ├── cache-spring-boot-starter/
│   ├── mq-spring-boot-starter/
│   └── pom.xml
├── services/               # 微服务目录
│   ├── user-service/
│   ├── post-service/
│   ├── feed-service/
│   ├── interaction-service/
│   ├── recommend-service/
│   ├── notification-service/
│   └── media-service/
├── gateway/                # API Gateway（Spring Cloud Gateway or Nginx）
├── scripts/                # 部署脚本、DB迁移（Flyway/liquibase）、Dockerfile
└── docs/                   # 设计文档（架构、ER图、Playbook、API规范）
```

## Feed流图文项目整体梳理

- **API 网关（Nginx）**：对外统一鉴权、限流、TLS。
- **监控**：
- **部署**：Docker 镜像

| 模块      |                      | 主要功能                             | 核心说明                |
| ------- | -------------------- | -------------------------------- | ------------------- |
| 用户模块    | user-service         | 登录、关注关系、黑名单                      | 提供用户画像数据给推荐与Feed生成  |
| 内容模块    | post-service         | 图文发布、编辑、删除                       | 管理主内容数据与媒体上传        |
| Feed模块  | feed-service         | 生成用户时间线、推荐流                      | 负责时间线拼接、去重、聚合       |
| 互动模块    | interaction-service  | 点赞、评论、转发                         | 写入交互事件并异步影响推荐分数     |
| 推荐模块    | recommend-service    | 基于兴趣或热度排序                        | 可以使用简单的打分模型（可独立微服务） |
| 通知模块    | notification-service | 新评论、新点赞、新关注推送                    | 由消息队列触发             |
| 存储与缓存模块 | media-service        | Redis + MySQL + MQ + 对象存储(配合cdn) | 支撑高QPS与冷热分层         |

- **todo list**
- [ ] 用户注册/登录（JWT 或 OAuth2）
- [ ] 发布图文（文本 + 多张图片；媒体上传到 OSS）
- [ ] 关注/取关（关注流基本数据）
- [ ] 拉取“关注时间线”（分页）与“推荐流（简单热度）”
- [ ] 点赞、评论、转发（写库并异步通知）
- [ ] 热度推荐 + 基础算法
- [ ] 基本监控（请求指标、服务健康、队列积压）

> 非业务型需求功能，请参考各个项目内的文档。[common](common/README.md)、[gateway](gateway/README.md)、[infra](infra/README.md)、[starter](starter/README.md)、[services](services/README.md)

> 通用模块功能设计请参考[Todo](TODO.md)
