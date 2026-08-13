# mjl · 物联网作品集 —— 产品需求文档（PRD）

> **文档版本**：v1.0  
> **编写日期**：2026-08-13  
> **文档作者**：mjl  
> **关联代码**：`homework/day03/`（HTML / CSS / JS 单页实现）  
> **目标读者**：招聘方（HR / 技术面试官 / 团队负责人）

---

## 0. 文档说明

本 PRD 是对 `day03/` 目录下 **「mjl · 物联网作品集」** 单页站点（Portfolio）的产品级描述文档。
代码实现已经在 day03 完成，本文用于：

1. 在求职场景下，向招聘方讲清楚「这个站点是什么、为什么做、做到什么程度、怎么衡量」。
2. 沉淀本人对产品的拆解能力——把一个**视觉/交互密集型**的个人项目，按正式产品流程描述清楚。
3. 作为后续 v2 迭代（博客/作品详情页/多语言）的需求基线。

文档语言为中文，详略程度按求职阅读场景优化：突出**定位、用户、功能边界、设计语言、验收标准与求职话术**。

---

## 1. 产品概述

### 1.1 一句话定位

一个面向**物联网/嵌入式工程师求职**的个人作品集单页站点：把「**技能 / 作品 / 联系方式**」用 Material You 设计语言 + 实时 Canvas 鸟群动画整合在一屏内，让面试官在 30 秒内形成「有审美、有工程能力、对 IoT 有热情」的印象。

### 1.2 产品名称

- 中文名：**mjl · 物联网作品集**
- 英文名：**mjl · IoT Portfolio**
- Slogan：**感知 · 连接 · 智能**（Perceive · Connect · Make Intelligent）

### 1.3 价值主张（Value Proposition）

| 维度 | 给招聘方的价值 |
| --- | --- |
| 信息密度 | 单页内呈现技能、作品、联系方式，零点击成本 |
| 视觉记忆 | 鸟群动画 + Material You 配色，建立差异化记忆点 |
| 技术验证 | Canvas / Boids 算法 / GitHub API / 主题系统 = 一次端到端前端能力展示 |
| 时效性 | 作品直接读自 GitHub 仓库，**无需手动维护**作品列表 |

### 1.4 目标用户与场景

| 角色 | 使用场景 | 核心诉求 |
| --- | --- | --- |
| **HR / 简历初筛** | 收到简历后访问 GitHub Pages 链接 | 30 秒内看清「这人做什么方向、有什么作品」 |
| **技术面试官** | 面试前快速 review 候选人 | 看代码组织、设计品味、对工程细节的把控 |
| **猎头** | 在候选人池中横向对比 | 差异化亮点、联系方式是否醒目 |
| **同行业工程师** | 业内交流、互相认识 | 作品技术栈是否对路、是否值得 follow |

> **非目标用户**：客户端业务用户、C 端消费者——本站是**作品集**而非**业务产品**。

---

## 2. 范围与边界

### 2.1 In Scope（v1 已实现）

- 单页站点（Single Page），无路由
- 个人信息、技能、GitHub 作品、联系方式展示
- 浅色 / 深色 / 跟随系统 三态主题切换
- Canvas 鸟群动画（鼠标交互 + 主题联动）
- 响应式适配（桌面 / 平板 / 手机）
- GitHub API 动态拉取仓库，零手动维护

### 2.2 Out of Scope（v1 明确不做）

- 后端服务、用户登录、评论
- CMS / 文章发布系统
- 多语言（v1 仅中文）
- 服务端 SEO（依赖 GitHub Pages 静态托管）
- i18n、暗色主题以外的视觉主题

### 2.3 v2 候选（本文档不展开）

- 作品详情页（点卡片进入项目 README 全文渲染）
- 博客模块（记录 IoT 学习笔记）
- 「招聘方留言」联系表单
- 多语言（中 / 英）

---

## 3. 用户故事与验收标准

> 格式：**作为 [角色]，我希望 [动作]，以便 [价值]**。每条配验收要点。

