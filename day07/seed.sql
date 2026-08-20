-- =====================================================
-- 「此刻」图文分享社区 - 种子数据脚本 (seed.sql)
-- 依赖: 先执行 init.sql 建表
-- 所有用户登录密码均为: 123456 (BCrypt 加密)
-- =====================================================
USE `cike`;

-- ---------- 1. t_user 用户表 ----------
INSERT INTO `t_user` (`id`,`phone`,`password`,`nickname`,`avatar`,`bio`,`note_count`,`like_total`) VALUES
(1,'13800000001','$2b$10$tmylOBjb36SwBQ2spJeNhujktrPOotcGSTrS10fkxFxeSSAHkPY8y','小美','https://picsum.photos/seed/avatar1/200','热爱生活，喜欢分享日常',3,25),
(2,'13800000002','$2b$10$tmylOBjb36SwBQ2spJeNhujktrPOotcGSTrS10fkxFxeSSAHkPY8y','阿杰','https://picsum.photos/seed/avatar2/200','美食探店小能手',2,18),
(3,'13800000003','$2b$10$tmylOBjb36SwBQ2spJeNhujktrPOotcGSTrS10fkxFxeSSAHkPY8y','小鹿','https://picsum.photos/seed/avatar3/200','穿搭博主，分享穿搭灵感',2,30),
(4,'13800000004','$2b$10$tmylOBjb36SwBQ2spJeNhujktrPOotcGSTrS10fkxFxeSSAHkPY8y','风行者','https://picsum.photos/seed/avatar4/200','喜欢旅行与摄影',2,22),
(5,'13800000005','$2b$10$tmylOBjb36SwBQ2spJeNhujktrPOotcGSTrS10fkxFxeSSAHkPY8y','学习菌','https://picsum.photos/seed/avatar5/200','分享学习干货与成长',3,40),
(6,'13800000006','$2b$10$tmylOBjb36SwBQ2spJeNhujktrPOotcGSTrS10fkxFxeSSAHkPY8y','甜品控','https://picsum.photos/seed/avatar6/200','甜品与下午茶爱好者',2,15);

-- ---------- 2. t_topic 话题表 ----------
INSERT INTO `t_topic` (`id`,`topic_name`,`note_count`) VALUES
(1,'#美食',3),
(2,'#穿搭',2),
(3,'#风景',3),
(4,'#干货',3),
(5,'#探店',2),
(6,'#旅行',2);

-- ---------- 3. t_note 笔记表 ----------
INSERT INTO `t_note` (`id`,`user_id`,`title`,`content`,`cover_url`,`view_count`,`like_count`,`collect_count`,`comment_count`,`visible`,`status`) VALUES
(1,1,'周末自制草莓蛋糕','今天在家尝试做了一款草莓奶油蛋糕，松软香甜，超级成功！材料简单，新手也能做～','https://picsum.photos/seed/cake1/600',120,25,18,6,1,1),
(2,1,'春日野餐攻略','分享一次超棒的春日野餐，带上亲手做的小食和奶茶，去郊外晒晒太阳吧～','https://picsum.photos/seed/picnic1/600',98,15,12,4,1,1),
(3,2,'巷子里的宝藏面馆','这家开了三十年的面馆，牛肉面汤底浓郁，面条筋道，人均只要20块！','https://picsum.photos/seed/noodle1/600',150,30,25,8,1,1),
(4,3,'秋季慵懒叠穿法则','分享几套秋季叠穿搭配，慵懒又显气质，通勤约会都合适～','https://picsum.photos/seed/outfit1/600',210,45,40,10,1,1),
(5,3,'小个子穿搭避雷指南','总结了小个子显高的几个穿搭重点，避免踩坑，轻松拥有好比例！','https://picsum.photos/seed/outfit2/600',180,35,32,7,1,1),
(6,4,'雪山日出','凌晨四点半爬山，终于等到了绝美的雪山日出，一切都值得！','https://picsum.photos/seed/mountain1/600',300,60,55,15,1,1),
(7,4,'海边公路自驾','沿着海边公路自驾，一路都是大片，随手一拍都是壁纸级别～','https://picsum.photos/seed/coast1/600',260,50,48,12,1,1),
(8,5,'高效学习法｜番茄钟使用技巧','分享番茄工作法的正确打开方式，帮你提升专注力与效率！','https://picsum.photos/seed/study1/600',340,70,66,18,1,1),
(9,5,'程序员必备效率工具清单','整理了10个超好用的效率工具，覆盖代码、文档、时间管理，效率翻倍！','https://picsum.photos/seed/tools1/600',400,85,80,20,1,1),
(10,5,'一周健身计划表','自律的起点，分享我的一周健身计划，从新手到进阶都有～','https://picsum.photos/seed/fitness1/600',190,42,38,9,1,1),
(11,6,'网红甜品店打卡','这家网红甜品店的提拉米苏直接封神，甜而不腻，超治愈！','https://picsum.photos/seed/dessert1/600',160,33,28,11,1,1),
(12,6,'夏日冰饮DIY','三分钟自制高颜值夏日冰饮，清凉解暑，拍照也好看～','https://picsum.photos/seed/drink1/600',140,28,22,6,1,1);

