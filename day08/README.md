# Day 08 - 用户模块接口与前后端联调

## 作业目标

基于 Spring Boot、MariaDB、Redis 和 Vue 3 完成用户认证及用户模块接口，并执行线上联调。

## 核心交付

- `用户模块接口文档.md`：认证与用户模块的请求、响应和鉴权约定。
- 后端实现：Spring Boot、MyBatis-Plus、JWT、Redis、BCrypt。
- 前端实现：Vue 3、Pinia、Vue Router、Axios、Vuetify 3。

## 已完成能力

- 短信验证码写入 Redis，注册验证码有效期 120 秒。
- 手机号注册、密码登录、退出和会话恢复。
- Bearer Token 与安全 HttpOnly Cookie 两种认证来源。
- 用户列表、详情、资料修改、作品、点赞和收藏列表。
- 注册后发布图文笔记并在首页展示。

## 联调结果

- Maven 后端打包通过。
- Vite 前端生产构建通过。
- 线上 Spring Boot、MariaDB、Redis、nginx 均正常运行。
- 短信弹窗显示验证码和 120 秒倒计时。
- 注册、会话恢复、个人页和发布流程通过浏览器端到端验证。
- 桌面首页笔记图片能够正确解码和显示。
- HTTP 自动重定向 HTTPS。

实现仓库：[Lerrenp/cike](https://github.com/Lerrenp/cike)

线上地址：[https://majiawebtest.dpdns.org/](https://majiawebtest.dpdns.org/)
