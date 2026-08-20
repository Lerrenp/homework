# Day 07 - 测试数据与数据验证

## 作业目标

在 Day 06 表结构上准备可用于页面展示和接口联调的完整测试数据。

## 核心交付

- `seed.sql`：初始化全部核心业务数据。
- `数据库数据截图.txt`：用户表查询结果，作为导入验证记录。
- 测试用户统一密码：`123456`，数据库中保存 BCrypt 哈希。

## 数据覆盖

- 6 个用户。
- 6 个话题。
- 12 条图文笔记。
- 14 条笔记图片记录。
- 16 条笔记话题关联。
- 10 条评论，包含二级回复。
- 点赞和收藏关系数据。

## 验收方式

先执行 Day 06 的 `init.sql`，再执行：

```bash
mysql -u root -p cike < seed.sql
mysql -u root -p -e "USE cike; SELECT id, phone, nickname, bio FROM t_user;"
```

查询结果应与 `数据库数据截图.txt` 一致。该数据集已用于后续接口、首页卡片、详情页和个人中心联调。

实现仓库：[Lerrenp/cike](https://github.com/Lerrenp/cike)
