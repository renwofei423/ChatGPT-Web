/*
 Navicat Premium Data Transfer

 Source Server         : gc-hk-epoch-mysql
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : xxxx
 Source Schema         : chatgptv2

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 14/11/2023 13:30:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for action
-- ----------------------------
DROP TABLE IF EXISTS `action`;
CREATE TABLE `action` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `describe` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for carmi
-- ----------------------------
DROP TABLE IF EXISTS `carmi`;
CREATE TABLE `carmi` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint DEFAULT NULL COMMENT '使用者',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '使用时候的ip',
  `key` varchar(255) NOT NULL COMMENT '卡密',
  `value` varchar(255) NOT NULL COMMENT '积分',
  `status` int NOT NULL DEFAULT '0' COMMENT '0有效 1使用 2过期',
  `type` varchar(255) NOT NULL COMMENT '类型',
  `end_time` varchar(255) DEFAULT NULL COMMENT '截止时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `level` int DEFAULT NULL COMMENT '卡密充值等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `remarks` varchar(255) DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`name`) USING BTREE,
  KEY `key_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for invite_record
-- ----------------------------
DROP TABLE IF EXISTS `invite_record`;
CREATE TABLE `invite_record` (
  `id` bigint NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `invite_code` varchar(255) DEFAULT NULL COMMENT '邀请码',
  `superior_id` bigint DEFAULT NULL COMMENT '上级ID（一旦确定将不可修改）',
  `reward` varchar(255) DEFAULT NULL COMMENT '奖励',
  `reward_type` varchar(255) DEFAULT NULL COMMENT '奖励类型',
  `status` int NOT NULL DEFAULT '1' COMMENT '1正常',
  `remarks` varchar(255) DEFAULT NULL COMMENT '评论',
  `ip` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_agent` varchar(255) DEFAULT NULL COMMENT 'ua',
  PRIMARY KEY (`id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `room_id` varchar(255) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `frequency_penalty` float DEFAULT NULL,
  `max_tokens` int DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `presence_penalty` float DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `parent_message_id` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `key_room_id` (`room_id`) USING BTREE,
  KEY `key_roomo_user` (`user_id`,`room_id`) USING BTREE,
  KEY `key_user_createtime` (`user_id`,`create_time`) USING BTREE,
  KEY `key_user_status_room` (`user_id`,`room_id`,`status`) USING BTREE,
  KEY `key_parent_message_id_status` (`parent_message_id`,`status`) USING BTREE,
  KEY `idx_user_model_time` (`user_id`,`room_id`,`create_time`) USING BTREE,
  KEY `idx_model` (`user_id`,`model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `sort` int DEFAULT '1',
  `status` int DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69514540164845569 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` bigint NOT NULL,
  `trade_no` varchar(255) DEFAULT NULL COMMENT '支付方订单ID',
  `pay_type` varchar(255) DEFAULT NULL COMMENT '支付方式 wxpay alipay',
  `product_id` bigint DEFAULT NULL COMMENT '商品产品id',
  `trade_status` varchar(255) DEFAULT NULL COMMENT '支付状态',
  `user_id` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `product_info` text COMMENT '商品信息快照',
  `channel` varchar(255) DEFAULT NULL COMMENT '渠道号',
  `payment_id` bigint DEFAULT NULL COMMENT '支付产品ID',
  `payment_info` text COMMENT '支付产品信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `money` double DEFAULT NULL COMMENT '支付金额',
  `params` text COMMENT '拓展参数',
  `ip` varchar(255) DEFAULT NULL,
  `notify_info` text COMMENT '通知回来的全部信息',
  `pay_url` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '支付URL',
  `product_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` bigint NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `channel` varchar(255) NOT NULL DEFAULT '' COMMENT '标识 支付宝 微信 易支付 码支付',
  `types` varchar(255) DEFAULT NULL COMMENT '[''ailipay'',''wxpay'']',
  `params` text COMMENT '支付所需参数',
  `status` int NOT NULL DEFAULT '1' COMMENT '1 正常 0异常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` bigint unsigned NOT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` int NOT NULL,
  `original_price` int DEFAULT NULL,
  `value` int DEFAULT NULL,
  `badge` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1为正常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(255) DEFAULT NULL COMMENT 'integral 或 day',
  `level` int DEFAULT '1' COMMENT '会员级别 1 普通 2会员 3超级会员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for reward
-- ----------------------------
DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward` (
  `id` bigint NOT NULL COMMENT '奖励表',
  `category` varchar(255) NOT NULL COMMENT '签到 ｜ 邀请',
  `value` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL COMMENT '天 ｜ 积分',
  `demand` varchar(255) NOT NULL COMMENT '要求 签到是连续 邀请是不连续',
  `status` int NOT NULL DEFAULT '1' COMMENT '1有效',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `id` bigint NOT NULL,
  `room_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `key_room_id` (`room_id`) USING BTREE,
  KEY `key_user_id_room_id` (`room_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for signin
-- ----------------------------
DROP TABLE IF EXISTS `signin`;
CREATE TABLE `signin` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint NOT NULL,
  `ip` varchar(255) NOT NULL,
  `status` int DEFAULT '1',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` bigint unsigned NOT NULL,
  `key` varchar(255) NOT NULL DEFAULT '',
  `host` varchar(255) NOT NULL DEFAULT '',
  `remarks` varchar(255) DEFAULT NULL,
  `models` varchar(255) DEFAULT NULL COMMENT '可用模型',
  `limit` double DEFAULT '0' COMMENT '总限制',
  `usage` double DEFAULT '0' COMMENT '已经使用',
  `status` int DEFAULT '1' COMMENT '1 正常 0异常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for turnover
-- ----------------------------
DROP TABLE IF EXISTS `turnover`;
CREATE TABLE `turnover` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户',
  `describe` varchar(255) NOT NULL COMMENT '描述',
  `value` varchar(255) NOT NULL COMMENT '值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint unsigned NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `integral` int DEFAULT '0',
  `vip_expire_time` date NOT NULL COMMENT '会员时间',
  `svip_expire_time` date DEFAULT NULL COMMENT '超级会员时间',
  `status` int NOT NULL DEFAULT '1' COMMENT '1正常',
  `ip` varchar(255) DEFAULT NULL,
  `invite_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'invite_code' COMMENT '邀请码',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;

--
-- 转存表中的数据 `config`
--
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (1, 'signin_reward', '10', '签到奖励', '2023-05-19 16:21:12', '2023-10-19 11:52:32');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (2, 'register_reward', '100', '注册奖励', '2023-05-19 16:21:49', '2023-05-26 21:49:49');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (3, 'history_message_count', '20', '携带历史聊天数量', '2023-05-21 14:57:37', '2023-06-22 01:04:05');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (4, 'ai3_ratio', '10', '3版本比例 每1积分等于多少token', '2023-05-25 16:40:18', '2023-06-20 23:05:58');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (5, 'ai4_ratio', '50', '4版本比例 每1积分等于多少token', '2023-05-25 16:40:20', '2023-06-21 14:58:40');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (6, 'draw_use_price', '[{\"size\":\"1024x1024\",\"integral\":160},{\"size\":\"1024x1792\",\"integral\":200},{\"size\":\"1792x1024\",\"integral\":200}]', '绘画价格 ', '2023-05-25 16:58:26', '2023-11-07 15:09:26');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (7, 'shop_introduce', '<h3>商品说明会员<strong>/</strong>积分说明：</h3><p>1. 会员有效天数内使用不扣除积分；</p><p>3. 会员不限量GPT-3，普通用户和会员仅能积分兑换GPT-4；</p><p>4. 暂不开放超级会员</p><h3>积分消耗说明：</h3><p>1. GPT3.5-4K每次对话消耗10积分</p><p>2. GPT3.5-16k 每次对话消耗25积分</p><p>3. GPT4.0-4K 每次对话消耗50积分</p><p>4. GPT4.0-32K 每次对话消耗100积分</p><p>5. 1024x1024 规格图片一张消耗160积分</p><p>6. 1024x1792 规格图片一张消耗200积分</p><p>7. 1792x1024规格图片一张消耗200积分</p>', '商城介绍', '2023-05-29 11:51:39', '2023-11-07 15:10:00');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (8, 'user_introduce', '<p>尊敬的用户你好：	请坚持签到～ 每天可领取10积分</p>', '用户中心介绍', '2023-05-29 11:52:07', '2023-10-19 11:52:20');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (9, 'ai3_16k_ratio', '25', '3.5 16k 版本比例 每次对话多少积分', '2023-05-25 16:40:18', '2023-06-20 23:05:58');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (10, 'invite_introduce', '<h2>邀请功能暂未开启，敬请期待</h2>', '邀请页面说明', '2023-06-10 17:37:02', '2023-07-17 11:27:49');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (11, 'invite_reward', '10', '邀请奖励', '2023-06-10 18:13:30', '2023-06-10 18:34:40');
INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES (12, 'ai4_32k_ratio', '100', '4版本32k比例 每1积分等于多少token', '2023-07-24 17:01:30', '2023-07-24 17:01:40');


--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `nickname`, `account`, `password`, `avatar`, `role`, `integral`, `vip_expire_time`, `svip_expire_time`, `status`, `ip`, `create_time`, `update_time`) VALUES
(61874584357441536, '管理员', 'admin@gmail.com', '3988ca8b82f82d11763c6f5b5633efd4', 'https://image.lightai.io/icon/header.png', 'administrator', 100, '2024-01-01', '2024-01-01', 1, '127.0.0.1', '2023-06-20 17:47:30', '2023-06-20 17:47:30');