/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : security

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 30/01/2019 16:13:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户角色名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id_and_name`(`user_id`, `name`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 1, 'VIP2');
INSERT INTO `role` VALUES (2, 2, 'VIP1');
INSERT INTO `role` VALUES (3, 3, 'USER');
INSERT INTO `role` VALUES (4, 4, 'USER');
INSERT INTO `role` VALUES (5, 5, 'USER');
INSERT INTO `role` VALUES (6, 6, 'USER');
INSERT INTO `role` VALUES (7, 7, 'USER');
INSERT INTO `role` VALUES (8, 8, 'USER');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户唯一id',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `status` int(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户状态 0-正常 1-封禁',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '用户账号创建时间',
  `last_login_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '上次登录时间',
  `last_update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '上次更新记录时间',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_on_phone`(`phone_number`) USING BTREE COMMENT '用户手机号',
  UNIQUE INDEX `index_on_username`(`name`) USING BTREE COMMENT '用户名索引',
  UNIQUE INDEX `index_on_email`(`email`) USING BTREE COMMENT '电子邮箱索引'
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户基本信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'waliwali', 'wali@wali.com', '15111111111', '6fd1aad88b038aeecd9adeccc92b0bd1', 1, '2017-08-25 15:18:20', '2017-08-25 12:00:00', '2017-11-26 10:29:02', 'http://7xo6gy.com1.z0.glb.clouddn.com/99ff568bd61c744bf31185aeddf13580.png');
INSERT INTO `user` VALUES (2, 'admin', 'admin@imooc.com', '1388888888', '55b3d0936a3fb63168d57a6bda0ddbbf', 1, '2017-08-27 09:07:05', '2017-08-27 09:07:07', '2017-10-21 15:03:57', 'http://7xo6gy.com1.z0.glb.clouddn.com/99ff568bd61c744bf31185aeddf13580.png');
INSERT INTO `user` VALUES (5, '138****8888', NULL, '13888888888', NULL, 0, '2017-11-25 17:56:45', '2017-11-25 17:56:45', '2017-11-25 17:56:45', NULL);
INSERT INTO `user` VALUES (8, '151****9677', NULL, '15110059677', NULL, 0, '2017-11-25 18:58:18', '2017-11-25 18:58:18', '2017-11-25 18:58:18', NULL);

SET FOREIGN_KEY_CHECKS = 1;
