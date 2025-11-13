CREATE TABLE `t_user` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `loginname` varchar(16) NOT NULL DEFAULT '' COMMENT '登录名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
  `avatar_url` varchar(50) NOT NULL DEFAULT '' COMMENT '头像',


  `created_at`  datetime DEFAULT NULL COMMENT '',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';



CREATE TABLE `t_post` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `author_id` int(11) NOT NULL DEFAULT '0' COMMENT '作者',
  `text` text NOT NULL DEFAULT '' COMMENT '内容',
  `media_meta` text NOT NULL DEFAULT '' COMMENT 'oss等url',
  `visibility` tinyint(1) NOT NULL DEFAULT '0' COMMENT '可见标记',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `like_count` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `comment_count` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `share_count` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `created_at` datetime DEFAULT NULL COMMENT '',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '发布';

CREATE TABLE `t_follower` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `follower_id` int(11) NOT NULL DEFAULT '0' COMMENT '发帖用户',
  `followee_id` int(11) NOT NULL DEFAULT '0' COMMENT '粉丝用户',
  `created_at` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '关注';


CREATE TABLE `t_feed_timeline` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT '发布内容',
  `feed_type` varchar(20) NOT NULL DEFAULT '' COMMENT '',
  `score` varchar(20) NOT NULL DEFAULT '' COMMENT '',
  `created_at` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '作为用户拉取的“预计算时间线”存储（推/拉混合）';


CREATE TABLE `t_like` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT '发布内容',
  `created_at` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '点赞';

CREATE TABLE `t_feed_timeline` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT '发布内容',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级id',
  `content` text NOT NULL DEFAULT '' COMMENT '',
  `created_at` datetime DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '评论';
