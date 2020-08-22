/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 192.168.1.200:3306
 Source Schema         : bin-sns

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/08/2020 15:29:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu` VALUES (1, 0, 1, '主页', 'fa-bar-chart', '/', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (2, 0, 19, '系统管理', 'fa-tasks', '', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (3, 2, 20, '用户列表', 'fa-users', 'auth/users', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (4, 2, 21, '角色列表', 'fa-user', 'auth/roles', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (5, 2, 22, '权限列表', 'fa-ban', 'auth/permissions', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (6, 2, 23, '菜单列表', 'fa-bars', 'auth/menu', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (7, 2, 24, '操作日志', 'fa-history', 'auth/logs', NULL, NULL, '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (8, 0, 2, '广告管理', 'fa-viadeo-square', NULL, NULL, '2020-06-15 02:23:15', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (9, 8, 3, '广告位列表', 'fa-bars', '/ads_position', NULL, '2020-06-15 02:23:34', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (10, 8, 4, '广告列表', 'fa-bars', '/ads', NULL, '2020-06-15 02:23:50', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (11, 0, 5, '内容管理', 'fa-file-code-o', NULL, NULL, '2020-06-15 07:08:39', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (12, 11, 6, '动态管理', 'fa-amazon', '/post', NULL, '2020-06-15 07:09:33', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (13, 11, 7, '赞踩详情', 'fa-bars', '/post_like', NULL, '2020-06-15 07:10:11', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (14, 11, 8, '话题列表', 'fa-y-combinator-square', '/topic', NULL, '2020-06-15 07:11:02', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (15, 11, 9, '话题分类', 'fa-certificate', '/topic_cat', NULL, '2020-06-15 07:11:31', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (16, 11, 10, '帖子列表', 'fa-bars', '/topic_post', NULL, '2020-06-15 07:11:52', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (17, 0, 15, '用户管理', 'fa-user', NULL, NULL, '2020-06-15 07:13:45', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (18, 17, 16, '用户列表', 'fa-user-plus', '/user', NULL, '2020-06-15 07:14:08', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (19, 17, 17, '用户关系', 'fa-folder-open', '/user_follow', NULL, '2020-06-15 07:14:34', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (20, 17, 18, '用户黑名单', 'fa-black-tie', '/user_black', NULL, '2020-06-15 07:15:01', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (21, 11, 11, '评论列表', 'fa-creative-commons', '/comment', NULL, '2020-06-15 07:16:01', '2020-06-15 07:19:05');
INSERT INTO `admin_menu` VALUES (22, 0, 12, '资源管理', 'fa-compress', NULL, NULL, '2020-06-15 07:16:59', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (23, 22, 13, '图片列表', 'fa-image', '/image', NULL, '2020-06-15 07:17:14', '2020-06-15 07:19:28');
INSERT INTO `admin_menu` VALUES (24, 0, 14, '用户反馈', 'fa-coffee', '/feedback', NULL, '2020-06-15 07:18:45', '2020-06-15 07:19:28');
COMMIT;

-- ----------------------------
-- Table structure for admin_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_operation_log`;
CREATE TABLE `admin_operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_operation_log_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_operation_log
-- ----------------------------
BEGIN;
INSERT INTO `admin_operation_log` VALUES (1, 1, '/', 'GET', '127.0.0.1', '[]', '2020-06-15 02:00:34', '2020-06-15 02:00:34');
INSERT INTO `admin_operation_log` VALUES (2, 1, 'auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:01:28', '2020-06-15 02:01:28');
INSERT INTO `admin_operation_log` VALUES (3, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:01:29', '2020-06-15 02:01:29');
INSERT INTO `admin_operation_log` VALUES (4, 1, 'auth/roles', 'GET', '127.0.0.1', '[]', '2020-06-15 02:03:51', '2020-06-15 02:03:51');
INSERT INTO `admin_operation_log` VALUES (5, 1, '/', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:03:54', '2020-06-15 02:03:54');
INSERT INTO `admin_operation_log` VALUES (6, 1, '/', 'GET', '127.0.0.1', '[]', '2020-06-15 02:04:04', '2020-06-15 02:04:04');
INSERT INTO `admin_operation_log` VALUES (7, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:04:08', '2020-06-15 02:04:08');
INSERT INTO `admin_operation_log` VALUES (8, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:04:08', '2020-06-15 02:04:08');
INSERT INTO `admin_operation_log` VALUES (9, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:04:10', '2020-06-15 02:04:10');
INSERT INTO `admin_operation_log` VALUES (10, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:04:21', '2020-06-15 02:04:21');
INSERT INTO `admin_operation_log` VALUES (11, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:04:48', '2020-06-15 02:04:48');
INSERT INTO `admin_operation_log` VALUES (12, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:05:02', '2020-06-15 02:05:02');
INSERT INTO `admin_operation_log` VALUES (13, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:05:07', '2020-06-15 02:05:07');
INSERT INTO `admin_operation_log` VALUES (14, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:08:04', '2020-06-15 02:08:04');
INSERT INTO `admin_operation_log` VALUES (15, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:08:06', '2020-06-15 02:08:06');
INSERT INTO `admin_operation_log` VALUES (16, 1, 'auth/lock', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:08:58', '2020-06-15 02:08:58');
INSERT INTO `admin_operation_log` VALUES (17, 1, 'auth/lock', 'GET', '127.0.0.1', '[]', '2020-06-15 02:08:58', '2020-06-15 02:08:58');
INSERT INTO `admin_operation_log` VALUES (18, 1, 'auth/unlock', 'POST', '127.0.0.1', '{\"password\":\"admin\",\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\"}', '2020-06-15 02:09:05', '2020-06-15 02:09:05');
INSERT INTO `admin_operation_log` VALUES (19, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:09:05', '2020-06-15 02:09:05');
INSERT INTO `admin_operation_log` VALUES (20, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:09:11', '2020-06-15 02:09:11');
INSERT INTO `admin_operation_log` VALUES (21, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:13:56', '2020-06-15 02:13:56');
INSERT INTO `admin_operation_log` VALUES (22, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:14:07', '2020-06-15 02:14:07');
INSERT INTO `admin_operation_log` VALUES (23, 1, 'auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:14:09', '2020-06-15 02:14:09');
INSERT INTO `admin_operation_log` VALUES (24, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:14:10', '2020-06-15 02:14:10');
INSERT INTO `admin_operation_log` VALUES (25, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:14:11', '2020-06-15 02:14:11');
INSERT INTO `admin_operation_log` VALUES (26, 1, 'auth/roles', 'GET', '127.0.0.1', '[]', '2020-06-15 02:14:12', '2020-06-15 02:14:12');
INSERT INTO `admin_operation_log` VALUES (27, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:14:15', '2020-06-15 02:14:15');
INSERT INTO `admin_operation_log` VALUES (28, 1, 'auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:14:16', '2020-06-15 02:14:16');
INSERT INTO `admin_operation_log` VALUES (29, 1, 'auth/users', 'GET', '127.0.0.1', '[]', '2020-06-15 02:14:39', '2020-06-15 02:14:39');
INSERT INTO `admin_operation_log` VALUES (30, 1, 'auth/users', 'GET', '127.0.0.1', '[]', '2020-06-15 02:15:05', '2020-06-15 02:15:05');
INSERT INTO `admin_operation_log` VALUES (31, 1, 'auth/users', 'GET', '127.0.0.1', '[]', '2020-06-15 02:15:22', '2020-06-15 02:15:22');
INSERT INTO `admin_operation_log` VALUES (32, 1, 'auth/users', 'GET', '127.0.0.1', '[]', '2020-06-15 02:15:41', '2020-06-15 02:15:41');
INSERT INTO `admin_operation_log` VALUES (33, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:15:54', '2020-06-15 02:15:54');
INSERT INTO `admin_operation_log` VALUES (34, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:15:55', '2020-06-15 02:15:55');
INSERT INTO `admin_operation_log` VALUES (35, 1, 'auth/roles', 'GET', '127.0.0.1', '[]', '2020-06-15 02:15:56', '2020-06-15 02:15:56');
INSERT INTO `admin_operation_log` VALUES (36, 1, 'auth/roles', 'GET', '127.0.0.1', '[]', '2020-06-15 02:18:49', '2020-06-15 02:18:49');
INSERT INTO `admin_operation_log` VALUES (37, 1, 'auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:18:51', '2020-06-15 02:18:51');
INSERT INTO `admin_operation_log` VALUES (38, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:18:52', '2020-06-15 02:18:52');
INSERT INTO `admin_operation_log` VALUES (39, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:18:53', '2020-06-15 02:18:53');
INSERT INTO `admin_operation_log` VALUES (40, 1, 'auth/roles', 'GET', '127.0.0.1', '[]', '2020-06-15 02:18:53', '2020-06-15 02:18:53');
INSERT INTO `admin_operation_log` VALUES (41, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:18:54', '2020-06-15 02:18:54');
INSERT INTO `admin_operation_log` VALUES (42, 1, 'auth/logs', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:18:55', '2020-06-15 02:18:55');
INSERT INTO `admin_operation_log` VALUES (43, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:18:58', '2020-06-15 02:18:58');
INSERT INTO `admin_operation_log` VALUES (44, 1, 'auth/logs', 'GET', '127.0.0.1', '[]', '2020-06-15 02:18:59', '2020-06-15 02:18:59');
INSERT INTO `admin_operation_log` VALUES (45, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:19:02', '2020-06-15 02:19:02');
INSERT INTO `admin_operation_log` VALUES (46, 1, 'auth/logs', 'GET', '127.0.0.1', '[]', '2020-06-15 02:19:02', '2020-06-15 02:19:02');
INSERT INTO `admin_operation_log` VALUES (47, 1, 'auth/logs', 'GET', '127.0.0.1', '[]', '2020-06-15 02:19:57', '2020-06-15 02:19:57');
INSERT INTO `admin_operation_log` VALUES (48, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:19:59', '2020-06-15 02:19:59');
INSERT INTO `admin_operation_log` VALUES (49, 1, 'auth/logs', 'GET', '127.0.0.1', '[]', '2020-06-15 02:20:00', '2020-06-15 02:20:00');
INSERT INTO `admin_operation_log` VALUES (50, 1, 'auth/logs', 'GET', '127.0.0.1', '[]', '2020-06-15 02:20:36', '2020-06-15 02:20:36');
INSERT INTO `admin_operation_log` VALUES (51, 1, 'auth/logs', 'GET', '127.0.0.1', '[]', '2020-06-15 02:20:37', '2020-06-15 02:20:37');
INSERT INTO `admin_operation_log` VALUES (52, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:20:38', '2020-06-15 02:20:38');
INSERT INTO `admin_operation_log` VALUES (53, 1, 'auth/permissions', 'GET', '127.0.0.1', '[]', '2020-06-15 02:20:41', '2020-06-15 02:20:41');
INSERT INTO `admin_operation_log` VALUES (54, 1, 'auth/logs', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:21:06', '2020-06-15 02:21:06');
INSERT INTO `admin_operation_log` VALUES (55, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:21:11', '2020-06-15 02:21:11');
INSERT INTO `admin_operation_log` VALUES (56, 1, 'auth/logs', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:21:36', '2020-06-15 02:21:36');
INSERT INTO `admin_operation_log` VALUES (57, 1, 'auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:21:40', '2020-06-15 02:21:40');
INSERT INTO `admin_operation_log` VALUES (58, 1, 'auth/roles', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:21:41', '2020-06-15 02:21:41');
INSERT INTO `admin_operation_log` VALUES (59, 1, 'auth/roles/create', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:21:44', '2020-06-15 02:21:44');
INSERT INTO `admin_operation_log` VALUES (60, 1, 'auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:22:25', '2020-06-15 02:22:25');
INSERT INTO `admin_operation_log` VALUES (61, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:22:26', '2020-06-15 02:22:26');
INSERT INTO `admin_operation_log` VALUES (62, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u5e7f\\u544a\\u7ba1\\u7406\",\"icon\":\"fa-viadeo-square\",\"uri\":null,\"roles\":[null],\"permission\":null,\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\"}', '2020-06-15 02:23:15', '2020-06-15 02:23:15');
INSERT INTO `admin_operation_log` VALUES (63, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:23:15', '2020-06-15 02:23:15');
INSERT INTO `admin_operation_log` VALUES (64, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u5e7f\\u544a\\u4f4d\\u5217\\u8868\",\"icon\":\"fa-bars\",\"uri\":\"\\/ads_position\",\"roles\":[null],\"permission\":null,\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\"}', '2020-06-15 02:23:34', '2020-06-15 02:23:34');
INSERT INTO `admin_operation_log` VALUES (65, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:23:34', '2020-06-15 02:23:34');
INSERT INTO `admin_operation_log` VALUES (66, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u5e7f\\u544a\\u5217\\u8868\",\"icon\":\"fa-bars\",\"uri\":\"\\/ads\",\"roles\":[null],\"permission\":null,\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\"}', '2020-06-15 02:23:50', '2020-06-15 02:23:50');
INSERT INTO `admin_operation_log` VALUES (67, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:23:50', '2020-06-15 02:23:50');
INSERT INTO `admin_operation_log` VALUES (68, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:23:52', '2020-06-15 02:23:52');
INSERT INTO `admin_operation_log` VALUES (69, 1, 'auth/menu/9/edit', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:24:02', '2020-06-15 02:24:02');
INSERT INTO `admin_operation_log` VALUES (70, 1, 'auth/menu/9', 'PUT', '127.0.0.1', '{\"parent_id\":\"8\",\"title\":\"\\u5e7f\\u544a\\u4f4d\\u5217\\u8868\",\"icon\":\"fa-bars\",\"uri\":\"\\/ads_position\",\"roles\":[null],\"permission\":null,\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/admin.sns.lo\\/auth\\/menu\"}', '2020-06-15 02:24:07', '2020-06-15 02:24:07');
INSERT INTO `admin_operation_log` VALUES (71, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:24:08', '2020-06-15 02:24:08');
INSERT INTO `admin_operation_log` VALUES (72, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\",\"_order\":\"[{\\\"id\\\":8,\\\"children\\\":[{\\\"id\\\":9},{\\\"id\\\":10}]},{\\\"id\\\":1},{\\\"id\\\":2,\\\"children\\\":[{\\\"id\\\":3},{\\\"id\\\":4},{\\\"id\\\":5},{\\\"id\\\":6},{\\\"id\\\":7}]}]\"}', '2020-06-15 02:24:13', '2020-06-15 02:24:13');
INSERT INTO `admin_operation_log` VALUES (73, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:24:13', '2020-06-15 02:24:13');
INSERT INTO `admin_operation_log` VALUES (74, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:24:14', '2020-06-15 02:24:14');
INSERT INTO `admin_operation_log` VALUES (75, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\",\"_order\":\"[{\\\"id\\\":1},{\\\"id\\\":8,\\\"children\\\":[{\\\"id\\\":9},{\\\"id\\\":10}]},{\\\"id\\\":2,\\\"children\\\":[{\\\"id\\\":3},{\\\"id\\\":4},{\\\"id\\\":5},{\\\"id\\\":6},{\\\"id\\\":7}]}]\"}', '2020-06-15 02:24:21', '2020-06-15 02:24:21');
INSERT INTO `admin_operation_log` VALUES (76, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:24:21', '2020-06-15 02:24:21');
INSERT INTO `admin_operation_log` VALUES (77, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 02:24:23', '2020-06-15 02:24:23');
INSERT INTO `admin_operation_log` VALUES (78, 1, 'ads_position', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:24:25', '2020-06-15 02:24:25');
INSERT INTO `admin_operation_log` VALUES (79, 1, 'ads_position', 'GET', '127.0.0.1', '[]', '2020-06-15 02:25:02', '2020-06-15 02:25:02');
INSERT INTO `admin_operation_log` VALUES (80, 1, 'ads_position', 'GET', '127.0.0.1', '[]', '2020-06-15 02:28:13', '2020-06-15 02:28:13');
INSERT INTO `admin_operation_log` VALUES (81, 1, 'ads_position/create', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:28:15', '2020-06-15 02:28:15');
INSERT INTO `admin_operation_log` VALUES (82, 1, 'ads_position', 'POST', '127.0.0.1', '{\"name\":\"\\u9996\\u9875banner\",\"is_release\":\"on\",\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\",\"_previous_\":\"http:\\/\\/admin.sns.lo\\/ads_position\"}', '2020-06-15 02:28:25', '2020-06-15 02:28:25');
INSERT INTO `admin_operation_log` VALUES (83, 1, 'ads_position/create', 'GET', '127.0.0.1', '[]', '2020-06-15 02:28:25', '2020-06-15 02:28:25');
INSERT INTO `admin_operation_log` VALUES (84, 1, 'ads_position', 'POST', '127.0.0.1', '{\"name\":\"\\u9996\\u9875banner\",\"is_release\":\"on\",\"_token\":\"F56h4CaZKpcpoWgCFzRZE0AuGU2dYOFmhFoG5AuR\"}', '2020-06-15 02:28:50', '2020-06-15 02:28:50');
INSERT INTO `admin_operation_log` VALUES (85, 1, 'ads_position', 'GET', '127.0.0.1', '[]', '2020-06-15 02:28:51', '2020-06-15 02:28:51');
INSERT INTO `admin_operation_log` VALUES (86, 1, 'ads_position/1/edit', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:28:56', '2020-06-15 02:28:56');
INSERT INTO `admin_operation_log` VALUES (87, 1, 'ads_position', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 02:28:59', '2020-06-15 02:28:59');
INSERT INTO `admin_operation_log` VALUES (88, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:08:04', '2020-06-15 07:08:04');
INSERT INTO `admin_operation_log` VALUES (89, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u5185\\u5bb9\\u7ba1\\u7406\",\"icon\":\"fa-file-code-o\",\"uri\":null,\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:08:38', '2020-06-15 07:08:38');
INSERT INTO `admin_operation_log` VALUES (90, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:08:39', '2020-06-15 07:08:39');
INSERT INTO `admin_operation_log` VALUES (91, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"11\",\"title\":\"\\u52a8\\u6001\\u7ba1\\u7406\",\"icon\":\"fa-amazon\",\"uri\":\"\\/post\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:09:33', '2020-06-15 07:09:33');
INSERT INTO `admin_operation_log` VALUES (92, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:09:33', '2020-06-15 07:09:33');
INSERT INTO `admin_operation_log` VALUES (93, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"11\",\"title\":\"\\u8d5e\\u8e29\\u8be6\\u60c5\",\"icon\":\"fa-bars\",\"uri\":\"\\/post_like\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:10:11', '2020-06-15 07:10:11');
INSERT INTO `admin_operation_log` VALUES (94, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:10:11', '2020-06-15 07:10:11');
INSERT INTO `admin_operation_log` VALUES (95, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u8bdd\\u9898\\u5217\\u8868\",\"icon\":\"fa-y-combinator-square\",\"uri\":\"\\/topic\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:11:01', '2020-06-15 07:11:01');
INSERT INTO `admin_operation_log` VALUES (96, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:11:02', '2020-06-15 07:11:02');
INSERT INTO `admin_operation_log` VALUES (97, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"11\",\"title\":\"topic_cat\",\"icon\":\"fa-certificate\",\"uri\":\"\\/topic_cat\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:11:31', '2020-06-15 07:11:31');
INSERT INTO `admin_operation_log` VALUES (98, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:11:31', '2020-06-15 07:11:31');
INSERT INTO `admin_operation_log` VALUES (99, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"11\",\"title\":\"\\u5e16\\u5b50\\u5217\\u8868\",\"icon\":\"fa-bars\",\"uri\":\"\\/topic_post\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:11:52', '2020-06-15 07:11:52');
INSERT INTO `admin_operation_log` VALUES (100, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:11:52', '2020-06-15 07:11:52');
INSERT INTO `admin_operation_log` VALUES (101, 1, 'auth/menu/15/edit', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:12:11', '2020-06-15 07:12:11');
INSERT INTO `admin_operation_log` VALUES (102, 1, 'auth/menu/15', 'PUT', '127.0.0.1', '{\"parent_id\":\"11\",\"title\":\"\\u8bdd\\u9898\\u5206\\u7c7b\",\"icon\":\"fa-certificate\",\"uri\":\"\\/topic_cat\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/admin.sns.lo\\/auth\\/menu\"}', '2020-06-15 07:12:26', '2020-06-15 07:12:26');
INSERT INTO `admin_operation_log` VALUES (103, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:12:26', '2020-06-15 07:12:26');
INSERT INTO `admin_operation_log` VALUES (104, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:12:47', '2020-06-15 07:12:47');
INSERT INTO `admin_operation_log` VALUES (105, 1, 'auth/menu/14/edit', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:12:52', '2020-06-15 07:12:52');
INSERT INTO `admin_operation_log` VALUES (106, 1, 'auth/menu/14', 'PUT', '127.0.0.1', '{\"parent_id\":\"11\",\"title\":\"\\u8bdd\\u9898\\u5217\\u8868\",\"icon\":\"fa-y-combinator-square\",\"uri\":\"\\/topic\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/admin.sns.lo\\/auth\\/menu\"}', '2020-06-15 07:12:56', '2020-06-15 07:12:56');
INSERT INTO `admin_operation_log` VALUES (107, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:12:57', '2020-06-15 07:12:57');
INSERT INTO `admin_operation_log` VALUES (108, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"fa-user\",\"uri\":null,\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:13:45', '2020-06-15 07:13:45');
INSERT INTO `admin_operation_log` VALUES (109, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:13:45', '2020-06-15 07:13:45');
INSERT INTO `admin_operation_log` VALUES (110, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"17\",\"title\":\"\\u7528\\u6237\\u5217\\u8868\",\"icon\":\"fa-user-plus\",\"uri\":\"\\/user\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:14:08', '2020-06-15 07:14:08');
INSERT INTO `admin_operation_log` VALUES (111, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:14:08', '2020-06-15 07:14:08');
INSERT INTO `admin_operation_log` VALUES (112, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"17\",\"title\":\"\\u7528\\u6237\\u5173\\u7cfb\",\"icon\":\"fa-folder-open\",\"uri\":\"\\/user_follow\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:14:34', '2020-06-15 07:14:34');
INSERT INTO `admin_operation_log` VALUES (113, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:14:34', '2020-06-15 07:14:34');
INSERT INTO `admin_operation_log` VALUES (114, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"17\",\"title\":\"\\u7528\\u6237\\u9ed1\\u540d\\u5355\",\"icon\":\"fa-black-tie\",\"uri\":\"\\/user_black\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:15:01', '2020-06-15 07:15:01');
INSERT INTO `admin_operation_log` VALUES (115, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:15:01', '2020-06-15 07:15:01');
INSERT INTO `admin_operation_log` VALUES (116, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u8bc4\\u8bba\\u5217\\u8868\",\"icon\":\"fa-creative-commons\",\"uri\":\"\\/comment\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:16:01', '2020-06-15 07:16:01');
INSERT INTO `admin_operation_log` VALUES (117, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:16:01', '2020-06-15 07:16:01');
INSERT INTO `admin_operation_log` VALUES (118, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\",\"_order\":\"[{\\\"id\\\":11,\\\"children\\\":[{\\\"id\\\":12},{\\\"id\\\":13},{\\\"id\\\":14},{\\\"id\\\":15},{\\\"id\\\":16},{\\\"id\\\":21}]},{\\\"id\\\":17,\\\"children\\\":[{\\\"id\\\":18},{\\\"id\\\":19},{\\\"id\\\":20}]},{\\\"id\\\":1},{\\\"id\\\":8,\\\"children\\\":[{\\\"id\\\":9},{\\\"id\\\":10}]},{\\\"id\\\":2,\\\"children\\\":[{\\\"id\\\":3},{\\\"id\\\":4},{\\\"id\\\":5},{\\\"id\\\":6},{\\\"id\\\":7}]}]\"}', '2020-06-15 07:16:21', '2020-06-15 07:16:21');
INSERT INTO `admin_operation_log` VALUES (119, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:16:21', '2020-06-15 07:16:21');
INSERT INTO `admin_operation_log` VALUES (120, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u8d44\\u6e90\\u7ba1\\u7406\",\"icon\":\"fa-compress\",\"uri\":null,\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:16:59', '2020-06-15 07:16:59');
INSERT INTO `admin_operation_log` VALUES (121, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:16:59', '2020-06-15 07:16:59');
INSERT INTO `admin_operation_log` VALUES (122, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u56fe\\u7247\\u5217\\u8868\",\"icon\":\"fa-image\",\"uri\":\"\\/image\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:17:14', '2020-06-15 07:17:14');
INSERT INTO `admin_operation_log` VALUES (123, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:17:14', '2020-06-15 07:17:14');
INSERT INTO `admin_operation_log` VALUES (124, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"parent_id\":\"0\",\"title\":\"\\u7528\\u6237\\u53cd\\u9988\",\"icon\":\"fa-coffee\",\"uri\":\"\\/feedback\",\"roles\":[null],\"permission\":null,\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\"}', '2020-06-15 07:18:45', '2020-06-15 07:18:45');
INSERT INTO `admin_operation_log` VALUES (125, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:18:45', '2020-06-15 07:18:45');
INSERT INTO `admin_operation_log` VALUES (126, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\",\"_order\":\"[{\\\"id\\\":1},{\\\"id\\\":22,\\\"children\\\":[{\\\"id\\\":23}]},{\\\"id\\\":24},{\\\"id\\\":11,\\\"children\\\":[{\\\"id\\\":12},{\\\"id\\\":13},{\\\"id\\\":14},{\\\"id\\\":15},{\\\"id\\\":16},{\\\"id\\\":21}]},{\\\"id\\\":17,\\\"children\\\":[{\\\"id\\\":18},{\\\"id\\\":19},{\\\"id\\\":20}]},{\\\"id\\\":8,\\\"children\\\":[{\\\"id\\\":9},{\\\"id\\\":10}]},{\\\"id\\\":2,\\\"children\\\":[{\\\"id\\\":3},{\\\"id\\\":4},{\\\"id\\\":5},{\\\"id\\\":6},{\\\"id\\\":7}]}]\"}', '2020-06-15 07:19:05', '2020-06-15 07:19:05');
INSERT INTO `admin_operation_log` VALUES (127, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:19:05', '2020-06-15 07:19:05');
INSERT INTO `admin_operation_log` VALUES (128, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:19:08', '2020-06-15 07:19:08');
INSERT INTO `admin_operation_log` VALUES (129, 1, 'auth/menu', 'POST', '127.0.0.1', '{\"_token\":\"5Cdzyf6aqsww3ngP4yYKtWwedW0cmVuRGKSQx9ik\",\"_order\":\"[{\\\"id\\\":1},{\\\"id\\\":8,\\\"children\\\":[{\\\"id\\\":9},{\\\"id\\\":10}]},{\\\"id\\\":11,\\\"children\\\":[{\\\"id\\\":12},{\\\"id\\\":13},{\\\"id\\\":14},{\\\"id\\\":15},{\\\"id\\\":16},{\\\"id\\\":21}]},{\\\"id\\\":22,\\\"children\\\":[{\\\"id\\\":23}]},{\\\"id\\\":24},{\\\"id\\\":17,\\\"children\\\":[{\\\"id\\\":18},{\\\"id\\\":19},{\\\"id\\\":20}]},{\\\"id\\\":2,\\\"children\\\":[{\\\"id\\\":3},{\\\"id\\\":4},{\\\"id\\\":5},{\\\"id\\\":6},{\\\"id\\\":7}]}]\"}', '2020-06-15 07:19:28', '2020-06-15 07:19:28');
INSERT INTO `admin_operation_log` VALUES (130, 1, 'auth/menu', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:19:28', '2020-06-15 07:19:28');
INSERT INTO `admin_operation_log` VALUES (131, 1, 'auth/menu', 'GET', '127.0.0.1', '[]', '2020-06-15 07:19:30', '2020-06-15 07:19:30');
INSERT INTO `admin_operation_log` VALUES (132, 1, 'ads_position', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:39:52', '2020-06-15 07:39:52');
INSERT INTO `admin_operation_log` VALUES (133, 1, 'ads', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:39:54', '2020-06-15 07:39:54');
INSERT INTO `admin_operation_log` VALUES (134, 1, 'ads_position', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:39:56', '2020-06-15 07:39:56');
INSERT INTO `admin_operation_log` VALUES (135, 1, 'ads', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:39:58', '2020-06-15 07:39:58');
INSERT INTO `admin_operation_log` VALUES (136, 1, 'ads', 'GET', '127.0.0.1', '[]', '2020-06-15 07:41:10', '2020-06-15 07:41:10');
INSERT INTO `admin_operation_log` VALUES (137, 1, 'ads', 'GET', '127.0.0.1', '[]', '2020-06-15 07:42:32', '2020-06-15 07:42:32');
INSERT INTO `admin_operation_log` VALUES (138, 1, 'ads', 'GET', '127.0.0.1', '[]', '2020-06-15 07:42:49', '2020-06-15 07:42:49');
INSERT INTO `admin_operation_log` VALUES (139, 1, 'ads_position', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:42:53', '2020-06-15 07:42:53');
INSERT INTO `admin_operation_log` VALUES (140, 1, 'ads', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:42:54', '2020-06-15 07:42:54');
INSERT INTO `admin_operation_log` VALUES (141, 1, 'ads', 'GET', '127.0.0.1', '[]', '2020-06-15 07:43:07', '2020-06-15 07:43:07');
INSERT INTO `admin_operation_log` VALUES (142, 1, 'post', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:43:10', '2020-06-15 07:43:10');
INSERT INTO `admin_operation_log` VALUES (143, 1, 'post_like', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:43:35', '2020-06-15 07:43:35');
INSERT INTO `admin_operation_log` VALUES (144, 1, 'topic', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:43:40', '2020-06-15 07:43:40');
INSERT INTO `admin_operation_log` VALUES (145, 1, 'topic', 'GET', '127.0.0.1', '[]', '2020-06-15 07:44:09', '2020-06-15 07:44:09');
INSERT INTO `admin_operation_log` VALUES (146, 1, 'topic_cat', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:44:14', '2020-06-15 07:44:14');
INSERT INTO `admin_operation_log` VALUES (147, 1, 'topic_post', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:44:17', '2020-06-15 07:44:17');
INSERT INTO `admin_operation_log` VALUES (148, 1, 'comment', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:44:23', '2020-06-15 07:44:23');
INSERT INTO `admin_operation_log` VALUES (149, 1, 'topic_post', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:44:25', '2020-06-15 07:44:25');
INSERT INTO `admin_operation_log` VALUES (150, 1, 'image', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:44:33', '2020-06-15 07:44:33');
INSERT INTO `admin_operation_log` VALUES (151, 1, 'image', 'GET', '127.0.0.1', '[]', '2020-06-15 07:44:55', '2020-06-15 07:44:55');
INSERT INTO `admin_operation_log` VALUES (152, 1, 'feedback', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:26', '2020-06-15 07:45:26');
INSERT INTO `admin_operation_log` VALUES (153, 1, 'user', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:28', '2020-06-15 07:45:28');
INSERT INTO `admin_operation_log` VALUES (154, 1, 'user_follow', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:30', '2020-06-15 07:45:30');
INSERT INTO `admin_operation_log` VALUES (155, 1, 'user_black', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:31', '2020-06-15 07:45:31');
INSERT INTO `admin_operation_log` VALUES (156, 1, 'user_follow', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:33', '2020-06-15 07:45:33');
INSERT INTO `admin_operation_log` VALUES (157, 1, 'user_black', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:35', '2020-06-15 07:45:35');
INSERT INTO `admin_operation_log` VALUES (158, 1, 'user_follow', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:45:36', '2020-06-15 07:45:36');
INSERT INTO `admin_operation_log` VALUES (159, 1, 'user_follow', 'GET', '127.0.0.1', '[]', '2020-06-15 07:46:03', '2020-06-15 07:46:03');
INSERT INTO `admin_operation_log` VALUES (160, 1, 'user_black', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:46:06', '2020-06-15 07:46:06');
INSERT INTO `admin_operation_log` VALUES (161, 1, 'user_follow', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:46:08', '2020-06-15 07:46:08');
INSERT INTO `admin_operation_log` VALUES (162, 1, 'user', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:46:10', '2020-06-15 07:46:10');
INSERT INTO `admin_operation_log` VALUES (163, 1, 'user', 'GET', '127.0.0.1', '[]', '2020-06-15 07:46:21', '2020-06-15 07:46:21');
INSERT INTO `admin_operation_log` VALUES (164, 1, 'user', 'GET', '127.0.0.1', '[]', '2020-06-15 07:52:03', '2020-06-15 07:52:03');
INSERT INTO `admin_operation_log` VALUES (165, 1, 'user', 'GET', '127.0.0.1', '[]', '2020-06-15 07:52:12', '2020-06-15 07:52:12');
INSERT INTO `admin_operation_log` VALUES (166, 1, 'user', 'GET', '127.0.0.1', '[]', '2020-06-15 07:52:33', '2020-06-15 07:52:33');
INSERT INTO `admin_operation_log` VALUES (167, 1, 'user_follow', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:52:39', '2020-06-15 07:52:39');
INSERT INTO `admin_operation_log` VALUES (168, 1, 'user_black', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:52:40', '2020-06-15 07:52:40');
INSERT INTO `admin_operation_log` VALUES (169, 1, 'feedback', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:52:41', '2020-06-15 07:52:41');
INSERT INTO `admin_operation_log` VALUES (170, 1, 'image', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:52:43', '2020-06-15 07:52:43');
INSERT INTO `admin_operation_log` VALUES (171, 1, 'image', 'GET', '127.0.0.1', '[]', '2020-06-15 07:53:09', '2020-06-15 07:53:09');
INSERT INTO `admin_operation_log` VALUES (172, 1, 'post', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2020-06-15 07:53:20', '2020-06-15 07:53:20');
INSERT INTO `admin_operation_log` VALUES (173, 1, 'post', 'GET', '127.0.0.1', '[]', '2020-06-17 00:44:33', '2020-06-17 00:44:33');
COMMIT;

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '所属id',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `order` smallint(6) DEFAULT NULL COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`),
  UNIQUE KEY `admin_permissions_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_permissions` VALUES (1, NULL, 'All permission', '*', '', '*', NULL, NULL, NULL);
