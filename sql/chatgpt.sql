
CREATE DATABASE IF NOT EXISTS chatgpt;
USE chatgpt;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `chatgpt`
--

-- --------------------------------------------------------

--
-- 表的结构 `action`
--

CREATE TABLE `action` (
  `id` bigint(255) NOT NULL,
  `user_id` bigint(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `describe` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `carmi`
--

CREATE TABLE `carmi` (
  `id` bigint(255) UNSIGNED NOT NULL,
  `ip` varchar(255) DEFAULT NULL COMMENT '使用时候的ip',
  `user_id` bigint(255) DEFAULT NULL COMMENT '使用者',
  `key` varchar(255) NOT NULL COMMENT '卡密',
  `value` varchar(255) NOT NULL COMMENT '积分',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0有效 1使用 2过期',
  `type` varchar(255) NOT NULL COMMENT '类型',
  `end_time` varchar(255) DEFAULT NULL COMMENT '截止时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `level` int(11) DEFAULT NULL COMMENT '卡密充值等级'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `config`
--

CREATE TABLE `config` (
  `id` int(255) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) DEFAULT '',
  `remarks` varchar(255) DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `config`
--

INSERT INTO `config` (`id`, `name`, `value`, `remarks`, `create_time`, `update_time`) VALUES
(1, 'signin_reward', '100', '签到奖励', '2023-05-19 16:21:12', '2023-05-25 11:01:00'),
(2, 'register_reward', '100', '注册奖励', '2023-05-19 16:21:49', '2023-05-26 21:49:49'),
(3, 'history_message_count', '10', '携带历史聊天数量', '2023-05-21 14:57:37', '2023-06-20 17:43:28'),
(4, 'ai3_ratio', '1', '3版本比例 每1积分等于多少token', '2023-05-25 16:40:18', '2023-06-20 17:43:15'),
(5, 'ai4_ratio', '50', '4版本比例 每1积分等于多少token', '2023-05-25 16:40:20', '2023-06-20 17:43:22'),
(6, 'draw_use_price', '[{\"size\":\"256x256\",\"integral\":100},{\"size\":\"512x512\",\"integral\":120},{\"size\":\"1024x1024\",\"integral\":150}]', '绘画价格 ', '2023-05-25 16:58:26', '2023-05-26 21:49:43'),
(7, 'shop_introduce', '', '商城介绍', '2023-05-29 11:51:39', '2023-05-29 17:33:15'),
(8, 'user_introduce', '', '用户中心介绍', '2023-05-29 11:52:07', '2023-05-29 17:33:16');

-- --------------------------------------------------------

--
-- 表的结构 `message`
--

CREATE TABLE `message` (
  `id` bigint unsigned NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `room_id` varchar(255) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 NOT NULL,
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
  KEY `key_roomo_user` (`user_id`,`room_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- 表的结构 `room`
--
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


--
-- 表的结构 `notification`
--

CREATE TABLE `notification` (
  `id` bigint(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `sort` int(11) DEFAULT '1',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `order`
--

CREATE TABLE `order` (
  `id` bigint(255) NOT NULL,
  `trade_no` varchar(255) DEFAULT NULL COMMENT '支付方订单ID',
  `pay_type` varchar(255) DEFAULT NULL COMMENT '支付方式 wxpay alipay',
  `product_id` bigint(255) DEFAULT NULL COMMENT '商品产品id',
  `trade_status` varchar(255) DEFAULT NULL COMMENT '支付状态',
  `user_id` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `product_info` text COMMENT '商品信息快照',
  `channel` varchar(255) DEFAULT NULL COMMENT '渠道号',
  `payment_id` bigint(255) DEFAULT NULL COMMENT '支付产品ID',
  `payment_info` text COMMENT '支付产品信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `money` double DEFAULT NULL COMMENT '支付金额',
  `params` text COMMENT '拓展参数',
  `ip` varchar(255) DEFAULT NULL,
  `notify_info` text COMMENT '通知回来的全部信息',
  `pay_url` varchar(255) DEFAULT NULL COMMENT '支付URL',
  `product_title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `payment`
--

CREATE TABLE `payment` (
  `id` bigint(255) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `channel` varchar(255) NOT NULL DEFAULT '' COMMENT '标识 支付宝 微信 易支付 码支付',
  `types` varchar(255) DEFAULT NULL COMMENT '[''ailipay'',''wxpay'']',
  `params` text COMMENT '支付所需参数',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1 正常 0异常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `product`
--

CREATE TABLE `product` (
  `id` bigint(255) UNSIGNED NOT NULL,
  `title` varchar(11) NOT NULL,
  `price` int(11) NOT NULL,
  `original_price` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `badge` varchar(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1为正常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(255) DEFAULT NULL COMMENT 'integral 或 day',
  `level` int(11) DEFAULT '1' COMMENT '会员级别 1 普通 2会员 3超级会员'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `reward`
--

CREATE TABLE `reward` (
  `id` bigint(255) NOT NULL COMMENT '奖励表',
  `category` varchar(255) NOT NULL COMMENT '签到 ｜ 邀请',
  `value` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL COMMENT '天 ｜ 积分',
  `demand` varchar(255) NOT NULL COMMENT '要求 签到是连续 邀请是不连续',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1有效',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `signin`
--

CREATE TABLE `signin` (
  `id` bigint(255) UNSIGNED NOT NULL,
  `user_id` bigint(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `status` int(11) DEFAULT '1',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `token`
--

CREATE TABLE `token` (
  `id` bigint(255) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL DEFAULT '',
  `host` varchar(255) NOT NULL DEFAULT '',
  `remarks` varchar(255) DEFAULT NULL,
  `models` varchar(255) DEFAULT NULL COMMENT '可用模型',
  `limit` double DEFAULT '0' COMMENT '总限制',
  `usage` double DEFAULT '0' COMMENT '已经使用',
  `status` int(11) DEFAULT '1' COMMENT '1 正常 0异常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `turnover`
--

CREATE TABLE `turnover` (
  `id` bigint(255) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `describe` varchar(255) NOT NULL COMMENT '描述',
  `value` varchar(255) NOT NULL COMMENT '值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `turnover`
--

INSERT INTO `turnover` (`id`, `user_id`, `describe`, `value`, `create_time`, `update_time`) VALUES
(61833690270928896, 61833690208014336, '注册奖励', '100积分', '2023-06-20 15:05:00', '2023-06-20 15:05:00'),
(61874584416161792, 61874584357441536, '注册奖励', '100积分', '2023-06-20 17:47:30', '2023-06-20 17:47:30');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` bigint(255) UNSIGNED NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `integral` int(255) DEFAULT '0',
  `vip_expire_time` date NOT NULL COMMENT '会员时间',
  `svip_expire_time` date DEFAULT NULL COMMENT '超级会员时间',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1正常',
  `ip` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `nickname`, `account`, `password`, `avatar`, `role`, `integral`, `vip_expire_time`, `svip_expire_time`, `status`, `ip`, `create_time`, `update_time`) VALUES
(61874584357441536, '管理员', 'admin@gmail.com', '3988ca8b82f82d11763c6f5b5633efd4', 'https://image.lightai.io/icon/header.png', 'administrator', 100, '2024-01-01', '2024-01-01', 1, '127.0.0.1', '2023-06-20 17:47:30', '2023-06-20 17:47:30');
--
-- 转储表的索引
--

--
-- 表的索引 `action`
--
ALTER TABLE `action`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `carmi`
--
ALTER TABLE `carmi`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`,`name`) USING BTREE;

--
-- 表的索引 `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `reward`
--
ALTER TABLE `reward`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `signin`
--
ALTER TABLE `signin`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `turnover`
--
ALTER TABLE `turnover`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `config`
--
ALTER TABLE `config`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `notification`
--
ALTER TABLE `notification`
  MODIFY `id` bigint(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53897947229720577;
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