-- ---------- 4. t_note_image 笔记图片表 ----------
INSERT INTO `t_note_image` (`note_id`,`image_url`,`sort`) VALUES
(1,'https://picsum.photos/seed/cake1/600',0),
(1,'https://picsum.photos/seed/cake2/600',1),
(2,'https://picsum.photos/seed/picnic2/600',0),
(3,'https://picsum.photos/seed/noodle2/600',0),
(4,'https://picsum.photos/seed/outfit3/600',0),
(5,'https://picsum.photos/seed/outfit4/600',0),
(6,'https://picsum.photos/seed/mountain2/600',0),
(7,'https://picsum.photos/seed/coast2/600',0),
(7,'https://picsum.photos/seed/coast3/600',1),
(8,'https://picsum.photos/seed/study2/600',0),
(9,'https://picsum.photos/seed/tools2/600',0),
(10,'https://picsum.photos/seed/fitness2/600',0),
(11,'https://picsum.photos/seed/dessert2/600',0),
(12,'https://picsum.photos/seed/drink2/600',0);

-- ---------- 5. t_note_topic 笔记话题关联表 ----------
INSERT INTO `t_note_topic` (`note_id`,`topic_id`) VALUES
(1,1),(2,1),(3,1),(3,5),
(4,2),(5,2),
(6,3),(6,6),(7,3),(7,6),
(8,4),(9,4),(10,4),
(11,1),(11,5),(12,1);

-- ---------- 6. t_comment 评论表 ----------
INSERT INTO `t_comment` (`id`,`note_id`,`user_id`,`parent_id`,`reply_user_id`,`content`) VALUES
(1,1,2,0,0,'看起来好好吃！求教程！！'),
(2,1,3,1,1,'回复上楼：同求教程～'),
(3,1,4,0,0,'草莓蛋糕太治愈了'),
(4,3,1,0,0,'在哪里呀 想带朋友去！'),
(5,4,5,0,0,'叠穿太有气质了，学到了'),
(6,6,1,0,0,'雪山日出绝美！'),
(7,8,2,0,0,'番茄钟真的有用，谢谢分享'),
(8,11,6,0,0,'提拉米苏冲了！'),
(9,9,4,0,0,'工具清单很实用，收藏了'),
(10,10,3,0,0,'健身计划收下了，开始打卡');

-- ---------- 7. t_user_like_note 点赞表 ----------
INSERT INTO `t_user_like_note` (`user_id`,`note_id`) VALUES
(2,1),(3,1),(4,1),(5,1),(6,1),
(1,3),(4,3),(6,3),
(1,4),(2,4),(5,4),(6,4),
(2,5),(1,5),
(2,6),(3,6),(5,6),
(1,8),(2,8),(4,8),(6,8),
(1,9),(2,9),(3,9),(6,9),
(3,11),(5,11);

-- ---------- 8. t_user_collect_note 收藏表 ----------
INSERT INTO `t_user_collect_note` (`user_id`,`note_id`) VALUES
(3,1),(5,1),(6,1),
(1,3),(5,3),
(2,4),(3,4),(6,4),
(1,5),(2,5),
(1,6),(2,6),(4,6),
(3,8),(4,8),
(2,9),(3,9),(4,9),(5,9),
(4,11),(5,11);

-- seed.sql 插入完成