INSERT INTO `admin_permissions` VALUES (2, NULL, 'Dashboard', 'dashboard', 'GET', '/', NULL, NULL, NULL);
INSERT INTO `admin_permissions` VALUES (3, NULL, 'Login', 'auth.login', '', '/auth/login\r\n/auth/logout', NULL, NULL, NULL);
INSERT INTO `admin_permissions` VALUES (4, NULL, 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', NULL, NULL, NULL);
INSERT INTO `admin_permissions` VALUES (5, NULL, 'Auth management', 'auth.management', '', '/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_menu` VALUES (1, 1, 2, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_permissions` VALUES (1, 1, 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_role_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_users` VALUES (1, 1, 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_name_unique` (`name`),
  UNIQUE KEY `admin_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
BEGIN;
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', '2020-06-15 00:40:36', '2020-06-15 00:40:36');
COMMIT;

-- ----------------------------
-- Table structure for admin_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_permissions`;
CREATE TABLE `admin_user_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_users` VALUES (1, 'admin', '$2y$10$PvBXdbhotXNTGfl1iRNjy.tOyLFXGq8tjIUhuTX7laq54lfkG8VPC', 'Administrator', NULL, 'ReiyzvmQm6DKd9QcIAEeMKFev41WGaRWOkdbCtRk39K92dE8J3KZ3JCSy88o', '2020-06-15 00:40:36', '2020-06-15 00:40:36');
COMMIT;

-- ----------------------------
-- Table structure for ads
-- ----------------------------
DROP TABLE IF EXISTS `ads`;
CREATE TABLE `ads` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `url` varchar(255) NOT NULL COMMENT '地址',
  `image` varchar(255) NOT NULL COMMENT '图片地址',
  `position` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '广告位',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1=上线，2=上线',
  `created_at` int(10) unsigned NOT NULL COMMENT '添加时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='广告表';

-- ----------------------------
-- Records of ads
-- ----------------------------
BEGIN;
INSERT INTO `ads` VALUES (1, '广告1', 'http://www.baidu.com', 'uploads/banner1.jpg', 1, 1, 1, 123, 123);
INSERT INTO `ads` VALUES (2, '广告2', 'http://www.baidu.com', 'uploads/banner2.jpg', 1, 2, 1, 123, 123);
INSERT INTO `ads` VALUES (3, '广告3', 'http://www.baidu.com', 'uploads/banner3.jpg', 1, 3, 1, 123, 123);
INSERT INTO `ads` VALUES (4, '广告4', 'http://www.baidu.com', 'uploads/bg.jpg', 2, 1, 1, 123, 123);
COMMIT;

-- ----------------------------
-- Table structure for ads_position
-- ----------------------------
DROP TABLE IF EXISTS `ads_position`;
CREATE TABLE `ads_position` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '广告位名',
  `is_release` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='广告位';

-- ----------------------------
-- Records of ads_position
-- ----------------------------
BEGIN;
INSERT INTO `ads_position` VALUES (1, '首页banner', 1);
INSERT INTO `ads_position` VALUES (2, '我的banner', 1);
COMMIT;

-- ----------------------------
-- Table structure for cat
-- ----------------------------
DROP TABLE IF EXISTS `cat`;
CREATE TABLE `cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(5) NOT NULL COMMENT '分类名',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cat
-- ----------------------------
BEGIN;
INSERT INTO `cat` VALUES (1, '游戏', 0);
INSERT INTO `cat` VALUES (2, '文艺', 0);
INSERT INTO `cat` VALUES (3, '体育', 0);
INSERT INTO `cat` VALUES (4, '历史', 0);
INSERT INTO `cat` VALUES (5, '财经', 0);
INSERT INTO `cat` VALUES (6, '娱乐', 0);
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL COMMENT '动态帖子id',
  `user_id` int(11) unsigned NOT NULL COMMENT '发布人',
  `reply_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复人id',
  `reply_root` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复根节点',
  `content` varchar(225) NOT NULL COMMENT '内容',
  `created_at` int(11) unsigned NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=644 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES (624, 386, 403, 0, 0, 'aaaa', 1592961187);
INSERT INTO `comment` VALUES (625, 386, 403, 0, 0, '回复你很高兴', 1592963154);
INSERT INTO `comment` VALUES (626, 386, 403, 625, 625, '来来来', 1592963208);
INSERT INTO `comment` VALUES (627, 386, 403, 625, 625, '再回复你', 1592963607);
INSERT INTO `comment` VALUES (628, 386, 403, 627, 625, '啊', 1592963640);
INSERT INTO `comment` VALUES (629, 386, 403, 0, 0, '哈哈哈哈哈啊哈哈啊哈哈哈啊哈哈哈啊哈哈哈哈哈哈哈', 1592977739);
INSERT INTO `comment` VALUES (630, 386, 403, 629, 0, '今天你要嫁给我', 1592977780);
INSERT INTO `comment` VALUES (631, 386, 403, 0, 0, '今天你要嫁给我', 1592977975);
INSERT INTO `comment` VALUES (632, 386, 403, 0, 0, '来啊', 1592977998);
INSERT INTO `comment` VALUES (633, 386, 403, 632, 632, 'aaaa', 1592978173);
INSERT INTO `comment` VALUES (634, 386, 403, 631, 631, 'aaaaaa', 1592978180);
INSERT INTO `comment` VALUES (635, 386, 403, 631, 631, 'bbbbbb', 1592978185);
INSERT INTO `comment` VALUES (636, 386, 403, 633, 632, 'cccc', 1592978195);
INSERT INTO `comment` VALUES (637, 392, 402, 0, 0, 'aaaaa', 1593340050);
INSERT INTO `comment` VALUES (638, 392, 402, 0, 0, 'sdfasdf', 1593854672);
INSERT INTO `comment` VALUES (639, 392, 402, 637, 637, 'dfdf', 1593854678);
INSERT INTO `comment` VALUES (640, 397, 403, 0, 0, 'asdfasd', 1597744454);
INSERT INTO `comment` VALUES (641, 397, 403, 0, 0, 'asdfasdf', 1597744459);
INSERT INTO `comment` VALUES (642, 397, 403, 640, 640, 'asdf', 1597744465);
INSERT INTO `comment` VALUES (643, 410, 403, 0, 0, '天气**好啊', 1597826526);
COMMIT;

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `content` varchar(255) NOT NULL COMMENT '内容',
  `created_at` int(11) unsigned NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='反馈表';

-- ----------------------------
-- Records of feedback
-- ----------------------------
BEGIN;
INSERT INTO `feedback` VALUES (71, 403, '分类一:asdfasd', 1597823595);
COMMIT;

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `path` varchar(255) NOT NULL COMMENT '资源地址',
  `filename` varchar(255) NOT NULL COMMENT '文件名',
  `mime_type` varchar(10) NOT NULL COMMENT '文件类型',
  `size` int(10) unsigned NOT NULL COMMENT '文件大小',
  `file_md5` varchar(255) NOT NULL COMMENT '文件MD5值',
  `created_at` int(11) unsigned NOT NULL COMMENT '添加时间',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '图片类型，0=动态，1=头像',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_file_md5` (`file_md5`)
) ENGINE=InnoDB AUTO_INCREMENT=1057 DEFAULT CHARSET=utf8 COMMENT='资源图片表';

-- ----------------------------
-- Records of image
-- ----------------------------
BEGIN;
INSERT INTO `image` VALUES (985, 402, 'uploads/20206/19/3f313eecd63e0d3399abc1c611db7b0e.jpeg', '3f313eecd63e0d3399abc1c611db7b0e.jpeg', 'jpg', 12528, '3f313eecd63e0d3399abc1c611db7b0e', 1592530977, 0);
INSERT INTO `image` VALUES (986, 402, 'uploads/20206/19/c0b005cc136c1be574ee6e9b503dfbe6.jpeg', 'timg (6).jpeg', 'jpg', 1936071, 'c0b005cc136c1be574ee6e9b503dfbe6', 1592530979, 0);
INSERT INTO `image` VALUES (987, 402, 'uploads/20206/19/6374dafa0fec3bc6e93c71b00c19512c.gif', '6374dafa0fec3bc6e93c71b00c19512c2729.gif', 'gif', 1688268, '6374dafa0fec3bc6e93c71b00c19512c', 1592530979, 0);
INSERT INTO `image` VALUES (988, 402, 'uploads/20206/19/d9f8544bffe42331cdce05aa73f1d8ce.gif', 'd9f8544bffe42331cdce05aa73f1d8ce.gif', 'gif', 922484, 'd9f8544bffe42331cdce05aa73f1d8ce', 1592530980, 0);
INSERT INTO `image` VALUES (989, 402, 'uploads/20206/19/9c081e97f5b09d40dbe59225600eeae8.jpeg', '9c081e97f5b09d40dbe59225600eeae8.jpeg', 'jpg', 74491, '9c081e97f5b09d40dbe59225600eeae8', 1592531004, 0);
INSERT INTO `image` VALUES (990, 402, 'uploads/20206/19/85a473e047c77e7501889d1b19a9f794.jpeg', 'timg (1).jpeg', 'jpg', 482332, '85a473e047c77e7501889d1b19a9f794', 1592531005, 0);
INSERT INTO `image` VALUES (991, 402, 'uploads/20206/19/e9a9831bfa16d2ddb43aea0a54284c1c.jpeg', 'timg (2).jpeg', 'jpg', 266680, 'e9a9831bfa16d2ddb43aea0a54284c1c', 1592531005, 0);
INSERT INTO `image` VALUES (992, 402, 'uploads/20206/19/fb2f07b54d3f48979b5da273f00dff24.jpeg', 'timg (3).jpeg', 'jpg', 141483, 'fb2f07b54d3f48979b5da273f00dff24', 1592531005, 0);
INSERT INTO `image` VALUES (993, 402, 'uploads/20206/19/c704abe01d1dc8ac6d1b1348262262bf.jpeg', 'timg (4).jpeg', 'jpg', 81455, 'c704abe01d1dc8ac6d1b1348262262bf', 1592531042, 0);
INSERT INTO `image` VALUES (994, 402, 'uploads/20206/19/0560048e172db4162e4a8deffe47aa9b.jpeg', 'timg (5).jpeg', 'jpg', 53889, '0560048e172db4162e4a8deffe47aa9b', 1592531042, 0);
INSERT INTO `image` VALUES (995, 402, 'uploads/20206/19/4624edddb31e652f85339602bd34e26b.jpeg', 'timg (7).jpeg', 'jpg', 261336, '4624edddb31e652f85339602bd34e26b', 1592531043, 0);
INSERT INTO `image` VALUES (996, 402, 'uploads/20206/19/961704d983eed29b8ca1aa409d95cbae.jpeg', 'timg (8).jpeg', 'jpg', 90964, '961704d983eed29b8ca1aa409d95cbae', 1592531043, 0);
INSERT INTO `image` VALUES (997, 402, 'uploads/20206/19/c45e3cdeea82ec7ebfb9962a7f638b96.jpeg', 'timg (9).jpeg', 'jpg', 141890, 'c45e3cdeea82ec7ebfb9962a7f638b96', 1592531068, 0);
INSERT INTO `image` VALUES (998, 402, 'uploads/20206/19/8687d7f789f3f4dfdc0ddd1d6695c727.jpeg', 'timg (10).jpeg', 'jpg', 158553, '8687d7f789f3f4dfdc0ddd1d6695c727', 1592531068, 0);
INSERT INTO `image` VALUES (999, 402, 'uploads/20206/19/3c0c27c258b072cb343cc633ad7ad3fd.jpeg', 'timg.jpeg', 'jpg', 133422, '3c0c27c258b072cb343cc633ad7ad3fd', 1592531068, 0);
INSERT INTO `image` VALUES (1000, 402, 'uploads/20206/19/9d2bf1c0bd9cb511a61e146b18fa1eee.jpg', 'u=350409649,190622771&fm=26&gp=0.jpg', 'jpg', 23805, '9d2bf1c0bd9cb511a61e146b18fa1eee', 1592531068, 0);
INSERT INTO `image` VALUES (1001, 402, 'uploads/20206/19/6005597b87c7c80047af5777140c135b.jpg', 'u=1403910161,1206491917&fm=26&gp=0.jpg', 'jpg', 55469, '6005597b87c7c80047af5777140c135b', 1592531068, 0);
INSERT INTO `image` VALUES (1002, 402, 'uploads/20206/19/6a94a55165822a35c831ec30c5d0f605.jpg', 'u=1841706113,1931852008&fm=26&gp=0.jpg', 'jpg', 28597, '6a94a55165822a35c831ec30c5d0f605', 1592531088, 0);
INSERT INTO `image` VALUES (1003, 402, 'uploads/20206/19/0d458b84441a7929ede27aa09ae2ce9a.jpg', 'u=2302679721,3436768324&fm=26&gp=0.jpg', 'jpg', 37450, '0d458b84441a7929ede27aa09ae2ce9a', 1592531088, 0);
INSERT INTO `image` VALUES (1004, 402, 'uploads/20206/19/b3a51e7026f36d54f3788bc4e8d1c957.jpg', 'u=2643417733,2703946506&fm=26&gp=0.jpg', 'jpg', 38242, 'b3a51e7026f36d54f3788bc4e8d1c957', 1592531088, 0);
INSERT INTO `image` VALUES (1005, 403, 'uploads/20206/20/095f77f1129c4e999222ae753aa4cd51.jpeg', 'u=1852642673,3549834491&fm=173&s=2F1303C746420F5DD809A52F0300F013&w=580&h=440&img.jpeg', 'jpg', 31996, '095f77f1129c4e999222ae753aa4cd51', 1592649111, 0);
INSERT INTO `image` VALUES (1006, 403, 'uploads/20206/20/778570b4bf166d4b6fff4882a930273b.jpeg', 'u=2213620505,1083935165&fm=173&s=DA202FC6C22302B49E86C9280300F053&w=640&h=480&img.jpeg', 'jpg', 40027, '778570b4bf166d4b6fff4882a930273b', 1592649111, 0);
INSERT INTO `image` VALUES (1007, 403, 'uploads/20206/20/95ec88f800283a26f4c6488cce5a71e2.jpeg', 'u=3426601195,1266486604&fm=173&s=70BB3ED58E2305010291E43D0300F060&w=500&h=240&img.jpeg', 'jpg', 21620, '95ec88f800283a26f4c6488cce5a71e2', 1592649111, 0);
INSERT INTO `image` VALUES (1008, 403, 'uploads/20206/20/2f9f5cc00d5ebf85b7f7be463754579c.jpeg', 'u=3669142527,2830544914&fm=173&s=2EF05285CA5A18DC70FCCD980300E013&w=500&h=375&img.jpeg', 'jpg', 26824, '2f9f5cc00d5ebf85b7f7be463754579c', 1592649111, 0);
INSERT INTO `image` VALUES (1009, 403, 'uploads/20206/20/d12d0dba185d552f76482629abb5c222.jpeg', 'u=2329818994,3975021634&fm=173&s=2C78609206A00AB54D145D06030070E1&w=640&h=360&img.jpeg', 'jpg', 44153, 'd12d0dba185d552f76482629abb5c222', 1592649111, 0);
INSERT INTO `image` VALUES (1010, 403, 'uploads/20206/22/469cce3f8ce40833ab36ca7284ded489.jpeg', '767ea22721a2421e8ad4862480d30f45.jpeg', 'jpg', 17867, '469cce3f8ce40833ab36ca7284ded489', 1592828699, 0);
INSERT INTO `image` VALUES (1011, 403, 'uploads/20206/23/1eb02ce7b3218bead5287315d655708b.jpeg', '722ffe515f314c85ab2256d5918d90df.jpeg', 'jpg', 62210, '1eb02ce7b3218bead5287315d655708b', 1592873901, 0);
INSERT INTO `image` VALUES (1012, 403, 'uploads/20206/23/8cddf41d7fa9ce1d807d11e1e2ef7444.jpeg', '8.jpeg', 'jpg', 35900, '8cddf41d7fa9ce1d807d11e1e2ef7444', 1592874547, 0);
INSERT INTO `image` VALUES (1013, 403, 'uploads/20206/23/856b6b5ba518c528b360138ba9986cd2.jpeg', 'z1.jpeg', 'jpg', 10949, '856b6b5ba518c528b360138ba9986cd2', 1592874563, 0);
INSERT INTO `image` VALUES (1014, 403, 'uploads/20206/23/59d8905d92f59738e42dc6d6aacb75a5.jpeg', 'z.jpeg', 'jpg', 16146, '59d8905d92f59738e42dc6d6aacb75a5', 1592874563, 0);
INSERT INTO `image` VALUES (1015, 403, 'uploads/20206/23/1a42dc678b080aad3298066183a18328.jpeg', 'z2.jpeg', 'jpg', 13553, '1a42dc678b080aad3298066183a18328', 1592874563, 0);
INSERT INTO `image` VALUES (1016, 403, 'uploads/20206/23/df29f7bc6198477cd8197b149de77367.jpeg', 'z3.jpeg', 'jpg', 17999, 'df29f7bc6198477cd8197b149de77367', 1592874563, 0);
INSERT INTO `image` VALUES (1017, 403, 'uploads/20206/23/889ec0ade07e7eb36e6352477ea1c794.jpeg', 'z4.jpeg', 'jpg', 13459, '889ec0ade07e7eb36e6352477ea1c794', 1592874563, 0);
INSERT INTO `image` VALUES (1018, 403, 'uploads/20206/23/e69f13ec25c1b426ff0ba6a241d7d4bd.jpeg', 'z6.jpeg', 'jpg', 22111, 'e69f13ec25c1b426ff0ba6a241d7d4bd', 1592874563, 0);
INSERT INTO `image` VALUES (1019, 403, 'uploads/20206/23/92927876129a56fe8841cfe742dc2961.jpeg', 'z7.jpeg', 'jpg', 24455, '92927876129a56fe8841cfe742dc2961', 1592874563, 0);
INSERT INTO `image` VALUES (1020, 403, 'uploads/20206/23/09d5bb39b8c89550981f70c565e6b620.jpeg', 'z5.jpeg', 'jpg', 19943, '09d5bb39b8c89550981f70c565e6b620', 1592874563, 0);
INSERT INTO `image` VALUES (1021, 403, 'uploads/20206/23/a5d0fb3064233612b1e207e587633fe5.jpeg', 'x2.jpeg', 'jpg', 42468, 'a5d0fb3064233612b1e207e587633fe5', 1592896327, 0);
INSERT INTO `image` VALUES (1022, 403, 'uploads/20206/23/b44cd27284857344e73c5ed34ad8958e.jpeg', 'x1.jpeg', 'jpg', 51617, 'b44cd27284857344e73c5ed34ad8958e', 1592896327, 0);
INSERT INTO `image` VALUES (1023, 403, 'uploads/20206/23/000e9e95e24cb0e6e8c5573b391e5e97.jpeg', 'x.jpeg', 'jpg', 87924, '000e9e95e24cb0e6e8c5573b391e5e97', 1592896327, 0);
INSERT INTO `image` VALUES (1024, 403, 'uploads/20206/23/c15103ca0942d2f95cb2691dace0d5a2.jpeg', 'j1.jpeg', 'jpg', 36851, 'c15103ca0942d2f95cb2691dace0d5a2', 1592896593, 0);
INSERT INTO `image` VALUES (1025, 403, 'uploads/20206/23/b9a90c69326cd122f5bfeff93099bb87.jpeg', 'j.jpeg', 'jpg', 43959, 'b9a90c69326cd122f5bfeff93099bb87', 1592896593, 0);
INSERT INTO `image` VALUES (1026, 403, 'uploads/20206/23/a43e44d20481e26a37c4374f8932ed7a.jpeg', 'j4.jpeg', 'jpg', 64527, 'a43e44d20481e26a37c4374f8932ed7a', 1592896593, 0);
INSERT INTO `image` VALUES (1027, 403, 'uploads/20206/23/337f0f1c88f618a22b9cf1df7b75bde3.jpeg', 'j3.jpeg', 'jpg', 52605, '337f0f1c88f618a22b9cf1df7b75bde3', 1592896593, 0);
INSERT INTO `image` VALUES (1028, 403, 'uploads/20206/23/36336aedfd2e030e78d97734db1dbded.jpeg', 'a.jpeg', 'jpg', 25606, '36336aedfd2e030e78d97734db1dbded', 1592896694, 0);
INSERT INTO `image` VALUES (1029, 403, 'uploads/20206/23/b59dfecb76beaf3c6a8d990e34a31dc1.jpeg', 'a1.jpeg', 'jpg', 35475, 'b59dfecb76beaf3c6a8d990e34a31dc1', 1592896694, 0);
INSERT INTO `image` VALUES (1030, 403, 'uploads/20206/23/8af4611bfecfe95361176cf29cc00321.jpeg', 'h1.jpeg', 'jpg', 11390, '8af4611bfecfe95361176cf29cc00321', 1592896813, 0);
INSERT INTO `image` VALUES (1031, 403, 'uploads/20206/23/55ed564c047b0bca4de69c16accdf759.jpeg', 'h2.jpeg', 'jpg', 14746, '55ed564c047b0bca4de69c16accdf759', 1592896813, 0);
INSERT INTO `image` VALUES (1032, 403, 'uploads/20206/23/6b67ea1d15face851af7feeecae889be.jpeg', 'h3.jpeg', 'jpg', 18788, '6b67ea1d15face851af7feeecae889be', 1592896813, 0);
INSERT INTO `image` VALUES (1033, 403, 'uploads/20206/23/79ef667a02d8cf969917c27583b35840.jpeg', 'h.jpeg', 'jpg', 37464, '79ef667a02d8cf969917c27583b35840', 1592896813, 0);
INSERT INTO `image` VALUES (1034, 403, 'uploads/20206/23/477617fd84f6c553f1ff191084617f12.jpeg', 'h4.jpeg', 'jpg', 29454, '477617fd84f6c553f1ff191084617f12', 1592896813, 0);
INSERT INTO `image` VALUES (1035, 403, 'uploads/20206/23/ef2760eb1f643e734790a2bef3f8da90.jpeg', 'h5.jpeg', 'jpg', 79580, 'ef2760eb1f643e734790a2bef3f8da90', 1592896813, 0);
INSERT INTO `image` VALUES (1036, 403, 'uploads/20206/23/d270b5480440acb2d6ecf3637eeca926.jpeg', 'zz1.jpeg', 'jpg', 35247, 'd270b5480440acb2d6ecf3637eeca926', 1592896898, 0);
INSERT INTO `image` VALUES (1037, 403, 'uploads/20206/23/b2fe609b5e519cd925a3a1f874edb18e.jpeg', 'zz.jpeg', 'jpg', 86893, 'b2fe609b5e519cd925a3a1f874edb18e', 1592896899, 0);
INSERT INTO `image` VALUES (1038, 403, 'uploads/20206/23/2aff68e8d68b8e580b7aaadde1360795.jpeg', 'zz2.jpeg', 'jpg', 85702, '2aff68e8d68b8e580b7aaadde1360795', 1592896899, 0);
INSERT INTO `image` VALUES (1039, 403, 'uploads/20206/23/7b1acf5e3258097ccafe84d35a2659b7.jpeg', 'q2.jpeg', 'jpg', 49288, '7b1acf5e3258097ccafe84d35a2659b7', 1592897017, 0);
INSERT INTO `image` VALUES (1040, 403, 'uploads/20206/23/56496d6d0ba633cdb40004722bff329b.jpeg', 'q3.jpeg', 'jpg', 28869, '56496d6d0ba633cdb40004722bff329b', 1592897017, 0);
INSERT INTO `image` VALUES (1041, 403, 'uploads/20206/23/b1cb6675ae47726fefe4665a30419969.jpeg', 'q1.jpeg', 'jpg', 111139, 'b1cb6675ae47726fefe4665a30419969', 1592897017, 0);
INSERT INTO `image` VALUES (1042, 403, 'uploads/20206/23/cbe9ab4d4cdca7c46450ff653f8aefb3.jpeg', 'q.jpeg', 'jpg', 92735, 'cbe9ab4d4cdca7c46450ff653f8aefb3', 1592897017, 0);
INSERT INTO `image` VALUES (1043, 403, 'uploads/20206/23/f876a97a904eea4b150adfe413b47767.jpeg', 'q5.jpeg', 'jpg', 243399, 'f876a97a904eea4b150adfe413b47767', 1592897017, 0);
INSERT INTO `image` VALUES (1044, 403, 'uploads/20206/23/31c983c810bfc024b76f67422f20e8c7.jpeg', 'q4.jpeg', 'jpg', 91558, '31c983c810bfc024b76f67422f20e8c7', 1592897017, 0);
INSERT INTO `image` VALUES (1045, 403, 'uploads/20206/23/3eb467840c7b3bbf00e72506f03923ab.jpeg', 'q6.jpeg', 'jpg', 22513, '3eb467840c7b3bbf00e72506f03923ab', 1592897017, 0);
INSERT INTO `image` VALUES (1046, 403, 'uploads/20206/23/b70238aafea54e83b0d232699782030d.jpeg', 's4.jpeg', 'jpg', 22016, 'b70238aafea54e83b0d232699782030d', 1592897204, 0);
INSERT INTO `image` VALUES (1047, 403, 'uploads/20206/23/b9c41d4080bb87a837a03be844a95f9a.jpeg', 's.jpeg', 'jpg', 59336, 'b9c41d4080bb87a837a03be844a95f9a', 1592897204, 0);
INSERT INTO `image` VALUES (1048, 403, 'uploads/20206/23/a49ed75fdb87165dd9dc38405fbef7a3.jpeg', 's1.jpeg', 'jpg', 51992, 'a49ed75fdb87165dd9dc38405fbef7a3', 1592897204, 0);
INSERT INTO `image` VALUES (1049, 403, 'uploads/20206/23/8993597791a39b2057e2972068d365c2.jpeg', 's5.jpeg', 'jpg', 38364, '8993597791a39b2057e2972068d365c2', 1592897204, 0);
INSERT INTO `image` VALUES (1050, 403, 'uploads/20206/23/ae802999a050fbba49b5f7bba6287eb6.jpeg', 's2.jpeg', 'jpg', 49943, 'ae802999a050fbba49b5f7bba6287eb6', 1592897204, 0);
INSERT INTO `image` VALUES (1051, 403, 'uploads/20206/23/fa2b4665084b68cc5d5f3b16b10ebf04.jpeg', 'bbbb.jpeg', 'jpg', 50740, 'fa2b4665084b68cc5d5f3b16b10ebf04', 1592897265, 0);
INSERT INTO `image` VALUES (1052, 403, 'uploads/20206/24/bc5a7a637bbbe1ab1ad646a051c8e1de.jpg', 'w.jpg', 'jpg', 32773, 'bc5a7a637bbbe1ab1ad646a051c8e1de', 1592978538, 0);
INSERT INTO `image` VALUES (1053, 403, 'uploads/20206/24/870f194796d921661c61a7cb9f993df1.jpeg', 'qqq.jpeg', 'jpg', 31014, '870f194796d921661c61a7cb9f993df1', 1592978807, 0);
COMMIT;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题id',
  `cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `user_id` int(11) unsigned NOT NULL COMMENT '发布人',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `content` varchar(10000) NOT NULL COMMENT '内容',
  `share_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分享次数',
  `location` varchar(255) NOT NULL DEFAULT '' COMMENT '位置',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1 动态 2帖子',
  `see_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '可见类型',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞次数',
  `unlike_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '踩次数',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论次数',
  `is_recommend` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `created_at` int(11) unsigned NOT NULL COMMENT '添加时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=414 DEFAULT CHARSET=utf8 COMMENT='动态帖子列表';

-- ----------------------------
-- Records of post
-- ----------------------------
BEGIN;
INSERT INTO `post` VALUES (350, 0, 0, 402, '今天天气很好', '今天天气很好', 0, '', 1, 0, 0, 0, 0, 0, 1592531702, 1592531702);
INSERT INTO `post` VALUES (353, 0, 0, 402, '哈哈哈哈哈', '哈哈哈哈哈', 0, '', 1, 0, 0, 0, 0, 0, 1592531879, 1592531879);
INSERT INTO `post` VALUES (354, 0, 0, 402, '今起乘火车离京将查验“7日内核酸检测阴性证明”', '今起乘火车离京将查验“7日内核酸检测阴性证明”', 0, '', 1, 0, 0, 0, 0, 0, 1592531939, 1592531939);
INSERT INTO `post` VALUES (355, 0, 0, 402, '6月18日0—24时，31个省（自治区、直辖市）和新疆生产建设兵团报告新增确诊病例32例，其中境外输入病例4例（广东3例，甘肃1例），本土病例28例（北京25例', '6月18日0—24时，31个省（自治区、直辖市）和新疆生产建设兵团报告新增确诊病例32例，其中境外输入病例4例（广东3例，甘肃1例），本土病例28例（北京25例，河北2例，辽宁1例）；无新增死亡病例；新增疑似病例2例，均为本土病例（均在北京）。\n\n当日新增治愈出院病例4例，解除医学观察的密切接触者227人，重症病例增加4例。\n\n境外输入现有确诊病例91例（无重症病例），无现有疑似病例。累计确诊病例1864例，累计治愈出院病例1773例，无死亡病例。\n\n截至6月18日24时，据31个省（自治区、直辖市）和新疆生产建设兵团报告，现有确诊病例293例（其中重症病例13例），累计治愈出院病例78398例，累计死亡病例4634例，累计报告确诊病例83325例，现有疑似病例7例。累计追踪到密切接触者755832人，尚在医学观察的密切接触者5856人。\n\n31个省（自治区、直辖市）和新疆生产建设兵团报告新增无症状感染者5例（无境外输入）；当日转为确诊病例2例（无境外输入）；当日解除医学观察4例（境外输入3例）；尚在医学观察无症状感染者110例（境外输入60例）', 0, '', 1, 0, 0, 0, 0, 0, 1592532177, 1592532177);
INSERT INTO `post` VALUES (356, 0, 0, 402, '中新网客户端6月19日消息，当日，教育部高校学生司介绍，今年高考报名达1071万人，比去年增加40万。全国将设考点7000余个、考场40万个，安排监考及考务人员', '中新网客户端6月19日消息，当日，教育部高校学生司介绍，今年高考报名达1071万人，比去年增加40万。全国将设考点7000余个、考场40万个，安排监考及考务人员94.5万人。可以说，今年高考是新冠肺炎疫情发生以来，全国范围内规模最大的一次有组织的集体性活动。\n\n而受到疫情等外界条件的影响，如果孩子2020年高考没有考好怎么办？小青下面提几点建议，希望能够帮助到各位考生家长？\n\n生活在疫情中，我们即将走向高考的时候，我们尤其要强调的就是需要稳定，我们不仅要稳定生活，还要稳定情绪，忙而不乱，你的生活要有规律有秩序，需要遵循有序的生活规律，日常你是怎么做的现在还怎么做，遵循自己的作息，不要打破规律，按部就班往前走，这个过程会让我们感到稳定，不至于出现过度的焦虑和紧张，所以生活要有序安排。\n\n2020年高考没有考好，家长可以选择让孩子复读一年或者选择职业教育培训。高考并不是人生当中唯一的一条出路，并不是说高考没有考好，孩子的人生就失败了，有些人高考落榜，甚至没有参加过高考，但通过自己的努力和拼搏，也能够在社会上闯出属于自己的一片天地。', 0, '', 1, 0, 0, 0, 0, 0, 1592532270, 1592532270);
INSERT INTO `post` VALUES (357, 0, 0, 402, '　全球累计确诊新冠肺炎病例近842万例。（图源：美联社）\n\n　　海外网6月19日电美国约翰斯·霍普金斯大学发布的实时统计数据显示，截至北京时间6月19日6时30', '　全球累计确诊新冠肺炎病例近842万例。（图源：美联社）\n\n　　海外网6月19日电美国约翰斯·霍普金斯大学发布的实时统计数据显示，截至北京时间6月19日6时30分左右，全球累计确诊新冠肺炎病例8421357例，累计死亡451118例。\n\n　　全球疫情持续蔓延，多个国家抗疫形势不容乐观。美洲方面，在重启经济后，专家预计美国新冠病毒感染第二次高峰正在到来。而巴西疫情依然严峻，新冠病毒已蔓延至亚马逊丛林。德国、法国、英国等欧洲国家则在进一步推进相关疫苗研发。\n\n　　美国累计确诊2182285例 专家预测疫情第二次高峰正在到来\n\n　　美国约翰斯·霍普金斯大学发布的疫情数据显示，截至北京时间6月19日6时30分左右，美国累计确诊2182285例，累计死亡118296例。与前一日6时30分数据相比，美国新增确诊病例22839例，新增死亡病例633例。\n\n　　当前，美国多个州新冠肺炎确诊病例数继续攀升。据美国有线电视新闻网统计，21个州在过去数周出现新冠病毒感染确诊案例增加，8个州保持稳定。目前美国各地均开始了不同程度重启，专家预计新冠病毒感染第二次高峰正在到来。\n\n　　意大利累计确诊238159例 50万学生戴口罩高考', 0, '', 1, 0, 0, 0, 0, 0, 1592532339, 1592532339);
INSERT INTO `post` VALUES (358, 0, 0, 402, '我的热情好像一把火', '我的热情好像一把火', 0, '', 1, 0, 0, 0, 0, 0, 1592532368, 1592532368);
INSERT INTO `post` VALUES (359, 0, 0, 402, '今天星期五，明天星期六，但我不放假', '今天星期五，明天星期六，但我不放假', 0, '', 1, 0, 0, 1, 0, 0, 1592532389, 1592877495);
INSERT INTO `post` VALUES (360, 0, 0, 402, '我是一个小小鸟，可是怎么也飞不高', '我是一个小小鸟，可是怎么也飞不高', 0, '', 1, 0, 0, 0, 0, 0, 1592532411, 1592532411);
INSERT INTO `post` VALUES (361, 0, 0, 402, '学习中.。。。。。', '学习中.。。。。。', 0, '', 1, 0, 0, 0, 0, 0, 1592532421, 1592532421);
INSERT INTO `post` VALUES (363, 0, 0, 402, 'aaa', 'aaa', 0, '', 1, 0, 0, 1, 0, 0, 1592638336, 1592979419);
INSERT INTO `post` VALUES (365, 0, 0, 402, '啊啊啊啊噢噢噢噢', '啊啊啊啊噢噢噢噢', 0, '', 1, 0, 1, 0, 0, 0, 1592638708, 1592979453);
INSERT INTO `post` VALUES (367, 0, 0, 403, '我们一起测试吧', '我们一起测试吧', 0, '', 1, 0, 0, 0, 0, 0, 1592648378, 1592648378);
INSERT INTO `post` VALUES (368, 0, 0, 403, '我们都是好孩子，说好一起走', '我们都是好孩子，说好一起走', 0, '', 1, 0, 0, 0, 0, 0, 1592648414, 1592648414);
INSERT INTO `post` VALUES (369, 0, 0, 403, '啊哈哈，哦嚯嚯', '啊哈哈，哦嚯嚯', 0, '', 1, 0, 0, 0, 0, 0, 1592648430, 1592648430);
INSERT INTO `post` VALUES (370, 0, 0, 403, '今天星期六，放假啦，但怎么似乎好像大概不怎么高兴呢', '今天星期六，放假啦，但怎么似乎好像大概不怎么高兴呢', 0, '', 1, 0, 0, 0, 0, 0, 1592648468, 1592648468);
INSERT INTO `post` VALUES (371, 0, 0, 403, '天若有情天亦老，只是当时已惘然', '天若有情天亦老，只是当时已惘然', 0, '', 1, 0, 0, 0, 0, 0, 1592648732, 1592648732);
INSERT INTO `post` VALUES (372, 0, 0, 403, '在天愿作比翼鸟，在地愿为连理枝', '在天愿作比翼鸟，在地愿为连理枝', 0, '', 1, 0, 0, 0, 0, 0, 1592648800, 1592648800);
INSERT INTO `post` VALUES (373, 0, 0, 403, '人生若只如初见，何事秋风悲画扇？\n\n等闲变却故人心，却道故人心易变。\n\n骊山语罢清宵半，泪雨零铃终不怨。\n\n何如薄幸锦衣郎，比翼连枝当日愿。', '人生若只如初见，何事秋风悲画扇？\n\n等闲变却故人心，却道故人心易变。\n\n骊山语罢清宵半，泪雨零铃终不怨。\n\n何如薄幸锦衣郎，比翼连枝当日愿。', 0, '', 1, 0, 0, 0, 0, 0, 1592649119, 1592649119);
INSERT INTO `post` VALUES (374, 0, 0, 403, '我是人间惆怅客,\n\n知君何事泪纵横,\n\n断肠声里忆平生。', '我是人间惆怅客,\n\n知君何事泪纵横,\n\n断肠声里忆平生。', 0, '', 1, 0, 0, 1, 0, 0, 1592649221, 1592820244);
INSERT INTO `post` VALUES (375, 0, 0, 403, '曾看到过这样一句话：不要去等明天，不要去相信永远，你所能做的，就是眼前。你所爱，为你所为。没有人会等你，在这风雨飘摇的人生路上。', '曾看到过这样一句话：不要去等明天，不要去相信永远，你所能做的，就是眼前。你所爱，为你所为。没有人会等你，在这风雨飘摇的人生路上。', 0, '', 1, 0, 0, 0, 0, 0, 1592828701, 1592828701);
INSERT INTO `post` VALUES (376, 0, 2, 403, '生命中无数个精彩瞬间，因为等待而变得更加宝贵和镌骨铭心。虽然时间有长有短，但愿结果总能顺遂人心。', '生命中无数个精彩瞬间，因为等待而变得更加宝贵和镌骨铭心。虽然时间有长有短，但愿结果总能顺遂人心。', 0, '', 1, 0, 0, 0, 0, 0, 1592873910, 1592873910);
INSERT INTO `post` VALUES (377, 0, 2, 403, '人生有两大哀叹：一叹知己难求，二叹世事无常。\n\n我们明白，这一生会接触许多人，会经历了许多事，唯独有一样东西不想触碰，那便是——无常。', '人生有两大哀叹：一叹知己难求，二叹世事无常。\n\n我们明白，这一生会接触许多人，会经历了许多事，唯独有一样东西不想触碰，那便是——无常。', 0, '', 1, 0, 0, 0, 0, 0, 1592874565, 1592874565);
INSERT INTO `post` VALUES (378, 4, 0, 403, '【 宋】 刘克庄\n\n纤云扫迹，万顷玻璃色。\n\n醉跨玉龙游八极，历历天青海碧。\n\n水晶宫殿飘香，群仙方按霓裳。\n\n消得几多风露，变教人世清凉。', '【 宋】 刘克庄\n\n纤云扫迹，万顷玻璃色。\n\n醉跨玉龙游八极，历历天青海碧。\n\n水晶宫殿飘香，群仙方按霓裳。\n\n消得几多风露，变教人世清凉。', 0, '', 2, 0, 1, 0, 0, 0, 1592896332, 1592905899);
INSERT INTO `post` VALUES (379, 4, 0, 403, '家庭是块责任田，\n\n肥也是田，瘦也是田；\n\n辛勤耕耘不偷懒，\n\n丰也喜欢，欠也喜欢。\n\n俗话说：金窝银窝，不如自己的狗窝。\n\n家，无关大小，舒适即可；无关美丑，', '家庭是块责任田，\n\n肥也是田，瘦也是田；\n\n辛勤耕耘不偷懒，\n\n丰也喜欢，欠也喜欢。\n\n俗话说：金窝银窝，不如自己的狗窝。\n\n家，无关大小，舒适即可；无关美丑，温暖则佳。\n\n冰心说：一个美好的家庭，是一切幸福和力量的根源。\n\n家，是我们心灵的寄托，是精神的支撑，是一生的归宿地。\n', 0, '', 2, 0, 0, 0, 0, 0, 1592896597, 1592896597);
INSERT INTO `post` VALUES (380, 5, 0, 403, '1、幸福跟幸福感是两码事，幸福是别人看着你各种好 ，对你各种羡慕，你该有的都有，所谓的幸福感是发自内心的，如果再给你一次机会，是不是觉得自己过得是那样的满意，所', '1、幸福跟幸福感是两码事，幸福是别人看着你各种好 ，对你各种羡慕，你该有的都有，所谓的幸福感是发自内心的，如果再给你一次机会，是不是觉得自己过得是那样的满意，所谓的幸福感就是再给你一次机会，你是不是还会选择今天的生活，是不是还会选择这样一个人，看到他时是不是会充满怜爱的想去触摸，', 0, '', 2, 0, 0, 0, 0, 0, 1592896695, 1592896695);
INSERT INTO `post` VALUES (381, 4, 0, 403, '汉字是中文的基础，也是五千年文化的载体。\n\n无论是沟通、学习还是传承，认字都是必要的步骤。\n\n但是很多字你认识了，连在一起就未必能读懂了！不信？来看看吧！\n\n0', '汉字是中文的基础，也是五千年文化的载体。\n\n无论是沟通、学习还是传承，认字都是必要的步骤。\n\n但是很多字你认识了，连在一起就未必能读懂了！不信？来看看吧！\n\n01\n\n舌头打结的汉字\n\n听说您语文好，请来读读试试：\n\n1.这几 天天天天气不好。\n\n2.我有一个小 本本本来很干净。', 0, '', 2, 0, 0, 0, 0, 0, 1592896817, 1592896817);
INSERT INTO `post` VALUES (382, 4, 0, 403, '所谓“感受”是被动的，是容许自然界事物感动我的感官和心灵。\n\n这两个字涵义极广。\n\n眼见颜色，耳闻声音，是感受；\n\n见颜色而知其美，闻声音而知其和，也是感受。\n', '所谓“感受”是被动的，是容许自然界事物感动我的感官和心灵。\n\n这两个字涵义极广。\n\n眼见颜色，耳闻声音，是感受；\n\n见颜色而知其美，闻声音而知其和，也是感受。\n\n同一美颜，同一和声，而各个人所见到的美与和的程度又随天资境遇而不同。\n\n比方路边有一棵苍松，你看见它只觉得可以砍来造船', 0, '', 2, 0, 0, 0, 0, 0, 1592896902, 1592896902);
INSERT INTO `post` VALUES (383, 4, 0, 403, '说到惊艳的诗句，一千个人心中，有一千个答案。\n\n有人惊艳于 “愿我如星君如月，夜夜流光相皎洁”的爱情，\n\n有人惊艳于 “日暮酒醒人已远，满天风雨下西楼”的友情，', '说到惊艳的诗句，一千个人心中，有一千个答案。\n\n有人惊艳于 “愿我如星君如月，夜夜流光相皎洁”的爱情，\n\n有人惊艳于 “日暮酒醒人已远，满天风雨下西楼”的友情，\n\n有人惊艳于 “荷风送香气，竹露滴清响”的自然美景', 0, '', 2, 0, 0, 0, 0, 0, 1592897019, 1592897019);
INSERT INTO `post` VALUES (384, 4, 0, 403, '杜甫是唐朝和李白齐名的大诗人，他出身于一个书香门第，祖父是初唐“文章四友”之首的杜审言，母亲崔氏也是名门望族之后。\n\n所以杜甫也曾有过富贵无忧的青少年生活，只是', '杜甫是唐朝和李白齐名的大诗人，他出身于一个书香门第，祖父是初唐“文章四友”之首的杜审言，母亲崔氏也是名门望族之后。\n\n所以杜甫也曾有过富贵无忧的青少年生活，只是后来家道中落，再加上连年的战乱，使得他穷困潦倒。\n\n公元755年，安史之乱爆发，当时的杜甫因为回乡探亲，所以躲过了一劫。', 0, '', 2, 0, 1, 0, 0, 0, 1592897090, 1597744437);
INSERT INTO `post` VALUES (385, 4, 0, 403, '林语堂先生在《苏东坡传》中写道：“一提到苏东坡，中国人总是亲切而温暖地会心一笑。”\n\n这大概就是对苏东坡最好的诠释。\n\n\n\n苏轼因“乌台诗案”被贬为黄州团练副使', '林语堂先生在《苏东坡传》中写道：“一提到苏东坡，中国人总是亲切而温暖地会心一笑。”\n\n这大概就是对苏东坡最好的诠释。\n\n\n\n苏轼因“乌台诗案”被贬为黄州团练副使时，与朋友出门游玩，忽降大雨。\n\n同伴狼狈躲雨，只有苏轼依旧缓步前行，昂头高歌：回首向来萧瑟处，归去，也无风雨也无晴。\n', 0, '', 1, 0, 0, 1, 0, 0, 1592897124, 1597744434);
INSERT INTO `post` VALUES (386, 4, 0, 403, '我们常说，字如其人，其实诗词也是如此。\n\n读懂一首诗或者词，便读懂了其中的情，也便读懂了一个人。\n\n一如写下“安得广厦千万间，大庇天下寒士俱欢颜”的杜甫，忧国忧', '我们常说，字如其人，其实诗词也是如此。\n\n读懂一首诗或者词，便读懂了其中的情，也便读懂了一个人。\n\n一如写下“安得广厦千万间，大庇天下寒士俱欢颜”的杜甫，忧国忧民；\n\n一如写下“天生我材必有用，千金散尽还复来”的李白，潇洒不羁；\n\n一如写下“醉里挑灯看剑，梦回吹角连营”的辛弃疾，', 0, '', 2, 0, 0, 1, 13, 0, 1592897206, 1592978195);
INSERT INTO `post` VALUES (387, 4, 0, 403, '轻汗微微透碧纨，明朝端午浴芳兰。流香涨腻满晴川。\n\n彩线轻缠红玉臂，小符斜挂绿云鬟。佳人相见一千年。', '轻汗微微透碧纨，明朝端午浴芳兰。流香涨腻满晴川。\n\n彩线轻缠红玉臂，小符斜挂绿云鬟。佳人相见一千年。', 0, '', 2, 0, 0, 1, 0, 1, 1592897266, 1592914613);
INSERT INTO `post` VALUES (388, 0, 1, 403, '作者：知乎用户\n链接：https://www.zhihu.com/question/54916913/answer/190566353\n来源：知乎\n著作权归作者', '作者：知乎用户\n链接：https://www.zhihu.com/question/54916913/answer/190566353\n来源：知乎\n著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。\n\n中间很久没玩这游戏了，这个赛季又重新开始玩。这回我玩的是司马', 0, '', 1, 0, 1, 0, 0, 0, 1592978560, 1593312197);
INSERT INTO `post` VALUES (389, 0, 4, 403, '《史记》记载甚详：“至平原津而病，始皇恶言死，群臣莫敢言死事。上病益甚，乃为玺书赐公子扶苏曰：‘与丧会咸阳而葬。’书已封，在中车府令赵高行符玺事所，未授使者。七', '《史记》记载甚详：“至平原津而病，始皇恶言死，群臣莫敢言死事。上病益甚，乃为玺书赐公子扶苏曰：‘与丧会咸阳而葬。’书已封，在中车府令赵高行符玺事所，未授使者。七月丙寅，始皇崩于沙丘平台。”\n\n平原津今属山东省德州市，是古黄河上重要渡口之一。沙丘位于今河北省邢台市广宗县大平台村南，', 0, '', 1, 0, 0, 1, 0, 0, 1592978811, 1592979924);
INSERT INTO `post` VALUES (390, 0, 0, 403, '今天还是端午节，可是。。。', '今天还是端午节，可是。。。', 0, '', 1, 0, 1, 0, 0, 0, 1593242959, 1597744397);
INSERT INTO `post` VALUES (391, 0, 0, 403, '今天有点不开森啊', '今天有点不开森啊', 0, '', 1, 0, 0, 2, 0, 0, 1593242981, 1597744394);
INSERT INTO `post` VALUES (392, 0, 0, 403, '今天早上天气时好时坏啊', '今天早上天气时好时坏啊', 0, '', 1, 0, 1, 1, 3, 0, 1593312646, 1593854678);
INSERT INTO `post` VALUES (393, 0, 0, 402, 'aaaaa', 'aaaaa', 0, '', 1, 0, 1, 0, 0, 0, 1593854709, 1597821564);
INSERT INTO `post` VALUES (394, 2, 0, 402, 'asdfsdf', 'asdfsdf', 0, '', 2, 0, 0, 1, 0, 0, 1593854733, 1597821567);
INSERT INTO `post` VALUES (395, 0, 0, 403, '我是人间', '我是人间', 0, '', 1, 0, 0, 0, 0, 0, 1597739225, 1597739225);
INSERT INTO `post` VALUES (396, 0, 0, 403, 'sgf', 'sgf', 0, '', 1, 0, 1, 0, 0, 0, 1597743988, 1597744426);
INSERT INTO `post` VALUES (397, 0, 0, 403, 'asdfasdf', 'asdfasdf', 0, '', 1, 0, 0, 1, 3, 0, 1597744044, 1597744471);
INSERT INTO `post` VALUES (406, 4, 2, 403, '天下大事', '天下大事', 0, '', 2, 0, 0, 0, 0, 0, 1597807684, 1597807684);
INSERT INTO `post` VALUES (407, 4, 0, 403, '今天天气不调好', '今天天气不调好', 0, '', 2, 0, 0, 0, 0, 0, 1597807706, 1597807706);
INSERT INTO `post` VALUES (408, 0, 0, 403, '我要一个小星星', '我要一个小星星', 0, '', 1, 0, 0, 0, 0, 0, 1597807716, 1597807716);
INSERT INTO `post` VALUES (409, 4, 0, 403, '我是天上红太阳', '我是天上红太阳', 0, '', 2, 0, 0, 0, 0, 0, 1597807729, 1597807729);
INSERT INTO `post` VALUES (410, 0, 0, 403, '今天**天气***大地我今天天气', '今天**天气***大地我今天天气', 0, '', 1, 0, 0, 0, 1, 0, 1597826304, 1597826526);
INSERT INTO `post` VALUES (411, 0, 0, 403, '我', '我', 0, '', 1, 0, 0, 0, 0, 0, 1597826356, 1597826356);
INSERT INTO `post` VALUES (412, 0, 0, 403, '天气', '天气', 0, '', 1, 0, 0, 0, 0, 0, 1597826384, 1597826384);
INSERT INTO `post` VALUES (413, 0, 0, 403, 'haha', 'haha', 0, '', 1, 0, 0, 0, 0, 0, 1597826497, 1597826497);
COMMIT;

-- ----------------------------
-- Table structure for post_like
-- ----------------------------
DROP TABLE IF EXISTS `post_like`;
CREATE TABLE `post_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '发布人',
  `post_id` int(10) unsigned NOT NULL COMMENT '帖子id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型，1=赞，2=踩',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_post` (`user_id`,`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=597 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_like
-- ----------------------------
BEGIN;
INSERT INTO `post_like` VALUES (577, 403, 374, 2);
INSERT INTO `post_like` VALUES (578, 403, 359, 2);
INSERT INTO `post_like` VALUES (579, 403, 365, 1);
INSERT INTO `post_like` VALUES (580, 403, 387, 2);
INSERT INTO `post_like` VALUES (581, 403, 378, 1);
INSERT INTO `post_like` VALUES (582, 403, 386, 2);
INSERT INTO `post_like` VALUES (583, 403, 388, 1);
INSERT INTO `post_like` VALUES (584, 403, 389, 2);
INSERT INTO `post_like` VALUES (585, 403, 363, 2);
INSERT INTO `post_like` VALUES (586, 403, 391, 2);
INSERT INTO `post_like` VALUES (587, 403, 392, 1);
INSERT INTO `post_like` VALUES (588, 0, 392, 2);
INSERT INTO `post_like` VALUES (589, 0, 391, 2);
INSERT INTO `post_like` VALUES (590, 403, 390, 1);
INSERT INTO `post_like` VALUES (591, 403, 397, 2);
INSERT INTO `post_like` VALUES (592, 403, 396, 1);
INSERT INTO `post_like` VALUES (593, 403, 385, 2);
INSERT INTO `post_like` VALUES (594, 403, 384, 1);
INSERT INTO `post_like` VALUES (595, 403, 393, 1);
INSERT INTO `post_like` VALUES (596, 403, 394, 2);
COMMIT;

-- ----------------------------
-- Table structure for post_rel_image
-- ----------------------------
DROP TABLE IF EXISTS `post_rel_image`;
CREATE TABLE `post_rel_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL COMMENT '动态id',
  `image_id` int(11) DEFAULT NULL COMMENT '图片id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of post_rel_image
-- ----------------------------
BEGIN;
INSERT INTO `post_rel_image` VALUES (6, 350, 985);
INSERT INTO `post_rel_image` VALUES (11, 353, 986);
INSERT INTO `post_rel_image` VALUES (12, 353, 987);
INSERT INTO `post_rel_image` VALUES (13, 354, 988);
INSERT INTO `post_rel_image` VALUES (14, 354, 989);
INSERT INTO `post_rel_image` VALUES (15, 354, 990);
INSERT INTO `post_rel_image` VALUES (16, 355, 991);
INSERT INTO `post_rel_image` VALUES (17, 355, 992);
INSERT INTO `post_rel_image` VALUES (18, 355, 993);
INSERT INTO `post_rel_image` VALUES (19, 355, 994);
INSERT INTO `post_rel_image` VALUES (20, 356, 998);
INSERT INTO `post_rel_image` VALUES (21, 356, 997);
INSERT INTO `post_rel_image` VALUES (22, 356, 996);
INSERT INTO `post_rel_image` VALUES (23, 356, 995);
INSERT INTO `post_rel_image` VALUES (24, 356, 999);
INSERT INTO `post_rel_image` VALUES (25, 357, 1000);
INSERT INTO `post_rel_image` VALUES (26, 357, 1001);
INSERT INTO `post_rel_image` VALUES (27, 357, 1002);
INSERT INTO `post_rel_image` VALUES (28, 357, 1003);
INSERT INTO `post_rel_image` VALUES (29, 357, 1004);
INSERT INTO `post_rel_image` VALUES (30, 357, 999);
INSERT INTO `post_rel_image` VALUES (31, 357, 998);
INSERT INTO `post_rel_image` VALUES (32, 357, 997);
INSERT INTO `post_rel_image` VALUES (33, 357, 996);
INSERT INTO `post_rel_image` VALUES (34, 365, 993);
INSERT INTO `post_rel_image` VALUES (35, 365, 994);
INSERT INTO `post_rel_image` VALUES (36, 365, 986);
INSERT INTO `post_rel_image` VALUES (37, 365, 996);
INSERT INTO `post_rel_image` VALUES (38, 365, 995);
INSERT INTO `post_rel_image` VALUES (39, 367, 991);
INSERT INTO `post_rel_image` VALUES (40, 367, 992);
INSERT INTO `post_rel_image` VALUES (41, 367, 993);
INSERT INTO `post_rel_image` VALUES (42, 367, 994);
INSERT INTO `post_rel_image` VALUES (43, 367, 995);
INSERT INTO `post_rel_image` VALUES (44, 367, 986);
INSERT INTO `post_rel_image` VALUES (45, 367, 996);
INSERT INTO `post_rel_image` VALUES (46, 368, 993);
INSERT INTO `post_rel_image` VALUES (47, 368, 994);
INSERT INTO `post_rel_image` VALUES (48, 370, 1002);
INSERT INTO `post_rel_image` VALUES (49, 370, 1001);
INSERT INTO `post_rel_image` VALUES (50, 371, 1001);
INSERT INTO `post_rel_image` VALUES (51, 372, 1004);
INSERT INTO `post_rel_image` VALUES (52, 373, 1005);
INSERT INTO `post_rel_image` VALUES (53, 373, 1006);
INSERT INTO `post_rel_image` VALUES (54, 373, 1007);
INSERT INTO `post_rel_image` VALUES (55, 373, 1008);
INSERT INTO `post_rel_image` VALUES (56, 373, 1009);
INSERT INTO `post_rel_image` VALUES (57, 374, 1005);
INSERT INTO `post_rel_image` VALUES (58, 374, 1009);
INSERT INTO `post_rel_image` VALUES (59, 375, 1010);
INSERT INTO `post_rel_image` VALUES (60, 376, 1011);
INSERT INTO `post_rel_image` VALUES (61, 376, 990);
INSERT INTO `post_rel_image` VALUES (62, 377, 1012);
INSERT INTO `post_rel_image` VALUES (63, 377, 1014);
INSERT INTO `post_rel_image` VALUES (64, 377, 1013);
INSERT INTO `post_rel_image` VALUES (65, 377, 1015);
INSERT INTO `post_rel_image` VALUES (66, 377, 1016);
INSERT INTO `post_rel_image` VALUES (67, 377, 1017);
INSERT INTO `post_rel_image` VALUES (68, 377, 1018);
INSERT INTO `post_rel_image` VALUES (69, 377, 1019);
INSERT INTO `post_rel_image` VALUES (70, 377, 1020);
INSERT INTO `post_rel_image` VALUES (71, 378, 1021);
INSERT INTO `post_rel_image` VALUES (72, 378, 1022);
INSERT INTO `post_rel_image` VALUES (73, 378, 1023);
INSERT INTO `post_rel_image` VALUES (74, 379, 1024);
INSERT INTO `post_rel_image` VALUES (75, 379, 1025);
INSERT INTO `post_rel_image` VALUES (76, 379, 1026);
INSERT INTO `post_rel_image` VALUES (77, 379, 1027);
INSERT INTO `post_rel_image` VALUES (78, 380, 1028);
INSERT INTO `post_rel_image` VALUES (79, 380, 1029);
INSERT INTO `post_rel_image` VALUES (80, 381, 1030);
INSERT INTO `post_rel_image` VALUES (81, 381, 1031);
INSERT INTO `post_rel_image` VALUES (82, 381, 1032);
INSERT INTO `post_rel_image` VALUES (83, 381, 1033);
INSERT INTO `post_rel_image` VALUES (84, 381, 1034);
INSERT INTO `post_rel_image` VALUES (85, 381, 1035);
INSERT INTO `post_rel_image` VALUES (86, 382, 1036);
INSERT INTO `post_rel_image` VALUES (87, 382, 1037);
INSERT INTO `post_rel_image` VALUES (88, 382, 1038);
INSERT INTO `post_rel_image` VALUES (89, 383, 1039);
INSERT INTO `post_rel_image` VALUES (90, 383, 1040);
INSERT INTO `post_rel_image` VALUES (91, 383, 1041);
INSERT INTO `post_rel_image` VALUES (92, 383, 1042);
INSERT INTO `post_rel_image` VALUES (93, 383, 1043);
INSERT INTO `post_rel_image` VALUES (94, 383, 1044);
INSERT INTO `post_rel_image` VALUES (95, 383, 1045);
INSERT INTO `post_rel_image` VALUES (96, 386, 1025);
INSERT INTO `post_rel_image` VALUES (97, 386, 1046);
INSERT INTO `post_rel_image` VALUES (98, 386, 1047);
INSERT INTO `post_rel_image` VALUES (99, 386, 1048);
INSERT INTO `post_rel_image` VALUES (100, 386, 1049);
INSERT INTO `post_rel_image` VALUES (101, 386, 1050);
INSERT INTO `post_rel_image` VALUES (102, 387, 1051);
INSERT INTO `post_rel_image` VALUES (103, 388, 1052);
INSERT INTO `post_rel_image` VALUES (104, 389, 1053);
INSERT INTO `post_rel_image` VALUES (105, 392, 1030);
INSERT INTO `post_rel_image` VALUES (106, 393, 1011);
INSERT INTO `post_rel_image` VALUES (107, 393, 1028);
INSERT INTO `post_rel_image` VALUES (108, 393, 1029);
INSERT INTO `post_rel_image` VALUES (109, 393, 1011);
INSERT INTO `post_rel_image` VALUES (110, 393, 989);
INSERT INTO `post_rel_image` VALUES (111, 393, 1051);
INSERT INTO `post_rel_image` VALUES (112, 393, 987);
INSERT INTO `post_rel_image` VALUES (113, 393, 988);
INSERT INTO `post_rel_image` VALUES (114, 393, 1010);
INSERT INTO `post_rel_image` VALUES (115, 394, 1020);
INSERT INTO `post_rel_image` VALUES (116, 394, 1018);
INSERT INTO `post_rel_image` VALUES (117, 394, 1019);
INSERT INTO `post_rel_image` VALUES (118, 394, 1037);
INSERT INTO `post_rel_image` VALUES (119, 395, 1011);
INSERT INTO `post_rel_image` VALUES (120, 396, 989);
INSERT INTO `post_rel_image` VALUES (121, 397, 1010);
INSERT INTO `post_rel_image` VALUES (122, 412, 1024);
COMMIT;

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL COMMENT '标题',
  `cover` varchar(255) NOT NULL COMMENT '封面',
  `desc` varchar(255) NOT NULL COMMENT '描述',
  `cat_id` smallint(5) unsigned NOT NULL COMMENT '分类id',
  `post_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动态数',
  `is_release` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否发布',
  `created_at` int(255) unsigned NOT NULL COMMENT '添加时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------
BEGIN;
INSERT INTO `topic` VALUES (1, '涨知识', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg', '快来涨知识一起进步吧', 1, 0, 1, 0, 0);
INSERT INTO `topic` VALUES (2, '美食晒出来', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/2.jpeg', '生活唯独美食不可辜负', 1, 1, 1, 0, 0);
INSERT INTO `topic` VALUES (3, '二次元的日常', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/3.jpeg', '来一起维护你心中的精神圣地', 1, 0, 1, 0, 0);
INSERT INTO `topic` VALUES (4, '情感点滴', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/4.jpeg', '这里不卖酒，也不换故事', 1, 3, 1, 0, 0);
INSERT INTO `topic` VALUES (5, '总有一句话贼走心', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/5.jpeg', '孤独到嗓子眼', 1, 0, 1, 0, 0);
INSERT INTO `topic` VALUES (6, '足球二三事', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/6.jpeg', '生命之杯GOGOGO', 1, 0, 1, 0, 0);
INSERT INTO `topic` VALUES (7, '斗图必备', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/7.jpeg', '手机里没有千个表情包，就敢跟我聊天？', 1, 0, 1, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `created_at` int(255) unsigned NOT NULL COMMENT '添加时间',
  `updated_at` int(10) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (402, 'bin', '$2a$10$ajXD6PlBvW0afFm58HdYc.jHIJORNuT.7sG6OhVXALv3O6.DMUtDy', '', '', '13333333333', 1, 1592465773, 1592465773);
INSERT INTO `user` VALUES (403, 'test', '$2a$10$dLvs5rLY8ruZyV8xOWLtGeGoQRa38lQ2nN.fUxfF2l3uvbksuhPqS', '', 'http://127.0.0.1:9010/uploads/20206/23/thumb/df29f7bc6198477cd8197b149de77367.jpeg', '13333333333', 1, 1592635431, 1597744359);
COMMIT;

-- ----------------------------
-- Table structure for user_black
-- ----------------------------
DROP TABLE IF EXISTS `user_black`;
CREATE TABLE `user_black` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `black_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '拉黑id',
  `created_at` int(10) unsigned NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='黑名单表';

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `follow_id` int(10) unsigned NOT NULL COMMENT '关注id',
  `created_at` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=805 DEFAULT CHARSET=utf8 COMMENT='好友关系表';

-- ----------------------------
-- Records of user_follow
-- ----------------------------
BEGIN;
INSERT INTO `user_follow` VALUES (800, 402, 403, 1593250084);
INSERT INTO `user_follow` VALUES (804, 403, 402, 1597821573);
COMMIT;

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0保密，1=男，2=女',
  `emotion` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '情感',
  `job` varchar(10) NOT NULL DEFAULT '' COMMENT '职业',
  `hometown` varchar(100) NOT NULL DEFAULT '' COMMENT '故乡',
  `birthday` varchar(20) NOT NULL DEFAULT '' COMMENT '生日',
  `sign` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `background` varchar(255) NOT NULL DEFAULT '' COMMENT '主页图',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
BEGIN;
INSERT INTO `user_profile` VALUES (391, 403, 2, 1, '程序猿鼓励师', '北京市-市辖区-西城区', '2002-06-24', '谁明浪子心', '');
INSERT INTO `user_profile` VALUES (392, 402, 0, 0, '程序猿', '北京市-市辖区-西城区', '2020-07-04', '', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