### US-1 浏览技能概览
- **作为** 招聘方，**我希望** 在首屏看到候选人的核心技能方向，**以便** 快速判断技术栈是否匹配岗位。
- **验收**：
  - 技能区使用 4 张卡片：`嵌入式系统 / 无线通信 / 云平台与数据 / 前端与可视化`
  - 每张卡片含图标 + 标题 + 一句话描述
  - 悬停时上抬 + 主色描边

### US-2 浏览 GitHub 作品
- **作为** 招聘方，**我希望** 直接看到候选人在 GitHub 上的真实仓库，**以便** 验证简历中提到的项目是否真实可查。
- **验收**：
  - 自动拉取 `Lerrenp` 用户下、非 fork 的公开仓库，按更新时间倒序
  - 卡片显示：项目名、描述、Tag（启发式分类）、主语言 + 语言色点、Star 数
  - 加载中显示 3 个骨架占位
  - 加载失败显示红色状态条 + 错误信息（不破坏布局）

### US-3 切换主题
- **作为** 任意访问者，**我希望** 切换浅色 / 深色主题，或跟随系统，**以便** 在不同环境下都舒适浏览。
- **验收**：
  - 工具栏提供主题切换按钮（图标：月亮 / 太阳）
  - 点击循环 `light → dark → system → light`
  - 选择持久化到 `localStorage`
  - 选择 `system` 时响应 `prefers-color-scheme` 变化
  - 切换主题时，鸟群动画颜色**实时跟随**

### US-4 与鸟群动画互动
- **作为** 访问者，**我希望** 在背景中看到会跟随鼠标的鸟群，**以便** 感受到站点的「活气」。
- **验收**：
  - Canvas 固定全屏，作为底层背景，不阻挡主体交互
  - 鸟群按 Boids 规则（聚合 / 对齐 / 分离）运动
  - 鼠标移动时，鸟群被吸引；过近时被轻微排斥
  - 顶部右上 HUD 显示当前鸟群数量
  - 鸟群数量随屏幕面积自适应（28 ~ 80 只）

### US-5 找到联系方式
- **作为** 招聘方 / 猎头，**我希望** 一眼看到邮箱、电话与领域标签，**以便** 高效建立联系。
- **验收**：
  - 联系方式区位于页面底部
  - 邮箱点击可唤起邮件客户端（`mailto:`）
  - GitHub 链接在页脚，次级但可发现

### US-6 移动端浏览
- **作为** 移动端访问者，**我希望** 在小屏上也能完整、舒适地浏览，**以便** 通勤场景访问。
- **验收**：
  - `@media (max-width: 600px)` 下卡片网格单列、字号缩小、内边距收窄
  - 工具栏按钮缩小至 40×40
  - 鸟群在低端机仍流畅（DPR 上限为 2）

---

## 4. 信息架构与页面结构

```
┌─────────────────────────────────────────────────────────┐
│ Toolbar (固定右上)：主题切换按钮                          │
├─────────────────────────────────────────────────────────┤
│ Header                                                   │
│   ├─ H1: mjl · 物联网                                     │
│   ├─ Tagline: 感知 · 连接 · 智能（primary-container 胶囊）│
│   └─ Bird HUD: N birds (右上浮动徽章)                     │
├─────────────────────────────────────────────────────────┤
│ Section 1: 技能 (4 张卡片，auto-fit 网格)                  │
├─────────────────────────────────────────────────────────┤
│ Section 2: 作品 (GitHub 动态拉取，auto-fit 网格)           │
│   ├─ Repo Status: 加载状态 / 错误状态                      │
│   └─ Project Grid: 仓库卡片                              │
├─────────────────────────────────────────────────────────┤
│ Section 3: 联系方式 (邮箱 / 电话 / 领域)                   │
├─────────────────────────────────────────────────────────┤
│ Footer: © year · github.com/Lerrenp                      │
├─────────────────────────────────────────────────────────┤
│ #flock-canvas (fixed 全屏底层)                           │
└─────────────────────────────────────────────────────────┘
```

### 4.1 视觉层级

