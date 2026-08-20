# Day 06 - 数据库设计与建表

## 作业目标

把 Day 05 的产品原型转换为可执行的关系型数据库结构。

## 核心交付

- `init.sql`：完整初始化脚本。
- 数据库：`cike`。
- 字符集：`utf8mb4`。
- 存储引擎：InnoDB。

## 表结构

| 表名 | 用途 | 关键约束 |
| --- | --- | --- |
| `t_user` | 用户资料与统计 | 手机号唯一 |
| `t_note` | 笔记主数据 | 用户、时间索引 |
| `t_note_image` | 笔记多图 | 笔记索引、排序字段 |
| `t_topic` | 话题 | 话题名唯一 |
| `t_note_topic` | 笔记与话题多对多 | 组合唯一 |
| `t_comment` | 评论与二级回复 | 笔记、父评论索引 |
| `t_user_like_note` | 点赞记录 | 用户与笔记组合唯一 |
| `t_user_collect_note` | 收藏记录 | 用户与笔记组合唯一 |
| `t_draft` | 用户发布草稿 | 每用户唯一草稿 |

## 验收方式

```bash
mysql -u root -p < init.sql
mysql -u root -p -e "USE cike; SHOW TABLES;"
```

脚本包括数据库重建和 9 张业务表创建，可重复执行。线上项目使用 MariaDB 兼容执行该结构。

实现仓库：[Lerrenp/cike](https://github.com/Lerrenp/cike)
