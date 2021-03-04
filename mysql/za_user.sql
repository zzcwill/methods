/*
 Navicat Premium Data Transfer

 Source Server         : xc-test
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 192.168.26.11:3306
 Source Schema         : za_admin

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 03/03/2021 15:51:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for za_user
-- ----------------------------
DROP TABLE IF EXISTS `za_user`;
CREATE TABLE `za_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主ID',
  `username` varchar(40) DEFAULT NULL COMMENT '用户名，现统一为手机号',
  `job_no` varchar(50) DEFAULT NULL COMMENT '工号',
  `user_code` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `salt` varchar(255) DEFAULT NULL COMMENT '密码加密盐值',
  `realname` varchar(255) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `sex` int(8) DEFAULT NULL COMMENT '性别',
  `age` int(8) DEFAULT NULL COMMENT '年龄',
  `permissions` varchar(1000) DEFAULT NULL COMMENT '保留字段，特殊权限列表，英文逗号分隔',
  `level` int(4) DEFAULT NULL COMMENT '保留字段，用户级别',
  `company_id` int(11) DEFAULT NULL COMMENT '分公司ID，因为使用场景较多，故加之',
  `department_id` int(11) DEFAULT NULL COMMENT '所属部门ID',
  `bz_group_id` int(11) DEFAULT NULL COMMENT '所属业务组ID',
  `company_name` varchar(255) DEFAULT NULL COMMENT '所属分公司名称',
  `department_name` varchar(255) DEFAULT NULL COMMENT '所属部门名称',
  `bz_group_name` varchar(255) DEFAULT NULL COMMENT '所属业务组名称',
  `addr_province` varchar(255) DEFAULT NULL,
  `addr_city` varchar(255) DEFAULT NULL,
  `addr_area` varchar(255) DEFAULT NULL,
  `addr_detail` varchar(255) DEFAULT NULL COMMENT '详情地址，带上省市区',
  `is_on_duty` int(11) NOT NULL DEFAULT '1' COMMENT '是否在岗(0-否;1-是)',
  `status` varchar(255) DEFAULT NULL COMMENT '当前状态：NORMAL,LOCKED,DEAD',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登录时间',
  `sys_type` varchar(255) DEFAULT NULL COMMENT '用户系统范围（cls_1/cls_2/cs_1/cs_2）',
  `data_authority` varchar(100) DEFAULT NULL COMMENT '数据权限',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `uniq_username` (`username`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=906 DEFAULT CHARSET=utf8 COMMENT='用户表';

SET FOREIGN_KEY_CHECKS = 1;