| 层级 | 元素 | 视觉处理 |
| --- | --- | --- |
| L0 背景 | Canvas 鸟群 | fixed 全屏、`z-index: 0`、`pointer-events: none`、`opacity: 0.95` |
| L1 容器 | `.container` | 玻璃拟态：`backdrop-filter: blur(12px) saturate(1.2)` + 半透明白底 + 大圆角 + Elevation-3 阴影 |
| L2 内容 | 各 Section | 普通块级，章节标题左侧 6×28 主色色条 + 右侧渐变分隔线 |

---

## 5. 设计语言（Design Language）

> 本节描述的是 day03 已经实现、并贯穿全站的「设计哲学」。所有改动都必须符合这套语言。

### 5.1 设计参考

- **基线**：Google **Material Design 3 (Material You)** —— 强调大圆角、动态配色、Elevation、State Layers。
- **氛围叠加**：
  - **Glassmorphism（玻璃拟态）**：主容器使用 `backdrop-filter: blur + saturate`，呈现「悬浮于鸟群之上」的层次感。
  - **Generative Background（生成式背景）**：Canvas 鸟群作为会呼吸的背景，让站点区别于普通简历模板。

### 5.2 设计令牌（Design Tokens）

通过 CSS 变量集中管理，所有视觉规格仅在 `:root` 改一处：

| 类别 | 变量 | 示例值 |
| --- | --- | --- |
| 主色 | `--md-sys-color-primary` | 浅色 `#00658f`，深色 `#8ecff6` |
| 表面 | `--md-sys-color-surface` | 浅色 `#f7f9fc`，深色 `#0f1417` |
| 形状 | `--md-sys-shape-corner-{large,medium,small}` | 28 / 16 / 8 px |
| 字号 | `--md-sys-typescale-{display,headline,title,body,label}` | 3.5 / 1.75 / 1.25 / 1 / 0.875 rem |
| 动效曲线 | `--md-sys-motion-easing-{standard,emphasized}` | `(0.2,0,0,1)` / `(0.3,0,0,1)` |
| 阴影 | `--md-sys-elevation-{1,2,3}` | 1/2/3 级预设阴影 |
| 鸟群 | `--bird-color` / `--bird-wing` | 与主色联动 |
| 背景 | `--bg-gradient` | 浅色 / 深色径向渐变 |

### 5.3 主题系统

**三态主题**：`light / dark / system`

- `data-theme="light|dark"` 显式覆盖；不设置则走 `prefers-color-scheme`。
- 自动跟随：CSS 中通过 `@media (prefers-color-scheme: dark)` 兜底覆盖 `:root:not([data-theme="light"])`。
- 持久化：localStorage key = `mjl-portfolio-theme`，值为 `light | dark | system`。
- 切换按钮：循环 `light → dark → system → light`，图标随当前生效主题切换（月亮 = 当前浅色；太阳 = 当前深色）。

### 5.4 动效原则

| 场景 | 动效 | 时长 / 曲线 |
| --- | --- | --- |
| 主题切换 | 背景 / 文字颜色 `transition` | 0.6s / 0.4s · standard |
| 卡片悬停 | `translateY(-4px)` + Elevation 提升 | 0.25s · emphasized |
| 鸟群拍翅 | `flapPhase` 周期性摆动 | 每帧增量 `0.18~0.28` |
| HUD 点 | 呼吸光晕 | `pulse 2s ease-in-out infinite` |
| 骨架占位 | shimmer 横扫 | 1.5s linear infinite |
| **减弱动画** | `@media (prefers-reduced-motion: reduce)` 下全部降至 `0.01ms` | — |

### 5.5 排版与可访问性

- 字体栈：`"Google Sans", "Noto Sans SC", system-ui, ...`（中文走 Noto Sans SC，英文走 Google Sans）
- 行高 1.6；主标题 `letter-spacing: -0.02em`
- 所有交互元素具备 `aria-label`，按钮图标 `aria-hidden`
- 链接 `target="_blank" rel="noopener noreferrer"`
- 颜色对比度遵循 WCAG AA（主文本对比 ≥ 4.5:1）

---

## 6. 功能模块详述

### 6.1 模块 A：个人信息与技能

