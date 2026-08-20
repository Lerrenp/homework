-- =====================================================
-- 「此刻」图文分享社区 - 数据库初始化建表脚本 (init.sql)
-- 数据库: MySQL 8.0
-- 字符集: utf8mb4  排序规则: utf8mb4_unicode_ci
-- =====================================================

DROP DATABASE IF EXISTS `cike`;
CREATE DATABASE `cike` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `cike`;

-- -----------------------------------------------------
-- 1. t_user 用户表
-- -----------------------------------------------------
CREATE TABLE `t_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户主键ID',
  `phone` VARCHAR(11) NOT NULL COMMENT '手机号',
  `password` VARCHAR(100) NOT NULL COMMENT '加密密码',
  `nickname` VARCHAR(50) NOT NULL COMMENT '昵称',
  `avatar` VARCHAR(255) DEFAULT '' COMMENT '头像图片url',
  `bio` VARCHAR(200) DEFAULT '' COMMENT '个人简介',
  `note_count` INT DEFAULT 0 COMMENT '发布笔记数',
  `like_total` INT DEFAULT 0 COMMENT '获赞总数',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除 0未删 1已删',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- -----------------------------------------------------
-- 2. t_note 笔记表
-- -----------------------------------------------------
CREATE TABLE `t_note` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '笔记ID',
  `user_id` BIGINT NOT NULL COMMENT '发布者用户id',
  `title` VARCHAR(100) NOT NULL COMMENT '笔记标题',
  `content` TEXT NOT NULL COMMENT '笔记正文',
  `cover_url` VARCHAR(255) DEFAULT '' COMMENT '封面图（取第一张图片）',
  `view_count` INT DEFAULT 0 COMMENT '浏览量',
  `like_count` INT DEFAULT 0 COMMENT '点赞数',
  `collect_count` INT DEFAULT 0 COMMENT '收藏数',
  `comment_count` INT DEFAULT 0 COMMENT '评论数',
  `visible` TINYINT DEFAULT 1 COMMENT '可见性：1公开，2仅自己可见',
  `status` TINYINT DEFAULT 1 COMMENT '状态：1正常，0审核中，-1违规下架',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除 0未删 1已删',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='笔记主表';

-- -----------------------------------------------------
-- 3. t_note_image 笔记图片表（一对多）
-- -----------------------------------------------------
CREATE TABLE `t_note_image` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `note_id` BIGINT NOT NULL COMMENT '笔记id',
  `image_url` VARCHAR(255) NOT NULL COMMENT '图片访问地址',
  `sort` INT DEFAULT 0 COMMENT '图片排序序号，越小越靠前',
  `is_deleted` TINYINT DEFAULT 0,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_note_id` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='笔记图片表';

-- -----------------------------------------------------
-- 4. t_topic 话题表
-- -----------------------------------------------------
CREATE TABLE `t_topic` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `topic_name` VARCHAR(50) NOT NULL COMMENT '话题名称，如#美食',
  `note_count` INT DEFAULT 0 COMMENT '关联笔记数量',
  `is_deleted` TINYINT DEFAULT 0,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_topic_name` (`topic_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='话题表';

-- -----------------------------------------------------
-- 5. t_note_topic 笔记-话题中间表（多对多）
-- -----------------------------------------------------
CREATE TABLE `t_note_topic` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `note_id` BIGINT NOT NULL,
  `topic_id` BIGINT NOT NULL,
  `is_deleted` TINYINT DEFAULT 0,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_note_topic` (`note_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='笔记话题关联表';

-- -----------------------------------------------------
-- 6. t_comment 评论表（支持二级回复）
-- -----------------------------------------------------
CREATE TABLE `t_comment` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `note_id` BIGINT NOT NULL COMMENT '所属笔记id',
  `user_id` BIGINT NOT NULL COMMENT '评论用户id',
  `parent_id` BIGINT DEFAULT 0 COMMENT '父评论id，0代表一级评论，非0为回复某条评论',
  `reply_user_id` BIGINT DEFAULT 0 COMMENT '回复目标用户id，用于子回复',
  `content` VARCHAR(500) NOT NULL COMMENT '评论内容',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '逻辑删除',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_note_id` (`note_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- -----------------------------------------------------
-- 7. t_user_like_note 用户点赞笔记表
-- -----------------------------------------------------
CREATE TABLE `t_user_like_note` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `note_id` BIGINT NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_note` (`user_id`,`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='笔记点赞记录表';

-- -----------------------------------------------------
-- 8. t_user_collect_note 用户收藏笔记表
-- -----------------------------------------------------
CREATE TABLE `t_user_collect_note` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `note_id` BIGINT NOT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_note` (`user_id`,`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='笔记收藏记录表';

-- -----------------------------------------------------
-- 9. t_draft 用户草稿表
-- -----------------------------------------------------
CREATE TABLE `t_draft` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL COMMENT '所属用户',
  `title` VARCHAR(100) DEFAULT '' COMMENT '草稿标题',
  `content` TEXT COMMENT '草稿正文',
  `image_json` TEXT COMMENT '草稿图片列表json数组',
  `topic_ids` VARCHAR(255) DEFAULT '' COMMENT '话题id逗号分隔',
  `visible` TINYINT DEFAULT 1 COMMENT '可见设置',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发布页草稿表';

-- init.sql 建表完成
