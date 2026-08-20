# 假期作业集合 (mjl's Homework)

> ✨ *「才、才不是假期作业呢……这是**学习与创作的足迹**啦……」* ✨

![License](https://img.shields.io/badge/license-MIT-blueviolet)
![Days](https://img.shields.io/badge/作业天-8-blue)
![Status](https://img.shields.io/badge/状态-Day08完成-ff69b4)
![Made With](https://img.shields.io/badge/✿-爱与代码-ff6fa1)
![GitHub](https://img.shields.io/badge/github-Lerrenp-181717?logo=github)

```
        ✿(ᐢ..ᐢ)✿  ← 看板鸟 · 假期监督员 · 已连续打卡 8 天

```
---

##  这是啥？(´･ω･`)

这是 **mjl** 在 2026 年假期里完成的一系列小作业集合。
每个 `dayXX/` 目录都是独立的小主题项目，从静态 HTML、Git 和 Vue，逐步推进到「此刻」图文社区的原型、数据库与接口联调。

> *「一天一个小作业，一天一点点成长……大概就是这种感觉？」*

---

##  目录速览 ✧(ˊωˋ*)

| 目录 | 主题 | 技术栈 | 状态 |
| --- | --- | --- | --- |
| 📅 **day01** | DeepSeek 生成的 HTML 页面 | HTML | ✅ 完成 |
| 📅 **day02** | 命令行基础与 Git 学习笔记 | Markdown | ✅ 完成 |
| 📅 **day03** | mjl · 物联网作品集（原生 HTML/CSS/JS）| HTML / CSS / JS / Canvas | ✅ 完成 |
| 📅 **day04** | Vue 3 迁移版作品集 + PRD | Vue 3 / Vite / PRD | ✅ 完成 |
| 📅 **day05** | 「此刻」图文社区双端产品原型 | UI / UX / 响应式设计 | ✅ 完成 |
| 📅 **day06** | 「此刻」数据库设计与建表 | MySQL / MariaDB / SQL | ✅ 完成 |
| 📅 **day07** | 测试数据与数据库验证 | SQL / BCrypt / 关系数据 | ✅ 完成 |
| 📅 **day08** | 用户模块接口与线上联调 | Spring Boot / Redis / Vue 3 | ✅ 完成 |

---

## ✨ 各目录说明

### 📅 day01 · DeepSeek HTML 实验
- 第一次尝试用 LLM 协助生成 HTML 页面
- 内容相对简单，但开了个好头

### 📅 day02 · 命令行与 Git 笔记
- 重新梳理命令行基础操作
- 整理常用 Git 工作流（init / add / commit / push / submodule …）
- 适合作为新手的速查手册

### 📅 day03 · 物联网作品集（原生版）
> *「这是灵感炸裂的一天，做了一个让自己都惊艳的小作品！」*

- Material You 配色 + 玻璃拟态
- 三态主题切换（浅色 / 深色 / 跟随系统）
- Canvas 鸟群动画（Boids 算法 + 鼠标交互）
- 从 GitHub API 动态拉取作品
- **独立仓库** 👉 https://github.com/Lerrenp/portfolio

### 📅 day04 · Vue 3 迁移 + PRD
> *「人家也是写过 PRD 的产品经理呢……」*

- 把 day03 用 Vue 3 + Vite 重新组织
- 拆分为 4 个组件 + 2 个 composable
- 配套 474 行产品需求文档（`day04/PRD.md`）
- **独立仓库** 👉 https://github.com/Lerrenp/portfolio

### 📅 day05 · 「此刻」双端产品原型
- 完成首页、发布、详情、个人中心和登录注册 5 个核心页面
- 每个页面均包含移动端和电脑端原型，共 10 张交付图

### 📅 day06 · 数据库设计与建表
- 将产品模型拆分为用户、笔记、图片、话题、评论、点赞、收藏和草稿
- 提供可重复执行的 `init.sql`，创建数据库及 9 张业务表

### 📅 day07 · 测试数据与验证
- 提供覆盖核心业务关系的 `seed.sql`
- 包含用户、笔记、话题、评论、点赞和收藏数据及查询验证记录

### 📅 day08 · 用户模块接口与线上联调
- 完成短信验证码、注册登录、会话恢复与用户资料接口
- 完成 Spring Boot、MariaDB、Redis、nginx 和 Vue 3 的线上全链路联调
- **项目仓库** 👉 https://github.com/Lerrenp/cike
- **线上地址** 👉 https://majiawebtest.dpdns.org/

---

## 🚀 如何使用本仓库 (◕‿◕✿)

```bash
# 克隆整份作业合集
git clone https://github.com/Lerrenp/homework.git

# 进入感兴趣的目录
cd homework/day03        # 原生版作品集
cd homework/day08        # 用户模块接口与联调文档
```

> 💡 各子目录可能引用了独立的 GitHub 仓库（如 [portfolio](https://github.com/Lerrenp/portfolio)），如果想跑代码请到对应仓库去 clone。

---

## 🌙 主题切换（属于 day03/day04 的彩蛋）(¬‿¬)

```
浅色 ──→ 深色 ──→ 跟随系统 ──→ 浅色 ──→ ...
                ↑
        （选择会记住，下次打开还是上次的风格）
```

---

## 📜 License

本仓库采用 **MIT License** 开源 —— 详情见 [LICENSE](LICENSE) 文件。

简而言之：

> 你可以随便用、随便改、随便拿去商用，只要在副本里保留版权声明就行。

但是——

> *「虽然 MIT 是这样写的……但人家还是希望你能注明出处哦……♡」*

---

## ✿ 致谢

- 🎨 Google **Material Design 3 (Material You)**
- 🐦 Craig Reynolds 的 **Boids 算法**（1986 年）
- 📚 无数个改到凌晨三点的夜晚
- 🐦 还有那只永远在屏幕上飞的小鸟群

---

## 🌷 联系方式

| 渠道 | 内容 |
| --- | --- |
| ✉️ Email | 243383@qq.com |
| 🐙 GitHub | [@Lerrenp](https://github.com/Lerrenp) |

---

<div align="center">

```
✿╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯✿
  谢谢你读到这里！
  (ฅ́˘ฅ̀)♡
✿╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯✿
```

**假期愉快 · 学习进步** 🌸

</div>