**目标**：30 秒内让招聘方看清「这个人做 IoT、做嵌入式、做无线通信、做云」。

**实现要点**：
- 顶部 `h1`：`mjl · 物联网`，`.accent` 类将 `·` 着色为 primary。
- Tagline 使用 primary-container 胶囊样式（圆角 999px）。
- 4 张技能卡片，每张含 24×24 SVG 图标 + 标题 + 描述。
- 网格采用 `grid-template-columns: repeat(auto-fit, minmax(220px, 1fr))`，自适应列数。
- 卡片悬停：`translateY(-2px)` + Elevation-2 + 描边变 primary。

### 6.2 模块 B：GitHub 作品展示

**目标**：展示真实作品，**零维护成本**。

**接口**：
- `GET https://api.github.com/users/{GH_USER}/repos?per_page=100&sort=updated`
- `GH_USER = 'Lerrenp'`（day03 已硬编码，可改为构建时常量）

**处理流程**：

```
fetch repos
   │
   ▼
过滤 fork
   │
   ▼
按 updated_at 倒序
   │
   ▼
渲染卡片
   │
   ├─ 成功：状态条显示「来自 GitHub @Lerrenp · 共 N 个项目」
   └─ 失败：状态条红色 + 错误信息（HTTP 状态码），卡片区留空
```

**卡片字段**：

| 字段 | 来源 | 渲染 |
| --- | --- | --- |
| Tag | `deriveTag()` 启发式分类 | 见下文分类映射 |
| 名称 | `repo.name` | 转义后渲染，外链图标悬停显现 |
| 描述 | `repo.description` | 无则显示「暂无描述」 |
| 语言 | `repo.language` | 圆点 + GitHub 配色（`LANG_COLORS`） |
| Star | `repo.stargazers_count` | 右上角，star 图标 + 数字 |

**Tag 启发式分类**（来源：`js/main.js` 中 `deriveTag`）：

| 关键词命中 | Tag |
| --- | --- |
| iot / 物联网 / sensor / esp / stm / zigbee / lora / ble / embedded | 物联网 |
| bilibili / bili / video / player | 视频播放 |
| kernel / android / root / suki | 内核编译 |
| openai / gemini / api / llm | AI / API |
| defocus / eye / 护眼 | 健康工具 |
| homework / note / learn / 学习 / 笔记 | 学习笔记 |
| 兜底：`repo.language` → `Project` | — |

> **求职话术**：可在面试中解释「为了让作品自动分类，我用关键词正则做了一层语义 Tag，避免手动打标签。」

**安全**：所有用户输入（仓库名、描述）通过 `escapeHtml()` 防御 XSS。

### 6.3 模块 C：主题切换

**状态机**：

```
       ┌──────────┐  点击   ┌──────┐  点击   ┌──────────┐
       │  system  │ ──────▶ │ dark │ ──────▶ │  light   │
       └──────────┘         └──────┘         └──────────┘
            ▲                                          │
            └──────────────────────────────────────────┘
                            点击
```

**实现要点**：
- `applyTheme(theme)`：写 `data-theme` 属性，触发 `themechange` 自定义事件。
- 鸟群监听 `themechange`，调用 `updateColors()` 从 `getComputedStyle` 取最新 `--bird-color` / `--bird-wing`。
- 系统主题变化：监听 `matchMedia('(prefers-color-scheme: dark)').change`，仅当用户选择 `system` 时响应。
- `try/catch` 包裹 `localStorage`，兼容隐私模式 / 禁用存储的环境。

### 6.4 模块 D：Canvas 鸟群动画

**目标**：做一个**视觉记忆点**，并展示 Canvas + 算法能力。

**渲染架构**：

```
window.requestAnimationFrame
   │
   ▼
for each bird: update()  ← Boids + 鼠标 + 边界
   │
   ▼
for each bird: drawAll()  ← 身体 + 双翼（拍翅幅度）
```

**Boids 三规则**（感知半径 `perception = 80`）：

