/*
 Navicat Premium Data Transfer

 Source Server         : mysql-aliyun
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : 47.110.42.110:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 31/05/2021 10:08:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Cid` varchar(10) DEFAULT NULL,
  `Cname` varchar(10) DEFAULT NULL,
  `Tid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of course
-- ----------------------------
BEGIN;
INSERT INTO `course` VALUES (1, '01', '语文', '02');
INSERT INTO `course` VALUES (2, '02', '数学', '01');
INSERT INTO `course` VALUES (3, '03', '英语', '03');
COMMIT;

-- ----------------------------
-- Table structure for sc
-- ----------------------------
DROP TABLE IF EXISTS `sc`;
CREATE TABLE `sc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Sid` varchar(10) DEFAULT NULL,
  `Cid` varchar(10) DEFAULT NULL,
  `score` decimal(18,1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of sc
-- ----------------------------
BEGIN;
INSERT INTO `sc` VALUES (1, '01', '01', 80.0);
INSERT INTO `sc` VALUES (2, '01', '02', 90.0);
INSERT INTO `sc` VALUES (3, '01', '03', 99.0);
INSERT INTO `sc` VALUES (4, '02', '01', 70.0);
INSERT INTO `sc` VALUES (5, '02', '02', 60.0);
INSERT INTO `sc` VALUES (6, '02', '03', 80.0);
INSERT INTO `sc` VALUES (7, '03', '01', 80.0);
INSERT INTO `sc` VALUES (8, '03', '02', 80.0);
INSERT INTO `sc` VALUES (9, '03', '03', 80.0);
INSERT INTO `sc` VALUES (10, '04', '01', 50.0);
INSERT INTO `sc` VALUES (11, '04', '02', 30.0);
INSERT INTO `sc` VALUES (12, '04', '03', 20.0);
INSERT INTO `sc` VALUES (13, '05', '01', 76.0);
INSERT INTO `sc` VALUES (14, '05', '02', 87.0);
INSERT INTO `sc` VALUES (15, '06', '01', 31.0);
INSERT INTO `sc` VALUES (16, '06', '03', 34.0);
INSERT INTO `sc` VALUES (17, '07', '02', 89.0);
INSERT INTO `sc` VALUES (18, '07', '03', 98.0);
COMMIT;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Sid` varchar(6) DEFAULT NULL,
  `Sname` varchar(10) DEFAULT NULL,
  `Sage` datetime DEFAULT NULL,
  `Ssex` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of student
-- ----------------------------
BEGIN;
INSERT INTO `student` VALUES (1, '01', '赵雷', '1990-01-01 00:00:00', '男');
INSERT INTO `student` VALUES (2, '02', '钱电', '1990-12-21 00:00:00', '男');
INSERT INTO `student` VALUES (3, '03', '孙风', '1990-05-20 00:00:00', '男');
INSERT INTO `student` VALUES (4, '04', '李云', '1990-08-06 00:00:00', '男');
INSERT INTO `student` VALUES (5, '05', '周梅', '1991-12-01 00:00:00', '女');
INSERT INTO `student` VALUES (6, '06', '吴兰', '1992-03-01 00:00:00', '女');
INSERT INTO `student` VALUES (7, '07', '郑竹', '1989-07-01 00:00:00', '女');
INSERT INTO `student` VALUES (8, '08', '王菊', '1990-01-20 00:00:00', '女');
COMMIT;

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Tid` varchar(10) DEFAULT NULL,
  `Tname` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of teacher
-- ----------------------------
BEGIN;
INSERT INTO `teacher` VALUES (1, '01', '张三');
INSERT INTO `teacher` VALUES (2, '02', '李四');
INSERT INTO `teacher` VALUES (3, '03', '王五');
COMMIT;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `course` varchar(100) DEFAULT NULL,
  `grade` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Demo表';

-- ----------------------------
-- Records of test
-- ----------------------------
BEGIN;
INSERT INTO `test` VALUES (1, 'zzc', 'china', 80);
INSERT INTO `test` VALUES (3, 'zzc2', 'english', 75);
INSERT INTO `test` VALUES (4, 'zzc3', 'math', 85);
COMMIT;

-- ----------------------------
-- Table structure for test3
-- ----------------------------
DROP TABLE IF EXISTS `test3`;
CREATE TABLE `test3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Demo表';

-- ----------------------------
-- Records of test3
-- ----------------------------
BEGIN;
INSERT INTO `test3` VALUES (1, 'a');
INSERT INTO `test3` VALUES (2, 'b');
INSERT INTO `test3` VALUES (3, 'c');
INSERT INTO `test3` VALUES (4, 'd');
COMMIT;

-- ----------------------------
-- Table structure for test4
-- ----------------------------
DROP TABLE IF EXISTS `test4`;
CREATE TABLE `test4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `month` int NOT NULL,
  `money` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Demo表';

-- ----------------------------
-- Records of test4
-- ----------------------------
BEGIN;
INSERT INTO `test4` VALUES (1, 'a', 1, 100.00);
INSERT INTO `test4` VALUES (2, 'b', 1, 110.00);
INSERT INTO `test4` VALUES (3, 'a', 2, 100.00);
INSERT INTO `test4` VALUES (4, 'b', 2, 90.00);
INSERT INTO `test4` VALUES (5, 'c', 2, 120.00);
INSERT INTO `test4` VALUES (6, 'c', 1, 120.00);
COMMIT;

-- ----------------------------
-- Table structure for test5
-- ----------------------------
DROP TABLE IF EXISTS `test5`;
CREATE TABLE `test5` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `amount` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Demo表';

-- ----------------------------
-- Records of test5
-- ----------------------------
BEGIN;
INSERT INTO `test5` VALUES (1, 1991, 1, '1.1');
INSERT INTO `test5` VALUES (2, 1991, 2, '1.2');
INSERT INTO `test5` VALUES (3, 1992, 1, '2.1');
INSERT INTO `test5` VALUES (4, 1992, 2, '2.2');
COMMIT;

-- ----------------------------
-- Table structure for test6
-- ----------------------------
DROP TABLE IF EXISTS `test6`;
CREATE TABLE `test6` (
  `id` int NOT NULL AUTO_INCREMENT,
  `p_id` int NOT NULL,
  `num_id` int NOT NULL,
  `s_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='Demo表';

-- ----------------------------
-- Records of test6
-- ----------------------------
BEGIN;
INSERT INTO `test6` VALUES (7, 1, 10, 1);
INSERT INTO `test6` VALUES (8, 1, 12, 2);
INSERT INTO `test6` VALUES (9, 2, 4, 1);
INSERT INTO `test6` VALUES (10, 2, 6, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