| 规则 | 作用 | 公式 |
| --- | --- | --- |
| 对齐 (Alignment) | 与邻居同向 | `vx += avg(vx) * 0.02` |
| 聚合 (Cohesion) | 靠近邻居中心 | `vx += (avg(x) - x) * 0.005` |
| 分离 (Separation) | 避免重叠（<22px 强排） | `sep = (22 - dist)/22 * 1.4` |

**鼠标交互**：

| 距离 | 行为 |
| --- | --- |
| `> 220` | 无影响 |
| `70 ~ 220` | 吸引（`attract = 0.08`） |
| `< 70` | 排斥（避免贴脸） |

**边界处理**：进入 60px 边界区域则施加与边界法线方向相反的加速度；并对极端越界做「瞬移兜底」。

**数量自适应**：

```js
const target = Math.max(28, Math.min(80, Math.round((w * h) / 22000)));
```

**性能**：
- DPR 上限为 2，避免 4K 屏过度采样。
- 骨架占位 / 错误状态独立于 Canvas。
- 鸟群动画初始化失败 `console.warn` 后优雅降级，不影响主功能。

**HUD**：右上角胶囊，显示当前鸟群数量；前缀 8px 主色圆点 + `pulse` 动画。

### 6.5 模块 E：联系方式

| 项 | 内容 | 交互 |
| --- | --- | --- |
| 邮箱 | `2433832@qq.com` | `mailto:` 唤起邮件客户端 |
| 电话 | `+86 243383` | 纯展示（不唤起拨号，避免移动端误触） |
| 领域 | `物联网 · 嵌入式` | 纯展示 |

页脚补充 GitHub 链接 `github.com/Lerrenp`，作为次级入口。

---

## 7. 非功能性需求

| 类别 | 指标 | 当前实现 |
| --- | --- | --- |
| 性能 | 首屏 LCP < 2.5s（4G） | 单 HTML + 单 CSS + 单 JS，无第三方 CDN |
| 性能 | 鸟群动画稳定 ≥ 55fps（中端机） | DPR ≤ 2 + 28~80 只 + 单 Canvas |
| 兼容性 | Chrome / Edge / Safari / Firefox 最近 2 个大版本 | 仅使用标准 Canvas API、`color-mix`、`backdrop-filter` |
| 可访问性 | WCAG AA 对比度 + 键盘可达 + 减弱动画 | `aria-label`、`prefers-reduced-motion` |
| SEO | 静态 meta + 中文 description + 语义化标签 | `<meta name="description">`、`<section aria-labelledby>` |
| 隐私 | 不收集任何用户数据 | 仅缓存用户主题选择到 localStorage |
| 安全 | 防御 XSS / 第三方 API 注入 | `escapeHtml()` + 仅 GET 公开 API |
| 可维护性 | 设计令牌集中 | 全部走 CSS 变量 |
| 可扩展性 | 模块化 JS（IIFE 内分块） | 主题 / 作品 / 鸟群三个独立模块 |

---

## 8. 风险与权衡

| 决策 | 权衡 | 当前选择 |
| --- | --- | --- |
| GitHub API 速率限制（未认证 60 req/h） | 缓存 vs 实时 | **实时**——单页访问量极低，速率不是瓶颈；展示「数据是活的」更有说服力 |
| 鸟群动画耗电 | 视觉冲击 vs 电量 | 提供 `prefers-reduced-motion` 自动降级；不在手机上做更复杂效果 |
| Canvas DPR 上限为 2 | 清晰度 vs 性能 | 选择性能，4K 屏下鸟群略糊但不影响主信息阅读 |
| Tag 启发式分类 | 准确率 vs 实现成本 | 选择低成本正则；面试时可承认「会错分类，需要时升级到 LLM 二次分类」 |
| 单页 vs 多页 | 加载 vs 内容深度 | 选择单页——首屏信息密度优先；v2 再做详情页 |

---

## 9. 指标与成功标准（求职场景）

由于本站不是商业产品，不设 DAU / 转化率等业务指标，而用「**招聘场景 KPI**」衡量：

| 指标 | 目标 | 衡量方式 |
| --- | --- | --- |
| 首屏信息到达时间 | ≤ 5 秒 | 招聘方一眼看清「技能 + 作品 + 联系方式」 |
| 视觉记忆点 | ≥ 1 个 | 鸟群动画 + Material You 配色 |
| 作品可信度 | 100% | 全部直链 GitHub 真实仓库，无虚构 |
| 简历 → 面试 转化 | 定性 | 招聘方主动询问技术细节 |
| 代码可读性 | 通过 code review | day03 代码已模块化、命名清晰 |

---

## 10. 后续路线图（Roadmap）

| 版本 | 时间 | 关键特性 |
| --- | --- | --- |
| v1.0（当前） | day03 已交付 | 单页、主题、鸟群、GitHub 拉取 |
| v1.1 | day05+ | 作品详情页（点卡片读 README）、键盘快捷键（`t` 切主题） |
| v2.0 | 招聘季前 | 博客模块（IoT 学习笔记）、多语言（中/英）、RSS |
| v2.1 | 长期 | 「招聘方留言」联系表单（静态 form + 第三方服务） |

---

## 11. 求职话术锦囊（给面试官讲这个项目时用）

> 这部分不是产品功能，而是把 day03 的实现**翻译成面试语言**，方便本人复盘。

1. **「为什么不用 React/Vue？」** ——「这是单页、零路由、零状态管理的纯展示型页面。引入框架反而增加包体积和心智负担。原生 + 模块化 IIFE 即可。」
2. **「Boids 算法你是怎么权衡的？」** ——「我对三规则做了系数调优：分离用 `1/距离` 衰减、聚合用 `0.005` 低权重避免群体僵硬、对齐用 `0.02` 保证转向柔和。」
3. **「主题切换怎么避免闪烁？」** ——「CSS 变量集中在 `:root` 切换，所有引用色同步重排；鸟群通过 `themechange` 事件 + `getComputedStyle` 重取色，不读缓存。」
4. **「GitHub API 限流怎么办？」** ——「未认证 60 req/h 对个人作品集足够；如果未来加博客或访问量上来，会在服务端做 Redis 缓存代理。」
5. **「为什么用玻璃拟态？」** ——「Material You 主推『大圆角 + 透明分层 + 动态取色』。玻璃拟态刚好与之契合，且能让鸟群作为底层透出来，形成层次感。」
6. **「你怎么验证可访问性？」** ——「颜色对比走 WCAG AA；动效在 `prefers-reduced-motion: reduce` 下全部降到 0.01ms；交互元素都有 `aria-label`。」

---

## 12. 附录

### 12.1 文件清单（day03）

```
homework/day03/
├── index.html        # 单页结构
├── css/style.css     # 设计令牌 + 全部样式（672 行）
└── js/main.js        # 主题 / GitHub / 鸟群三大模块（IIFE，438 行）
```

### 12.2 关键常量

| 常量 | 值 | 位置 |
| --- | --- | --- |
| `GH_USER` | `Lerrenp` | `js/main.js` |
| `GH_API_REPOS` | `https://api.github.com/users/{user}/repos?per_page=100&sort=updated` | `js/main.js` |
| `THEME_KEY` | `mjl-portfolio-theme` | `js/main.js` |
| 鸟群数量公式 | `clamp(round(W*H/22000), 28, 80)` | `js/main.js` |
| 鸟群感知半径 | `80 px` | `js/main.js` |
| 鸟群吸引半径 | `220 px` / 排斥 `<70 px` | `js/main.js` |
| 主题切换循环 | `light → dark → system → light` | `js/main.js` |

### 12.3 术语表

| 术语 | 含义 |
| --- | --- |
| Material You | Google Material Design 3 强调动态取色与个性化的设计语言 |
| Glassmorphism | 玻璃拟态，通过半透明 + 背景模糊营造层次 |
| Boids | Craig Reynolds 1986 提出的鸟群仿真算法（分离/对齐/聚合） |
| Design Tokens | 设计令牌，把视觉规格抽象为可复用变量 |
| DPR | Device Pixel Ratio，物理像素与 CSS 像素比值 |

---

> **本文档完。** 如需针对某个模块做更细的接口定义、原型或测试用例，可在 day05+ 单独成档。
