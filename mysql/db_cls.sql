/*
 Navicat Premium Data Transfer

 Source Server         : xc-test
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 192.168.26.11:3306
 Source Schema         : cls

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 26/08/2020 11:21:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_balance
-- ----------------------------
DROP TABLE IF EXISTS `account_balance`;
CREATE TABLE `account_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_id` bigint(20) DEFAULT NULL COMMENT '账户Id',
  `register_date` datetime DEFAULT NULL COMMENT '余额记录日期',
  `today_balance` decimal(20,4) DEFAULT NULL COMMENT '今日余额',
  `yesterday_balance` decimal(20,4) DEFAULT NULL COMMENT '昨日余额',
  `is_register` int(2) DEFAULT '0' COMMENT '录入与否',
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `money_in` decimal(20,4) DEFAULT NULL COMMENT '账户汇入',
  `money_out` decimal(20,4) DEFAULT NULL COMMENT '账户汇出',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`acc_id`,`register_date`) USING BTREE,
  KEY `acc_id` (`acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4200 DEFAULT CHARSET=utf8 COMMENT='账户余额表';

-- ----------------------------
-- Table structure for account_balance_history_file_info
-- ----------------------------
DROP TABLE IF EXISTS `account_balance_history_file_info`;
CREATE TABLE `account_balance_history_file_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_id` bigint(20) DEFAULT NULL COMMENT '账户余额管理中账户ID',
  `year` int(5) DEFAULT NULL COMMENT '年份',
  `title` varchar(50) DEFAULT NULL COMMENT '展示标题',
  `file_size` decimal(18,2) DEFAULT NULL COMMENT '文件大小（k）',
  `path` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `in_use` int(2) DEFAULT NULL COMMENT '1正常2禁用',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='垫款资金统计表历史excel文件信息';

-- ----------------------------
-- Table structure for account_balance_payee
-- ----------------------------
DROP TABLE IF EXISTS `account_balance_payee`;
CREATE TABLE `account_balance_payee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_id` bigint(20) DEFAULT NULL COMMENT '账户Id',
  `payee_date` datetime DEFAULT NULL COMMENT '退款日期',
  `dealer_to_company` decimal(20,2) DEFAULT NULL COMMENT '车商退分公司金额',
  `dealer_to_company_time` datetime DEFAULT NULL,
  `dealer_to_third` decimal(20,2) DEFAULT NULL COMMENT '车商退第三方金额',
  `dealer_to_third_time` datetime DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `project_no` varchar(50) DEFAULT NULL COMMENT '贷款编号',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户姓名',
  `loan_amount` decimal(20,2) DEFAULT NULL COMMENT '贷款金额',
  `advance_date` datetime DEFAULT NULL COMMENT '垫款日期',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行Id',
  `co_bank_name` varchar(50) DEFAULT NULL COMMENT '合作银行名称',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '合作车商Id',
  `dealer_name` varchar(100) DEFAULT NULL COMMENT '合作车商名称',
  `deleted` int(2) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `acc_idx` (`acc_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for advance_detail
-- ----------------------------
DROP TABLE IF EXISTS `advance_detail`;
CREATE TABLE `advance_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `advance_id` bigint(20) DEFAULT NULL COMMENT '垫款费用申请Id',
  `overdue_id` bigint(20) DEFAULT NULL COMMENT '关联的逾期Id',
  `lawsuit_satus` int(2) DEFAULT NULL COMMENT '是否诉讼：1是 ，2未诉讼',
  `apply_advance_amt` decimal(24,4) DEFAULT NULL COMMENT '申请垫款金额',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请Id',
  `project_no` varchar(110) DEFAULT NULL COMMENT '贷款编号',
  `project_id` bigint(20) DEFAULT NULL COMMENT '垫款项目主键',
  `customer_id` bigint(20) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `repayment_card_no` varchar(110) DEFAULT NULL COMMENT '还款卡号',
  `loan_amount` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `current_plan_repay_amount` decimal(24,4) DEFAULT NULL COMMENT '月还款额',
  `loan_start_to_end` varchar(255) DEFAULT NULL COMMENT '贷款起止日期',
  `overdue_total_amount` decimal(24,4) DEFAULT NULL COMMENT '比较金额（逾期预警管理，每月还款日后，比较金额=昨日最优额；每月还款日前，比较金额=昨日最优-月还款额）',
  `compare_ratio` decimal(24,6) DEFAULT NULL COMMENT '垫款金额/月还款额',
  `isvalid` tinyint(2) DEFAULT NULL COMMENT '0删除1有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8 COMMENT='垫款费用申请明细';

-- ----------------------------
-- Table structure for advance_fee
-- ----------------------------
DROP TABLE IF EXISTS `advance_fee`;
CREATE TABLE `advance_fee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fee_type` varchar(255) DEFAULT NULL COMMENT '费用类型：风险费用',
  `fee_category` varchar(255) DEFAULT NULL COMMENT '费用类别：垫款',
  `fee_name` varchar(255) DEFAULT NULL COMMENT '费用名称',
  `fee_name_code` int(2) DEFAULT NULL COMMENT '1银行逾期垫款，2银行逾期全额垫款，3非车辆处置垫款，4垫款差额月供',
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL COMMENT '机构名称',
  `co_bank_id` bigint(20) DEFAULT NULL,
  `co_bank_name` varchar(255) DEFAULT NULL,
  `apply_date` datetime DEFAULT NULL COMMENT '申请日期',
  `apply_amount` decimal(24,4) DEFAULT NULL COMMENT '申请垫款金额',
  `advance_date` datetime DEFAULT NULL COMMENT '垫款日期',
  `advance_amt` decimal(24,4) DEFAULT NULL COMMENT '实际垫款金额',
  `payment_method` int(2) DEFAULT NULL COMMENT '垫款方式1：现金   2：银行转账',
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL COMMENT '申请人',
  `apply_status` int(2) DEFAULT NULL COMMENT '申请状态：1待提交，2审批中，3审批通过，4已付款',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isvalid` tinyint(2) DEFAULT NULL COMMENT '0删除1有效',
  `fee_id` bigint(20) DEFAULT NULL COMMENT 'FeeId',
  `fee_reason` varchar(255) DEFAULT NULL COMMENT '费用原因',
  `fee_reason_code` int(2) DEFAULT NULL COMMENT '费用原因code',
  `fee_type_code` int(10) DEFAULT NULL COMMENT '费用类型编码',
  `fee_category_code` int(10) DEFAULT NULL COMMENT '费用类别编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8 COMMENT='垫款费用申请表';

-- ----------------------------
-- Table structure for agency_car_dealer_ref
-- ----------------------------
DROP TABLE IF EXISTS `agency_car_dealer_ref`;
CREATE TABLE `agency_car_dealer_ref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `project_id` bigint(20) DEFAULT NULL COMMENT '车商ID',
  `car_dealer_id` bigint(20) DEFAULT NULL COMMENT '车商ID',
  `agency_id` bigint(20) DEFAULT NULL COMMENT '合作单位ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='预警信息表';

-- ----------------------------
-- Table structure for approve_report_detail
-- ----------------------------
DROP TABLE IF EXISTS `approve_report_detail`;
CREATE TABLE `approve_report_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `approve_project_no` varchar(50) DEFAULT NULL COMMENT '贷款编号',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `operator_name` varchar(50) DEFAULT NULL COMMENT '处理人',
  `operator_id` bigint(11) DEFAULT NULL COMMENT '处理人外键',
  `org_id` bigint(20) DEFAULT NULL COMMENT '机构Id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `approval_time` datetime NOT NULL COMMENT '审批时间',
  `approval_result` varchar(50) DEFAULT NULL,
  `business_object_id` bigint(11) DEFAULT NULL,
  `business_type` varchar(50) DEFAULT NULL,
  `node_key` varchar(50) NOT NULL DEFAULT '' COMMENT '流程节点的key',
  `node_name` varchar(50) NOT NULL COMMENT '流程节点名称',
  `skip` tinyint(1) NOT NULL,
  `is_first_time` tinyint(1) DEFAULT NULL COMMENT '是否首次审批 1 是 0 否',
  `process_id` bigint(20) DEFAULT '0' COMMENT '流程id',
  PRIMARY KEY (`id`,`project_id`,`skip`,`approval_time`)
) ENGINE=InnoDB AUTO_INCREMENT=159584 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for balance_detail
-- ----------------------------
DROP TABLE IF EXISTS `balance_detail`;
CREATE TABLE `balance_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `balance_id` bigint(20) DEFAULT NULL,
  `code_id` varchar(10) DEFAULT NULL COMMENT '明细项codeId',
  `code_name` varchar(50) DEFAULT NULL COMMENT '明细项名',
  `amount` decimal(20,4) DEFAULT NULL COMMENT '明细项金额',
  `sort_no` int(4) DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`balance_id`,`code_id`),
  KEY `balance_id` (`balance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110560 DEFAULT CHARSET=utf8 COMMENT='余额明细表';

-- ----------------------------
-- Table structure for bank_approve_config
-- ----------------------------
DROP TABLE IF EXISTS `bank_approve_config`;
CREATE TABLE `bank_approve_config` (
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(100) DEFAULT NULL,
  `base_loan_amount` decimal(10,2) DEFAULT NULL,
  `base_loan_count` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bank_overdue_info
-- ----------------------------
DROP TABLE IF EXISTS `bank_overdue_info`;
CREATE TABLE `bank_overdue_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL,
  `customer_name` varchar(50) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(50) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(50) DEFAULT NULL,
  `etl_date` datetime DEFAULT NULL COMMENT '报表更新日期',
  `card_no` varchar(30) DEFAULT NULL COMMENT '卡号',
  `cer_no` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `overdue_days` int(5) DEFAULT NULL COMMENT '逾期天数',
  `overdue_period` varchar(10) DEFAULT NULL COMMENT '逾期期限段',
  `cer_type` varchar(10) DEFAULT NULL COMMENT '证件类型',
  `current_balance` decimal(20,4) DEFAULT NULL COMMENT '当前余额',
  `last_trading_date` datetime DEFAULT NULL COMMENT '最后交易日',
  `repayment_date` datetime DEFAULT NULL COMMENT '到期还款日',
  `co_bank_id` bigint(20) DEFAULT NULL,
  `co_bank_name` varchar(100) DEFAULT NULL,
  `data_of_year` int(5) DEFAULT NULL,
  `data_of_month` int(3) DEFAULT NULL,
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人ID',
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '贷款发起人NAME',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `account_balance` decimal(10,0) DEFAULT NULL,
  `bank_payment_date` datetime DEFAULT NULL,
  `loan_left_amt` decimal(50,0) DEFAULT NULL,
  `batch_num` int(4) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=878 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bank_profile_info
-- ----------------------------
DROP TABLE IF EXISTS `bank_profile_info`;
CREATE TABLE `bank_profile_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `bank_id` bigint(11) DEFAULT NULL COMMENT '合作银行ID',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '合作银行名称',
  `profile_info` text COMMENT '寄送材料清单',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='银行资料配置信息表';

-- ----------------------------
-- Table structure for bank_remittance_info
-- ----------------------------
DROP TABLE IF EXISTS `bank_remittance_info`;
CREATE TABLE `bank_remittance_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `apply_id` bigint(20) NOT NULL COMMENT '申请主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(50) NOT NULL COMMENT '项目编号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户主键',
  `remittance_amount` double(11,2) DEFAULT NULL COMMENT '银行放款总额',
  `remittance_date` date DEFAULT NULL COMMENT '银行放款日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_pay` tinyint(1) DEFAULT '0' COMMENT '是否放款',
  `unpay_reason` varchar(255) DEFAULT NULL COMMENT '未放款原因',
  PRIMARY KEY (`id`),
  KEY `idx_bri_project_id` (`project_id`) USING BTREE,
  KEY `idx_bri_apply_id` (`apply_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行放款登记表';

-- ----------------------------
-- Table structure for biz_delivery_relative
-- ----------------------------
DROP TABLE IF EXISTS `biz_delivery_relative`;
CREATE TABLE `biz_delivery_relative` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `biz_type` int(2) DEFAULT NULL COMMENT '业务类型（1 ）',
  `biz_code` varchar(10) DEFAULT NULL COMMENT '业务类型码',
  `biz_id` bigint(11) DEFAULT NULL COMMENT '业务id',
  `delivery_type_code` int(2) DEFAULT NULL COMMENT '快递类型（1 顺丰快递 2 邮政EMS 3 其他快递 4 无需寄送）',
  `delivery_type_name` varchar(20) DEFAULT NULL COMMENT '快递类型名称',
  `delivery_no` varchar(30) DEFAULT NULL COMMENT '快递单号',
  `delivery_status` int(2) DEFAULT NULL COMMENT '快递状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='邮寄&业务关联表';

-- ----------------------------
-- Table structure for biz_region_configuration
-- ----------------------------
DROP TABLE IF EXISTS `biz_region_configuration`;
CREATE TABLE `biz_region_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `biz_region_type` varchar(64) DEFAULT NULL COMMENT '业务区间类型',
  `region_relate` int(2) DEFAULT NULL COMMENT '区间关联[A,B]&[C,D]&[E,F]，这种关联字段设置为相同的数字',
  `relate_operate` int(2) DEFAULT NULL COMMENT '关联关系 1、&& 2、||',
  `field_name` varchar(64) DEFAULT NULL COMMENT '区间对比源字段名称',
  `lower_region` varchar(100) DEFAULT NULL COMMENT '下限区间',
  `high_region` varchar(100) DEFAULT NULL COMMENT '上限区间',
  `rule_code` int(2) DEFAULT NULL COMMENT '匹配规则 1、[A,B]区间内 2、[A,B]区间外 3、（A,B）区间内，不包含 4、(A,B)区间外，不包含 5、A<? 6、?<B 7、(A,B]区间内',
  `rule_desc` varchar(200) DEFAULT NULL COMMENT '规则描述',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用 0-否,1-是',
  `remark` varchar(200) DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT NULL,
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='业务区间配置表';

-- ----------------------------
-- Table structure for business_object_process_info
-- ----------------------------
DROP TABLE IF EXISTS `business_object_process_info`;
CREATE TABLE `business_object_process_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `business_object_id` bigint(11) NOT NULL COMMENT '业务对象ID',
  `business_type` varchar(30) NOT NULL COMMENT '业务流程类型，标识此为哪一种业务对象',
  `borrower_id` bigint(11) DEFAULT NULL COMMENT '客户ID',
  `business_object_property` varchar(1024) DEFAULT NULL COMMENT '业务对象关键属性(可以决定流程流转),json格式',
  `borrower_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `agency_id` bigint(11) DEFAULT NULL COMMENT '合作单位id',
  `agency_name` varchar(60) DEFAULT NULL COMMENT '合作单位名称',
  `borrower_cert_no` varchar(255) DEFAULT NULL COMMENT '对应编号 如：客户证件号',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '发起人ID',
  `launch_user_name` varchar(32) DEFAULT NULL COMMENT '发起人姓名',
  `launch_organization_id` bigint(20) DEFAULT NULL COMMENT '发起机构ID',
  `launch_organization_name` varchar(60) DEFAULT NULL COMMENT '发起机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行网点ID',
  `sub_org_name` varchar(60) DEFAULT NULL COMMENT '支行网点名称',
  `business_num` varchar(50) DEFAULT NULL COMMENT '业务编码',
  `is_auto` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '是否自动提交',
  `is_submitted` tinyint(1) DEFAULT '0' COMMENT '是否已提交至下一节点，0：未提交，1：已提交',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '是否已读（0：未读，1：已读）',
  `is_finished` tinyint(1) DEFAULT '0' COMMENT '流程是否已结束（0：未结束，1：已结束）',
  `last_node_key` varchar(50) DEFAULT NULL COMMENT '上一节点key',
  `last_node_name` varchar(50) DEFAULT NULL COMMENT '上一流程节点名称',
  `last_node_index` int(4) DEFAULT NULL COMMENT '上一节点索引',
  `node_key` varchar(50) NOT NULL DEFAULT '' COMMENT '流程节点的key',
  `node_name` varchar(50) NOT NULL COMMENT '流程节点名称',
  `node_index` int(4) NOT NULL COMMENT '节点索引，表示此节点是流程中的第几个节点，这个值在流程确定后不会改变',
  `flow_index` int(4) NOT NULL COMMENT '流程索引，一个业务对象走流程后，每一次操作，此值顺序递增',
  `flow_version` varchar(10) DEFAULT NULL COMMENT '标识流程的版本',
  `flow_type` varchar(30) DEFAULT NULL COMMENT '流程类型',
  `operation_role_key` varchar(20) DEFAULT NULL COMMENT '操作角色Key',
  `operation_role_name` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `operator_id` bigint(11) DEFAULT NULL COMMENT '操作人外键',
  `operator_name` varchar(32) DEFAULT NULL COMMENT '操作人姓名',
  `approval_result` int(1) DEFAULT NULL COMMENT '审批结果，-1：待办；0：退回；1：同意或完结；2：补件。3：自动关闭；5：否决',
  `create_date_time` datetime NOT NULL COMMENT '创建时间，即：流转到当前节点的时间',
  `read_date_time` datetime DEFAULT NULL COMMENT '已读时间',
  `approval_date_time` datetime DEFAULT NULL COMMENT '审批时间',
  `submitted_date_time` datetime DEFAULT NULL COMMENT '提交到下一节点的时间',
  `approval_note` varchar(1024) DEFAULT NULL COMMENT '审批意见',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`create_date_time`) USING BTREE,
  KEY `idx_is_read` (`is_read`) USING BTREE,
  KEY `idx_operator_id_is_submitted` (`operator_id`,`is_submitted`) USING BTREE,
  KEY `idx_create_date_time` (`create_date_time`) USING BTREE,
  KEY `idx_business_object_id` (`business_object_id`) USING BTREE,
  KEY `idx_bni` (`business_type`,`node_key`,`is_submitted`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=737395 DEFAULT CHARSET=utf8 COMMENT='业务对像审批流程过程记录表'
/*!50100 PARTITION BY RANGE (to_days(create_date_time))
(PARTITION business_object_process_info_2017_08 VALUES LESS THAN (736938) ENGINE = InnoDB,
 PARTITION business_object_process_info_2017_09 VALUES LESS THAN (736968) ENGINE = InnoDB,
 PARTITION business_object_process_info_2017_10 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION business_object_process_info_2017_11 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION business_object_process_info_2017_12 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_01 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_02 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_03 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_04 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_05 VALUES LESS THAN (737211) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_06 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_07 VALUES LESS THAN (737272) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_08 VALUES LESS THAN (737303) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_09 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_10 VALUES LESS THAN (737364) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_11 VALUES LESS THAN (737394) ENGINE = InnoDB,
 PARTITION business_object_process_info_2018_12 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_01 VALUES LESS THAN (737456) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_02 VALUES LESS THAN (737484) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_03 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_04 VALUES LESS THAN (737545) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_05 VALUES LESS THAN (737576) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_06 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_07 VALUES LESS THAN (737637) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_08 VALUES LESS THAN (737668) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_09 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_10 VALUES LESS THAN (737729) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_11 VALUES LESS THAN (737759) ENGINE = InnoDB,
 PARTITION business_object_process_info_2019_12 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_01 VALUES LESS THAN (737821) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_02 VALUES LESS THAN (737850) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_03 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_04 VALUES LESS THAN (737911) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_05 VALUES LESS THAN (737942) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_06 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_07 VALUES LESS THAN (738003) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_08 VALUES LESS THAN (738034) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_09 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_10 VALUES LESS THAN (738095) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_11 VALUES LESS THAN (738125) ENGINE = InnoDB,
 PARTITION business_object_process_info_2020_12 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_01 VALUES LESS THAN (738187) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_02 VALUES LESS THAN (738215) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_03 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_04 VALUES LESS THAN (738276) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_05 VALUES LESS THAN (738307) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_06 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_07 VALUES LESS THAN (738368) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_08 VALUES LESS THAN (738399) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_09 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_10 VALUES LESS THAN (738460) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_11 VALUES LESS THAN (738490) ENGINE = InnoDB,
 PARTITION business_object_process_info_2021_12 VALUES LESS THAN (738521) ENGINE = InnoDB,
 PARTITION business_object_process_info_2022 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for business_object_process_status
-- ----------------------------
DROP TABLE IF EXISTS `business_object_process_status`;
CREATE TABLE `business_object_process_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID，自增序列',
  `business_object_id` bigint(20) NOT NULL COMMENT '业务对象ID',
  `business_type_key` varchar(255) NOT NULL COMMENT '流程类型编码',
  `flow_status` int(11) NOT NULL COMMENT '流程状态（1：审批中，2：关闭，3：已撤销，4：已结束',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`create_time`),
  KEY `idx_business_type_key_business_object_id` (`business_type_key`,`business_object_id`) USING BTREE,
  KEY `idx_business_object_id` (`business_object_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=269540 DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (to_days(create_time))
(PARTITION business_object_process_status_2017_3 VALUES LESS THAN (736968) ENGINE = InnoDB,
 PARTITION business_object_process_status_2017_4 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION business_object_process_status_2018_1 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION business_object_process_status_2018_2 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION business_object_process_status_2018_3 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION business_object_process_status_2018_4 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION business_object_process_status_2019_1 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION business_object_process_status_2019_2 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION business_object_process_status_2019_3 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION business_object_process_status_2019_4 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION business_object_process_status_2020_1 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION business_object_process_status_2020_2 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION business_object_process_status_2020_3 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION business_object_process_status_2020_4 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION business_object_process_status_2021_1 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION business_object_process_status_2021_2 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION business_object_process_status_2021_3 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION business_object_process_status_2021_4 VALUES LESS THAN (738521) ENGINE = InnoDB,
 PARTITION business_object_process_status_2022 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for business_rules_config
-- ----------------------------
DROP TABLE IF EXISTS `business_rules_config`;
CREATE TABLE `business_rules_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `business_type_code` varchar(768) DEFAULT NULL COMMENT '业务流程标识',
  `business_type_name` varchar(768) DEFAULT NULL COMMENT '业务流程名称',
  `node_code` varchar(768) DEFAULT NULL COMMENT '流程节点标识',
  `node_name` varchar(768) DEFAULT NULL COMMENT '流程节点名称',
  `effictive_begin` datetime DEFAULT NULL COMMENT '有效期起始日',
  `effictive_end` datetime DEFAULT NULL COMMENT '有效期截止日',
  `company_id` bigint(20) DEFAULT NULL COMMENT '分公司Id(即分行级机构Id)',
  `company_name` varchar(768) DEFAULT NULL COMMENT '分公司名称(即分行级机构名称)',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行Id',
  `co_bank_name` varchar(32) DEFAULT NULL COMMENT '合作银行名称',
  `business_group_id` bigint(20) DEFAULT NULL COMMENT '业务组Id(即支行级机构Id)',
  `business_group_name` varchar(768) DEFAULT NULL COMMENT '业务组名称(即支行级机构名称)',
  `car_type_key` varchar(768) DEFAULT NULL COMMENT '业务类型编码(-1:全部,1:新车,2:二手车,3:贴息,4:滴滴',
  `car_type_name` varchar(768) DEFAULT NULL COMMENT '业务类型名称',
  `loan_quota_low` decimal(26,0) DEFAULT NULL COMMENT '审批金额下限',
  `loan_quota_high` decimal(26,0) DEFAULT NULL COMMENT '审批金额上限',
  `expression` varchar(3072) DEFAULT NULL COMMENT '表达式(暂未使用)',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人Id',
  `operator_name` varchar(768) DEFAULT NULL COMMENT '操作人姓名',
  `prior_review_role` int(2) NOT NULL DEFAULT '0' COMMENT '优先审核对象(0-无,1-客户经理,2-风险经理)',
  `status` int(11) DEFAULT NULL COMMENT '启用状态(0-停用;1-启用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_company_id` (`company_id`) USING BTREE,
  KEY `idx_co_bank_id` (`co_bank_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_node_code` (`node_code`) USING BTREE,
  KEY `idx_business_type_code` (`business_type_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for business_serial_num
-- ----------------------------
DROP TABLE IF EXISTS `business_serial_num`;
CREATE TABLE `business_serial_num` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prefix` varchar(90) DEFAULT NULL,
  `serial` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `business_serial_prefix_index` (`prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=4267 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for business_suspend_record
-- ----------------------------
DROP TABLE IF EXISTS `business_suspend_record`;
CREATE TABLE `business_suspend_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `suspend_type` varchar(100) NOT NULL COMMENT '挂起类型(参见数据字典或枚举)',
  `suspend_code` int(2) NOT NULL COMMENT '挂起编码(参见数据字典或枚举)',
  `suspend_reason` varchar(64) NOT NULL COMMENT '挂起原因',
  `flow_type` varchar(64) DEFAULT NULL COMMENT '业务流程标识',
  `flow_node_code` varchar(64) DEFAULT NULL COMMENT '流程节点标识',
  `flow_node_name` varchar(50) DEFAULT NULL COMMENT '流程节点名称',
  `flow_node_index` int(4) DEFAULT NULL COMMENT '流程节点索引，表示此节点是流程中的第几个节点，这个值在流程确定后不会改变',
  `business_id` bigint(20) NOT NULL COMMENT '业务Id',
  `business_no` varchar(64) NOT NULL COMMENT '业务编号',
  `is_processed` int(11) NOT NULL DEFAULT '0' COMMENT '处理情况(0-未处理;1-已处理)',
  `process_opinion` varchar(64) DEFAULT NULL COMMENT '处理意见',
  `process_time` datetime DEFAULT NULL COMMENT '处理时间',
  `retry_result` int(2) DEFAULT NULL COMMENT '重试结果(0-失败;1-成功)',
  `retry_time` datetime DEFAULT NULL COMMENT '重试时间',
  `retry_fail_reason` varchar(255) DEFAULT NULL COMMENT '重试失败原因',
  `retry_operator_id` bigint(20) DEFAULT NULL COMMENT '重试操作用户Id(处理人ID)',
  `retry_operator_name` varchar(64) DEFAULT NULL COMMENT '重试操作用户姓名(处理人)',
  `retries` int(11) DEFAULT '0' COMMENT '重试次数',
  `agency_id` bigint(20) DEFAULT NULL COMMENT '合作单位Id',
  `agency_name` varchar(64) DEFAULT NULL COMMENT '合作单位名称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(64) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(64) DEFAULT NULL COMMENT '支行级机构名称',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0-停用;1-启用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_business_id` (`business_id`) USING BTREE,
  KEY `idx_business_no` (`business_no`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 COMMENT='业务挂起信息表，用于记录业务异常停顿及与之相关的操作记录';

-- ----------------------------
-- Table structure for car_dealer_account
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_account`;
CREATE TABLE `car_dealer_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '车商id',
  `account_name` varchar(55) DEFAULT NULL COMMENT '车行账户名',
  `opening_bank` varchar(55) DEFAULT NULL COMMENT '开户行',
  `open_bank_name` varchar(255) DEFAULT NULL COMMENT '银行中文名称',
  `sub_bank_name` varchar(55) DEFAULT NULL COMMENT '支行名称',
  `card_number` varchar(25) DEFAULT NULL COMMENT '卡号',
  `status` int(11) DEFAULT '1' COMMENT '1：启用，0：停用',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0:未删除，1：已删除',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构ID',
  `org_code` varchar(20) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `account_type` int(11) DEFAULT NULL COMMENT '账户类型,1:对公账户,2:个人账户',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `approve_status` int(11) DEFAULT '0' COMMENT '账户审批状态',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否是默认账户',
  `sub_bank_id` int(11) DEFAULT NULL COMMENT '支行id',
  PRIMARY KEY (`id`),
  KEY `idx_dealer_id` (`dealer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12371 DEFAULT CHARSET=utf8 COMMENT='车行账户信息表';

-- ----------------------------
-- Table structure for car_dealer_contract_info
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_contract_info`;
CREATE TABLE `car_dealer_contract_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '业务ID',
  `product_id` varchar(32) DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(32) DEFAULT NULL COMMENT '产品名称',
  `mf_customer_id` varchar(32) DEFAULT NULL COMMENT '核心客户号',
  `agency_code` varchar(32) NOT NULL COMMENT '合作单位编码',
  `social_code` varchar(32) NOT NULL COMMENT '社会统一信用代码（关联车商用）',
  `cert_no` varchar(32) DEFAULT NULL COMMENT '证件号',
  `phone` varchar(32) DEFAULT NULL COMMENT '手机号',
  `iou_number` varchar(32) DEFAULT NULL COMMENT '借据号',
  `artificial_no` varchar(32) NOT NULL COMMENT '合同号（与社会统一信用代码可确定当前库存车辆）',
  `bc_serial_no` varchar(32) DEFAULT NULL COMMENT '信贷合同流水号',
  `business_sum` varchar(32) DEFAULT NULL COMMENT '合同额度金额（元）',
  `business_rate` varchar(32) DEFAULT NULL COMMENT '执行利率',
  `contract_available_amount` varchar(32) DEFAULT NULL COMMENT '合同可用金额（元）',
  `due_bill_balance` varchar(32) DEFAULT NULL COMMENT '合同项下的借据余额（元）',
  `account_no` varchar(32) DEFAULT NULL COMMENT '放款账号',
  `putout_date` datetime DEFAULT NULL COMMENT '合同起始日',
  `maturity` datetime DEFAULT NULL COMMENT '合同到期日',
  `freeze_flag` varchar(2) DEFAULT NULL COMMENT '合同状态  1:正常 2:冻结 3:解冻 4:终止',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_inuse` int(1) DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='车商合同信息表';

-- ----------------------------
-- Table structure for car_dealer_customer_history
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_customer_history`;
CREATE TABLE `car_dealer_customer_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(100) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `car_dealer_id` bigint(20) DEFAULT NULL,
  `car_dealer_name` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `customer_name` varchar(50) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `project_no` varchar(100) DEFAULT NULL,
  `loan_amount` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `bank_payment_date` datetime DEFAULT NULL COMMENT '银行放款时间',
  `advance_date` datetime DEFAULT NULL COMMENT '垫款日期',
  `pledge_date` datetime DEFAULT NULL COMMENT '抵押时间',
  `overdue_status` int(2) DEFAULT NULL COMMENT '逾期状态（0未逾期1逾期）',
  `overdue_status_desc` varchar(20) DEFAULT NULL COMMENT '逾期状态（逾期，未逾期）',
  `settle_status` int(2) DEFAULT NULL COMMENT '结清状态（ 6“已结清”）',
  `settle_status_desc` varchar(20) DEFAULT NULL COMMENT '结清状态（ 结清，未结清）',
  `customer_car_status` int(2) DEFAULT NULL COMMENT '人车状态（1正常，2失联）',
  `customer_car_status_desc` varchar(20) DEFAULT NULL COMMENT '人车状态（正常，失联）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `year` int(5) NOT NULL COMMENT '年份',
  `month` int(2) NOT NULL COMMENT '月份',
  PRIMARY KEY (`id`,`year`,`month`),
  KEY `year_month` (`year`,`month`) USING BTREE,
  KEY `year_month_ID` (`year`,`month`,`project_id`) USING BTREE,
  KEY `ID` (`org_id`,`group_id`,`car_dealer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=431475 DEFAULT CHARSET=utf8
/*!50500 PARTITION BY RANGE  COLUMNS(`year`)
SUBPARTITION BY HASH (month)
SUBPARTITIONS 12
(PARTITION p2018 VALUES LESS THAN (2019) ENGINE = InnoDB,
 PARTITION p2019 VALUES LESS THAN (2020) ENGINE = InnoDB,
 PARTITION p2020 VALUES LESS THAN (2021) ENGINE = InnoDB,
 PARTITION p2021 VALUES LESS THAN (2022) ENGINE = InnoDB,
 PARTITION p2022 VALUES LESS THAN (2023) ENGINE = InnoDB,
 PARTITION p1 VALUES LESS THAN (MAXVALUE) ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for car_dealer_file
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_file`;
CREATE TABLE `car_dealer_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `car_dealer_id` bigint(20) DEFAULT NULL COMMENT '车商ID',
  `car_fee_id` bigint(20) DEFAULT NULL COMMENT '车商费用ID',
  `file_type` int(11) DEFAULT NULL COMMENT '文件类型',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_url` varchar(255) DEFAULT NULL COMMENT '文件url',
  `file_size` float(10,2) DEFAULT NULL COMMENT '文件大小',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否已经删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车商文件';

-- ----------------------------
-- Table structure for car_dealer_info
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_info`;
CREATE TABLE `car_dealer_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dealer_no` varchar(80) DEFAULT '' COMMENT '车行编号，按规则生成',
  `dealer_name` varchar(30) DEFAULT NULL COMMENT '车商名称',
  `dealer_type` int(11) DEFAULT '1' COMMENT '车商类型,1:个体工商户,2:有限责任公司,3:个人',
  `agency_dealer_id` bigint(20) DEFAULT NULL COMMENT '合作单位使用的车商ID',
  `contact_name` varchar(25) DEFAULT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(15) DEFAULT NULL COMMENT '联系人手机号',
  `legal_person_name` varchar(20) DEFAULT NULL COMMENT '法人姓名',
  `legal_person_cert_no` varchar(20) DEFAULT NULL COMMENT '法人证件号',
  `province` varchar(15) DEFAULT NULL COMMENT '省',
  `province_code` varchar(255) DEFAULT NULL COMMENT '省编码',
  `city` varchar(15) DEFAULT NULL COMMENT '市',
  `city_code` varchar(255) DEFAULT NULL COMMENT '市编码',
  `area` varchar(15) DEFAULT NULL COMMENT '县',
  `area_code` varchar(255) DEFAULT NULL COMMENT '区编码',
  `detailed_address` varchar(99) DEFAULT NULL COMMENT '详细地址',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '0：未删除，1：已删除',
  `admittance_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '车商准入状态 详见枚举 com.ftcs.venus.cls.enums.cardealer.CarDealerAdmittanceStatusEnum',
  `social_code` varchar(50) DEFAULT '' COMMENT '社会信用代码',
  `detail_address` varchar(100) DEFAULT '' COMMENT '车商注册地详细地址',
  `status` int(11) DEFAULT '1' COMMENT '状态，0：停用，1：启用',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=70584 DEFAULT CHARSET=utf8 COMMENT='经销商表';

-- ----------------------------
-- Table structure for car_dealer_investigation
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_investigation`;
CREATE TABLE `car_dealer_investigation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `status_record_id` bigint(20) NOT NULL COMMENT '车商状态记录ID',
  `invest_period` bigint(20) NOT NULL COMMENT '调查期数',
  `invest_date` datetime DEFAULT NULL COMMENT '调查日期',
  `invest_result` varchar(255) NOT NULL COMMENT '调查结果',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：0-失效 1-正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_dealer_modify_info
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_modify_info`;
CREATE TABLE `car_dealer_modify_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `car_dealer_id` bigint(20) NOT NULL COMMENT '车商基础信息ID',
  `object_type` varchar(30) DEFAULT NULL COMMENT '修改对象类型（CAR_DEALER_INFO,CAR_FEE_INFO等）',
  `object_name` varchar(50) DEFAULT NULL COMMENT '修改对象名',
  `action_type` varchar(10) DEFAULT '2' COMMENT '动作类型（1:add,2:modify,3:delete）',
  `column_code` varchar(50) DEFAULT NULL COMMENT '修改字段的code',
  `column_name` varchar(100) DEFAULT NULL COMMENT '修改字段名',
  `before_value` varchar(500) DEFAULT NULL COMMENT '修改前的值',
  `after_value` varchar(500) DEFAULT NULL COMMENT '修改后的值',
  `user_id` bigint(20) DEFAULT NULL COMMENT '修改人',
  `user_name` varchar(50) DEFAULT NULL COMMENT '修改名称',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37769 DEFAULT CHARSET=utf8 COMMENT='车商信息修改记录表';

-- ----------------------------
-- Table structure for car_dealer_order
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_order`;
CREATE TABLE `car_dealer_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '车商ID',
  `dealer_name` varchar(255) DEFAULT NULL COMMENT '车商名称',
  `dealer_order` varchar(255) DEFAULT NULL COMMENT '车商订单编号',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `card_type` int(11) DEFAULT NULL COMMENT '证件类型',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `customer_mobile` varchar(255) DEFAULT NULL COMMENT '客户手机号码',
  `car_type` int(11) DEFAULT NULL COMMENT '汽车类型： 1:新车,2:二手车',
  `brand_key` varchar(255) DEFAULT NULL COMMENT '品牌编码',
  `vehicle_brand` varchar(255) DEFAULT NULL COMMENT '品牌名称',
  `car_group_key` varchar(255) DEFAULT NULL COMMENT '车系编码',
  `car_group` varchar(255) DEFAULT NULL COMMENT '车系名称',
  `vehicle_type_key` varchar(255) DEFAULT NULL COMMENT '车型编码',
  `vehicle_type` varchar(255) DEFAULT NULL COMMENT '车型名称',
  `car_price` decimal(24,6) DEFAULT NULL COMMENT '车价',
  `loan_amount` decimal(24,6) DEFAULT NULL COMMENT '贷款金额',
  `loan_nper` int(11) DEFAULT NULL COMMENT '贷款期数：  1:12期，2:18期，3:24期，4:36期',
  `car_source` int(11) DEFAULT NULL COMMENT '车商来源： 1:车国，2:内部',
  `estimate_status` int(11) DEFAULT NULL COMMENT '评估状态（0：评估发起；1：初评中；2：初评完成；3：复评中；4：复评完成）',
  `credit_status` int(11) DEFAULT NULL COMMENT '征信状态: 1:已征信，2:未征信',
  `order_status` int(11) DEFAULT '1' COMMENT '订单状态：1:未被抢单，2：已经被抢',
  `submit_time` datetime DEFAULT NULL COMMENT '订单提交时间',
  `grab_user_id` bigint(20) DEFAULT NULL COMMENT '抢单用户ID',
  `own_credit_status` int(11) DEFAULT NULL COMMENT '车贷系统征信状态：1：已发起征信，2：征信完成',
  `own_loan_status` int(11) DEFAULT NULL COMMENT '车贷贷款状态：1：已发起贷款，2：贷款已完成',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `province` varchar(255) DEFAULT NULL COMMENT '省code',
  `city` varchar(255) DEFAULT NULL COMMENT '市code',
  `AREA` varchar(255) DEFAULT NULL COMMENT '区code',
  `province_name` varchar(255) DEFAULT NULL COMMENT '省中文名',
  `city_name` varchar(255) DEFAULT NULL COMMENT '市中文名',
  `area_name` varchar(255) DEFAULT NULL COMMENT '区中文名',
  `is_nationwide` tinyint(4) DEFAULT '0' COMMENT '是否全国',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dealer_order` (`dealer_order`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1291 DEFAULT CHARSET=utf8 COMMENT='车商订单信息表（车果推送）';

-- ----------------------------
-- Table structure for car_dealer_rebate
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_rebate`;
CREATE TABLE `car_dealer_rebate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dealer_fee_id` bigint(20) DEFAULT NULL COMMENT '车商费用id',
  `channel` int(1) DEFAULT NULL COMMENT '返利渠道 0返利给经销商  1返利给关键人',
  `calculate_type` int(1) DEFAULT NULL COMMENT '计算方式 0按单笔 1按比例',
  `commissions` decimal(10,4) DEFAULT NULL COMMENT '提成值',
  `deleted` tinyint(1) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_user_id` bigint(20) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_dealer_rebate_key_person
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_rebate_key_person`;
CREATE TABLE `car_dealer_rebate_key_person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rebate_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `bank_name` varchar(50) DEFAULT NULL,
  `bank_account` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_dealer_report_info
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_report_info`;
CREATE TABLE `car_dealer_report_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(100) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `apply_count` int(10) NOT NULL DEFAULT '0' COMMENT '申请数',
  `permit_count` int(10) NOT NULL DEFAULT '0' COMMENT '准入数',
  `permit_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '准入率',
  `current_month_complete_count` int(10) NOT NULL DEFAULT '0' COMMENT '当月资料齐全数',
  `total_complete_count` int(10) NOT NULL DEFAULT '0' COMMENT '截止目前资料齐全数',
  `need_invest_count` int(10) NOT NULL DEFAULT '0' COMMENT '需调查数',
  `invest_count` int(10) NOT NULL DEFAULT '0' COMMENT '实际调查数',
  `approved_count` int(10) NOT NULL DEFAULT '0' COMMENT '核准数',
  `approved_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '核准率',
  `delete_count` int(10) NOT NULL DEFAULT '0' COMMENT '删除数',
  `founded_time` datetime DEFAULT NULL COMMENT '分公司成立时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_dealer_report_info_history
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_report_info_history`;
CREATE TABLE `car_dealer_report_info_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(100) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `apply_count` int(10) NOT NULL DEFAULT '0' COMMENT '申请数',
  `permit_count` int(10) NOT NULL DEFAULT '0' COMMENT '准入数',
  `permit_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '准入率',
  `current_month_complete_count` int(10) NOT NULL DEFAULT '0' COMMENT '当月资料齐全数',
  `total_complete_count` int(10) NOT NULL DEFAULT '0' COMMENT '截止目前资料齐全数',
  `need_invest_count` int(10) NOT NULL DEFAULT '0' COMMENT '需调查数',
  `invest_count` int(10) NOT NULL DEFAULT '0' COMMENT '实际调查数',
  `approved_count` int(10) NOT NULL DEFAULT '0' COMMENT '核准数',
  `approved_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '核准率',
  `delete_count` int(10) NOT NULL DEFAULT '0' COMMENT '删除数',
  `founded_time` datetime DEFAULT NULL COMMENT '分公司成立时间',
  `create_time` datetime DEFAULT NULL,
  `year` int(5) DEFAULT NULL COMMENT '年份',
  `month` int(2) DEFAULT NULL COMMENT '月份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_dealer_statistics
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_statistics`;
CREATE TABLE `car_dealer_statistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` int(2) DEFAULT NULL COMMENT '状态，0：停用，1：启用',
  `status_desc` varchar(10) DEFAULT NULL COMMENT '状态',
  `approve_status` int(2) DEFAULT NULL COMMENT '审批状态: 0,未审批，1，审批中，2已审批，3审批拒绝',
  `approve_status_desc` varchar(10) DEFAULT NULL COMMENT '审批状态',
  `car_dealer_id` bigint(20) DEFAULT NULL,
  `car_dealer_name` varchar(255) DEFAULT NULL COMMENT '车商名称',
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(100) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL COMMENT '最新申请日期',
  `permit_time` datetime DEFAULT NULL COMMENT '最新准入时间',
  `business_num` int(10) NOT NULL DEFAULT '0' COMMENT '业务数',
  `bank_unpay_num` int(10) NOT NULL DEFAULT '0' COMMENT '银行未放款数',
  `need_pledge_num` int(10) NOT NULL DEFAULT '0' COMMENT '抵押未完成数',
  `no_settle_num` int(10) NOT NULL DEFAULT '0' COMMENT '应还客户数',
  `overdue_num` int(10) NOT NULL DEFAULT '0' COMMENT '逾期客户数',
  `customer_num` int(10) NOT NULL DEFAULT '0' COMMENT '客户总数',
  `car_missing_num` int(10) NOT NULL DEFAULT '0' COMMENT '人车失联数',
  `top_three_month_repay_customer_num` bigint(20) DEFAULT NULL COMMENT '首三期应还客户数',
  `top_three_month_overdue_customer_num` bigint(20) DEFAULT NULL COMMENT '首三期逾期客户数',
  `n2above_customer_num` bigint(20) DEFAULT NULL COMMENT 'N2及以上客户数',
  `cumulative_loan_deficit` bigint(20) DEFAULT NULL COMMENT '累计贷款亏损额',
  `cumulative_loan` bigint(20) DEFAULT NULL COMMENT '累计贷款额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=352 DEFAULT CHARSET=utf8 COMMENT='（车商报表）以车商统计数据表';

-- ----------------------------
-- Table structure for car_dealer_statistics_history
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_statistics_history`;
CREATE TABLE `car_dealer_statistics_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` int(2) DEFAULT NULL COMMENT '状态，0：停用，1：启用',
  `status_desc` varchar(10) DEFAULT NULL COMMENT '状态描述',
  `approve_status` int(2) DEFAULT NULL COMMENT '审批状态: 0,未审批，1，审批中，2已审批，3审批拒绝',
  `approve_status_desc` varchar(10) DEFAULT NULL COMMENT '审批状态',
  `car_dealer_id` bigint(20) DEFAULT NULL,
  `car_dealer_name` varchar(255) DEFAULT NULL COMMENT '车商名称',
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(100) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `business_num` int(10) NOT NULL DEFAULT '0' COMMENT '业务数',
  `bank_unpay_num` int(10) NOT NULL DEFAULT '0' COMMENT '银行未放款数',
  `need_pledge_num` int(10) NOT NULL DEFAULT '0' COMMENT '抵押未完成数',
  `no_settle_num` int(10) NOT NULL DEFAULT '0' COMMENT '应还客户数',
  `overdue_num` int(10) NOT NULL DEFAULT '0' COMMENT '逾期客户数',
  `customer_num` int(10) NOT NULL DEFAULT '0' COMMENT '客户总数',
  `car_missing_num` int(10) NOT NULL DEFAULT '0' COMMENT '人车失联数',
  `create_time` datetime DEFAULT NULL,
  `year` int(5) DEFAULT NULL COMMENT '年份',
  `month` int(2) DEFAULT NULL COMMENT '月份',
  `top_three_month_repay_customer_num` bigint(20) DEFAULT NULL COMMENT '首三期应还客户数',
  `top_three_month_overdue_customer_num` bigint(20) DEFAULT NULL COMMENT '首三期逾期客户数',
  `n2above_customer_num` bigint(20) DEFAULT NULL COMMENT 'N2及以上客户数',
  `cumulative_loan_deficit` bigint(20) DEFAULT NULL COMMENT '累计贷款亏损额',
  `cumulative_loan` bigint(20) DEFAULT NULL COMMENT '累计贷款额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2132 DEFAULT CHARSET=utf8 COMMENT='（车商报表）以车商统计历史月报';

-- ----------------------------
-- Table structure for car_dealer_status_record
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_status_record`;
CREATE TABLE `car_dealer_status_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `car_dealer_id` bigint(20) DEFAULT NULL COMMENT '车商ID',
  `data_state` varchar(255) DEFAULT '1' COMMENT '资料状态,1:不齐全,2:齐全',
  `apply_time` timestamp NULL DEFAULT NULL COMMENT '申请时间',
  `permit_time` timestamp NULL DEFAULT NULL COMMENT '准入时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `invest_completed` tinyint(1) DEFAULT '0' COMMENT '调查完成（0 否  1 是）',
  `disabled_time` timestamp NULL DEFAULT NULL COMMENT '停用时间',
  `is_disabled` tinyint(1) DEFAULT '0' COMMENT '是否被停用',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=874 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_dealer_stock_pledge_info
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_stock_pledge_info`;
CREATE TABLE `car_dealer_stock_pledge_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '业务ID',
  `car_dealer_contract_info_id` bigint(20) NOT NULL COMMENT '车商合同信息表ID',
  `car_frame_no` varchar(300) DEFAULT NULL COMMENT '车架号',
  `car_model_name` varchar(300) DEFAULT NULL COMMENT '车型',
  `plate_no` varchar(30) DEFAULT NULL COMMENT '车牌号',
  `estimate_price` varchar(32) DEFAULT NULL COMMENT '评估金额（元）',
  `payment_amount` varchar(32) DEFAULT NULL COMMENT '放款金额（元）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=691 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='创建车商在库质押车辆信息表';

-- ----------------------------
-- Table structure for car_dealer_withdrawa_repayment
-- ----------------------------
DROP TABLE IF EXISTS `car_dealer_withdrawa_repayment`;
CREATE TABLE `car_dealer_withdrawa_repayment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '业务ID',
  `car_dealer_contract_info_id` bigint(20) NOT NULL COMMENT '车商合同信息表ID',
  `operation_type` varchar(2) NOT NULL COMMENT '操作类别	1 提款；2 还款',
  `amount` varchar(32) NOT NULL COMMENT '金额（元）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='车商提款还款表';

-- ----------------------------
-- Table structure for car_fee_info
-- ----------------------------
DROP TABLE IF EXISTS `car_fee_info`;
CREATE TABLE `car_fee_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `car_dealer_id` bigint(20) DEFAULT NULL,
  `nper` int(11) DEFAULT NULL COMMENT '期数，1:12期，2：18期，3：24期，4：36期',
  `car_type` int(2) DEFAULT NULL COMMENT '汽车类型（1：新车，2：二手车）',
  `business_type_id` int(2) DEFAULT NULL COMMENT '业务品种ID(1:信用卡贷款(普通模式),2:信用卡贷款(银行直销),3:个人消费贷款 4:信用卡贷款(银行直销-垫款 5:工行@车贷 6:车主再分期',
  `business_type_name` varchar(50) DEFAULT NULL COMMENT '业务品种Name',
  `handing_fee` decimal(24,6) DEFAULT NULL COMMENT '手续费率',
  `min_earnings` decimal(24,6) DEFAULT NULL COMMENT '最低收益',
  `rebate_type` varchar(255) DEFAULT NULL COMMENT '返利方式',
  `rebate` decimal(24,6) DEFAULT NULL COMMENT '返利利率',
  `rebate_team` decimal(24,6) DEFAULT NULL COMMENT '返销售团队比例',
  `pb_deposit` decimal(24,6) DEFAULT NULL COMMENT '履约保证金',
  `serve_fee` decimal(24,6) DEFAULT NULL COMMENT '服务费',
  `guaranty_risk_amount` decimal(24,6) DEFAULT NULL COMMENT '担保风险金',
  `gps_number` int(11) DEFAULT NULL COMMENT 'gps数量',
  `gps_installation_fee` decimal(24,6) DEFAULT NULL COMMENT 'gps安装费',
  `liability_amount` decimal(24,6) DEFAULT NULL COMMENT '责信险',
  `cost_type` int(11) DEFAULT NULL COMMENT '首年保险（1：公司，2：车行，3：客户）',
  `is_pb` int(11) DEFAULT NULL COMMENT '是否续保（1：是，2：否）',
  `approve_status` int(11) DEFAULT '0' COMMENT '审批状态',
  `status` int(1) DEFAULT '1' COMMENT '是否启用(1:启用，0：停用)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `fee_name` varchar(255) DEFAULT NULL COMMENT '费用名称',
  `dealer_server_charge` decimal(24,6) DEFAULT NULL COMMENT '车商服务费',
  `outsourcing_service_charge` decimal(24,6) DEFAULT NULL COMMENT '外包服务费',
  `registration_charge` decimal(24,6) DEFAULT NULL COMMENT '上牌费',
  `on_site_survey_fee` decimal(24,6) DEFAULT NULL COMMENT '上门调查费',
  `bank_interest_margin` decimal(24,6) DEFAULT NULL COMMENT '银行利差',
  `gps_type` int(11) DEFAULT NULL COMMENT 'gps类型',
  `gps_factory` varchar(255) DEFAULT NULL COMMENT 'gps厂家',
  `cost_type_fee` decimal(24,6) DEFAULT NULL COMMENT '首年保费金额',
  `charge_for_trouble` int(11) DEFAULT NULL COMMENT '工本费',
  `charge_for_trouble_fee` decimal(24,6) DEFAULT NULL COMMENT '工本费金额',
  `vehicle_purchase_tax` int(11) DEFAULT NULL COMMENT '预计车辆购置税(1:公司，2：车行：3：客户)',
  `vehicle_purchase_tax_fee` decimal(24,6) DEFAULT NULL COMMENT '预计车辆购置税',
  `account_deposit` decimal(24,6) DEFAULT NULL COMMENT '上牌抵押押金',
  `remark` varchar(512) DEFAULT NULL,
  `valuation_fee` decimal(24,6) DEFAULT NULL COMMENT '评估费',
  `per_cent` int(11) DEFAULT '0' COMMENT '启用百分号,从右到左(反销售团队，履约保证金，按揭手续费，按揭服务费，银行利差，上牌费，上门调查费，车行服务费，外包调查费)',
  PRIMARY KEY (`id`),
  KEY `idx_car_dealer_id` (`car_dealer_id`) USING BTREE,
  KEY `IDX_NPER` (`nper`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2869 DEFAULT CHARSET=utf8 COMMENT='车商费用信息表';

-- ----------------------------
-- Table structure for car_manage_team_member
-- ----------------------------
DROP TABLE IF EXISTS `car_manage_team_member`;
CREATE TABLE `car_manage_team_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `car_dealer_id` bigint(20) DEFAULT NULL COMMENT '车商ID',
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL COMMENT '登录姓名,登录账号',
  `manager_name` varchar(255) DEFAULT NULL,
  `manage_type` varchar(255) DEFAULT NULL COMMENT '管理权类型',
  `company_id` bigint(20) DEFAULT NULL COMMENT '分公司ID',
  `company_name` varchar(255) DEFAULT NULL COMMENT '分公司名称',
  `department_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `department_name` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `group_id` bigint(20) DEFAULT NULL COMMENT '业务组ID',
  `group_name` varchar(255) DEFAULT NULL COMMENT '业务组名称',
  `is_manager` tinyint(1) DEFAULT '0' COMMENT '是否有管护权',
  `has_business` int(11) DEFAULT '0' COMMENT '是否已经发起业务',
  `status` int(11) DEFAULT '1' COMMENT '启用状态，',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_car_dealer_id` (`car_dealer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21461 DEFAULT CHARSET=utf8 COMMENT='车商管理团队成员';

-- ----------------------------
-- Table structure for car_order_img
-- ----------------------------
DROP TABLE IF EXISTS `car_order_img`;
CREATE TABLE `car_order_img` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单ID',
  `dealer_order` varchar(255) DEFAULT NULL COMMENT '订单号',
  `customer_type` int(11) DEFAULT NULL COMMENT '客户类型：1，客户，2,配偶，3，担保人',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户（配偶，担保人）名称',
  `card_type` int(11) DEFAULT NULL COMMENT '1：身份证，2：军官证，3：侨胞证，4：外籍人士',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `borrower_relationship` int(11) DEFAULT NULL COMMENT '与借款人关系（1：本人，2：夫妻，3：父亲，4：母亲，5：姐妹，6：兄弟，7：儿子，8：亲戚，9：朋友，10：合伙人，11：同事，12：女儿，13：姐夫，14：嫂子，15：儿媳）',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机号',
  `file_url1` varchar(255) DEFAULT NULL COMMENT '图片1',
  `file_url2` varchar(255) DEFAULT NULL COMMENT '图片2',
  `file_url3` varchar(255) DEFAULT NULL COMMENT '图片3',
  `file_url4` varchar(255) DEFAULT NULL COMMENT '图片4',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_dealer_order` (`dealer_order`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=619 DEFAULT CHARSET=utf8 COMMENT='车商意向订单配偶等图片信息';

-- ----------------------------
-- Table structure for car_pick_file
-- ----------------------------
DROP TABLE IF EXISTS `car_pick_file`;
CREATE TABLE `car_pick_file` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` varchar(255) DEFAULT NULL,
  `fileType` int(11) DEFAULT NULL COMMENT '文件类型（1：提车照片2：车商门店照）',
  `car_pick_id` bigint(11) DEFAULT NULL COMMENT '关联的提车登记外键',
  `photographLongitude` decimal(20,16) DEFAULT NULL COMMENT '经度',
  `photographLatitude` decimal(20,16) DEFAULT NULL COMMENT '纬度',
  `is_available` int(11) DEFAULT '1' COMMENT '是否可用（0false1true 标记垃圾文件）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1183 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_pick_gps_ref
-- ----------------------------
DROP TABLE IF EXISTS `car_pick_gps_ref`;
CREATE TABLE `car_pick_gps_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gps_id` bigint(20) DEFAULT NULL,
  `car_pick_id` bigint(20) DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_pick_storage
-- ----------------------------
DROP TABLE IF EXISTS `car_pick_storage`;
CREATE TABLE `car_pick_storage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL COMMENT '贷款ID',
  `project_no` varchar(255) DEFAULT NULL COMMENT '贷款编号',
  `pick_date` datetime DEFAULT NULL COMMENT '提车日期',
  `customer_id` bigint(11) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户姓名',
  `id_card` varchar(255) DEFAULT NULL COMMENT '身份证号',
  `telephone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `car_dealer_id` bigint(11) DEFAULT NULL,
  `car_dealer_name` varchar(255) DEFAULT NULL COMMENT '车商名',
  `car_frame_no` varchar(255) DEFAULT NULL COMMENT '车架号',
  `gps_supplier_main_id` bigint(11) DEFAULT NULL COMMENT 'gps,imei',
  `customer_imgs` varchar(255) DEFAULT NULL COMMENT '客户提车照',
  `dealer_imgs` varchar(255) DEFAULT NULL COMMENT '车商门店照',
  `car_model_name` varchar(255) DEFAULT NULL,
  `car_brand_name` varchar(255) DEFAULT NULL,
  `car_make_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_price_warn
-- ----------------------------
DROP TABLE IF EXISTS `car_price_warn`;
CREATE TABLE `car_price_warn` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请Id',
  `city_code` varchar(50) DEFAULT NULL COMMENT '城市（市区级）代码',
  `vin` varchar(50) DEFAULT NULL COMMENT '车架号',
  `billing_price` decimal(24,2) DEFAULT NULL COMMENT '开票价',
  `car_model` varchar(60) DEFAULT NULL COMMENT '车型',
  `car_model_id` varchar(50) DEFAULT NULL COMMENT '车型Id',
  `reference_price` decimal(24,2) DEFAULT NULL COMMENT '经销商参考价',
  `hs_guide_price` decimal(24,2) DEFAULT NULL COMMENT 'hs厂商指导价',
  `autohome_guide_price` decimal(24,2) DEFAULT NULL COMMENT '汽车之家厂商指导价',
  `return_car_model` varchar(255) DEFAULT NULL COMMENT 'hs返回车型',
  `warning_level` varchar(50) DEFAULT NULL COMMENT '预警等级',
  `warning_result` varchar(255) DEFAULT NULL COMMENT '预警结果',
  `is_inuse` tinyint(2) DEFAULT NULL COMMENT '是否启用',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5874 DEFAULT CHARSET=utf8 COMMENT='车价预警信息表';

-- ----------------------------
-- Table structure for car_quick_estimate
-- ----------------------------
DROP TABLE IF EXISTS `car_quick_estimate`;
CREATE TABLE `car_quick_estimate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `estimate_order_no` varchar(64) DEFAULT NULL COMMENT '车辆评估订单号（车贷系统生成）',
  `vin` varchar(32) DEFAULT NULL COMMENT '车架号',
  `car_brand` varchar(10) DEFAULT NULL COMMENT '品牌名称',
  `car_brand_name` varchar(150) DEFAULT NULL COMMENT '品牌名称',
  `car_make` varchar(10) DEFAULT NULL COMMENT '车系名称',
  `car_make_name` varchar(150) DEFAULT NULL COMMENT '车系名称',
  `car_model` varchar(10) DEFAULT NULL COMMENT '汽车款型',
  `car_model_name` varchar(150) DEFAULT NULL COMMENT '车型名称',
  `register_date` datetime DEFAULT NULL COMMENT '上牌时间',
  `car_engine_no` varchar(64) DEFAULT NULL COMMENT '发动机号码',
  `plate_no` varchar(32) DEFAULT NULL COMMENT '车牌号码',
  `kilometres` decimal(10,2) NOT NULL COMMENT '公里数(公里)',
  `buy_car_address_pid` varchar(10) DEFAULT NULL COMMENT '购车地址ID',
  `buy_car_address_pname` varchar(30) DEFAULT NULL COMMENT '购车地址名称',
  `buy_car_address_cid` varchar(10) DEFAULT NULL COMMENT '购车地址格式化市id',
  `buy_car_address_cname` varchar(30) DEFAULT NULL COMMENT '购车地址格式化市Name',
  `buy_car_address_rid` varchar(10) DEFAULT NULL COMMENT '购车地址格式化区id',
  `buy_car_address_rname` varchar(30) DEFAULT NULL COMMENT '购车地址格式化区name',
  `estimate_user_id` bigint(20) DEFAULT NULL COMMENT '评估发起人ID',
  `estimate_user_name` varchar(50) DEFAULT NULL COMMENT '评估发起人NAME',
  `estimate_group_id` bigint(20) DEFAULT NULL COMMENT '评估发起业务组ID',
  `estimate_group_name` varchar(100) DEFAULT NULL COMMENT '评估发起业务组NAME',
  `estimate_org_id` bigint(20) DEFAULT NULL COMMENT '评估发起机构ID',
  `estimate_org_name` varchar(100) DEFAULT NULL COMMENT '评估发起机构NAME',
  `estimate_status` int(2) DEFAULT NULL COMMENT '评估状态：2 评估中 3 评估完成',
  `estimate_result` varchar(64) DEFAULT NULL COMMENT '评估结果',
  `result_url` varchar(255) DEFAULT NULL COMMENT '返回h5页面url',
  `estimate_date` datetime DEFAULT NULL COMMENT '评估日期 超过1个月要重新评估',
  `dirver_license_photo` varchar(255) DEFAULT NULL COMMENT '行驶证照片',
  `extra_photo` varchar(255) DEFAULT NULL COMMENT '扩展图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_estimate_order_no` (`estimate_order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='车300快速评估表';

-- ----------------------------
-- Table structure for ccms_bt_etl_delete
-- ----------------------------
DROP TABLE IF EXISTS `ccms_bt_etl_delete`;
CREATE TABLE `ccms_bt_etl_delete` (
  `cust_name` varchar(20) DEFAULT NULL COMMENT '客户姓名',
  `card_no` varchar(50) NOT NULL COMMENT '身份证号',
  `mobile_phone` bigint(20) DEFAULT NULL COMMENT '手机号',
  `etl_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代偿数据（需剔除）';

-- ----------------------------
-- Table structure for ccms_overdue_mid
-- ----------------------------
DROP TABLE IF EXISTS `ccms_overdue_mid`;
CREATE TABLE `ccms_overdue_mid` (
  `project_id` varchar(50) NOT NULL,
  `acct_no` varchar(30) NOT NULL COMMENT '账户号',
  `t_acct_no` varchar(30) DEFAULT NULL COMMENT '顶层账户号',
  `cust_no` varchar(30) DEFAULT NULL COMMENT '客户号',
  `card_no` varchar(30) DEFAULT NULL COMMENT '证件号',
  `coll_rec_type` varchar(4) DEFAULT NULL COMMENT '催收记录类型',
  `incoll_date` datetime DEFAULT NULL COMMENT '入催日期',
  `satisfy_date` datetime DEFAULT NULL COMMENT '满意日期',
  `satisfy_flag` varchar(20) DEFAULT NULL COMMENT '满意标识',
  `coll_status` varchar(4) DEFAULT NULL COMMENT '催收状态',
  `ACCT_STATUS` varchar(20) DEFAULT NULL COMMENT '账户状态',
  `incoll_reason` varchar(4) DEFAULT NULL COMMENT '入催原因',
  `s_acct_lmt` decimal(15,2) DEFAULT '0.00' COMMENT '清算层额度',
  `acct_type` varchar(20) DEFAULT NULL COMMENT '账户类型',
  `bucket` varchar(20) DEFAULT NULL COMMENT '逾期期数',
  `manual_status_code` varchar(4) DEFAULT NULL COMMENT '手工状态码',
  `manual_stat_set_date` datetime DEFAULT NULL COMMENT '手工状态设置日期',
  `auto_status_code` varchar(4) DEFAULT NULL COMMENT '自动状态码',
  `auto_stat_set_date` datetime DEFAULT NULL COMMENT '自动状态设置日期',
  `credit_card_no` varchar(20) DEFAULT NULL COMMENT '信用卡卡号',
  `card_product` varchar(50) DEFAULT NULL COMMENT '卡产品',
  `mcard_name` varchar(30) DEFAULT NULL COMMENT '压花名',
  `card_valid_date` char(4) DEFAULT NULL COMMENT '卡有效日期',
  `card_status` varchar(4) DEFAULT NULL COMMENT '卡片状态',
  `card_stat_set_date` datetime DEFAULT NULL COMMENT '卡片状态设置日期',
  `mail_city` varchar(30) DEFAULT NULL COMMENT '邮寄城市',
  `stmt_addr1` varchar(60) DEFAULT NULL COMMENT '账单地址第一行',
  `stmt_addr2` varchar(60) DEFAULT NULL COMMENT '账单地址第二行',
  `stmt_addr3` varchar(200) DEFAULT NULL COMMENT '账单地址第三行',
  `mail_postcode` varchar(10) DEFAULT NULL COMMENT '邮寄邮编',
  `open_acct_date` datetime DEFAULT NULL COMMENT '开户日期',
  `REGIST_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户注册日期',
  `ACTIVE_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户激活日期',
  `SIGN_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户签约日期',
  `AUDIT_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户审批日期',
  `APPR_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户通过日期',
  `LEND_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户放款日期',
  `OVER_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户完结日期',
  `currency` varchar(20) DEFAULT NULL COMMENT '币种',
  `exceed_lmt_amt` decimal(15,2) DEFAULT '0.00' COMMENT '超限金额',
  `has_ins_acct` char(1) DEFAULT NULL COMMENT '有无分期账户',
  `remain_ins_amt` decimal(15,2) DEFAULT NULL COMMENT '剩余分期金额',
  `due_amt` decimal(15,2) DEFAULT '0.00' COMMENT '最低还款金额',
  `sys_cur_bal` decimal(15,2) DEFAULT '0.00' COMMENT '系统当前余额',
  `cur_spend_bal` decimal(15,2) DEFAULT '0.00' COMMENT '当前消费余额',
  `REMAIN_SPEND_BAL` decimal(15,2) DEFAULT '0.00' COMMENT '剩余欠款本金部分',
  `cur_ins_spend_bal` decimal(15,2) DEFAULT '0.00' COMMENT '当前分期消费余额',
  `cur_cash_amt` decimal(15,2) DEFAULT '0.00' COMMENT '当前取现余额',
  `cur_cash_amt_sign` char(1) DEFAULT NULL COMMENT '当前取现余额符号',
  `expense_amt` decimal(15,2) DEFAULT NULL COMMENT '费用金额',
  `REMAIN_EXPENSE_AMT` decimal(15,2) DEFAULT NULL COMMENT '剩余欠款费用部分',
  `interest_amt` decimal(15,2) DEFAULT NULL COMMENT '利息金额',
  `REMAIN_INTEREST_AMT` decimal(15,2) DEFAULT NULL COMMENT '剩余欠款利息部分',
  `LATE_FEE_AMT` decimal(15,2) DEFAULT NULL COMMENT '滞纳金',
  `REMAIN_LATE_FEE_AMT` decimal(15,2) DEFAULT NULL COMMENT '剩余欠款滞纳金部分',
  `last_stmt_date` datetime DEFAULT NULL COMMENT '上一账单日',
  `cur_cyc_stmt_bal` decimal(15,2) DEFAULT '0.00' COMMENT '本期账单余额',
  `pay_due_date` datetime DEFAULT NULL COMMENT '应付账款日期',
  `last_cyc_stmt_bal` decimal(15,2) DEFAULT '0.00' COMMENT '上期账单余额',
  `last_cyc_stmt_bal_sign` char(1) DEFAULT NULL COMMENT '上期账单余额符号',
  `last_cyc_due_amt` decimal(15,2) DEFAULT '0.00' COMMENT '上期最低还款额',
  `last_cyc_pay_due_date` datetime DEFAULT NULL COMMENT '上期到期还款日',
  `cur_cyc_bal` decimal(15,2) DEFAULT '0.00' COMMENT '当期欠款余额',
  `m1_amt` decimal(15,2) DEFAULT '0.00' COMMENT '30天以下欠款',
  `m2_amt` decimal(15,2) DEFAULT '0.00' COMMENT '30-59天欠款',
  `m3_amt` decimal(15,2) DEFAULT '0.00' COMMENT '60-89天欠款',
  `m4_amt` decimal(15,2) DEFAULT '0.00' COMMENT '90-119天欠款',
  `m5_amt` decimal(15,2) DEFAULT '0.00' COMMENT '120-149天欠款',
  `m6_amt` decimal(15,2) DEFAULT '0.00' COMMENT '150-179天欠款',
  `m7_amt` decimal(15,2) DEFAULT '0.00' COMMENT '180-209天欠款',
  `m7_plus_amt` decimal(15,2) DEFAULT '0.00' COMMENT '210天及以上欠款',
  `m1_cnt` int(11) DEFAULT NULL COMMENT '30天以下欠款延滞次数',
  `m2_cnt` int(11) DEFAULT NULL COMMENT '30-59天欠款延滞次数',
  `m3_cnt` int(11) DEFAULT NULL COMMENT '60-89天欠款延滞次数',
  `m4_cnt` int(11) DEFAULT NULL COMMENT '90-119天欠款延滞次数',
  `m5_cnt` int(11) DEFAULT NULL COMMENT '120-149天欠款延滞次数',
  `m6_cnt` int(11) DEFAULT NULL COMMENT '150-179天欠款延滞次数',
  `m7_cnt` int(11) DEFAULT NULL COMMENT '180-209天欠款延滞次数',
  `m7_plus_cnt` int(11) DEFAULT NULL COMMENT '210天及以上欠款延滞次数',
  `last_loan_trans_amt` decimal(15,2) DEFAULT '0.00' COMMENT '最近一次贷记交易金额',
  `last_loan_trans_date` datetime DEFAULT NULL COMMENT '最近一次贷记交易日期',
  `last_debit_trans_amt` decimal(15,2) DEFAULT '0.00' COMMENT '最近一次借记交易金额',
  `last_debit_trans_date` datetime DEFAULT NULL COMMENT '最近一次借记交易日期',
  `cur_cyc_debit_cnt` int(11) DEFAULT NULL COMMENT '本周期借记笔数',
  `cur_cyc_cash_cnt` int(11) DEFAULT NULL COMMENT '本周期取现笔数',
  `auto_pm_debit_card_no` varchar(20) DEFAULT NULL COMMENT '自动还款借记卡卡号',
  `auto_payment_mode` varchar(20) DEFAULT NULL COMMENT '自动还款方式',
  `auto_pm_sg_or_tm_date` datetime DEFAULT NULL COMMENT '自动还款签约/解约日期',
  `auto_payment_act_date` datetime DEFAULT NULL COMMENT '自动还款激活日期',
  `auto_payment_amt` decimal(15,2) DEFAULT NULL COMMENT '自动还款金额',
  `auto_pay_rtn_rsn_code` varchar(4) DEFAULT NULL COMMENT '自动还款返回原因码',
  `apply_no` varchar(30) DEFAULT NULL COMMENT '申请编号',
  `sales_code` varchar(20) DEFAULT NULL COMMENT '营销代码',
  `source_code` varchar(10) DEFAULT NULL COMMENT '来源代码',
  `dispute_amt` decimal(15,2) DEFAULT '0.00' COMMENT '争议金额',
  `dispute_cnt` int(11) DEFAULT '0' COMMENT '争议笔数',
  `delinquent_days` int(11) DEFAULT NULL COMMENT '拖欠天数',
  `ver_identity` varchar(20) DEFAULT NULL COMMENT '核销标识',
  `ver_reason` varchar(60) DEFAULT NULL COMMENT '核销原因',
  `ver_chg_date` datetime DEFAULT NULL COMMENT '核销标识变更日期',
  `pre_appr_lmt_flag` char(1) DEFAULT NULL COMMENT '预批额度标识',
  `ins_poundage_bal` decimal(15,2) DEFAULT '0.00' COMMENT '分期手续费用余额',
  `spend_ini_amt` decimal(15,2) DEFAULT '0.00' COMMENT '消费起始金额',
  `statement_day` varchar(20) DEFAULT NULL COMMENT '账单日',
  `branch_org` varchar(4) DEFAULT NULL COMMENT '分行机构',
  `apply_score` varchar(4) DEFAULT NULL COMMENT '申请评分',
  `bank_no` varchar(20) DEFAULT NULL COMMENT '银行编号',
  `app_source_code` varchar(10) DEFAULT NULL COMMENT '发卡专案代码',
  `compound_interest_bal` decimal(15,2) DEFAULT NULL COMMENT '复利余额',
  `no_interest_bal` decimal(15,2) DEFAULT NULL COMMENT '不计息余额',
  `first_loan_cash_date` datetime DEFAULT NULL COMMENT '第一次交易为预借现金日期',
  `last_close_acct_date` datetime DEFAULT NULL COMMENT '最近关账日期',
  `close_acct_code` varchar(4) DEFAULT NULL COMMENT '关账代码',
  `warrant_flag` char(20) DEFAULT NULL COMMENT '担保标识',
  `highest_spend_amt` decimal(15,2) DEFAULT NULL COMMENT '最高消费金额',
  `highest_spend_date` datetime DEFAULT NULL COMMENT '最高消费日期',
  `last_dispute_date` datetime DEFAULT NULL COMMENT '最近一次争议款产生日期',
  `ins_cur_amt` decimal(15,2) DEFAULT NULL COMMENT '分期付款本期分摊金额',
  `ins_remain_principal` decimal(15,2) DEFAULT NULL COMMENT '分期付款目前剩余本金',
  `in_oct_num` int(11) DEFAULT NULL COMMENT '进入OCT队列次数',
  `in_oct_date` datetime DEFAULT NULL COMMENT '进入OCT队列日期',
  `loan_overdue_flag` char(20) DEFAULT NULL COMMENT '贷款逾期状态标识',
  `cur_payment_amt` decimal(15,2) DEFAULT NULL COMMENT '当期已还款金额',
  `sub_division_code` varchar(4) DEFAULT NULL COMMENT '细分类代码',
  `stmt_spend_bal` decimal(15,2) DEFAULT NULL COMMENT '账单消费余额',
  `stmt_cash_bal` decimal(15,2) DEFAULT NULL COMMENT '账单日计息余额',
  `stmt_cash_bal_sign` char(1) DEFAULT NULL COMMENT '账单日计息余额符号',
  `stmt_no_int_bal` decimal(15,2) DEFAULT NULL COMMENT '账单免息余额',
  `stmt_interest_bal` decimal(15,2) DEFAULT NULL COMMENT '账单利息余额',
  `ins_no_stmt_bal` decimal(15,2) DEFAULT NULL COMMENT '分期付款未出账单余额',
  `ins_no_stmt_bal_sign` char(1) DEFAULT NULL COMMENT '分期付款未出账单余额符号',
  `ins_stmt_bal` decimal(15,2) DEFAULT NULL COMMENT '分期付款已出账单余额',
  `ins_stmt_bal_sign` char(1) DEFAULT NULL COMMENT '分期付款已出账单余额符号',
  `acct_layer_code_1` varchar(4) DEFAULT NULL COMMENT '账户分层代码1',
  `acct_layer_code_2` varchar(4) DEFAULT NULL COMMENT '账户分层代码2',
  `stop_ins_flag` char(20) DEFAULT NULL COMMENT '停止分期业务标识',
  `STOP_INS_DATE` datetime DEFAULT NULL COMMENT '停止分期日期',
  `cur_big_ins_bal` decimal(15,2) DEFAULT NULL COMMENT '本期大额分期余额',
  `last_big_ins_bal` decimal(15,2) DEFAULT NULL COMMENT '上期大额分期余额',
  `creditor_adj_amt` decimal(15,2) DEFAULT NULL COMMENT '贷方调整金额',
  `stmt_addr_type` varchar(4) DEFAULT NULL COMMENT '账单地址类型',
  `keep_field` varchar(30) DEFAULT NULL COMMENT '保留字段',
  `crt_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `crt_user` varchar(20) DEFAULT 'SYSTEM' COMMENT '创建人',
  `upd_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `upd_user` varchar(20) DEFAULT 'SYSTEM' COMMENT '更新人',
  `bt_date` date DEFAULT NULL COMMENT '批量日期',
  `MATRUITY_REPAY_DATE` datetime DEFAULT NULL COMMENT '到期还款处理日',
  `CREDIT_LIMIT` decimal(15,2) DEFAULT NULL COMMENT '账户的信用额度',
  `LOAN_PURPOSE` varchar(100) DEFAULT NULL COMMENT '贷款用途',
  `DEBUCTED_BANK` varchar(50) DEFAULT NULL COMMENT '代扣银行分行',
  `LAST_DD_RESULT` varchar(100) DEFAULT NULL COMMENT '最近一次代扣行回盘结果 last DD result（将交易时间、交易金额、交易结果合并为一个字段）',
  `IS_PREPAYMENT` varchar(20) DEFAULT NULL COMMENT '是否提前还款',
  `PREPAYMENT_DATE` datetime DEFAULT NULL COMMENT '提前还款日期',
  `PREPAYMENT_AMT` decimal(15,2) DEFAULT NULL COMMENT '提前还款金额',
  `IS_EXEMPT` varchar(20) DEFAULT NULL COMMENT '是否小额豁免',
  `EXEMPT_DATE` datetime DEFAULT NULL COMMENT '豁免时间',
  `EXEMPT_AMT` decimal(15,2) DEFAULT NULL COMMENT '豁免金额',
  `VER_TYPE` varchar(20) DEFAULT NULL COMMENT '核销类型',
  `receivable_amt` decimal(15,2) DEFAULT '0.00' COMMENT '应还款额',
  `etl_date` datetime DEFAULT NULL COMMENT 'etl日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='催收数据中间表(最后还款日后最新数据)';

-- ----------------------------
-- Table structure for ccms_overdue_mid_new
-- ----------------------------
DROP TABLE IF EXISTS `ccms_overdue_mid_new`;
CREATE TABLE `ccms_overdue_mid_new` (
  `project_id` varchar(50) NOT NULL,
  `acct_no` varchar(30) NOT NULL COMMENT '账户号',
  `t_acct_no` varchar(30) DEFAULT NULL COMMENT '顶层账户号',
  `cust_no` varchar(30) DEFAULT NULL COMMENT '客户号',
  `card_no` varchar(30) DEFAULT NULL COMMENT '证件号',
  `coll_rec_type` varchar(4) DEFAULT NULL COMMENT '催收记录类型',
  `incoll_date` datetime DEFAULT NULL COMMENT '入催日期',
  `satisfy_date` datetime DEFAULT NULL COMMENT '满意日期',
  `satisfy_flag` varchar(20) DEFAULT NULL COMMENT '满意标识',
  `coll_status` varchar(4) DEFAULT NULL COMMENT '催收状态',
  `ACCT_STATUS` varchar(20) DEFAULT NULL COMMENT '账户状态',
  `incoll_reason` varchar(4) DEFAULT NULL COMMENT '入催原因',
  `s_acct_lmt` decimal(15,2) DEFAULT '0.00' COMMENT '清算层额度',
  `acct_type` varchar(20) DEFAULT NULL COMMENT '账户类型',
  `bucket` varchar(20) DEFAULT NULL COMMENT '逾期期数',
  `manual_status_code` varchar(4) DEFAULT NULL COMMENT '手工状态码',
  `manual_stat_set_date` datetime DEFAULT NULL COMMENT '手工状态设置日期',
  `auto_status_code` varchar(4) DEFAULT NULL COMMENT '自动状态码',
  `auto_stat_set_date` datetime DEFAULT NULL COMMENT '自动状态设置日期',
  `credit_card_no` varchar(20) DEFAULT NULL COMMENT '信用卡卡号',
  `card_product` varchar(50) DEFAULT NULL COMMENT '卡产品',
  `mcard_name` varchar(30) DEFAULT NULL COMMENT '压花名',
  `card_valid_date` char(4) DEFAULT NULL COMMENT '卡有效日期',
  `card_status` varchar(4) DEFAULT NULL COMMENT '卡片状态',
  `card_stat_set_date` datetime DEFAULT NULL COMMENT '卡片状态设置日期',
  `mail_city` varchar(30) DEFAULT NULL COMMENT '邮寄城市',
  `stmt_addr1` varchar(60) DEFAULT NULL COMMENT '账单地址第一行',
  `stmt_addr2` varchar(60) DEFAULT NULL COMMENT '账单地址第二行',
  `stmt_addr3` varchar(200) DEFAULT NULL COMMENT '账单地址第三行',
  `mail_postcode` varchar(10) DEFAULT NULL COMMENT '邮寄邮编',
  `open_acct_date` datetime DEFAULT NULL COMMENT '开户日期',
  `REGIST_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户注册日期',
  `ACTIVE_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户激活日期',
  `SIGN_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户签约日期',
  `AUDIT_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户审批日期',
  `APPR_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户通过日期',
  `LEND_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户放款日期',
  `OVER_ACCT_DATE` datetime DEFAULT NULL COMMENT '账户完结日期',
  `currency` varchar(20) DEFAULT NULL COMMENT '币种',
  `exceed_lmt_amt` decimal(15,2) DEFAULT '0.00' COMMENT '超限金额',
  `has_ins_acct` char(1) DEFAULT NULL COMMENT '有无分期账户',
  `remain_ins_amt` decimal(15,2) DEFAULT NULL COMMENT '剩余分期金额',
  `due_amt` decimal(15,2) DEFAULT '0.00' COMMENT '最低还款金额',
  `sys_cur_bal` decimal(15,2) DEFAULT '0.00' COMMENT '系统当前余额',
  `cur_spend_bal` decimal(15,2) DEFAULT '0.00' COMMENT '当前消费余额',
  `REMAIN_SPEND_BAL` decimal(15,2) DEFAULT '0.00' COMMENT '剩余欠款本金部分',
  `cur_ins_spend_bal` decimal(15,2) DEFAULT '0.00' COMMENT '当前分期消费余额',
  `cur_cash_amt` decimal(15,2) DEFAULT '0.00' COMMENT '当前取现余额',
  `cur_cash_amt_sign` char(1) DEFAULT NULL COMMENT '当前取现余额符号',
  `expense_amt` decimal(15,2) DEFAULT NULL COMMENT '费用金额',
  `REMAIN_EXPENSE_AMT` decimal(15,2) DEFAULT NULL COMMENT '剩余欠款费用部分',
  `interest_amt` decimal(15,2) DEFAULT NULL COMMENT '利息金额',
  `REMAIN_INTEREST_AMT` decimal(15,2) DEFAULT NULL COMMENT '剩余欠款利息部分',
  `LATE_FEE_AMT` decimal(15,2) DEFAULT NULL COMMENT '滞纳金',
  `REMAIN_LATE_FEE_AMT` decimal(15,2) DEFAULT NULL COMMENT '剩余欠款滞纳金部分',
  `last_stmt_date` datetime DEFAULT NULL COMMENT '上一账单日',
  `cur_cyc_stmt_bal` decimal(15,2) DEFAULT '0.00' COMMENT '本期账单余额',
  `pay_due_date` datetime DEFAULT NULL COMMENT '应付账款日期',
  `last_cyc_stmt_bal` decimal(15,2) DEFAULT '0.00' COMMENT '上期账单余额',
  `last_cyc_stmt_bal_sign` char(1) DEFAULT NULL COMMENT '上期账单余额符号',
  `last_cyc_due_amt` decimal(15,2) DEFAULT '0.00' COMMENT '上期最低还款额',
  `last_cyc_pay_due_date` datetime DEFAULT NULL COMMENT '上期到期还款日',
  `cur_cyc_bal` decimal(15,2) DEFAULT '0.00' COMMENT '当期欠款余额',
  `m1_amt` decimal(15,2) DEFAULT '0.00' COMMENT '30天以下欠款',
  `m2_amt` decimal(15,2) DEFAULT '0.00' COMMENT '30-59天欠款',
  `m3_amt` decimal(15,2) DEFAULT '0.00' COMMENT '60-89天欠款',
  `m4_amt` decimal(15,2) DEFAULT '0.00' COMMENT '90-119天欠款',
  `m5_amt` decimal(15,2) DEFAULT '0.00' COMMENT '120-149天欠款',
  `m6_amt` decimal(15,2) DEFAULT '0.00' COMMENT '150-179天欠款',
  `m7_amt` decimal(15,2) DEFAULT '0.00' COMMENT '180-209天欠款',
  `m7_plus_amt` decimal(15,2) DEFAULT '0.00' COMMENT '210天及以上欠款',
  `m1_cnt` int(11) DEFAULT NULL COMMENT '30天以下欠款延滞次数',
  `m2_cnt` int(11) DEFAULT NULL COMMENT '30-59天欠款延滞次数',
  `m3_cnt` int(11) DEFAULT NULL COMMENT '60-89天欠款延滞次数',
  `m4_cnt` int(11) DEFAULT NULL COMMENT '90-119天欠款延滞次数',
  `m5_cnt` int(11) DEFAULT NULL COMMENT '120-149天欠款延滞次数',
  `m6_cnt` int(11) DEFAULT NULL COMMENT '150-179天欠款延滞次数',
  `m7_cnt` int(11) DEFAULT NULL COMMENT '180-209天欠款延滞次数',
  `m7_plus_cnt` int(11) DEFAULT NULL COMMENT '210天及以上欠款延滞次数',
  `last_loan_trans_amt` decimal(15,2) DEFAULT '0.00' COMMENT '最近一次贷记交易金额',
  `last_loan_trans_date` datetime DEFAULT NULL COMMENT '最近一次贷记交易日期',
  `last_debit_trans_amt` decimal(15,2) DEFAULT '0.00' COMMENT '最近一次借记交易金额',
  `last_debit_trans_date` datetime DEFAULT NULL COMMENT '最近一次借记交易日期',
  `cur_cyc_debit_cnt` int(11) DEFAULT NULL COMMENT '本周期借记笔数',
  `cur_cyc_cash_cnt` int(11) DEFAULT NULL COMMENT '本周期取现笔数',
  `auto_pm_debit_card_no` varchar(20) DEFAULT NULL COMMENT '自动还款借记卡卡号',
  `auto_payment_mode` varchar(20) DEFAULT NULL COMMENT '自动还款方式',
  `auto_pm_sg_or_tm_date` datetime DEFAULT NULL COMMENT '自动还款签约/解约日期',
  `auto_payment_act_date` datetime DEFAULT NULL COMMENT '自动还款激活日期',
  `auto_payment_amt` decimal(15,2) DEFAULT NULL COMMENT '自动还款金额',
  `auto_pay_rtn_rsn_code` varchar(4) DEFAULT NULL COMMENT '自动还款返回原因码',
  `apply_no` varchar(30) DEFAULT NULL COMMENT '申请编号',
  `sales_code` varchar(20) DEFAULT NULL COMMENT '营销代码',
  `source_code` varchar(10) DEFAULT NULL COMMENT '来源代码',
  `dispute_amt` decimal(15,2) DEFAULT '0.00' COMMENT '争议金额',
  `dispute_cnt` int(11) DEFAULT '0' COMMENT '争议笔数',
  `delinquent_days` int(11) DEFAULT NULL COMMENT '拖欠天数',
  `ver_identity` varchar(20) DEFAULT NULL COMMENT '核销标识',
  `ver_reason` varchar(60) DEFAULT NULL COMMENT '核销原因',
  `ver_chg_date` datetime DEFAULT NULL COMMENT '核销标识变更日期',
  `pre_appr_lmt_flag` char(1) DEFAULT NULL COMMENT '预批额度标识',
  `ins_poundage_bal` decimal(15,2) DEFAULT '0.00' COMMENT '分期手续费用余额',
  `spend_ini_amt` decimal(15,2) DEFAULT '0.00' COMMENT '消费起始金额',
  `statement_day` varchar(20) DEFAULT NULL COMMENT '账单日',
  `branch_org` varchar(4) DEFAULT NULL COMMENT '分行机构',
  `apply_score` varchar(4) DEFAULT NULL COMMENT '申请评分',
  `bank_no` varchar(20) DEFAULT NULL COMMENT '银行编号',
  `app_source_code` varchar(10) DEFAULT NULL COMMENT '发卡专案代码',
  `compound_interest_bal` decimal(15,2) DEFAULT NULL COMMENT '复利余额',
  `no_interest_bal` decimal(15,2) DEFAULT NULL COMMENT '不计息余额',
  `first_loan_cash_date` datetime DEFAULT NULL COMMENT '第一次交易为预借现金日期',
  `last_close_acct_date` datetime DEFAULT NULL COMMENT '最近关账日期',
  `close_acct_code` varchar(4) DEFAULT NULL COMMENT '关账代码',
  `warrant_flag` char(20) DEFAULT NULL COMMENT '担保标识',
  `highest_spend_amt` decimal(15,2) DEFAULT NULL COMMENT '最高消费金额',
  `highest_spend_date` datetime DEFAULT NULL COMMENT '最高消费日期',
  `last_dispute_date` datetime DEFAULT NULL COMMENT '最近一次争议款产生日期',
  `ins_cur_amt` decimal(15,2) DEFAULT NULL COMMENT '分期付款本期分摊金额',
  `ins_remain_principal` decimal(15,2) DEFAULT NULL COMMENT '分期付款目前剩余本金',
  `in_oct_num` int(11) DEFAULT NULL COMMENT '进入OCT队列次数',
  `in_oct_date` datetime DEFAULT NULL COMMENT '进入OCT队列日期',
  `loan_overdue_flag` char(20) DEFAULT NULL COMMENT '贷款逾期状态标识',
  `cur_payment_amt` decimal(15,2) DEFAULT NULL COMMENT '当期已还款金额',
  `sub_division_code` varchar(4) DEFAULT NULL COMMENT '细分类代码',
  `stmt_spend_bal` decimal(15,2) DEFAULT NULL COMMENT '账单消费余额',
  `stmt_cash_bal` decimal(15,2) DEFAULT NULL COMMENT '账单日计息余额',
  `stmt_cash_bal_sign` char(1) DEFAULT NULL COMMENT '账单日计息余额符号',
  `stmt_no_int_bal` decimal(15,2) DEFAULT NULL COMMENT '账单免息余额',
  `stmt_interest_bal` decimal(15,2) DEFAULT NULL COMMENT '账单利息余额',
  `ins_no_stmt_bal` decimal(15,2) DEFAULT NULL COMMENT '分期付款未出账单余额',
  `ins_no_stmt_bal_sign` char(1) DEFAULT NULL COMMENT '分期付款未出账单余额符号',
  `ins_stmt_bal` decimal(15,2) DEFAULT NULL COMMENT '分期付款已出账单余额',
  `ins_stmt_bal_sign` char(1) DEFAULT NULL COMMENT '分期付款已出账单余额符号',
  `acct_layer_code_1` varchar(4) DEFAULT NULL COMMENT '账户分层代码1',
  `acct_layer_code_2` varchar(4) DEFAULT NULL COMMENT '账户分层代码2',
  `stop_ins_flag` char(20) DEFAULT NULL COMMENT '停止分期业务标识',
  `STOP_INS_DATE` datetime DEFAULT NULL COMMENT '停止分期日期',
  `cur_big_ins_bal` decimal(15,2) DEFAULT NULL COMMENT '本期大额分期余额',
  `last_big_ins_bal` decimal(15,2) DEFAULT NULL COMMENT '上期大额分期余额',
  `creditor_adj_amt` decimal(15,2) DEFAULT NULL COMMENT '贷方调整金额',
  `stmt_addr_type` varchar(4) DEFAULT NULL COMMENT '账单地址类型',
  `keep_field` varchar(30) DEFAULT NULL COMMENT '保留字段',
  `crt_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `crt_user` varchar(20) DEFAULT 'SYSTEM' COMMENT '创建人',
  `upd_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `upd_user` varchar(20) DEFAULT 'SYSTEM' COMMENT '更新人',
  `bt_date` date DEFAULT NULL COMMENT '批量日期',
  `MATRUITY_REPAY_DATE` datetime DEFAULT NULL COMMENT '到期还款处理日',
  `CREDIT_LIMIT` decimal(15,2) DEFAULT NULL COMMENT '账户的信用额度',
  `LOAN_PURPOSE` varchar(100) DEFAULT NULL COMMENT '贷款用途',
  `DEBUCTED_BANK` varchar(50) DEFAULT NULL COMMENT '代扣银行分行',
  `LAST_DD_RESULT` varchar(100) DEFAULT NULL COMMENT '最近一次代扣行回盘结果 last DD result（将交易时间、交易金额、交易结果合并为一个字段）',
  `IS_PREPAYMENT` varchar(20) DEFAULT NULL COMMENT '是否提前还款',
  `PREPAYMENT_DATE` datetime DEFAULT NULL COMMENT '提前还款日期',
  `PREPAYMENT_AMT` decimal(15,2) DEFAULT NULL COMMENT '提前还款金额',
  `IS_EXEMPT` varchar(20) DEFAULT NULL COMMENT '是否小额豁免',
  `EXEMPT_DATE` datetime DEFAULT NULL COMMENT '豁免时间',
  `EXEMPT_AMT` decimal(15,2) DEFAULT NULL COMMENT '豁免金额',
  `VER_TYPE` varchar(20) DEFAULT NULL COMMENT '核销类型',
  `receivable_amt` decimal(15,2) DEFAULT '0.00' COMMENT '应还款额',
  `etl_date` datetime DEFAULT NULL COMMENT 'etl日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='催收数据中间表(最后还款日后最新数据)';

-- ----------------------------
-- Table structure for certificate_org_agency
-- ----------------------------
DROP TABLE IF EXISTS `certificate_org_agency`;
CREATE TABLE `certificate_org_agency` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `org_agency_id` bigint(31) NOT NULL COMMENT '证书发起注册机构(合作单位id/组织机构id)',
  `org_agency_type` int(2) DEFAULT NULL COMMENT '证书发起注册机构类型(合作单位2,组织机构1)',
  `certificate_id` bigint(31) NOT NULL COMMENT '证书表id',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:否 1:是)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_org_agency_id` (`org_agency_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='证书注册表和机构(合作单位和组织机构关联表)';

-- ----------------------------
-- Table structure for certificate_register
-- ----------------------------
DROP TABLE IF EXISTS `certificate_register`;
CREATE TABLE `certificate_register` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `social_credit_code` varchar(31) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '社会统一信用代码',
  `certificate_register_org_name` varchar(31) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '证书注册机构名称',
  `legal_representative_name` varchar(31) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '法人代表姓名',
  `legal_representative_phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '法人代表手机号',
  `legal_representative_idcard` varchar(31) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '法人代表证件号',
  `certificate_register_status` int(1) unsigned zerofill DEFAULT '0' COMMENT '证书注册状态',
  `certificate_serial_number` varchar(31) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '证书序列号',
  `certificate_pwd` varchar(31) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '证书密码',
  `electronic_stamp_pic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子印章图片',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='证书注册表';

-- ----------------------------
-- Table structure for chechong_relate
-- ----------------------------
DROP TABLE IF EXISTS `chechong_relate`;
CREATE TABLE `chechong_relate` (
  `carid` int(11) DEFAULT NULL,
  `chechongid` int(11) DEFAULT NULL,
  `carbrand` int(11) DEFAULT NULL,
  `carbrandname` varchar(255) DEFAULT NULL,
  `carmake` varchar(255) DEFAULT NULL,
  `carmakename` varchar(255) DEFAULT NULL,
  `carmodel` int(11) DEFAULT NULL,
  `carmodelname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for checkout_car_apply
-- ----------------------------
DROP TABLE IF EXISTS `checkout_car_apply`;
CREATE TABLE `checkout_car_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `checkout_car_num` varchar(100) DEFAULT NULL COMMENT '出库编号',
  `drag_car_id` bigint(20) NOT NULL COMMENT '拖车ID',
  `checkout_reason` int(11) DEFAULT NULL COMMENT '出库理由（1:全额结清垫款本息及银行垫款,2:结清当前垫款本息及银行月供,3:公司处置,4:法院执行）',
  `other_reason` varchar(255) DEFAULT NULL COMMENT '其他理由',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `memo` varchar(255) DEFAULT NULL COMMENT '情况描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `launch_user_id` bigint(20) DEFAULT NULL,
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '发起人',
  `branch_manager_id` bigint(20) DEFAULT NULL,
  `branch_manager_name` varchar(50) DEFAULT NULL COMMENT '分公司副总审批人',
  `finance_remark` varchar(255) DEFAULT NULL COMMENT '财务审批备注',
  `payee_date` datetime DEFAULT NULL COMMENT '收款时间',
  PRIMARY KEY (`id`),
  KEY `IDX_DRAG_CAR_ID` (`drag_car_id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cls_etl_status
-- ----------------------------
DROP TABLE IF EXISTS `cls_etl_status`;
CREATE TABLE `cls_etl_status` (
  `etl_id` varchar(32) NOT NULL COMMENT 'ETL主键',
  `etl_key` varchar(32) NOT NULL COMMENT 'ETL_KEY',
  `etl_name` varchar(32) NOT NULL COMMENT 'ETL注释',
  `batch_date` date DEFAULT NULL COMMENT 'ETL日期',
  `batch_flag` int(5) DEFAULT '1' COMMENT '跑批标识(1,已跑批，2，下游已跑批)',
  `crt_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `upd_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`etl_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局参数配置表';

-- ----------------------------
-- Table structure for cls_feedback_question
-- ----------------------------
DROP TABLE IF EXISTS `cls_feedback_question`;
CREATE TABLE `cls_feedback_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) DEFAULT NULL COMMENT '内容，目前限制2000字',
  `pictures` varchar(255) DEFAULT NULL COMMENT '附图，逗号分隔',
  `user_id` bigint(20) DEFAULT NULL COMMENT '提问人userId',
  `user_name` varchar(20) DEFAULT NULL,
  `user_realname` varchar(255) DEFAULT NULL COMMENT '提问人姓名',
  `company_name` varchar(20) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '问题类型',
  `status` int(4) DEFAULT NULL COMMENT '当前状态 1：未回复 2：已回复',
  `last_reply_time` datetime DEFAULT NULL COMMENT '最后回复时间',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modity_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='车贷系统-在线提问-问题表';

-- ----------------------------
-- Table structure for cls_feedback_reply
-- ----------------------------
DROP TABLE IF EXISTS `cls_feedback_reply`;
CREATE TABLE `cls_feedback_reply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question_id` bigint(20) DEFAULT NULL COMMENT '问题主ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '回复人userId',
  `user_realname` varchar(255) DEFAULT NULL COMMENT '回复人姓名',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modity_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='车贷系统-在线提问-回复表';

-- ----------------------------
-- Table structure for cls_score_field
-- ----------------------------
DROP TABLE IF EXISTS `cls_score_field`;
CREATE TABLE `cls_score_field` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '主键',
  `sys_field` varchar(765) DEFAULT NULL COMMENT '系统字段',
  `field_name` varchar(765) DEFAULT NULL COMMENT '字段名称',
  `value_rule` int(11) DEFAULT NULL COMMENT '取值规则(1:求和，2:或，3:取最大,4:自定义)',
  `is_valid` tinyint(1) DEFAULT '1',
  `create_time` datetime DEFAULT NULL,
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='评分字段表';

-- ----------------------------
-- Table structure for cls_score_field_rule
-- ----------------------------
DROP TABLE IF EXISTS `cls_score_field_rule`;
CREATE TABLE `cls_score_field_rule` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '主键',
  `score_field_id` bigint(20) DEFAULT NULL COMMENT '评分字段ID',
  `sys_field` varchar(765) DEFAULT NULL COMMENT '系统字段',
  `with_relationship` int(6) DEFAULT NULL COMMENT '关系类型（1：主贷人，2：配偶，3：担保人，4：反担保人）',
  `is_provide` tinyint(1) DEFAULT NULL COMMENT '是否需要提供材料(1:是,0:否)',
  `check_hint` varchar(765) DEFAULT NULL COMMENT '材料清单（材料清单命中后，【提醒】评分材料收集清单-文案）',
  `is_verify` tinyint(1) DEFAULT NULL COMMENT '是否生成核实清单(1:是,0:否)',
  `verify_hint` varchar(765) DEFAULT NULL COMMENT '材料清单勾选后自动生成-核实文案',
  `remind` varchar(765) DEFAULT NULL COMMENT '【提醒】评分材料收集清单-文案',
  `rule_expression` varchar(1536) DEFAULT NULL COMMENT '规则表达式',
  `rule_score` float DEFAULT NULL COMMENT '计分值',
  `rule_desc` varchar(765) DEFAULT NULL COMMENT '规则描述',
  `is_valid` tinyint(1) DEFAULT '1',
  `create_time` datetime DEFAULT NULL,
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_SCORE_FIELD_ID` (`score_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='评分字段积分规则表';

-- ----------------------------
-- Table structure for cls_score_field_rule_copy
-- ----------------------------
DROP TABLE IF EXISTS `cls_score_field_rule_copy`;
CREATE TABLE `cls_score_field_rule_copy` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '主键',
  `score_field_id` bigint(20) DEFAULT NULL COMMENT '评分字段ID',
  `sys_field` varchar(765) DEFAULT NULL COMMENT '系统字段',
  `with_relationship` int(6) DEFAULT NULL COMMENT '关系类型（1：主贷人，2：配偶，3：担保人，4：反担保人）',
  `is_provide` tinyint(1) DEFAULT NULL COMMENT '是否需要提供材料(1:是,0:否)',
  `check_hint` varchar(765) DEFAULT NULL COMMENT '材料清单（材料清单命中后，【提醒】评分材料收集清单-文案）',
  `is_verify` tinyint(1) DEFAULT NULL COMMENT '是否生成核实清单(1:是,0:否)',
  `verify_hint` varchar(765) DEFAULT NULL COMMENT '材料清单勾选后自动生成-核实文案',
  `remind` varchar(765) DEFAULT NULL COMMENT '【提醒】评分材料收集清单-文案',
  `rule_expression` varchar(1536) DEFAULT NULL COMMENT '规则表达式',
  `rule_score` float DEFAULT NULL COMMENT '计分值',
  `rule_desc` varchar(765) DEFAULT NULL COMMENT '规则描述',
  `is_valid` tinyint(1) DEFAULT '1',
  `create_time` datetime DEFAULT NULL,
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_SCORE_FIELD_ID` (`score_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='评分字段积分规则表';

-- ----------------------------
-- Table structure for cls_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `cls_sms_log`;
CREATE TABLE `cls_sms_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `busi_type` varchar(255) DEFAULT NULL COMMENT '业务类型:CAR_DEALER_ORDER车商订单;',
  `busi_id` bigint(20) DEFAULT NULL COMMENT '业务ID',
  `status` int(11) DEFAULT '0' COMMENT '0:未发送,1:已发送',
  `msg_context` varchar(512) DEFAULT NULL COMMENT '短信内容',
  `msg_receiver` varchar(255) DEFAULT NULL COMMENT '短信接收者',
  `mobile` varchar(20) DEFAULT NULL COMMENT '接收者手机号码',
  `msg_result` varchar(512) DEFAULT NULL COMMENT '发送结果',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `IDX_BUSI_ID` (`busi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cls_sms_templ
-- ----------------------------
DROP TABLE IF EXISTS `cls_sms_templ`;
CREATE TABLE `cls_sms_templ` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `template_id` varchar(32) DEFAULT NULL COMMENT '模板ID',
  `template_code` varchar(20) DEFAULT NULL COMMENT '模板code',
  `template_name` varchar(100) DEFAULT NULL COMMENT '模板名称',
  `template_content` varchar(500) DEFAULT NULL COMMENT '模板内容',
  `keyword` varchar(20) DEFAULT NULL COMMENT '中间件keyword',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATE_USER` varchar(20) DEFAULT NULL COMMENT '创建人',
  `MODIFY_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFY_USER` varchar(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='短信模板表';

-- ----------------------------
-- Table structure for cls_smsgroupsending_info
-- ----------------------------
DROP TABLE IF EXISTS `cls_smsgroupsending_info`;
CREATE TABLE `cls_smsgroupsending_info` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `INFOR_SEND_TIME` datetime DEFAULT NULL COMMENT '消息发送时间',
  `template_code` varchar(20) DEFAULT NULL COMMENT '模板code',
  `template_name` varchar(50) DEFAULT NULL COMMENT '模板名称',
  `template_content` varchar(500) DEFAULT NULL COMMENT '模板内容',
  `SEND_NUM` int(11) DEFAULT NULL COMMENT '发送号码数量',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CREATE_USER` varchar(20) DEFAULT NULL COMMENT '创建人',
  `MODIFY_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFY_USER` varchar(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='短信群发记录表';

-- ----------------------------
-- Table structure for code_library
-- ----------------------------
DROP TABLE IF EXISTS `code_library`;
CREATE TABLE `code_library` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code_id` varchar(500) DEFAULT NULL COMMENT '数据字典所属类型下的Id',
  `code_name` varchar(150) DEFAULT NULL COMMENT '数据字典名称',
  `code_type` varchar(150) DEFAULT NULL COMMENT '数据字典所属类型',
  `sort_no` varchar(9) DEFAULT NULL COMMENT '数据字典排序(一般以1开始);也可作他用',
  `describe` varchar(4000) DEFAULT NULL COMMENT '数据字典说明',
  `is_inuse` tinyint(1) DEFAULT NULL COMMENT '是否启用(0-否;1-是)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_code_id` (`code_id`) USING BTREE,
  KEY `idx_code_type` (`code_type`) USING BTREE,
  KEY `idx_is_inuse` (`is_inuse`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14107 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for company_acc_info
-- ----------------------------
DROP TABLE IF EXISTS `company_acc_info`;
CREATE TABLE `company_acc_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) DEFAULT NULL COMMENT '公司id',
  `acc_name` varchar(255) DEFAULT NULL COMMENT '账户名称',
  `company_type` int(2) DEFAULT NULL COMMENT '1总公司账户2分公司账户',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `status` int(2) DEFAULT '1' COMMENT '1启用0禁用',
  `sort_no` int(4) DEFAULT NULL COMMENT '序号',
  `opening_bank` varchar(55) DEFAULT NULL COMMENT '开户行',
  `open_bank_name` varchar(255) DEFAULT NULL COMMENT '银行中文名称',
  `sub_bank_name` varchar(55) DEFAULT NULL COMMENT '支行名称',
  `card_number` varchar(25) DEFAULT NULL COMMENT '卡号',
  `acc_type` int(11) DEFAULT NULL COMMENT '账户类型,1:对公账户,2:个人账户',
  `acc_purpose` int(11) DEFAULT NULL COMMENT '账户用途：1:公司账号 、2:垫款账号、3:贴息账号',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_advance` int(11) DEFAULT NULL COMMENT '1是车贷垫款账户，0不是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='公司账户表';

-- ----------------------------
-- Table structure for company_file_config
-- ----------------------------
DROP TABLE IF EXISTS `company_file_config`;
CREATE TABLE `company_file_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL COMMENT '机构id',
  `files` int(5) DEFAULT NULL COMMENT '发件资料',
  PRIMARY KEY (`id`),
  KEY `idx_cfc_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for company_info
-- ----------------------------
DROP TABLE IF EXISTS `company_info`;
CREATE TABLE `company_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '企业名称',
  `intro` varchar(1000) DEFAULT NULL COMMENT '简介',
  `tags` varchar(255) DEFAULT NULL COMMENT '标签',
  `money` varchar(255) DEFAULT NULL COMMENT '资金规模',
  `single_money` varchar(255) DEFAULT NULL COMMENT '投资规模',
  `areas` varchar(500) DEFAULT NULL COMMENT '投资领域',
  `rounds` varchar(100) DEFAULT NULL COMMENT '投资轮次',
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `wechat` varchar(30) DEFAULT NULL,
  `founded_time` datetime DEFAULT NULL COMMENT '成立时间',
  `img` varchar(100) DEFAULT NULL COMMENT 'logo图',
  `deleted` tinyint(2) DEFAULT NULL COMMENT '是否删除',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资机构表';

-- ----------------------------
-- Table structure for company_info_config
-- ----------------------------
DROP TABLE IF EXISTS `company_info_config`;
CREATE TABLE `company_info_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `company_name` varchar(255) DEFAULT NULL COMMENT '公司名称(业务机构)',
  `manager_name` varchar(255) DEFAULT NULL COMMENT '经办经理',
  `manager_phone` varchar(255) DEFAULT NULL COMMENT '经办经理联系电话',
  `company_service_phone` varchar(255) DEFAULT NULL COMMENT '分公司客服电话',
  `compensation_department_phone` varchar(255) DEFAULT NULL COMMENT '理赔部门固定电话',
  `company_id` bigint(20) DEFAULT NULL COMMENT '公司Id',
  `downpayment_add` decimal(10,2) DEFAULT NULL COMMENT '首期偿还增加值',
  `question_phone_json_str` varchar(1000) DEFAULT NULL COMMENT '常见问题电话集',
  `language_version` int(2) DEFAULT NULL COMMENT '1维语0汉语',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for constraint_valid_config
-- ----------------------------
DROP TABLE IF EXISTS `constraint_valid_config`;
CREATE TABLE `constraint_valid_config` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `business_object_id` bigint(11) NOT NULL COMMENT '业务对像ID',
  `business_type` varchar(100) NOT NULL COMMENT '业务类型，标识此为哪一种业务对象',
  `is_valid` tinyint(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='规则逃逸表';

-- ----------------------------
-- Table structure for consume_loan
-- ----------------------------
DROP TABLE IF EXISTS `consume_loan`;
CREATE TABLE `consume_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `consume_loan_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '消费贷款金额',
  `purchase_tax` decimal(24,6) DEFAULT '0.000000' COMMENT '购置税',
  `insurance_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '保险金额',
  `decorate_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '其他费用（汽车装潢等费用）',
  `account_name` varchar(255) DEFAULT NULL COMMENT '打款账户名',
  `account_no` varchar(255) DEFAULT NULL COMMENT '打款帐号',
  `account_bank` varchar(255) DEFAULT NULL COMMENT '开户行',
  `pay_amount` decimal(24,6) DEFAULT NULL COMMENT '付款金额',
  `pay_status` int(5) DEFAULT '0' COMMENT '支付状态0 初始化 1付款中 2付款成功 3 付款失败 4人工付款',
  `pay_type` int(5) DEFAULT '0' COMMENT '0人工付款 1CBS系统',
  `is_pay_purchase_tax` tinyint(2) DEFAULT NULL COMMENT '付款是否有购置税（0否1有）',
  `is_pay_insurance_amount` tinyint(2) DEFAULT NULL COMMENT '付款是否有保险金额（0否1有）',
  `is_pay_decorate_amount` tinyint(2) DEFAULT NULL COMMENT '付款是否包含其他费用（0否1有）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '操作人',
  `pay_date` datetime DEFAULT NULL COMMENT '打款日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请Id',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，0：停用）',
  `payee_method` int(10) DEFAULT NULL COMMENT '收款处理方式（1：差额处理；2：全额回款）',
  `payment_direction` int(1) DEFAULT NULL COMMENT '支付方向（1：收款；2：付款）',
  `payee_amount` decimal(24,6) DEFAULT NULL COMMENT '收款金额',
  `payee_date` date DEFAULT NULL COMMENT '退款时间',
  `is_buy_accident_insurance` int(1) DEFAULT '0' COMMENT '是否购买人生意外险(0:否 1:是)',
  `is_finance_accident_insurance` int(1) DEFAULT NULL COMMENT '是否融贷人生意外险(0:否 1:是)',
  `life_accident_insurance` decimal(31,0) DEFAULT '0' COMMENT '人生意外险费用',
  `is_buy_decorate_amount` int(1) DEFAULT '0' COMMENT '是否购买其他费用(车辆盗抢服务费)',
  `is_finance_decorate_amount` int(1) DEFAULT NULL COMMENT '是否融贷其他费用(车辆盗抢服务费)',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `idx_loan_apply_id` (`loan_apply_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3895 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for continuous_overdue_times_history
-- ----------------------------
DROP TABLE IF EXISTS `continuous_overdue_times_history`;
CREATE TABLE `continuous_overdue_times_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `dealer_id` bigint(20) DEFAULT NULL,
  `continuous_overdue_times` int(3) DEFAULT NULL COMMENT '连续逾期次数',
  `year` int(5) DEFAULT NULL COMMENT '年份',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50033 DEFAULT CHARSET=utf8 COMMENT='连续逾期次数年历史记录表';

-- ----------------------------
-- Table structure for contracts_item
-- ----------------------------
DROP TABLE IF EXISTS `contracts_item`;
CREATE TABLE `contracts_item` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contract_no` varchar(50) NOT NULL COMMENT '文件合同编号',
  `delivey_no` varchar(50) DEFAULT NULL,
  `contract_id` bigint(11) DEFAULT NULL COMMENT '收件编号',
  `contract_type` varchar(20) NOT NULL COMMENT '抵押合同:GUARANTY,还款合同:REPAYMENT,抵押委托书:GUARANTYTRUST,抵押申请表:GUARANTYAPPLY',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `contract_receive_state` int(11) NOT NULL DEFAULT '0' COMMENT '合同接收状态',
  `contract_get_state` int(11) NOT NULL DEFAULT '0' COMMENT '合同出库状态：0.未出库 1.已经出库 2.出库中',
  `use_state` int(11) NOT NULL DEFAULT '0' COMMENT '使用状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `company_id` bigint(11) DEFAULT NULL COMMENT '公司编号',
  `company_name` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `manager` varchar(20) DEFAULT NULL COMMENT '责任人',
  `receive_company` varchar(20) DEFAULT NULL COMMENT '收件公司',
  `tranfer_state` varchar(20) DEFAULT NULL COMMENT '当前文件中转状态',
  `tranfer_time` datetime DEFAULT NULL COMMENT '当前文件中转时间',
  `print_state` int(11) DEFAULT '0' COMMENT '打印状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_ContractNo` (`contract_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同明细';

-- ----------------------------
-- Table structure for contracts_operator
-- ----------------------------
DROP TABLE IF EXISTS `contracts_operator`;
CREATE TABLE `contracts_operator` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contract_no` varchar(50) NOT NULL COMMENT '合同编号',
  `customer_id` bigint(11) NOT NULL COMMENT '客户编号',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `project_id` bigint(20) DEFAULT NULL COMMENT '当前贷款编号',
  `project_no` varchar(50) DEFAULT NULL COMMENT '贷款编号',
  `signed_state` int(11) DEFAULT '0' COMMENT '签单状态',
  `signed_time` datetime DEFAULT NULL COMMENT '签单时间',
  `contract_write_state` int(11) DEFAULT '0' COMMENT '合同抄写状态 ',
  `contract_write_time` datetime DEFAULT NULL COMMENT '合同抄写时间',
  `guaranty_state` int(11) DEFAULT '0' COMMENT '抵押状态',
  `guaranty_time` datetime DEFAULT NULL COMMENT '抵押时间',
  `bank_check_state` int(11) DEFAULT '0' COMMENT '银行核销状态',
  `bank_check_time` datetime DEFAULT NULL COMMENT '银行核销时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_contractNo_projectId` (`contract_no`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空白合同操作数据';

-- ----------------------------
-- Table structure for contracts_opr_logs
-- ----------------------------
DROP TABLE IF EXISTS `contracts_opr_logs`;
CREATE TABLE `contracts_opr_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contract_no` varchar(50) NOT NULL COMMENT '合同编号',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `tranfer_state` varchar(20) NOT NULL COMMENT '文件中转类型',
  `operater` varchar(30) NOT NULL COMMENT '当前操作人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单个合同操作日志';

-- ----------------------------
-- Table structure for contracts_order
-- ----------------------------
DROP TABLE IF EXISTS `contracts_order`;
CREATE TABLE `contracts_order` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `delivey_no` varchar(50) NOT NULL COMMENT '快递单号',
  `delivey_company` varchar(50) NOT NULL COMMENT '快递公司',
  `delivey_bank_id` bigint(11) DEFAULT NULL COMMENT '发件银行ID',
  `delivey_bank` varchar(50) NOT NULL COMMENT '发件银行',
  `delivey_time` datetime NOT NULL COMMENT '发件时间',
  `delivey_personal` varchar(100) DEFAULT NULL COMMENT '发件人',
  `delivey_mobile` varchar(15) NOT NULL COMMENT '发件人手机',
  `receive_company` varchar(30) NOT NULL COMMENT '收件公司',
  `receive_company_id` bigint(11) NOT NULL COMMENT '收件公司ID',
  `receiver` varchar(20) NOT NULL COMMENT '收件人',
  `manager` varchar(20) NOT NULL COMMENT '责任人',
  `receive_posit` varchar(30) NOT NULL COMMENT '收件位置',
  `receive_remark` varchar(200) DEFAULT NULL COMMENT '收件备注',
  `guaranty_nums` int(11) NOT NULL COMMENT '抵押合同数量',
  `repayment_nums` int(11) NOT NULL COMMENT '还款合同数量',
  `guaranty_trust_nums` int(11) NOT NULL COMMENT '抵押委托书数量',
  `guaranty_apply_nums` int(11) NOT NULL COMMENT '抵押申请合同数量',
  `totals` int(11) NOT NULL COMMENT '合同总数',
  `receive_time` datetime NOT NULL COMMENT '收件时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `receive_state` int(1) NOT NULL COMMENT '接收状态',
  `user_id` bigint(11) NOT NULL COMMENT '当前账号用户',
  `user_name` varchar(50) NOT NULL COMMENT '当前账号姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收件合同列表';

-- ----------------------------
-- Table structure for contracts_receives
-- ----------------------------
DROP TABLE IF EXISTS `contracts_receives`;
CREATE TABLE `contracts_receives` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `receive_no` varchar(100) NOT NULL COMMENT '领取编号',
  `type` int(1) NOT NULL COMMENT '领取方式',
  `deliery_no` varchar(50) NOT NULL COMMENT '快递单号',
  `guaranty_nums` int(11) NOT NULL DEFAULT '0' COMMENT '领取抵押合同数量',
  `repayment_nums` int(11) NOT NULL DEFAULT '0' COMMENT '领取还款合同数量',
  `guaranty_trust_nums` int(11) NOT NULL DEFAULT '0' COMMENT '领取抵押委托书数量',
  `guaranty_apply_nums` int(11) NOT NULL DEFAULT '0' COMMENT '领取抵押申请书数量',
  `user_id` bigint(11) NOT NULL COMMENT '当前用户id',
  `user_name` varchar(50) NOT NULL COMMENT '当前用户姓名',
  `operater_id` bigint(11) DEFAULT NULL COMMENT '领取人ID',
  `operater` varchar(50) NOT NULL COMMENT '领取人',
  `bz_group_id` bigint(11) DEFAULT NULL COMMENT '业务组ID',
  `bz_group_name` varchar(50) DEFAULT NULL COMMENT '业务组名称',
  `manager` varchar(50) NOT NULL COMMENT '库管责任人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `state` int(11) NOT NULL COMMENT '状态',
  `company_id` bigint(11) NOT NULL COMMENT '公司机构ID',
  `company_name` varchar(255) NOT NULL COMMENT '公司机构名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='领取合同单';

-- ----------------------------
-- Table structure for contracts_receives_item
-- ----------------------------
DROP TABLE IF EXISTS `contracts_receives_item`;
CREATE TABLE `contracts_receives_item` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `receive_id` bigint(11) NOT NULL COMMENT '领取单ID',
  `contract_no` varchar(50) NOT NULL COMMENT '合同编号',
  `contract_type` varchar(20) NOT NULL DEFAULT '' COMMENT '抵押合同:GUARANTY,还款合同:REPAYMENT,抵押委托书:GUARANTYTRUST,抵押申请表:GUARANTYAPPLY',
  `contract_use_state` int(11) NOT NULL COMMENT '是否被使用 0.未使用 1.已经使用 2.已经作废',
  `company_id` bigint(11) NOT NULL COMMENT '公司编号',
  `company_name` varchar(255) NOT NULL COMMENT '公司名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `operater_id` bigint(11) DEFAULT NULL COMMENT '领用人ID',
  `operater` varchar(50) DEFAULT NULL COMMENT '领用人姓名',
  `fact_operater_id` bigint(11) DEFAULT NULL COMMENT '实际接收人ID',
  `fact_operater` varchar(50) DEFAULT NULL COMMENT '实际接收人名称',
  `store_state` int(4) DEFAULT NULL COMMENT '0.库存中 1.已出库',
  `is_in_transit` int(1) DEFAULT '0' COMMENT '是否在途0.否 1.是',
  `is_destroyed` int(1) DEFAULT '0' COMMENT '是否核销0.否 1.是',
  `store_time` datetime DEFAULT NULL COMMENT '库存操作时间',
  `pre_own_id` bigint(11) DEFAULT NULL COMMENT '上一个接收人ID',
  `pre_own` varchar(50) DEFAULT NULL COMMENT '上一个接收人名称',
  `delivey_no` varchar(50) DEFAULT NULL COMMENT '快递编号',
  `sort_index` int(11) NOT NULL COMMENT '流转索引，合同每一次流转，此值顺序递增',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `index_contractNo_contractType` (`contract_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='领取合同明细';

-- ----------------------------
-- Table structure for credit_query_record
-- ----------------------------
DROP TABLE IF EXISTS `credit_query_record`;
CREATE TABLE `credit_query_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `credit_id` bigint(20) NOT NULL COMMENT '征信id',
  `credit_no` varchar(32) NOT NULL COMMENT '征信编号',
  `operator_id` varchar(16) NOT NULL COMMENT '操作员',
  `name` varchar(128) NOT NULL COMMENT '被查询人姓名',
  `cert_type` varchar(4) NOT NULL COMMENT '被查询人证件类型,',
  `cert_no` varchar(64) NOT NULL COMMENT '被查询人证件号',
  `query_reason` varchar(256) DEFAULT NULL COMMENT '查询事由',
  `status` int(2) DEFAULT NULL COMMENT '征信状态,0:初始值,1:查询成功',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=506 DEFAULT CHARSET=utf8 COMMENT='征信查询记录表';

-- ----------------------------
-- Table structure for credit_report_detail
-- ----------------------------
DROP TABLE IF EXISTS `credit_report_detail`;
CREATE TABLE `credit_report_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `credit_id` bigint(20) DEFAULT NULL,
  `card_no` varchar(30) DEFAULT NULL,
  `dealer_name` varchar(30) DEFAULT NULL,
  `dealer_id` bigint(20) DEFAULT NULL,
  `inqury_bank` varchar(30) DEFAULT NULL,
  `inqury_bank_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(30) DEFAULT NULL,
  `customer_manager_id` bigint(20) DEFAULT NULL,
  `business_group_id` bigint(20) DEFAULT NULL,
  `customer_manager` varchar(20) DEFAULT NULL,
  `submit_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `check_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `credit_status` int(11) DEFAULT NULL,
  `loan_status` int(11) DEFAULT NULL,
  `efficiency_minutes` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for customer_base_info
-- ----------------------------
DROP TABLE IF EXISTS `customer_base_info`;
CREATE TABLE `customer_base_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '客户Id',
  `customer_no` varchar(32) DEFAULT NULL COMMENT '客户编号',
  `customer_name` varchar(32) NOT NULL COMMENT '客户姓名',
  `en_customer_name` varchar(64) DEFAULT NULL COMMENT '英文名',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(25) NOT NULL COMMENT '证件号码',
  `cert_valid_start_date` varchar(16) DEFAULT NULL COMMENT '证件有效期起始日',
  `cert_valid_end_date` varchar(16) DEFAULT NULL COMMENT '证件有效期截止日',
  `licence_issuing_authority` varchar(32) DEFAULT NULL COMMENT '发证机关',
  `mobile_phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(16) DEFAULT NULL COMMENT '出生日期(yyyy-MM-dd)',
  `gender` int(11) DEFAULT NULL COMMENT '性别(1:男;2:女)',
  `marital_status` int(11) DEFAULT NULL COMMENT '婚姻状态1:未婚(无配偶)2:已婚(有配偶)3:分居;4:离异5:丧偶6:其他',
  `spouse_name` varchar(32) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_en_name` varchar(64) DEFAULT NULL COMMENT '配偶英文名',
  `spouse_cert_type` varchar(4) DEFAULT NULL COMMENT '配偶证件类型(身份证01,其他见数据字典)',
  `spouse_cert_no` varchar(25) DEFAULT NULL COMMENT '配偶证件号码',
  `spouse_cert_valid_start_date` varchar(16) DEFAULT NULL COMMENT '配偶证件有效期起始日',
  `spouse_cert_valid_end_date` varchar(16) DEFAULT NULL COMMENT '配偶证件有效期截止日',
  `spouse_licence_issuing_authority` varchar(32) DEFAULT NULL COMMENT '配偶发证机关',
  `spouse_mobile_phone` varchar(16) DEFAULT NULL COMMENT '配偶手机号',
  `spouse_birthday` varchar(16) DEFAULT NULL COMMENT '配偶出生日期',
  `spouse_gender` int(11) DEFAULT NULL COMMENT '配偶性别(1:男;2:女)',
  `native_place` varchar(128) DEFAULT NULL COMMENT '籍贯',
  `domicile_type` int(10) DEFAULT NULL COMMENT '户籍性质1:农业,2,非农',
  `education` int(10) DEFAULT NULL COMMENT '学历(1:初中及以下;2:高中;3:大专;4:本科;5:硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位(0:无;1:学士;2:硕士;3:博士)',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1:自有住房;2:贷款购房;3:租房;4:其他)',
  `driver_licence` int(1) DEFAULT NULL COMMENT '驾照情况(0:无;1:有)',
  `personal_monthly_income` decimal(12,4) DEFAULT NULL COMMENT '个人月收入(元)',
  `household_monthly_income` decimal(12,4) DEFAULT NULL COMMENT '家庭月收入(元)',
  `personal_yearly_income` decimal(12,4) DEFAULT NULL COMMENT '个人年收入(元)',
  `household_yearly_income` decimal(12,4) DEFAULT NULL COMMENT '家庭年收入(元)',
  `personal_asset_sum` decimal(12,4) DEFAULT NULL COMMENT '个人总资产(元)',
  `personal_debt_balance` decimal(12,4) DEFAULT NULL COMMENT '个人总负债(元)',
  `housing_provident_fund_monthly_payment` decimal(12,4) DEFAULT NULL COMMENT '住房公积金月缴总额(元)',
  `housing_provident_fund_year` int(11) DEFAULT NULL COMMENT '住房公积金缴纳年限(0:无;1:一年以内;2:1年-3年;3:3年以上)',
  `social_insurance_monthly_payment` decimal(12,4) DEFAULT NULL COMMENT '社保月缴总额(元)',
  `social_insurance_year` int(11) DEFAULT NULL COMMENT '社保缴纳年限(0:无;1:一年以内;2:1年-3年;3:3年以上)',
  `industry_code` varchar(16) DEFAULT NULL COMMENT '行业编码',
  `industry_name` varchar(32) DEFAULT NULL COMMENT '行业名称',
  `profession_code` varchar(16) DEFAULT NULL COMMENT '职业编码',
  `profession_name` varchar(32) DEFAULT NULL COMMENT '职业名称',
  `post_code` varchar(16) DEFAULT NULL COMMENT '职务编码',
  `post_name` varchar(32) DEFAULT NULL COMMENT '职务名称',
  `work_unit_nature_code` varchar(16) DEFAULT NULL COMMENT '工作单位性质编码',
  `work_unit_nature_name` varchar(32) DEFAULT NULL COMMENT '工作单位性质名称',
  `work_unit_name` varchar(64) DEFAULT NULL COMMENT '工作单位名称',
  `work_unit_phone` varchar(32) DEFAULT NULL COMMENT '工作单位固定电话',
  `work_unit_postcode` varchar(32) DEFAULT NULL COMMENT '工作单位邮编',
  `work_unit_address_pid` varchar(16) DEFAULT NULL COMMENT '工作单位地址省Id',
  `work_unit_address_pname` varchar(32) DEFAULT NULL COMMENT '工作单位地址省名',
  `work_unit_address_cid` varchar(16) DEFAULT NULL COMMENT '工作单位地址市Id',
  `work_unit_address_cname` varchar(32) DEFAULT NULL COMMENT '工作单位地址市名',
  `work_unit_address_rid` varchar(16) DEFAULT NULL COMMENT '工作单位地址区Id',
  `work_unit_address_rname` varchar(32) DEFAULT NULL COMMENT '工作单位地址区名',
  `work_unit_address_detail` varchar(128) DEFAULT NULL COMMENT '工作单位详细地址',
  `work_unit_induction_time` date DEFAULT NULL COMMENT '工作单位入职时间',
  `home_phone` varchar(32) DEFAULT NULL COMMENT '家庭固定电话',
  `home_postcode` varchar(32) DEFAULT NULL COMMENT '家庭住址邮编',
  `home_address_pid` varchar(16) DEFAULT NULL COMMENT '家庭地址省Id',
  `home_address_pname` varchar(32) DEFAULT NULL COMMENT '家庭地址省名',
  `home_address_cid` varchar(16) DEFAULT NULL COMMENT '家庭地址市Id',
  `home_address_cname` varchar(32) DEFAULT NULL COMMENT '家庭地址市名',
  `home_address_rid` varchar(16) DEFAULT NULL COMMENT '家庭地址区Id',
  `home_address_rname` varchar(32) DEFAULT NULL COMMENT '家庭地址区名',
  `home_address_detail` varchar(128) DEFAULT NULL COMMENT '家庭详细地址',
  `habitation_phone` varchar(32) DEFAULT NULL COMMENT '邮寄地址固定电话',
  `habitation_postcode` varchar(32) DEFAULT NULL COMMENT '邮寄地址邮编',
  `habitation_address_pid` varchar(16) DEFAULT NULL COMMENT '邮寄地址省Id',
  `habitation_address_pname` varchar(32) DEFAULT NULL COMMENT '邮寄地址省名',
  `habitation_address_cid` varchar(16) DEFAULT NULL COMMENT '邮寄地址市Id',
  `habitation_address_cname` varchar(32) DEFAULT NULL COMMENT '邮寄地址市名',
  `habitation_address_rid` varchar(16) DEFAULT NULL COMMENT '邮寄地址区Id',
  `habitation_address_rname` varchar(32) DEFAULT NULL COMMENT '邮寄地址区名',
  `habitation_address_detail` varchar(128) DEFAULT NULL COMMENT '邮寄地址详细地址',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_ccc` (`customer_name`,`cert_type`,`cert_no`) USING BTREE COMMENT '唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=46405 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='客户基础信息表,用于记录客户及其配偶的基础信息';

-- ----------------------------
-- Table structure for customer_base_info_his
-- ----------------------------
DROP TABLE IF EXISTS `customer_base_info_his`;
CREATE TABLE `customer_base_info_his` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '客户历表史Id',
  `customer_id` bigint(20) NOT NULL COMMENT '客户Id',
  `customer_no` varchar(32) DEFAULT NULL COMMENT '客户编号',
  `customer_name` varchar(32) NOT NULL COMMENT '客户姓名',
  `en_customer_name` varchar(64) DEFAULT NULL COMMENT '英文名',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(25) NOT NULL COMMENT '证件号码',
  `cert_valid_start_date` varchar(16) DEFAULT NULL COMMENT '证件有效期起始日',
  `cert_valid_end_date` varchar(16) DEFAULT NULL COMMENT '证件有效期截止日',
  `licence_issuing_authority` varchar(32) DEFAULT NULL COMMENT '发证机关',
  `mobile_phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(16) DEFAULT NULL COMMENT '出生日期(yyyyMMdd)',
  `gender` int(11) DEFAULT NULL COMMENT '性别(1:男;2:女)',
  `marital_status` int(11) DEFAULT NULL COMMENT '婚姻状态1:未婚(无配偶)2:已婚(有配偶)3:分居;4:离异5:丧偶6:其他',
  `spouse_name` varchar(32) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_en_name` varchar(64) DEFAULT NULL COMMENT '配偶英文名',
  `spouse_cert_type` varchar(4) DEFAULT NULL COMMENT '配偶证件类型(身份证01,其他见数据字典)',
  `spouse_cert_no` varchar(25) DEFAULT NULL COMMENT '配偶证件号码',
  `spouse_cert_valid_start_date` varchar(16) DEFAULT NULL COMMENT '配偶证件有效期起始日',
  `spouse_cert_valid_end_date` varchar(16) DEFAULT NULL COMMENT '配偶证件有效期截止日',
  `spouse_licence_issuing_authority` varchar(32) DEFAULT NULL COMMENT '配偶发证机关',
  `spouse_mobile_phone` varchar(16) DEFAULT NULL COMMENT '配偶手机号',
  `spouse_birthday` varchar(16) DEFAULT NULL COMMENT '配偶出生日期',
  `spouse_gender` int(11) DEFAULT NULL COMMENT '配偶性别(1:男;2:女)',
  `native_place` varchar(128) DEFAULT NULL COMMENT '籍贯',
  `domicile_type` int(10) DEFAULT NULL COMMENT '户籍性质1:农业,2,非农',
  `education` int(10) DEFAULT NULL COMMENT '学历(1:初中及以下;2:高中;3:大专;4:本科;5:硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位(0:无;1:学士;2:硕士;3:博士)',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1:自有住房;2:贷款购房;3:租房;4:其他)',
  `driver_licence` int(1) DEFAULT NULL COMMENT '驾照情况(0:无;1:有)',
  `personal_monthly_income` decimal(12,4) DEFAULT NULL COMMENT '个人月收入(元)',
  `household_monthly_income` decimal(12,4) DEFAULT NULL COMMENT '家庭月收入(元)',
  `personal_yearly_income` decimal(12,4) DEFAULT NULL COMMENT '个人年收入(元)',
  `household_yearly_income` decimal(12,4) DEFAULT NULL COMMENT '家庭年收入(元)',
  `personal_asset_sum` decimal(12,4) DEFAULT NULL COMMENT '个人总资产(元)',
  `personal_debt_balance` decimal(12,4) DEFAULT NULL COMMENT '个人总负债(元)',
  `housing_provident_fund_monthly_payment` decimal(12,4) DEFAULT NULL COMMENT '住房公积金月缴总额(元)',
  `housing_provident_fund_year` int(11) DEFAULT NULL COMMENT '住房公积金缴纳年限(0:无;1:一年以内;2:1年-3年;3:3年以上)',
  `social_insurance_monthly_payment` decimal(12,4) DEFAULT NULL COMMENT '社保月缴总额(元)',
  `social_insurance_year` int(11) DEFAULT NULL COMMENT '社保缴纳年限(0:无;1:一年以内;2:1年-3年;3:3年以上)',
  `industry_code` varchar(16) DEFAULT NULL COMMENT '行业编码',
  `industry_name` varchar(32) DEFAULT NULL COMMENT '行业名称',
  `profession_code` varchar(16) DEFAULT NULL COMMENT '职业编码',
  `profession_name` varchar(32) DEFAULT NULL COMMENT '职业名称',
  `post_code` varchar(16) DEFAULT NULL COMMENT '职务编码',
  `post_name` varchar(32) DEFAULT NULL COMMENT '职务名称',
  `work_unit_nature_code` varchar(16) DEFAULT NULL COMMENT '工作单位性质编码',
  `work_unit_nature_name` varchar(32) DEFAULT NULL COMMENT '工作单位性质名称',
  `work_unit_name` varchar(64) DEFAULT NULL COMMENT '工作单位名称',
  `work_unit_phone` varchar(32) DEFAULT NULL COMMENT '工作单位固定电话',
  `work_unit_postcode` varchar(32) DEFAULT NULL COMMENT '工作单位邮编',
  `work_unit_address_pid` varchar(16) DEFAULT NULL COMMENT '工作单位地址省Id',
  `work_unit_address_pname` varchar(32) DEFAULT NULL COMMENT '工作单位地址省名',
  `work_unit_address_cid` varchar(16) DEFAULT NULL COMMENT '工作单位地址市Id',
  `work_unit_address_cname` varchar(32) DEFAULT NULL COMMENT '工作单位地址市名',
  `work_unit_address_rid` varchar(16) DEFAULT NULL COMMENT '工作单位地址区Id',
  `work_unit_address_rname` varchar(32) DEFAULT NULL COMMENT '工作单位地址区名',
  `work_unit_address_detail` varchar(128) DEFAULT NULL COMMENT '工作单位详细地址',
  `work_unit_induction_time` date DEFAULT NULL COMMENT '工作单位入职时间',
  `home_phone` varchar(32) DEFAULT NULL COMMENT '家庭固定电话',
  `home_postcode` varchar(32) DEFAULT NULL COMMENT '家庭住址邮编',
  `home_address_pid` varchar(16) DEFAULT NULL COMMENT '家庭地址省Id',
  `home_address_pname` varchar(32) DEFAULT NULL COMMENT '家庭地址省名',
  `home_address_cid` varchar(16) DEFAULT NULL COMMENT '家庭地址市Id',
  `home_address_cname` varchar(32) DEFAULT NULL COMMENT '家庭地址市名',
  `home_address_rid` varchar(16) DEFAULT NULL COMMENT '家庭地址区Id',
  `home_address_rname` varchar(32) DEFAULT NULL COMMENT '家庭地址区名',
  `home_address_detail` varchar(128) DEFAULT NULL COMMENT '家庭详细地址',
  `habitation_phone` varchar(32) DEFAULT NULL COMMENT '邮寄地址固定电话',
  `habitation_postcode` varchar(32) DEFAULT NULL COMMENT '邮寄地址邮编',
  `habitation_address_pid` varchar(16) DEFAULT NULL COMMENT '邮寄地址省Id',
  `habitation_address_pname` varchar(32) DEFAULT NULL COMMENT '邮寄地址省名',
  `habitation_address_cid` varchar(16) DEFAULT NULL COMMENT '邮寄地址市Id',
  `habitation_address_cname` varchar(32) DEFAULT NULL COMMENT '邮寄地址市名',
  `habitation_address_rid` varchar(16) DEFAULT NULL COMMENT '邮寄地址区Id',
  `habitation_address_rname` varchar(32) DEFAULT NULL COMMENT '邮寄地址区名',
  `habitation_address_detail` varchar(128) DEFAULT NULL COMMENT '邮寄地址详细地址',
  `habitation_check_in_time` date DEFAULT NULL COMMENT '居住地入住时间',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_ccc` (`customer_name`,`cert_type`,`cert_no`) USING BTREE COMMENT '客户关键信息索引',
  KEY `idx_customer_id` (`customer_id`) USING BTREE COMMENT '客户表id'
) ENGINE=InnoDB AUTO_INCREMENT=46382 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='客户基础信息表,用于记录客户及其配偶的基础信息';

-- ----------------------------
-- Table structure for customer_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `customer_blacklist`;
CREATE TABLE `customer_blacklist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(32) NOT NULL COMMENT '证件号码',
  `storage_reason` varchar(500) DEFAULT NULL COMMENT '入库原因',
  `storage_time` datetime DEFAULT NULL COMMENT '入库时间',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name_certtype_certno_isinuse` (`name`,`cert_type`,`cert_no`,`is_inuse`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='客户黑名单表';

-- ----------------------------
-- Table structure for customer_credit
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit`;
CREATE TABLE `customer_credit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '征信Id',
  `credit_no` varchar(32) CHARACTER SET latin1 NOT NULL COMMENT '征信编号',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户Id',
  `customer_name` varchar(32) NOT NULL COMMENT '客户名称',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(32) NOT NULL COMMENT '证件号码',
  `biz_type` varchar(4) NOT NULL COMMENT '业务类型(汽车消费分期01 其他见数据字典)',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型(如0101:新车;0102:二手车;其余见数据字典))',
  `auth_type` varchar(4) NOT NULL COMMENT '鉴权类型(见数据字典)',
  `sign_type` int(11) NOT NULL COMMENT '签约类型(1:电子签约;2:影像上传)',
  `agency_org_id` bigint(20) NOT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) NOT NULL COMMENT '合作单位名称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `apply_time` datetime NOT NULL COMMENT '进件时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_credit_no` (`credit_no`) USING BTREE,
  KEY `idx_customer_name` (`customer_name`) USING BTREE,
  KEY `idx_ccbbas` (`cert_no`,`cert_type`,`biz_type`,`biz_product_type`,`agency_org_id`,`branch_org_id`) USING BTREE,
  KEY `idx_sub_org_id` (`sub_org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177976 DEFAULT CHARSET=utf8 COMMENT='征信主表，记录征信进件的基础信息';

-- ----------------------------
-- Table structure for customer_credit_auth
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_auth`;
CREATE TABLE `customer_credit_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_no` varchar(100) NOT NULL COMMENT '唯一认证标识号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户编号',
  `customer_name` varchar(30) DEFAULT NULL,
  `id_number` varchar(30) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `auth_state` varchar(20) DEFAULT NULL COMMENT '认证结果状态',
  `auth_result_no` varchar(50) DEFAULT NULL COMMENT '认证结果编号',
  `driver` varchar(10) DEFAULT '0' COMMENT '是否有驾驶证书（0.无 1.有）',
  `state` int(1) DEFAULT NULL COMMENT '0.有效1.无效',
  `create_time` datetime DEFAULT NULL COMMENT '申请时间',
  `auth_time` datetime DEFAULT NULL COMMENT '认证时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_customer` (`customer_id`) USING BTREE,
  KEY `idx_name_idnumber_mobile` (`customer_name`,`id_number`,`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='大数据征信基础信息';

-- ----------------------------
-- Table structure for customer_credit_auth_contacter
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_auth_contacter`;
CREATE TABLE `customer_credit_auth_contacter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_id` int(11) NOT NULL COMMENT '大数据征信主键',
  `name` varchar(30) DEFAULT NULL COMMENT '联系人姓名',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号码',
  `relative` varchar(10) DEFAULT NULL COMMENT '与借款人关系',
  `relative2` varchar(10) DEFAULT NULL COMMENT '第三方关系码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='大数据征信常用联系人';

-- ----------------------------
-- Table structure for customer_credit_ext
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_ext`;
CREATE TABLE `customer_credit_ext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '征信扩展表Id',
  `credit_id` bigint(20) NOT NULL COMMENT '征信Id',
  `last_credit_id` bigint(20) DEFAULT NULL COMMENT '上次征信Id(预留备用字段)',
  `external_serial_no` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '与此征信关联的外部订单流水号(预留备用字段)',
  `expect_loan_amount` decimal(12,4) DEFAULT NULL COMMENT '意向贷款金额(元)',
  `expect_extra_loan_amount` decimal(12,4) DEFAULT NULL COMMENT '意向专项贷金额(元)',
  `expect_loan_term` varchar(4) CHARACTER SET utf8 DEFAULT NULL COMMENT '意向贷款期限(月)',
  `loan_purpose` varchar(512) CHARACTER SET utf8 DEFAULT NULL COMMENT '贷款用途（v2.5.0）',
  `pre_check_bank_card` int(11) DEFAULT '0' COMMENT '是否预校验银行卡(0:不校验;1:校验 )(v2.5.0)',
  `auth_result` int(11) DEFAULT NULL COMMENT '鉴权总结果(0:不通过;1:通过)',
  `sign_result` int(11) NOT NULL DEFAULT '0' COMMENT '签约结果(0:未签约授权;1:已签约授权)',
  `sign_finish_time` datetime DEFAULT NULL COMMENT '签约完成时间',
  `ocr_status` int(11) DEFAULT '0' COMMENT 'OCR总状态(0,"未执行" 1,"识别通过"  2,"识别不通过")',
  `real_auth_status` int(11) DEFAULT '0' COMMENT '实名认证总状态(0:认证;1:认证成功;2:认证失败)',
  `credit_result` int(11) NOT NULL DEFAULT '1' COMMENT '征信总结果(1:征信中;2:征信通过;3:征信不通过;4:已关闭)',
  `credit_remark` varchar(1024) CHARACTER SET utf8 DEFAULT NULL COMMENT '征信总结果说明',
  `credit_status` int(11) NOT NULL DEFAULT '1' COMMENT '征信总结果状态(0:无效;1有效)',
  `flow_type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '流程标识',
  `flow_node_key` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '流程节点标识',
  `flow_node_index` int(11) DEFAULT NULL COMMENT '流程节点索引',
  `flow_node_name` varchar(16) CHARACTER SET utf8 DEFAULT NULL COMMENT '流程节点名称',
  `flow_create_time` datetime DEFAULT NULL COMMENT '流程创建时间',
  `credit_launch_time` datetime DEFAULT NULL COMMENT '征信发起提交时间',
  `credit_inter_time` datetime DEFAULT NULL COMMENT '征信录入时间',
  `flow_finish_time` datetime DEFAULT NULL COMMENT '征信流程结束时间',
  `effective_expire_time` datetime DEFAULT NULL COMMENT '征信有效期截止时间',
  `signing_authorize_link_total` varchar(512) CHARACTER SET utf8 DEFAULT NULL COMMENT '总签约授权地址(h5)(v2.5.0)',
  `customer_manager_id` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '客户经理Id',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_credit_id` (`credit_id`) USING BTREE,
  KEY `idx_ccei` (`credit_status`,`credit_result`,`effective_expire_time`,`is_inuse`) USING BTREE,
  KEY `idx_credit_result` (`credit_result`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177980 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='征信扩展表，用于记录征信进件及审批的相关扩展信息';

-- ----------------------------
-- Table structure for customer_credit_field_rule
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_field_rule`;
CREATE TABLE `customer_credit_field_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sys_field` varchar(50) DEFAULT NULL COMMENT '系统字段',
  `rule_expression` varchar(1536) DEFAULT NULL COMMENT '规则表达式',
  `rule_desc` varchar(300) DEFAULT NULL COMMENT '规则描述',
  `is_valid` tinyint(1) DEFAULT '1',
  `create_time` datetime DEFAULT NULL,
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for customer_credit_file
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_file`;
CREATE TABLE `customer_credit_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '征信文件Id',
  `credit_relavant_id` bigint(20) NOT NULL COMMENT '征信关联人Id',
  `file_type` varchar(10) DEFAULT NULL COMMENT '文件类型(1:图片;2:视频)',
  `file_name` varchar(64) DEFAULT NULL COMMENT '文件名称',
  `file_format` varchar(32) DEFAULT NULL COMMENT '文件格式(即后缀名)',
  `file_path` varchar(512) DEFAULT NULL COMMENT '资信文件路径',
  `file_size` decimal(10,2) DEFAULT NULL COMMENT '文件大小(单位KB)',
  `file_key` int(11) DEFAULT NULL COMMENT '文件标记,用于表示文件所代表的含义(参见数据字典)',
  `file_remark` varchar(255) DEFAULT NULL COMMENT '说明(预留备用字段)',
  `content_type` varchar(128) DEFAULT NULL COMMENT '浏览器识别类型',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_credit_relavant_id` (`credit_relavant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1082789 DEFAULT CHARSET=utf8 COMMENT='征信文件表，用于记录征信关联人相关的资信文件';

-- ----------------------------
-- Table structure for customer_credit_file_bak
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_file_bak`;
CREATE TABLE `customer_credit_file_bak` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `credit_relavant_id` bigint(11) NOT NULL COMMENT '借款人担保人表ID',
  `credit_file` varchar(255) DEFAULT NULL COMMENT '资信文件',
  `credit_file_size` float(10,2) DEFAULT NULL COMMENT '文件大小(单位K）',
  `credit_type` int(11) DEFAULT NULL COMMENT '资信文件类型：（1：身份证复印件，2：征信查询授权书）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT '0正常 1删除 ',
  `push_status` int(4) NOT NULL DEFAULT '0' COMMENT '推送情况 0 本地 1已推送到台账 2远程删除',
  PRIMARY KEY (`id`),
  KEY `IDX_CREDIT_RELAVANT_ID` (`credit_relavant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=412172 DEFAULT CHARSET=utf8 COMMENT='资信文件表';

-- ----------------------------
-- Table structure for customer_credit_relavant
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_relavant`;
CREATE TABLE `customer_credit_relavant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '征信关联人Id',
  `credit_id` bigint(20) NOT NULL COMMENT '征信Id',
  `name` varchar(100) NOT NULL COMMENT '征信关联人姓名',
  `en_name` varchar(100) DEFAULT NULL COMMENT '征信关联人英文姓名',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(25) NOT NULL COMMENT '证件号码',
  `cert_valid_start_date` varchar(16) DEFAULT NULL COMMENT '证件有效期起始日',
  `cert_valid_end_date` varchar(16) DEFAULT NULL COMMENT '证件有效期截止日',
  `licence_issuing_authority` varchar(32) DEFAULT NULL COMMENT '发证机关',
  `mobile_phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(16) DEFAULT NULL COMMENT '出生日期',
  `gender` int(11) DEFAULT NULL COMMENT '性别(1:男;2:女)',
  `home_address_full_detail` varchar(128) DEFAULT NULL COMMENT '家庭地址全称',
  `domicile_address` varchar(128) DEFAULT NULL COMMENT '户籍地址',
  `marital_status` int(11) DEFAULT NULL COMMENT '婚姻状态(见数据字典或枚举)',
  `borrower_relationship` int(11) DEFAULT NULL COMMENT '与借款人关系(1:本人;2:夫妻;其余见数据字典)',
  `business_relationship` int(11) DEFAULT NULL COMMENT '业务关系(1借款人;2:共同偿债人;3:担保人)',
  `cert_similarity_degree` int(11) DEFAULT NULL COMMENT '证照比对相似度',
  `cert_status` int(2) DEFAULT '0' COMMENT '证照比对识别状态（0：默认 1通过 2拒绝 3其他）',
  `cert_result` varchar(64) DEFAULT NULL COMMENT '证照比对识别结果',
  `cert_time` datetime DEFAULT NULL COMMENT '证照比对识别时间',
  `bank_card_no` varchar(32) DEFAULT NULL COMMENT '银行卡号',
  `bank_card_reserve_mobile_phone` varchar(16) DEFAULT NULL COMMENT '银行卡预留手机号',
  `bank_card_openning_bank_name` varchar(32) DEFAULT NULL COMMENT '银行卡开户行名称',
  `bank_card_cnaps_code` varchar(32) DEFAULT NULL COMMENT '银行卡开户行联行号',
  `auth_result` int(11) DEFAULT NULL COMMENT '鉴权结果(0:不通过;1:通过)',
  `auth_remark` varchar(128) DEFAULT NULL COMMENT '鉴权结果说明',
  `risk_serial_number` varchar(128) DEFAULT NULL COMMENT '风控流水号',
  `ocr_flow_no` varchar(100) DEFAULT NULL COMMENT 'OCR识别流水号(2.5.1)',
  `bank_credit_result` int(11) DEFAULT NULL COMMENT '人行征信调查结果(0:不通过;1:通过)',
  `bank_credit_remark` varchar(1024) DEFAULT NULL COMMENT '人行征信调查结果说明',
  `big_data_credit_result` int(11) DEFAULT NULL COMMENT '大数据调查结果(0:不通过;1:通过)',
  `big_data_credit_remark` varchar(1024) DEFAULT NULL COMMENT '大数据调查结果说明',
  `bank_credit_staff_id` bigint(20) DEFAULT NULL COMMENT '人行征信调查人Id',
  `bank_credit_staff_name` varchar(32) DEFAULT NULL COMMENT '人行征信调查人名称',
  `credit_result` int(11) DEFAULT '1' COMMENT '征信个人总结果(1:征信中;2:征信通过;3:征信不通过;4:已关闭)',
  `loan_record_status` int(11) DEFAULT '0' COMMENT '借款人当前是否有贷款记录(1:有  0:无)(v2.5.4)',
  `credit_remark` varchar(1024) DEFAULT NULL COMMENT '征信个人总结果说明',
  `signing_authorize_link` varchar(512) DEFAULT NULL COMMENT '签约授权地址(v2.5.0)',
  `sign_result` int(11) NOT NULL DEFAULT '0' COMMENT '签约结果(0, "未签约授权"; 1, "已签约授权"; 2, "无需签约授权" ; 3, "签约授权失败")',
  `send_sms_result` int(11) DEFAULT NULL COMMENT '短信发送结果(0, "短信未发送"; 1, "短信已发送";)',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `due_12months_debt` decimal(12,4) DEFAULT NULL COMMENT '12个月内到期负债(2.5.1)',
  `due_24months_debt` decimal(12,4) DEFAULT NULL COMMENT '24个月内到期负债(2.5.1)',
  `due_36months_debt` decimal(12,4) DEFAULT NULL COMMENT '36个月内到期负债(2.5.1)',
  `due_48months_debt` decimal(12,4) DEFAULT NULL COMMENT '48个月内到期负债(2.5.1)',
  `due_60months_debt` decimal(12,4) DEFAULT NULL COMMENT '60个月内到期负债(2.5.1)',
  `auth_flow_no` varchar(100) DEFAULT NULL COMMENT '认证流水号(2.5.1)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_credit_id` (`credit_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=356357 DEFAULT CHARSET=utf8 COMMENT='征信关联人表，用于记录征信关联人的相关信息';

-- ----------------------------
-- Table structure for customer_credit_validate
-- ----------------------------
DROP TABLE IF EXISTS `customer_credit_validate`;
CREATE TABLE `customer_credit_validate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL COMMENT '客户来源，值域：｛1：个人申请，2：车商线下推荐， 3：车商线上推送｝',
  `department_id` int(11) NOT NULL COMMENT '业务组ID',
  `validate` datetime DEFAULT NULL COMMENT '生效时间',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0未生效 1生效',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '权限控制类型 0 征信 1贷款',
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_va` (`source`,`department_id`,`status`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for customer_manager
-- ----------------------------
DROP TABLE IF EXISTS `customer_manager`;
CREATE TABLE `customer_manager` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(11) NOT NULL COMMENT '客户ID',
  `manager_id` bigint(11) DEFAULT NULL COMMENT '客户经理ID',
  `manager_name` varchar(25) DEFAULT NULL COMMENT '客户经理名称',
  `management_type` int(1) DEFAULT NULL COMMENT '管理类型（1：管理权2：业务权）',
  `organization` varchar(50) DEFAULT NULL COMMENT '所属机构',
  `depart` varchar(50) DEFAULT NULL COMMENT '所在部门',
  `business_team` varchar(20) DEFAULT NULL COMMENT '业务小组',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `status` int(1) DEFAULT NULL COMMENT '0：停用，1：启用',
  `is_read` tinyint(1) DEFAULT '1' COMMENT '是否已读（0：未读，1：已读）',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  KEY `IDX_CUSTOMER_ID` (`customer_id`) USING BTREE,
  KEY `customer_manager_manager_id` (`manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23705 DEFAULT CHARSET=utf8 COMMENT='业务权用户表';

-- ----------------------------
-- Table structure for customer_manager_query_record
-- ----------------------------
DROP TABLE IF EXISTS `customer_manager_query_record`;
CREATE TABLE `customer_manager_query_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `customer_manager_id` varchar(100) NOT NULL COMMENT '客户经理Id',
  `agency_code` varchar(100) DEFAULT NULL COMMENT '合作单位码',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `biz_type` varchar(4) DEFAULT NULL COMMENT '业务类型(汽车消费分期01 其他见数据字典)',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型(如0101:新车;0102:二手车;其余见数据字典))',
  `flow_create_time` datetime DEFAULT NULL COMMENT '流程创建时间',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_query_count` (`customer_manager_id`,`agency_code`,`sub_org_id`,`create_time`,`is_inuse`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='客户经理查询表';

-- ----------------------------
-- Table structure for customer_relationship
-- ----------------------------
DROP TABLE IF EXISTS `customer_relationship`;
CREATE TABLE `customer_relationship` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `customer_id` bigint(11) NOT NULL COMMENT '客户ID',
  `full_name` varchar(10) NOT NULL COMMENT '关系人姓名',
  `relationship` int(3) unsigned NOT NULL COMMENT '与客户关系，值域为｛1：本人，2：夫妻，3：父亲，4:母亲，5:姐妹，6:兄弟，7:子女｝',
  `card_type` int(3) DEFAULT NULL,
  `card_no` varchar(20) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `home_address_pid` varchar(11) DEFAULT NULL COMMENT '家庭地址名称pid',
  `home_address_pname` varchar(30) DEFAULT '' COMMENT '家庭地址名称',
  `home_address_cid` varchar(11) DEFAULT '' COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(30) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(11) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(30) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(255) DEFAULT NULL COMMENT '家庭详细地址',
  `add_user` bigint(10) DEFAULT NULL,
  `add_user_name` varchar(255) DEFAULT NULL COMMENT '添加人姓名',
  PRIMARY KEY (`id`),
  KEY `IDX_CUSTOMER_ID` (`customer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='客户关系人表';

-- ----------------------------
-- Table structure for default_loan
-- ----------------------------
DROP TABLE IF EXISTS `default_loan`;
CREATE TABLE `default_loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `order_no` varchar(100) DEFAULT NULL COMMENT '合作机构订单号',
  `update_date` varchar(10) DEFAULT NULL COMMENT '报表更新日期',
  `card_no` varchar(30) DEFAULT NULL COMMENT '卡号',
  `id_type` varchar(8) DEFAULT NULL COMMENT '证件类型',
  `id_num` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `current_balance` varchar(20) DEFAULT NULL COMMENT '当前余额',
  `overdue_days` varchar(10) DEFAULT NULL COMMENT '逾期天数',
  `last_trading_day` varchar(10) DEFAULT NULL COMMENT '最后交易日 ',
  `repayment_date` varchar(10) DEFAULT NULL COMMENT ' 到期还款日',
  `affiliated_branches` varchar(50) DEFAULT NULL COMMENT '所属网点',
  `partners_institution` varchar(50) DEFAULT NULL COMMENT '合作机构|',
  `project_id` varchar(20) DEFAULT NULL COMMENT '车贷projectId字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38275 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dis_city_mapper
-- ----------------------------
DROP TABLE IF EXISTS `dis_city_mapper`;
CREATE TABLE `dis_city_mapper` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `city_code` varchar(255) DEFAULT NULL COMMENT '城市编码（车果的city编码）',
  `city_name` varchar(255) DEFAULT NULL COMMENT '城市名称（来自车果）',
  `city_level` int(11) DEFAULT NULL COMMENT '城市级别,10-全国,1-一线城市，2-二线发达城市，3-二线中等发达城市，4-二线发展较弱城市,5-三线城市 ,6-四线城市,7-五线城市',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_city_code` (`city_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='城市级别映射';

-- ----------------------------
-- Table structure for dis_policy_car_dealer
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_car_dealer`;
CREATE TABLE `dis_policy_car_dealer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `discount_id` bigint(20) DEFAULT NULL COMMENT '贴息政策ID',
  `car_dealer_name` varchar(255) DEFAULT NULL COMMENT '试用车商名称',
  `dealer_code` varchar(255) DEFAULT NULL COMMENT '经销商代码',
  `status` int(11) DEFAULT '1' COMMENT '启用停用状态：1：启用，0：停用',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除，1：删除，0：未删除',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_car_dealer_name` (`car_dealer_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='贴息政策适用车商表';

-- ----------------------------
-- Table structure for dis_policy_coo_bank
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_coo_bank`;
CREATE TABLE `dis_policy_coo_bank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贴息政策关联合作银行',
  `discount_id` bigint(20) DEFAULT NULL COMMENT '贴息政策ID',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行ID',
  `co_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名称',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_discount_id` (`discount_id`) USING BTREE,
  KEY `idx_co_bank_id` (`co_bank_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='贴息政策合作银行表';

-- ----------------------------
-- Table structure for dis_policy_host_factory
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_host_factory`;
CREATE TABLE `dis_policy_host_factory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `discount_id` bigint(20) DEFAULT NULL COMMENT '贴息政策ID',
  `host_factory_id` bigint(20) DEFAULT NULL COMMENT '主机厂ID',
  `host_factory_name` varchar(255) DEFAULT NULL COMMENT '主机厂名称',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8 COMMENT='贴息关联试用主机厂';

-- ----------------------------
-- Table structure for dis_policy_info
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_info`;
CREATE TABLE `dis_policy_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贴息主键ID',
  `policy_name` varchar(255) DEFAULT NULL COMMENT '贴息政策名称',
  `contact_name` varchar(255) DEFAULT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(255) DEFAULT NULL COMMENT '联系人手机号',
  `start_time` datetime DEFAULT NULL COMMENT '生效开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '生效结束时间',
  `effectual_status` int(11) DEFAULT '1' COMMENT '生效状态，1:有效，2：失效',
  `status` int(11) DEFAULT '1' COMMENT '启用状态（0：停用，1：启用）',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除（0：未删除，1：已删除）',
  `operate_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `operate_user_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `business_group_id` bigint(20) DEFAULT NULL COMMENT '创建人业务组ID',
  `business_group_name` varchar(255) DEFAULT NULL COMMENT '创建人业务组名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='贴息政策信息表';

-- ----------------------------
-- Table structure for dis_policy_scheme_car_model
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_scheme_car_model`;
CREATE TABLE `dis_policy_scheme_car_model` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `scheme_id` bigint(20) DEFAULT NULL COMMENT '贴息方案ID',
  `car_brand` varchar(255) DEFAULT NULL COMMENT '品牌名称',
  `car_brand_name` varchar(255) DEFAULT NULL COMMENT '品牌名称',
  `car_make` varchar(255) DEFAULT NULL COMMENT '车系名称',
  `car_make_name` varchar(255) DEFAULT NULL COMMENT '车系名称',
  `car_model` varchar(255) DEFAULT NULL COMMENT '汽车款型',
  `car_model_name` varchar(255) DEFAULT NULL COMMENT '车型名称',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_scheme_id_car_info` (`scheme_id`,`car_brand`,`car_make`,`car_model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8 COMMENT='贴息方案品牌车系车型信息表';

-- ----------------------------
-- Table structure for dis_policy_scheme_info
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_scheme_info`;
CREATE TABLE `dis_policy_scheme_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `discount_id` bigint(20) DEFAULT NULL COMMENT '贴息政策ID',
  `scheme_name` varchar(255) DEFAULT NULL COMMENT '方案名称',
  `down_payment` decimal(24,6) DEFAULT NULL COMMENT '首付比例',
  `city_type` int(11) DEFAULT NULL COMMENT '城市类型：1:一级城市，2:二级城市',
  `effectual_status` int(11) DEFAULT '1' COMMENT '生效状态，1:有效，2：失效',
  `status` int(11) DEFAULT '1' COMMENT '启用停用状态：1:启用，0：停用',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:删除，0:未删除',
  `discount_type` int(11) DEFAULT '1' COMMENT '贴息模式, 1：综合模式, 2:一汽模式',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='贴息方案信息表';

-- ----------------------------
-- Table structure for dis_policy_scheme_nper
-- ----------------------------
DROP TABLE IF EXISTS `dis_policy_scheme_nper`;
CREATE TABLE `dis_policy_scheme_nper` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `scheme_id` bigint(20) DEFAULT NULL COMMENT '贴息方案ID',
  `nper` int(11) DEFAULT NULL COMMENT '期数,1:12期，2:18期，3:24期，4:36期',
  `discount_rate` decimal(24,6) DEFAULT NULL COMMENT '贴息金额（百分比或者金额）',
  `is_per_cent` tinyint(1) DEFAULT '0' COMMENT '是否百分号,1：是，0：否',
  `discount_limit` decimal(24,6) DEFAULT NULL COMMENT '贴息金额上限',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 COMMENT='贴息方案期数信息表';

-- ----------------------------
-- Table structure for document_borrowing
-- ----------------------------
DROP TABLE IF EXISTS `document_borrowing`;
CREATE TABLE `document_borrowing` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(50) DEFAULT NULL COMMENT '项目编号',
  `bank_code` varchar(20) DEFAULT NULL COMMENT '银行编号',
  `bank_name` varchar(45) DEFAULT NULL COMMENT '银行名称',
  `borrowing_date` date DEFAULT NULL COMMENT '借阅日期',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `customer_phone` varchar(50) DEFAULT NULL COMMENT '客户电话',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `borrowing_purpose` varchar(256) DEFAULT NULL COMMENT '借阅目的',
  `expect_return_date` date DEFAULT NULL COMMENT '预计归还日期',
  `mailing_address` varchar(256) DEFAULT NULL COMMENT '邮寄地址',
  `recipient_phone` varchar(256) DEFAULT NULL COMMENT '收件人电话',
  `borrowing_status` int(1) DEFAULT '1' COMMENT '借阅状态(1:待借阅，2:借阅中 ，3:已归还，4:已关闭)',
  `permission_granted_time` datetime DEFAULT NULL COMMENT '审批通过时间',
  `borrowing_type` int(1) DEFAULT '0' COMMENT '是否全套资料 0：非全套资料，1：是全套资料',
  `is_valid` int(1) DEFAULT '1' COMMENT '是否有效（0：无效，1：有效）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '借阅人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '借阅人用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '借阅人所属机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '借阅人所属机构名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档借阅记录表';

-- ----------------------------
-- Table structure for document_borrowing_detail
-- ----------------------------
DROP TABLE IF EXISTS `document_borrowing_detail`;
CREATE TABLE `document_borrowing_detail` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `borrowing_id` bigint(11) NOT NULL COMMENT '文档借阅记录表ID',
  `doucument_name` varchar(200) NOT NULL COMMENT '文档名称',
  `document_type` int(1) DEFAULT NULL COMMENT '文档类型 (1:原件 ，2:复印件)',
  `borrowing_number` bigint(20) DEFAULT NULL COMMENT '借阅数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档借阅记录明细表';

-- ----------------------------
-- Table structure for document_deliver
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver`;
CREATE TABLE `document_deliver` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '文档传递主键，数据库自动增长序列',
  `current_deliver_status_id` bigint(11) DEFAULT NULL COMMENT '当前文档资料收发状态',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `project_no` varchar(50) DEFAULT NULL COMMENT '项目编号',
  `document_no` varchar(30) DEFAULT NULL COMMENT '文档传递编号',
  `staff_id` bigint(20) NOT NULL COMMENT '办理人',
  `deliver_status` int(1) DEFAULT NULL COMMENT '文档传递状态(1:未传递，2:已传递，3:已关闭，4:待归档，5:已归档 )',
  `deliver_time` datetime DEFAULT NULL COMMENT '文档到达日期',
  `file_sended` int(1) DEFAULT '0' COMMENT '资料发送状态,二进制位标识(从右到左：抵押合同、还款卡、抵押委托书、合同资料、抵押资料)',
  `guaranty_status` tinyint(1) DEFAULT NULL COMMENT '1-未抵押 2-已抵押',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `launch_time` datetime DEFAULT NULL COMMENT '第一节点发起时间',
  `verify_time` datetime DEFAULT NULL COMMENT '第二节点审核时间',
  `copy_time` datetime DEFAULT NULL COMMENT '第三节点合同抄写提交时间',
  `review_time` datetime DEFAULT NULL COMMENT '第4节点资料复核提交时间',
  `classify_time` datetime DEFAULT NULL COMMENT '第5节点资料归档提交时间',
  `pigeonhole_time` datetime DEFAULT NULL COMMENT '归档日期',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remark` varchar(256) DEFAULT NULL,
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `bank_send_status` int(1) DEFAULT NULL,
  `bank_handle_time` timestamp NULL DEFAULT NULL,
  `print_status` int(2) DEFAULT NULL COMMENT '放款合同套打流程状态（1待提交2已提交3已打印）',
  `file_need_send` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PROJECT_ID` (`project_id`) USING BTREE,
  KEY `idx_document_no` (`document_no`),
  KEY `index_staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58318 DEFAULT CHARSET=utf8 COMMENT='文档传递业务表';

-- ----------------------------
-- Table structure for document_deliver_configure
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_configure`;
CREATE TABLE `document_deliver_configure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `org_id` bigint(20) NOT NULL COMMENT '公司id',
  `days` bigint(20) DEFAULT NULL COMMENT '未发件垫款天数最大值',
  `number` bigint(20) DEFAULT NULL COMMENT '允许未发起单数最大值',
  `status` tinyint(255) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for document_deliver_customer
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_customer`;
CREATE TABLE `document_deliver_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `customer_no` varchar(50) NOT NULL COMMENT '客户编号',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `customer_type` int(10) DEFAULT NULL COMMENT '客户类型（1：个人客户，2：企业客户）',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `card_expiry_date` varchar(20) DEFAULT NULL COMMENT '证件有效期(yyyyMMdd)',
  `card_or_expiry_date` tinyint(1) DEFAULT '0' COMMENT '证件是否长期有效 0:否,1:是',
  `customer_source` int(10) DEFAULT NULL COMMENT '客户来源（1：车果网，2：内部推荐）',
  `source_serialno` varchar(50) DEFAULT NULL COMMENT '客户来源流水号',
  `sex` int(1) DEFAULT NULL COMMENT '性别（1：男，2：女）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `mobile_phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `home_phone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `native_place` varchar(50) DEFAULT NULL COMMENT '籍贯',
  `education` int(10) DEFAULT NULL COMMENT '学历(1：初中及以下，2：高中，3：大专，4：本科，5：硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1：自有住房，2：贷款购房，3：租房：4：其他)',
  `current_house_area` decimal(6,2) DEFAULT NULL COMMENT '当前住宅面积(平方米)',
  `housing_date` varchar(20) DEFAULT NULL COMMENT '现居地入住时间(yyyyMMdd)',
  `mortgage_repayment` varchar(50) DEFAULT NULL COMMENT '住房月还款情况',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `industry` int(10) DEFAULT NULL COMMENT '行业',
  `monthly_income` int(10) DEFAULT NULL COMMENT '个人月收入',
  `reserved_funds` int(10) DEFAULT NULL COMMENT '公积金（1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上）',
  `company_name` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `company_phone` varchar(20) DEFAULT NULL COMMENT '单位电话',
  `company_type` varchar(100) DEFAULT NULL COMMENT '工作单位经济性质',
  `employment_date` datetime DEFAULT NULL COMMENT '入职日期',
  `company_address_pid` varchar(10) DEFAULT NULL COMMENT '单位地址ID',
  `company_address_pname` varchar(50) DEFAULT NULL COMMENT '单位地址名称',
  `company_address_cid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化市id',
  `company_address_cname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化市Name',
  `company_address_rid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化区id',
  `company_address_rname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化区name',
  `company_address_detail` varchar(200) DEFAULT NULL COMMENT '单位详细地址',
  `company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址经度坐标',
  `company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址纬度坐标',
  `home_address_pid` varchar(10) DEFAULT NULL COMMENT '家庭地址ID',
  `home_address_pname` varchar(50) DEFAULT NULL COMMENT '家庭地址名称',
  `home_address_cid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(200) DEFAULT NULL COMMENT '家庭详细地址',
  `home_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址经度坐标',
  `home_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址纬度坐标',
  `spouse_name` varchar(20) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_card_type` int(10) DEFAULT NULL COMMENT '配偶证件类型(1：身份证，2：军官证，3：侨胞证，4：外籍人士)',
  `spouse_card_no` varchar(20) DEFAULT NULL COMMENT '配偶证件编号',
  `spouse_mobile_phone` varchar(11) DEFAULT NULL COMMENT '配偶手机号码',
  `spouse_permant_address` varchar(200) DEFAULT NULL COMMENT '配偶户籍地址',
  `spouse_reserved_funds` int(11) DEFAULT NULL COMMENT '配偶公积金(1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上)',
  `spouse_company_name` varchar(200) DEFAULT NULL COMMENT '配偶单位名称',
  `spouse_company_address_pid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址省代码',
  `spouse_company_address_pname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址省',
  `spouse_company_address_cid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址市代码',
  `spouse_company_address_cname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址市',
  `spouse_company_address_rid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址县代码',
  `spouse_company_address_rname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址县',
  `spouse_company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址经度坐标',
  `spouse_company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址纬坐标',
  `spouse_company_address` varchar(200) DEFAULT NULL COMMENT '配偶单位地址',
  `spouse_company_phone` varchar(20) DEFAULT NULL COMMENT '配偶单位电话',
  `spouse_monthly_income` int(10) DEFAULT NULL COMMENT '配偶月薪',
  `is_agency` int(1) DEFAULT NULL COMMENT '是否代购(1:是，2：否)',
  `real_car_owner` varchar(20) DEFAULT NULL COMMENT '实际用车人',
  `register_date` datetime DEFAULT NULL COMMENT '建档日期',
  `joint_obligor_id` bigint(20) DEFAULT NULL COMMENT '共同还款人ID',
  `joint_obligor` varchar(30) DEFAULT NULL COMMENT '共同还款人',
  `customer_score` decimal(10,2) DEFAULT NULL COMMENT '客户信用评分',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `en_customer_name` varchar(50) DEFAULT NULL COMMENT '英文名',
  `licence_issuing_authority` varchar(100) DEFAULT NULL COMMENT '发证机关',
  `post` int(10) DEFAULT NULL COMMENT '职务',
  `post_name` varchar(50) DEFAULT NULL COMMENT '职务名称',
  `yearly_income` decimal(24,6) DEFAULT NULL COMMENT '年收入',
  `personal_asset_sum` decimal(24,6) DEFAULT NULL COMMENT '个人总资产(万)',
  `monthly_liabilities` decimal(24,6) DEFAULT NULL COMMENT '月负债',
  `other_debt_balance` decimal(24,6) DEFAULT NULL COMMENT '其他负债余额(元)',
  `profession_code` int(10) DEFAULT NULL COMMENT '职业编码',
  `work_nature_code` int(10) DEFAULT NULL COMMENT '工作单位性质编码',
  `domicile_type` int(10) DEFAULT NULL COMMENT '户籍性质1:农业,2,非农',
  `spouse_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '配偶年收入（万元）',
  `house_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '家庭年收入（万元）',
  `cmpy_postcode` varchar(50) DEFAULT NULL COMMENT '工作单位邮编',
  `home_postcode` varchar(50) DEFAULT NULL COMMENT '家庭住址邮编',
  `survey_report` varchar(3000) DEFAULT NULL COMMENT '调查报告',
  `card_collect_method` int(1) NOT NULL DEFAULT '1' COMMENT '开卡领取方式 1-自取 2-寄送单位 3-寄送住宅',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=472 DEFAULT CHARSET=utf8 COMMENT='文档传递客户审批表(发银行用)';

-- ----------------------------
-- Table structure for document_deliver_express_bill
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_express_bill`;
CREATE TABLE `document_deliver_express_bill` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `bill_no` varchar(30) DEFAULT NULL COMMENT '快递单号',
  `express_company_code` varchar(10) DEFAULT NULL COMMENT '快递公司编号',
  `express_company` varchar(10) DEFAULT NULL COMMENT '快递公司名称',
  `recipient_addr` varchar(50) NOT NULL COMMENT '收件人地址',
  `recipient` varchar(50) NOT NULL COMMENT '收件组织',
  `recipient_id` bigint(20) NOT NULL COMMENT '收件组织ID',
  `recipient_user` varchar(50) DEFAULT NULL COMMENT '收件人',
  `recipient_user_id` bigint(20) DEFAULT NULL COMMENT '收件人ID',
  `recipient_type` int(1) NOT NULL COMMENT '收件组织类型(1:公司，2：银行)',
  `sender_id` bigint(20) DEFAULT NULL COMMENT '发件人ID',
  `sender_org_id` bigint(20) DEFAULT NULL COMMENT '发件人机构ID',
  `sender` varchar(50) NOT NULL COMMENT '发件人',
  `sender_mobile` varchar(20) DEFAULT NULL COMMENT '发送人手机号',
  `send_time` datetime NOT NULL COMMENT '发件时间',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(32) DEFAULT NULL COMMENT '合作银行名称',
  `org_id` bigint(20) NOT NULL COMMENT '业务机构ID',
  `org_name` varchar(100) NOT NULL COMMENT '业务机构',
  `recipient_status` int(1) DEFAULT NULL COMMENT '收件状态（1：未收件，2：资料缺失，3：已收件）',
  `recipient_time` datetime DEFAULT NULL COMMENT '收件时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `sender_group_id` int(11) DEFAULT NULL COMMENT '发送人业务组id',
  `sender_group_name` varchar(255) DEFAULT NULL COMMENT '发送人业务组名称',
  `remark` varchar(500) DEFAULT NULL COMMENT '结果反馈',
  `recipient_phone` varchar(50) DEFAULT NULL COMMENT '收件人手机号码',
  PRIMARY KEY (`id`),
  KEY `IDX_BILL_NO` (`bill_no`) USING BTREE,
  KEY `IDX_CMY_BILL` (`bill_no`,`express_company_code`) USING BTREE,
  KEY `idx_ddeb_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1645 DEFAULT CHARSET=utf8 COMMENT='文档传递快递单表';

-- ----------------------------
-- Table structure for document_deliver_express_bill_list
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_express_bill_list`;
CREATE TABLE `document_deliver_express_bill_list` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `bill_id` bigint(20) NOT NULL COMMENT '文档传递快递单表主键',
  `document_deliver_id` bigint(20) NOT NULL COMMENT '文档传递业务表主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `file_list` int(1) DEFAULT NULL COMMENT '发送资料,二进制位标识(从右到左：抵押合同、还款卡、抵押委托书、合同资料、抵押资料)',
  `recipient_status` int(1) DEFAULT NULL COMMENT '收件状态(1：未收件，2：资料缺失，3：已收件)',
  `recipient_time` datetime DEFAULT NULL COMMENT '收件时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '情况描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `bank_handle_time` timestamp NULL DEFAULT NULL COMMENT '银行处理时间',
  `send_remark` varchar(255) DEFAULT NULL COMMENT '发件备注信息',
  PRIMARY KEY (`id`),
  KEY `IDX_BILL_ID` (`bill_id`) USING BTREE,
  KEY `IDX_PROJECT_ID` (`project_id`) USING BTREE,
  KEY `IDX_DELIVER_ID` (`bill_id`,`document_deliver_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3211 DEFAULT CHARSET=utf8 COMMENT='文档传递快递单清单表';

-- ----------------------------
-- Table structure for document_deliver_fee
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_fee`;
CREATE TABLE `document_deliver_fee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `guarantee_service_fee` decimal(24,6) DEFAULT NULL COMMENT '担保服务费',
  `loan_amount` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `handing_fee` decimal(24,6) DEFAULT NULL COMMENT '手续费率',
  `down_payment_amount` decimal(24,4) DEFAULT NULL COMMENT '首付款',
  `loan_ratio` decimal(24,6) DEFAULT NULL COMMENT '贷款比例',
  `bank_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '银行首付金额',
  `bank_installment_amount` decimal(24,6) DEFAULT NULL COMMENT '银行分期金额',
  `bank_installment_fee` decimal(24,6) DEFAULT NULL COMMENT '银行分期手续费总额',
  `extra_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '附加费分期金额',
  `extra_loan_handing_fee` decimal(24,6) DEFAULT NULL COMMENT '附加费分期手续费',
  `notice_downpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期偿还本金',
  `notice_downpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期利息',
  `notice_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期总金额',
  `notice_periodpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期偿还本金',
  `notice_periodpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期利息',
  `notice_periodpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期总金额',
  `notice_finalpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期偿还本金',
  `notice_finalpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期利息',
  `notice_finalpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期总金额',
  `notice_downpayment_car_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期车辆贷款偿还本金',
  `notice_downpayment_car_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期车辆贷款偿还利息',
  `notice_downpayment_car_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期车辆贷款偿还总额',
  `notice_periodpayment_car_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期车辆贷款偿还本金',
  `notice_periodpayment_car_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期车辆贷款偿还利息',
  `notice_periodpayment_car_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期车辆贷款偿还总额',
  `notice_downpayment_extra_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期附加费偿还本金',
  `notice_downpayment_extra_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期附加费偿还利息',
  `notice_downpayment_extra_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期附加费偿还总额',
  `notice_periodpayment_extra_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期附加费偿还本金',
  `notice_periodpayment_extra_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期附加费偿还利息',
  `notice_periodpayment_extra_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期附加费偿还总额',
  `contract_downpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)首期偿还本金',
  `contract_downpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)首期利息',
  `contract_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)首期总金额',
  `contract_periodpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)每期偿还本金',
  `contract_periodpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)每期利息',
  `contract_periodpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)每期总金额',
  `contract_finalpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)末期偿还本金',
  `contract_finalpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)末期利息',
  `contract_finalpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期总金额',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=166537 DEFAULT CHARSET=utf8 COMMENT='贷款费用信息表';

-- ----------------------------
-- Table structure for document_deliver_guarantor
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_guarantor`;
CREATE TABLE `document_deliver_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `credit_id` bigint(20) DEFAULT NULL COMMENT '征信主键',
  `guarantor_id` bigint(20) DEFAULT NULL COMMENT '担保人编号',
  `guarantor_no` varchar(30) DEFAULT NULL COMMENT '保证人编号',
  `guarantor_name` varchar(50) DEFAULT NULL COMMENT '保证人名称',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件编号',
  `mobile_phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `customer_type` int(10) DEFAULT NULL COMMENT '客户类型（1：个人客户，2：企业客户）',
  `customer_source` int(10) DEFAULT NULL COMMENT '客户来源（1：车果网，2：内部推荐）',
  `source_serialno` varchar(50) DEFAULT NULL COMMENT '客户来源流水号',
  `sex` int(1) DEFAULT NULL COMMENT '性别 1 男，0 女',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `home_phone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `native_place` varchar(50) DEFAULT NULL COMMENT '籍贯',
  `education` int(10) DEFAULT NULL COMMENT '学历(1：初中及以下，2：高中，3：大专，4：本科，5：硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1：自有住房，2：贷款购房，3：租房：4：其他)',
  `mortgage_repayment` varchar(50) DEFAULT NULL COMMENT '住房月还款情况',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `industry` int(10) DEFAULT NULL COMMENT '行业',
  `monthly_income` int(10) DEFAULT NULL COMMENT '个人月收入',
  `yearly_income` decimal(24,6) DEFAULT NULL COMMENT '个人年收入(万)',
  `social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `reserved_funds` int(10) DEFAULT NULL COMMENT '公积金（1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上）',
  `company_name` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `company_phone` varchar(20) DEFAULT NULL COMMENT '单位电话',
  `company_address_pid` varchar(10) DEFAULT NULL COMMENT '单位地址ID',
  `company_address_pname` varchar(50) DEFAULT NULL COMMENT '单位地址名称',
  `company_address_cid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化市id',
  `company_address_cname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化市Name',
  `company_address_rid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化区id',
  `company_address_rname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化区name',
  `company_address_detail` varchar(200) DEFAULT NULL COMMENT '单位详细地址',
  `company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址经度坐标',
  `company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址纬度坐标',
  `home_address_pid` varchar(10) DEFAULT NULL COMMENT '家庭地址ID',
  `home_address_pname` varchar(50) DEFAULT NULL COMMENT '家庭地址名称',
  `home_address_cid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(200) DEFAULT NULL COMMENT '家庭详细地址',
  `home_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址经度坐标',
  `home_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址纬度坐标',
  `spouse_name` varchar(20) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_card_type` int(10) DEFAULT NULL COMMENT '配偶证件类型(1：身份证，2：军官证，3：侨胞证，4：外籍人士)',
  `spouse_card_no` varchar(20) DEFAULT NULL COMMENT '配偶证件编号',
  `spouse_mobile_phone` varchar(11) DEFAULT NULL COMMENT '配偶手机号码',
  `spouse_permant_address` varchar(200) DEFAULT NULL COMMENT '配偶户籍地址',
  `spouse_reserved_funds` int(11) DEFAULT NULL COMMENT '配偶公积金(1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上)',
  `spouse_company_name` varchar(200) DEFAULT NULL COMMENT '配偶单位名称',
  `spouse_company_address_pid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址省代码',
  `spouse_company_address_pname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址省',
  `spouse_company_address_cid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址市代码',
  `spouse_company_address_cname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址市',
  `spouse_company_address_rid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址县代码',
  `spouse_company_address_rname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址县',
  `spouse_company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址经度坐标',
  `spouse_company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址纬坐标',
  `spouse_company_address` varchar(200) DEFAULT NULL COMMENT '配偶单位地址',
  `spouse_company_phone` varchar(20) DEFAULT NULL COMMENT '配偶单位电话',
  `spouse_monthly_income` int(10) DEFAULT NULL COMMENT '配偶月薪',
  `spouse_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '配偶个人年收入(万)',
  `register_date` datetime DEFAULT NULL COMMENT '建档日期',
  `relationship_with_loaner` int(10) DEFAULT NULL COMMENT '与借款人关系(1：本人，2：夫妻，3：父亲，4：母亲，5：姐妹，6：兄弟，7：子女)',
  `guaranty_relationship` int(10) DEFAULT NULL COMMENT '担保关系(1:担保人，2:反担保人)',
  `remark` varchar(100) DEFAULT NULL COMMENT '说明',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `profession_code` int(1) DEFAULT NULL COMMENT '职业编码',
  PRIMARY KEY (`id`),
  KEY `loan_approve_guarantor_projectid_index` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20240 DEFAULT CHARSET=utf8 COMMENT='文档传递保证人表(发银行用)';

-- ----------------------------
-- Table structure for document_deliver_list
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_list`;
CREATE TABLE `document_deliver_list` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '文档清单主键，数据库自动增长序列',
  `document_deliver_id` bigint(20) NOT NULL COMMENT '文档传递业务表主键',
  `document_name` varchar(31) NOT NULL COMMENT '文档名称',
  `original_count` int(1) DEFAULT NULL COMMENT '原件数量',
  `duplicate_count` int(1) DEFAULT NULL COMMENT '复印件数量',
  `sort` int(1) DEFAULT NULL COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `IDX_DOCUMENT_DELIVER_ID` (`document_deliver_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=62868 DEFAULT CHARSET=utf8 COMMENT='文档传递流程文档清单表';

-- ----------------------------
-- Table structure for document_deliver_status
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_status`;
CREATE TABLE `document_deliver_status` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '文档收发状态主键，数据库自动增长序列',
  `document_deliver_id` bigint(20) NOT NULL COMMENT '文档主键',
  `project_id` varchar(50) DEFAULT NULL COMMENT '项目主键',
  `document_no` varchar(30) DEFAULT NULL COMMENT '文档传递编号',
  `staff_id` bigint(20) NOT NULL COMMENT '办理人',
  `deliver_status` int(1) DEFAULT NULL COMMENT '文档传递状态(1:待发件，2:已发件)',
  `dest_type` int(1) DEFAULT NULL COMMENT '目的地类型(1.区域-客户经理 2.办事处-内勤 3.银行-内勤 4.分公司-资料审核合同抄写复核归档)',
  `file_sended` int(1) DEFAULT '0' COMMENT '资料发送状态,二进制位标识(从右到左：抵押合同、还款卡、抵押委托书、合同资料、抵押资料、放款资料)',
  `guaranty_status` int(1) DEFAULT NULL COMMENT '抵押状态 1-未抵押 2-已抵押',
  `handle_time` datetime DEFAULT NULL COMMENT '文档处理时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `receive_time` datetime DEFAULT NULL COMMENT '文件到达时间(文件确认收件时间)',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `IDSX_PROJECT_ID` (`project_id`) USING BTREE,
  KEY `idsx_document_deliver_id` (`document_deliver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73353 DEFAULT CHARSET=utf8 COMMENT='文档传递业务状态表';

-- ----------------------------
-- Table structure for document_deliver_trans_report
-- ----------------------------
DROP TABLE IF EXISTS `document_deliver_trans_report`;
CREATE TABLE `document_deliver_trans_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` int(11) DEFAULT NULL,
  `pledge_deal_date` datetime DEFAULT NULL COMMENT '抵押录入时间',
  `org_id` bigint(11) DEFAULT NULL COMMENT '分公司id',
  `org_name` varchar(255) DEFAULT NULL COMMENT '分公司名称',
  `project_id` bigint(11) DEFAULT NULL COMMENT '贷款编号',
  `project_no` varchar(255) DEFAULT NULL COMMENT '贷款编号',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户姓名',
  `document_deliver_id` int(11) DEFAULT NULL COMMENT '文档传递id',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `loan_amount` decimal(10,0) DEFAULT NULL COMMENT '贷款金额',
  `advanceDate` datetime DEFAULT NULL COMMENT '垫款日期',
  `contract_transfer_office` datetime DEFAULT NULL COMMENT '合同移交办事处',
  `contractCompanySendUid` bigint(20) DEFAULT NULL COMMENT '合同公司发件人id',
  `contractCompanySendUname` varchar(255) DEFAULT NULL COMMENT '合同公司发件人名称',
  `contract_office_received` datetime DEFAULT NULL COMMENT '办事处收到合同',
  `contractOfficeReceiveUid` bigint(20) DEFAULT NULL COMMENT '合同办事处收件人id',
  `contractOfficeReceiveUname` varchar(255) DEFAULT NULL COMMENT '合同办事处收件人名称',
  `contract_office_to_bank` datetime DEFAULT NULL COMMENT '合同移交给银行',
  `contractOfficeSendUid` bigint(20) DEFAULT NULL COMMENT '合同办事处发件人id',
  `contractOfficeSendUname` varchar(255) DEFAULT NULL COMMENT '合同办事处发件人名称',
  `contract_bank_received` datetime DEFAULT NULL COMMENT '银行收到合同',
  `contractBankReceiveUid` bigint(20) DEFAULT NULL COMMENT '合同银行收件人id',
  `contractBankReceiveUname` varchar(255) DEFAULT NULL COMMENT '合同银行收件人名称',
  `acceptance_date` datetime DEFAULT NULL COMMENT '受理日期',
  `loan_date` datetime DEFAULT NULL COMMENT '放款日期',
  `infomation_bank_to_cmp` datetime DEFAULT NULL COMMENT '银行寄抵押资料给公司',
  `infomationBankSendUid` bigint(20) DEFAULT NULL COMMENT '抵押资料银行发件人id',
  `infomationBankSendUname` varchar(255) DEFAULT NULL COMMENT '抵押资料银行发件人名称',
  `infomation_cmp_received` datetime DEFAULT NULL COMMENT '公司收到抵押资料',
  `infomationCompanyReceiveUid` bigint(20) DEFAULT NULL COMMENT '抵押资料公司收件人id',
  `infomationCompanyReceiveUname` varchar(255) DEFAULT NULL COMMENT '抵押资料公司收件人名称',
  `mortgage_date` datetime DEFAULT NULL COMMENT '抵押日期',
  `infomation_cmp_to_office` datetime DEFAULT NULL COMMENT '公司寄抵押资料给办事处',
  `infomationCompanySendUid` bigint(20) DEFAULT NULL COMMENT '抵押资料公司发件人id',
  `infomationCompanySendUname` varchar(255) DEFAULT NULL COMMENT '抵押资料公司发件人名称',
  `infomation_office_received` datetime DEFAULT NULL COMMENT '办事处收到抵押资料',
  `infomationOfficeReceiveUid` bigint(20) DEFAULT NULL COMMENT '抵押资料办事处收件人id',
  `infomationOfficeReceiveUname` varchar(255) DEFAULT NULL COMMENT '抵押资料办事处收件人名称',
  `infomation_offcie_to_bank` datetime DEFAULT NULL COMMENT '办事处移交抵押资料到银行',
  `infomationOfficeSendUid` bigint(20) DEFAULT NULL COMMENT '抵押资料办事处发件人id',
  `infomationOfficeSendUname` varchar(255) DEFAULT NULL COMMENT '抵押资料办事处发件人名称',
  `infomation_bank_received` datetime DEFAULT NULL COMMENT '银行收到抵押资料',
  `infomationBankReceiveUid` bigint(20) DEFAULT NULL COMMENT '抵押资料银行收件人id',
  `infomationBankReceiveUname` varchar(255) DEFAULT NULL COMMENT '抵押资料银行收件人名称',
  `contract_company_to_bank` datetime DEFAULT NULL COMMENT '公司发给银行合同资料时间',
  `infomation_company_to_bank` datetime DEFAULT NULL COMMENT '公司发给银行抵押资料时间',
  `infomationCompanyToBankSendUid` bigint(20) DEFAULT NULL COMMENT '抵押资料公司->银行发件人id',
  `infomationCompanyToBankSendUname` varchar(255) DEFAULT NULL COMMENT '抵押资料公司->银行发件人name',
  `contractCompanyToBankSendUid` bigint(20) DEFAULT NULL COMMENT '合同资料公司->银行发件人id',
  `contractCompanyToBankSendUname` varchar(255) DEFAULT NULL COMMENT '合同资料公司->银行发件人name',
  `infomation_company_to_bank_received` datetime DEFAULT NULL COMMENT '公司发给银行抵押资料收件时间',
  `contract_company_to_bank_received` datetime DEFAULT NULL COMMENT '公司发给银行合同资料收件时间',
  `infomationCompanyToBankReceiveUname` varchar(255) DEFAULT NULL COMMENT '公司发给银行抵押资料收件人姓名',
  `infomationCompanyToBankReceiveUid` bigint(255) DEFAULT NULL COMMENT '公司发给银行抵押资料收件人id',
  `contractCompanyToBankReceiveUname` varchar(255) DEFAULT NULL COMMENT '公司发给银行合同资料收件人姓名',
  `contractCompanyToBankReceiveUid` bigint(11) DEFAULT NULL COMMENT '公司发给银行合同资料收件人ID',
  `no_loan_reson` varchar(255) DEFAULT NULL COMMENT '未放款原因',
  `group_id` bigint(11) DEFAULT NULL COMMENT '业务组id',
  `group_name` varchar(255) DEFAULT NULL COMMENT '业务组名字',
  `car_info` varchar(255) DEFAULT NULL COMMENT '汽车信息',
  `co_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名字',
  `co_bank_id` int(11) DEFAULT NULL COMMENT '合作银行id',
  `bank_recieve_infomation_mark` varchar(255) DEFAULT NULL,
  `office_recieve_infomation_mark` varchar(255) DEFAULT NULL,
  `bank_recieve_contract_mark` varchar(255) DEFAULT NULL,
  `office_recieve_contract_mark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projectIdIndex` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for document_filed
-- ----------------------------
DROP TABLE IF EXISTS `document_filed`;
CREATE TABLE `document_filed` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `filed_id` bigint(20) NOT NULL COMMENT '归档人ID',
  `filed_name` varchar(255) NOT NULL COMMENT '归档人姓名',
  `project_id` bigint(20) NOT NULL COMMENT '被归档贷款项目ID',
  `filed_time` datetime NOT NULL COMMENT '归档时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for document_list
-- ----------------------------
DROP TABLE IF EXISTS `document_list`;
CREATE TABLE `document_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dir_id` bigint(20) DEFAULT NULL COMMENT '目录ID',
  `parent_id` bigint(20) NOT NULL COMMENT '父id，判断文档属于那种类型',
  `type` varchar(200) NOT NULL COMMENT '类型',
  `doucument_name` varchar(200) NOT NULL COMMENT '文档名称',
  `number` bigint(20) NOT NULL COMMENT '份数',
  `must` bigint(20) NOT NULL COMMENT '是否是必须归档的文档：1是，2不是',
  `status` bigint(20) NOT NULL COMMENT '状态:1开启，2关闭',
  `sort` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for document_list_biz
-- ----------------------------
DROP TABLE IF EXISTS `document_list_biz`;
CREATE TABLE `document_list_biz` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `document_id` bigint(20) NOT NULL COMMENT '文档id',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8 COMMENT='归档资料业务关联表';

-- ----------------------------
-- Table structure for drag_car_apply
-- ----------------------------
DROP TABLE IF EXISTS `drag_car_apply`;
CREATE TABLE `drag_car_apply` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '拖车登记主键ID',
  `drag_car_num` varchar(255) DEFAULT NULL COMMENT '拖车编码',
  `business_group_id` bigint(20) NOT NULL COMMENT '业务组ID',
  `business_group_name` varchar(255) NOT NULL COMMENT '业务组名称',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '发起人ID',
  `launch_user_name` varchar(255) DEFAULT NULL COMMENT '发起人姓名',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `card_type` int(11) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(30) DEFAULT NULL COMMENT '身份证',
  `mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目ID(贷款ID)',
  `project_no` varchar(255) NOT NULL COMMENT '项目编号(贷款编号)',
  `plate_no` varchar(255) DEFAULT NULL COMMENT '车牌号',
  `car_frame_no` varchar(255) DEFAULT NULL COMMENT '车架号码',
  `plate_area` varchar(255) DEFAULT NULL COMMENT '上牌地',
  `car_model_name` varchar(255) DEFAULT NULL COMMENT '车辆型号',
  `bank_id` bigint(11) NOT NULL COMMENT '贷款银行ID',
  `bank_name` varchar(20) NOT NULL COMMENT '贷款银行名称',
  `org_id` bigint(11) NOT NULL COMMENT '所属机构ID',
  `org_name` varchar(255) NOT NULL COMMENT '所属机构名称',
  `way` int(11) DEFAULT NULL COMMENT '拖车方式（0：本司；1：委外）',
  `fexpect_ee` decimal(10,0) DEFAULT NULL COMMENT '预计费用',
  `note` varchar(255) DEFAULT NULL COMMENT '拖车申请情况描述',
  `status` int(11) DEFAULT NULL COMMENT '拖车状态 0.初始化拖车状态 1.拖车审批中 2.待拖车 3.已入库 4.已撤销 5.出库审批中 6.出库',
  `drag_status` int(11) DEFAULT NULL COMMENT '拖车状态，页面选择拖回或撤销专用 1：拖回 2：撤销',
  `drag_user` varchar(255) DEFAULT NULL COMMENT '拖车人',
  `drag_time` datetime DEFAULT NULL COMMENT '拖车时间',
  `pipe_user` varchar(255) DEFAULT NULL COMMENT '占管人',
  `pipe_user_phone` varchar(255) DEFAULT NULL COMMENT '占管人联系方式',
  `in_time` datetime DEFAULT NULL COMMENT '入库时间',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `in_km_num` decimal(10,2) DEFAULT NULL,
  `drag_fee` decimal(10,2) DEFAULT NULL,
  `drag_register_note` varchar(255) DEFAULT NULL COMMENT '拖车登记情况描述',
  `undo_reason` int(11) DEFAULT NULL COMMENT '撤销理由 1：全额结清垫款本息及银行贷款 2:结清全部垫款，落实后续还款计划及担保措施 3：结清部分垫款，落实后续还款计划及担保措施',
  `other_reason` varchar(255) DEFAULT NULL COMMENT '其他理由',
  `create_time` datetime NOT NULL COMMENT '拖车申请时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `drag_user_id` bigint(20) DEFAULT NULL COMMENT '拖车人id',
  `pipe_way` int(11) DEFAULT NULL COMMENT '占管方式1.公司占管（物品移交清单） ；2.委外占管',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8 COMMENT='拖车管理表';

-- ----------------------------
-- Table structure for drag_car_apply_file
-- ----------------------------
DROP TABLE IF EXISTS `drag_car_apply_file`;
CREATE TABLE `drag_car_apply_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `drag_car_id` bigint(20) DEFAULT NULL COMMENT '拖车登记ID',
  `drag_car_file` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `drag_car_file_name` varchar(255) DEFAULT NULL COMMENT '拖车登记上传文件的名称',
  `drag_car_size` double DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `filetype` varchar(255) DEFAULT '' COMMENT '文件类型：1为图片，2为视频',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='拖车登记文件表';

-- ----------------------------
-- Table structure for econtract_config
-- ----------------------------
DROP TABLE IF EXISTS `econtract_config`;
CREATE TABLE `econtract_config` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template_no` varchar(31) DEFAULT NULL COMMENT '合同模板编号',
  `template_name` varchar(31) DEFAULT NULL COMMENT '合同模板名称',
  `apply_region` int(2) DEFAULT NULL COMMENT '应用环节(1:征信查询 2:通用业务审批)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_inuse` int(2) DEFAULT NULL COMMENT '是否启用(0:弃用 1:启用)',
  `operate_user_id` bigint(31) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `idx_template_no_is_inuse` (`template_no`,`is_inuse`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='签约配置表';

-- ----------------------------
-- Table structure for econtract_config_bank_agency_biz_type
-- ----------------------------
DROP TABLE IF EXISTS `econtract_config_bank_agency_biz_type`;
CREATE TABLE `econtract_config_bank_agency_biz_type` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template_no` varchar(31) DEFAULT NULL COMMENT '合同模板编号',
  `template_name` varchar(31) DEFAULT NULL COMMENT '合同模板名称',
  `org_agency_id` varchar(31) DEFAULT NULL COMMENT '(银行id/合作单位id/业务品种id)',
  `org_agency_type` int(2) DEFAULT NULL COMMENT '(银行id:1 合作单位id:2 业务品种id:3)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_template_no` (`template_no`) USING BTREE,
  KEY `idx_org_agency_id_org_agency_type` (`org_agency_id`,`org_agency_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2015 DEFAULT CHARSET=utf8 COMMENT='签约配置对应合作单位,银行,业务类型关联表';

-- ----------------------------
-- Table structure for econtract_template
-- ----------------------------
DROP TABLE IF EXISTS `econtract_template`;
CREATE TABLE `econtract_template` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `econtract_template_master_id` bigint(31) NOT NULL DEFAULT '1' COMMENT '模板主表ID',
  `tempate_param` varchar(31) DEFAULT NULL COMMENT '模板参数',
  `param_explanation` varchar(127) DEFAULT NULL COMMENT '参数说明',
  `param_type` int(2) DEFAULT NULL COMMENT '参数类型(1:填充域 2:签名域)',
  `authType` int(2) DEFAULT NULL COMMENT '鉴权方式(1 无需鉴权；2 ；短信鉴权（三/四要素+短信 3 活体鉴权（三/四要素+（活体+人脸）+短信）)',
  `signature_strategy` int(2) DEFAULT NULL COMMENT '签章策略(6 密钥证书 ； 8 场景证书)',
  `template_region_config_id` bigint(31) DEFAULT NULL COMMENT '填充系统参数id(合同模板和签名域/填充域关联表id)',
  `remark` varchar(127) DEFAULT NULL COMMENT '备注',
  `econtract_template_no` varchar(31) DEFAULT NULL COMMENT '合同模板编号',
  `econtract_template_name` varchar(31) DEFAULT NULL COMMENT '合同模板名称',
  `tempate_sort` int(31) DEFAULT NULL COMMENT '模板中模板列表序号',
  `middleware_region_id` varchar(31) DEFAULT NULL COMMENT '中间件签名域/填充域id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_inuse` int(2) DEFAULT '1' COMMENT '停用启用状态(0:停用 1:启用)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_etn` (`econtract_template_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COMMENT='合同模板参数表';

-- ----------------------------
-- Table structure for econtract_template_master
-- ----------------------------
DROP TABLE IF EXISTS `econtract_template_master`;
CREATE TABLE `econtract_template_master` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `remark` varchar(127) DEFAULT NULL COMMENT '备注',
  `econtract_template_no` varchar(31) DEFAULT NULL COMMENT '合同模板编号',
  `econtract_template_name` varchar(31) DEFAULT NULL COMMENT '合同模板名称',
  `is_inuse` int(2) DEFAULT '1' COMMENT '停用启用状态(0:停用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COMMENT='合同模板主表';

-- ----------------------------
-- Table structure for econtract_template_region_config
-- ----------------------------
DROP TABLE IF EXISTS `econtract_template_region_config`;
CREATE TABLE `econtract_template_region_config` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `region_name` varchar(31) DEFAULT NULL COMMENT '填充域/签名域名称',
  `region_type` int(2) DEFAULT NULL COMMENT '1:填充域 2:签名域',
  `region_value` varchar(127) DEFAULT NULL COMMENT '签名域/填充域值(例如:loanProjectInfo.projectNo)',
  `region_assemble_bean` varchar(255) DEFAULT NULL COMMENT '签名域/填充域组装数据bean对象',
  `region_party_type` int(2) DEFAULT NULL COMMENT '签名域主体(1:银行签章; 2:合作单位签章 3:主贷人签章 4:共同偿债人1签章 5:共同偿债人2签章 6:担保人1签章 7:担保人2签章 )\n',
  `is_inuse` int(2) DEFAULT NULL COMMENT '是否启用(1:启用 0:弃用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='合同模板表签名域/填充域配置表';

-- ----------------------------
-- Table structure for escrow_account_fee_info
-- ----------------------------
DROP TABLE IF EXISTS `escrow_account_fee_info`;
CREATE TABLE `escrow_account_fee_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_apply_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `escrow_account_id` bigint(20) DEFAULT NULL COMMENT '第三方账户id',
  `loan_amount` decimal(22,2) DEFAULT NULL COMMENT '第三方的贷款金额',
  `down_payment_amount` decimal(22,2) DEFAULT NULL COMMENT '第三方首付款',
  `billing_price` decimal(22,2) DEFAULT NULL COMMENT '第三方车价',
  `total_fee` decimal(22,2) DEFAULT NULL COMMENT '第三方总费用',
  `is_inuse` int(2) DEFAULT NULL COMMENT '是否启用(1启用、0禁用)',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apply_idx` (`loan_apply_id`) USING BTREE,
  KEY `project_idx` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='第三账户金额信息';

-- ----------------------------
-- Table structure for etl_slow_query_log
-- ----------------------------
DROP TABLE IF EXISTS `etl_slow_query_log`;
CREATE TABLE `etl_slow_query_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_time` datetime DEFAULT NULL COMMENT '查询时间',
  `query_time` decimal(10,3) DEFAULT NULL COMMENT '时长-默认秒',
  `query_sql` mediumtext COMMENT '查询sql',
  `user_host` varchar(50) NOT NULL COMMENT '访问ip',
  `db` varchar(512) NOT NULL COMMENT '数据源',
  `is_optimize` tinyint(1) DEFAULT '1' COMMENT '是否优化（处理）（0：已优化，1：未优化）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `etl_date` date DEFAULT NULL COMMENT '跑批日期',
  PRIMARY KEY (`id`),
  KEY `idx_start_time` (`start_time`) USING BTREE,
  KEY `idx_query_time` (`query_time`) USING BTREE,
  KEY `idx_user_host` (`user_host`) USING BTREE,
  KEY `idx_is_optimize` (`is_optimize`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=166697 DEFAULT CHARSET=utf8 COMMENT='慢查询日志';

-- ----------------------------
-- Table structure for external_platform_service_log
-- ----------------------------
DROP TABLE IF EXISTS `external_platform_service_log`;
CREATE TABLE `external_platform_service_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_serial_no` varchar(64) DEFAULT NULL COMMENT '订单序列号(UUID)',
  `external_order_no` varchar(64) DEFAULT NULL COMMENT '外部平台订单号',
  `external_platform_type` varchar(32) DEFAULT NULL COMMENT '外部平台类型',
  `external_biz_type` varchar(32) DEFAULT NULL COMMENT '外部服务类型',
  `internal_order_no` varchar(64) DEFAULT NULL COMMENT '内部订单号',
  `internal_order_no_type` varchar(32) DEFAULT NULL COMMENT '内部订单号类型',
  `request_msg` varchar(3000) DEFAULT NULL COMMENT '请求报文',
  `request_msg_ext` varchar(255) DEFAULT NULL COMMENT '请求报文-扩展信息',
  `response_msg` varchar(3000) DEFAULT NULL COMMENT '响应报文',
  `exception_msg` varchar(3000) DEFAULT NULL COMMENT '异常信息',
  `request_time` datetime DEFAULT NULL COMMENT '请求时间',
  `response_time` datetime DEFAULT NULL COMMENT '响应时间',
  `result` int(8) DEFAULT NULL COMMENT '报表解析结果(根据不同调用类型,解析结果也各不相同)(云图:0审批未通过, 1审批通过)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_serial_no` (`order_serial_no`) USING BTREE,
  KEY `idx_eeii` (`external_platform_type`,`external_biz_type`,`internal_order_no_type`,`internal_order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=357130 DEFAULT CHARSET=utf8 COMMENT='外部平台服务调用日志表';

-- ----------------------------
-- Table structure for external_platform_service_rule
-- ----------------------------
DROP TABLE IF EXISTS `external_platform_service_rule`;
CREATE TABLE `external_platform_service_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `biz_module` int(11) NOT NULL COMMENT '业务模块',
  `external_platform_type` int(11) NOT NULL COMMENT '外部平台类型',
  `external_biz_type` int(11) NOT NULL COMMENT '外部服务类型',
  `co_bank_id` bigint(11) DEFAULT NULL COMMENT '合作银行Id',
  `co_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '分公司Id',
  `org_name` varchar(255) DEFAULT NULL COMMENT '分公司名称',
  `group_id` bigint(20) DEFAULT NULL COMMENT '业务组Id',
  `group_name` varchar(255) DEFAULT NULL COMMENT '业务组名称',
  `car_type` int(11) DEFAULT NULL COMMENT '汽车类型 1-新车,2-二手车',
  `biz_type` int(11) DEFAULT NULL COMMENT '业务品种 1-信用卡贷款(普通模式),2-信用卡贷款(银行直销),3-个人消费贷款),4-信用卡贷款(银行直销-垫款),5-工行@车贷',
  `loan_amount_upper_limit` decimal(18,6) DEFAULT NULL COMMENT '贷款金额上限',
  `loan_term` int(11) DEFAULT NULL COMMENT '贷款期限 1-12期,2-18期,3-24期,4-36期',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用 0-否,1-是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='外部平台服务配置表';

-- ----------------------------
-- Table structure for fee_manage
-- ----------------------------
DROP TABLE IF EXISTS `fee_manage`;
CREATE TABLE `fee_manage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fee_no` varchar(50) DEFAULT NULL COMMENT '费用编号',
  `bussiness_id` bigint(20) DEFAULT NULL COMMENT '业务主键（拖车主键或案件主键）',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `project_no` varchar(50) NOT NULL COMMENT '项目编号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `fee_type_code` int(10) DEFAULT NULL COMMENT '费用类型编码',
  `fee_category_code` int(10) DEFAULT NULL COMMENT '费用类别编码',
  `fee_code` int(10) DEFAULT NULL COMMENT '费用名称编码',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `mobile_phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `apply_amount` decimal(24,6) DEFAULT NULL COMMENT '申请金额',
  `approve_amount` decimal(24,6) DEFAULT NULL COMMENT '审批金额',
  `payment_amount` decimal(24,6) DEFAULT NULL COMMENT '付款金额',
  `receivable_amount` decimal(24,6) DEFAULT NULL COMMENT '收款金额',
  `collected_amount` decimal(24,6) DEFAULT NULL COMMENT '实收金额',
  `payment_method` int(10) DEFAULT NULL COMMENT '打款方式',
  `account_name` varchar(50) DEFAULT NULL COMMENT '帐户名称',
  `account_no` varchar(50) DEFAULT NULL COMMENT '帐户号码',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `status` int(10) DEFAULT NULL COMMENT '1,待提交 2，审批中3，审批通过4，已收款，5已关闭',
  `is_income` int(1) DEFAULT NULL COMMENT '收支(1:支，2：收)',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用(1:启用，2：停用)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '业务组ID',
  `user_group_name` varchar(50) DEFAULT NULL COMMENT '业务组名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `launch_date` date DEFAULT NULL COMMENT '费用发起时间',
  `actual_date` date DEFAULT NULL COMMENT '费用实际时间（费用发生日期或收款日期）',
  `business_area` int(1) DEFAULT NULL COMMENT '业务区域 1:浙江省内 2:浙江省外 (20160919垫款)',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `operator` varchar(50) DEFAULT NULL,
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`),
  KEY `index_project_id` (`project_id`),
  KEY `index_bussiness_id` (`bussiness_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='财务管理表';

-- ----------------------------
-- Table structure for fee_manage_advance
-- ----------------------------
DROP TABLE IF EXISTS `fee_manage_advance`;
CREATE TABLE `fee_manage_advance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `business_area` int(1) DEFAULT NULL COMMENT '业务区域 1:浙江省内 2:浙江省外 (20160919垫款)',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(32) DEFAULT NULL COMMENT '合作银行名称',
  `apply_amount` decimal(24,6) DEFAULT NULL COMMENT '申请总金额',
  `isvalid` int(1) NOT NULL DEFAULT '1' COMMENT '1.有效（未删除） 0.无效（已删除）',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='垫款费用表';

-- ----------------------------
-- Table structure for fee_manage_advance_file
-- ----------------------------
DROP TABLE IF EXISTS `fee_manage_advance_file`;
CREATE TABLE `fee_manage_advance_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fee_advance_id` bigint(20) DEFAULT NULL COMMENT '费用垫款ID',
  `file_path` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_size` decimal(18,2) DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8 COMMENT='费用垫款文件表';

-- ----------------------------
-- Table structure for fee_manage_apply
-- ----------------------------
DROP TABLE IF EXISTS `fee_manage_apply`;
CREATE TABLE `fee_manage_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fee_no` varchar(50) DEFAULT NULL COMMENT '费用编号',
  `fee_type_code` int(10) DEFAULT NULL COMMENT '费用类型编码',
  `fee_category_code` int(10) DEFAULT NULL COMMENT '费用类别编码',
  `fee_code` int(10) DEFAULT NULL COMMENT '费用名称编码',
  `apply_amount` decimal(24,6) DEFAULT NULL COMMENT '申请金额',
  `approve_amount` decimal(24,6) DEFAULT NULL COMMENT '审批金额',
  `payment_amount` decimal(24,6) DEFAULT NULL COMMENT '付款金额',
  `receivable_amount` decimal(24,6) DEFAULT NULL COMMENT '收款金额',
  `collect_amount` decimal(24,6) DEFAULT NULL COMMENT '实收金额',
  `payment_method` int(10) DEFAULT NULL COMMENT '打款方式',
  `account_name` varchar(50) DEFAULT NULL COMMENT '帐户名称',
  `account_no` varchar(50) DEFAULT NULL COMMENT '帐户号码',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `status` int(10) DEFAULT NULL COMMENT '1,待提交 2，审批中3，审批通过4，已收款，5已关闭',
  `is_income` int(1) DEFAULT NULL COMMENT '收支(1:支，2：收)',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用(1:启用，2：停用)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '业务组ID',
  `user_group_name` varchar(50) DEFAULT NULL COMMENT '业务组名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `launch_date` date DEFAULT NULL COMMENT '费用发起时间',
  `actual_date` date DEFAULT NULL COMMENT '费用实际时间（费用发生日期或收款日期）',
  `create_time` datetime DEFAULT NULL COMMENT '录入时间',
  `modify_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `operator` varchar(50) DEFAULT NULL,
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `fee_reason_code` int(10) DEFAULT NULL COMMENT '垫款时的费用原因',
  `fee_reason` varchar(255) DEFAULT NULL COMMENT '费用原因',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COMMENT='费用申请表';

-- ----------------------------
-- Table structure for fee_manage_detail
-- ----------------------------
DROP TABLE IF EXISTS `fee_manage_detail`;
CREATE TABLE `fee_manage_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fee_apply_id` bigint(20) DEFAULT NULL COMMENT '费用id',
  `business_id` varchar(20) DEFAULT NULL COMMENT '业务id',
  `project_id` bigint(20) DEFAULT NULL,
  `project_no` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `fee_type_code` int(5) DEFAULT NULL,
  `fee_category_code` int(5) DEFAULT NULL,
  `fee_code` int(5) DEFAULT NULL,
  `customer_name` varchar(20) DEFAULT NULL,
  `mobile_phone` varchar(20) DEFAULT NULL,
  `apply_amount` decimal(10,2) DEFAULT NULL,
  `approve_amount` decimal(10,2) DEFAULT NULL,
  `payment_amount` decimal(10,2) DEFAULT NULL,
  `receivable_amount` decimal(10,2) DEFAULT NULL,
  `collect_amount` decimal(10,2) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `is_income` int(1) DEFAULT NULL,
  `is_inuse` int(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fee_manage_file
-- ----------------------------
DROP TABLE IF EXISTS `fee_manage_file`;
CREATE TABLE `fee_manage_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fee_id` bigint(20) DEFAULT NULL COMMENT '收款ID',
  `file_path` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_size` decimal(18,2) DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='费用管理文件表';

-- ----------------------------
-- Table structure for file_storage_record
-- ----------------------------
DROP TABLE IF EXISTS `file_storage_record`;
CREATE TABLE `file_storage_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `file_type` varchar(100) DEFAULT NULL COMMENT '图片类型',
  `file_size` bigint(30) DEFAULT NULL COMMENT '图片大小',
  `file_path` varchar(255) DEFAULT NULL COMMENT '图片url',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `original_name` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `business_type` varchar(50) DEFAULT NULL COMMENT '业务类型:1合作机构证件；2法人代表证件；3合作协议证件',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int(11) DEFAULT '1' COMMENT '状态：1:启用，0：停用',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0：未删除，1：已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1231026994619539459 DEFAULT CHARSET=utf8mb4 COMMENT='文件存储记录表';

-- ----------------------------
-- Table structure for file_upload_sftp_record
-- ----------------------------
DROP TABLE IF EXISTS `file_upload_sftp_record`;
CREATE TABLE `file_upload_sftp_record` (
  `id` bigint(31) NOT NULL COMMENT '主键',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `business_id` bigint(31) DEFAULT NULL COMMENT '业务id',
  `is_upload` int(2) DEFAULT NULL COMMENT '是否已经上传了(0:上传失败 1:上传成功)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务上传文件sftp记录表';

-- ----------------------------
-- Table structure for finance_payment_application
-- ----------------------------
DROP TABLE IF EXISTS `finance_payment_application`;
CREATE TABLE `finance_payment_application` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `flow_name` varchar(255) DEFAULT NULL COMMENT '流程名称',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请ID',
  `apply_company_id` bigint(20) DEFAULT NULL COMMENT '申请机构ID',
  `apply_company` varchar(255) DEFAULT NULL COMMENT '申请机构名称',
  `apply_type` int(4) DEFAULT NULL COMMENT '申请类型，0：申请资金部出纳打款，1：申请分公司出纳打款',
  `biz_group_id` bigint(20) DEFAULT NULL COMMENT '业务组ID',
  `biz_group_name` varchar(255) DEFAULT NULL COMMENT '业务组名称',
  `processor_uid` bigint(20) DEFAULT NULL COMMENT '处理人用户UID',
  `processor_realname` varchar(255) DEFAULT NULL COMMENT '处理人姓名',
  `loan_amount` decimal(24,6) DEFAULT NULL COMMENT '贷款金额',
  `apply_amount` decimal(24,6) DEFAULT NULL COMMENT '申请打款金额',
  `coop_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行ID',
  `coop_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行全称',
  `coop_cardealer_id` bigint(20) DEFAULT NULL COMMENT '合作车商ID',
  `coop_cardealer_name` varchar(255) DEFAULT NULL COMMENT '合作车商全称',
  `fund_out_full_name` varchar(255) DEFAULT NULL COMMENT '打款方全称',
  `fund_out_bank_name` varchar(255) DEFAULT NULL COMMENT '打款方开户行',
  `fund_out_account` varchar(255) DEFAULT NULL COMMENT '打款方资金系统账号',
  `fund_out_bankcard` varchar(255) DEFAULT NULL COMMENT '打款方银行卡号',
  `fund_in_full_name` varchar(255) DEFAULT NULL COMMENT '收款方全称',
  `fund_in_bank_name` varchar(255) DEFAULT NULL COMMENT '收款方开户行',
  `fund_in_fund_account` varchar(255) DEFAULT NULL COMMENT '收款方资金账号',
  `fund_in_bankcard` varchar(255) DEFAULT NULL COMMENT '收款方银行卡号',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `last_approve_time` datetime DEFAULT NULL COMMENT '上个节点审批时间',
  `export_status` int(4) DEFAULT '0' COMMENT '导出状态，0：未导出，1：已导出',
  `print_status` int(4) DEFAULT '0' COMMENT '预算单打印状态，0：未打印，1：已打印，2：未打印（重打）',
  `payment_status` int(4) DEFAULT '0' COMMENT '付款状态，0：未付款，1：已付款-系统，2：已付款-人工，3：系统付款失败',
  `back_status` int(1) DEFAULT NULL COMMENT '退回状态（0：未退回，1：资金部出纳已退回；2：分公司出纳已退回）',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5840 DEFAULT CHARSET=utf8 COMMENT='打款申请表';

-- ----------------------------
-- Table structure for finance_receipt
-- ----------------------------
DROP TABLE IF EXISTS `finance_receipt`;
CREATE TABLE `finance_receipt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `apply_company_id` bigint(20) DEFAULT NULL COMMENT '分公司id',
  `apply_company` varchar(255) DEFAULT NULL COMMENT '分公司名称',
  `loan_amount` decimal(24,6) DEFAULT NULL COMMENT '贷款金额',
  `coop_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `coop_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名称',
  `receipt_amount` decimal(24,6) DEFAULT NULL COMMENT '收款金额',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `commit_time` datetime DEFAULT NULL COMMENT '分公司财务提交时间',
  `print_status` int(1) NOT NULL DEFAULT '0' COMMENT '打印状态(0:未打印，1：已打印）',
  `receipt_status` int(1) NOT NULL DEFAULT '0' COMMENT '是否收款（0:未收款，1:已收款）',
  `biz_group_id` bigint(20) DEFAULT NULL COMMENT '业务组id',
  `biz_group_name` varchar(255) DEFAULT NULL COMMENT '业务组名称',
  `billing_price` decimal(24,4) DEFAULT NULL COMMENT '开票价',
  `collected_amount` decimal(24,6) DEFAULT NULL COMMENT '实际收款金额',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_auto_node_config
-- ----------------------------
DROP TABLE IF EXISTS `flow_auto_node_config`;
CREATE TABLE `flow_auto_node_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_type` varchar(30) NOT NULL COMMENT '流程类型',
  `current_node_key` varchar(50) NOT NULL COMMENT '当前待办的流程节点',
  `auto_node_key` varchar(50) NOT NULL COMMENT '自动流程节点',
  `description` varchar(500) NOT NULL COMMENT '规则说明',
  `operator_bean` varchar(100) NOT NULL COMMENT '获取提交人的bean',
  `excute_bean` varchar(100) NOT NULL COMMENT '执行器',
  `param_list` varchar(500) NOT NULL COMMENT '参数列表,多个参数用|隔开，尾部不带分隔符',
  `for_expression` varchar(3000) NOT NULL COMMENT '计算表达式',
  `rule_index` int(4) NOT NULL DEFAULT '0' COMMENT '规则优先级，最大越优先',
  `auto_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '自动类型(0 自动提交自动退回,1 自动提交,2 自动退回)',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '停用标示(0:启用,1:停用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `submit_bean` varchar(100) NOT NULL DEFAULT '' COMMENT 'submit_bean 1.执行Action的submit2NextNode 2.配置了submit_bean 不会执行自动提交',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='流程自动节点配置规则表';

-- ----------------------------
-- Table structure for flow_node_embed_rule
-- ----------------------------
DROP TABLE IF EXISTS `flow_node_embed_rule`;
CREATE TABLE `flow_node_embed_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_type` varchar(30) NOT NULL COMMENT '流程类型',
  `node_key` varchar(50) NOT NULL COMMENT '流程节点',
  `bean_name` varchar(255) NOT NULL COMMENT '执行器(spring bean名字:@Service或@Component的名称)',
  `del_flag` tinyint(2) NOT NULL COMMENT '停用标示(0:启用,1:停用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_node_embed_rule_formula
-- ----------------------------
DROP TABLE IF EXISTS `flow_node_embed_rule_formula`;
CREATE TABLE `flow_node_embed_rule_formula` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_type` varchar(30) NOT NULL COMMENT '流程类型',
  `node_key` varchar(50) NOT NULL COMMENT '流程节点',
  `description` varchar(500) NOT NULL COMMENT '规则说明',
  `for_expression` varchar(3000) NOT NULL COMMENT '计算表达式',
  `param_list` varchar(500) NOT NULL COMMENT '参数列表,多个参数用|隔开，尾部不带分隔符',
  `rule_index` int(4) NOT NULL DEFAULT '0' COMMENT '规则优先级，最大越优先',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '停用标示(0:启用,1:停用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='流程节点引擎规则表';

-- ----------------------------
-- Table structure for flow_node_embed_rule_param
-- ----------------------------
DROP TABLE IF EXISTS `flow_node_embed_rule_param`;
CREATE TABLE `flow_node_embed_rule_param` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(50) NOT NULL COMMENT '参数名称',
  `description` varchar(1000) NOT NULL COMMENT '参数说明',
  `param_generator_bean` varchar(255) NOT NULL COMMENT '参数获取器',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_param_name` (`param_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='流程节点嵌入规则参数表';

-- ----------------------------
-- Table structure for flow_node_skip_config_deprecate
-- ----------------------------
DROP TABLE IF EXISTS `flow_node_skip_config_deprecate`;
CREATE TABLE `flow_node_skip_config_deprecate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '当前流程',
  `org_id` bigint(20) DEFAULT NULL COMMENT '机构Id',
  `loan_amout` decimal(20,4) DEFAULT NULL COMMENT '审批金额权限',
  `flow_type` varchar(50) DEFAULT NULL COMMENT '当前流程',
  `node_key` varchar(60) DEFAULT NULL COMMENT '当前节点',
  `next_node` varchar(60) DEFAULT NULL COMMENT '下一节点',
  `percent` int(3) NOT NULL DEFAULT '0',
  `is_back` tinyint(1) DEFAULT NULL COMMENT '0提交1退回',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='流程跳过配置';

-- ----------------------------
-- Table structure for flow_skip_info
-- ----------------------------
DROP TABLE IF EXISTS `flow_skip_info`;
CREATE TABLE `flow_skip_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `biz_flow` varchar(100) DEFAULT NULL COMMENT '流程code',
  `biz_id` varchar(20) DEFAULT NULL COMMENT '业务外键',
  `skip` tinyint(1) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3496 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for flow_start_param_cache
-- ----------------------------
DROP TABLE IF EXISTS `flow_start_param_cache`;
CREATE TABLE `flow_start_param_cache` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `business_type` varchar(30) NOT NULL COMMENT '流程类型',
  `business_object_id` bigint(11) NOT NULL COMMENT '业务对象id',
  `param_value` longtext NOT NULL COMMENT '参数缓存(用json形式存储)',
  `version` int(8) NOT NULL COMMENT '版本号',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '停用标示(0:启用,1:停用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_bbd` (`business_type`,`business_object_id`,`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11780 DEFAULT CHARSET=utf8 COMMENT='流程开始参数缓存表（1.根据配置表配置的参数缓存值）';

-- ----------------------------
-- Table structure for flow_start_param_cache_config
-- ----------------------------
DROP TABLE IF EXISTS `flow_start_param_cache_config`;
CREATE TABLE `flow_start_param_cache_config` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `business_type` varchar(30) NOT NULL COMMENT '流程类型',
  `node_key` varchar(50) NOT NULL COMMENT '缓存的流程节点',
  `param_list` varchar(1500) NOT NULL COMMENT '参数列表（多个参数请用|隔开）',
  `description` varchar(1000) NOT NULL COMMENT '配置说明',
  `version` int(8) NOT NULL COMMENT '版本号',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '停用标示(0:启用,1:停用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_business_type_version` (`business_type`,`version`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='流程开始参数缓存配置表（1.配置参数的在后续流程节点优先使用缓存值）';

-- ----------------------------
-- Table structure for fmis_order
-- ----------------------------
DROP TABLE IF EXISTS `fmis_order`;
CREATE TABLE `fmis_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payAccountId` bigint(20) DEFAULT NULL,
  `payAccountName` varchar(100) DEFAULT NULL,
  `payAccountNo` varchar(100) DEFAULT NULL,
  `payAccountBankNo` varchar(50) DEFAULT NULL,
  `payAccountBankId` bigint(20) DEFAULT NULL,
  `payAccountBankName` varchar(100) DEFAULT NULL,
  `payAccountCityId` bigint(20) DEFAULT NULL,
  `payAccountCityName` varchar(50) DEFAULT NULL,
  `receiptAccountId` bigint(20) DEFAULT NULL,
  `receiptAccountName` varchar(100) DEFAULT NULL,
  `receiptAccountNo` varchar(100) DEFAULT NULL,
  `receiptAccountBankId` bigint(20) DEFAULT NULL,
  `receiptAccountBankNo` varchar(50) DEFAULT NULL,
  `receiptAccountBankName` varchar(100) DEFAULT NULL,
  `receiptAccountCityId` bigint(20) DEFAULT NULL,
  `receiptAccountCityName` varchar(50) DEFAULT NULL,
  `bizId` varchar(30) DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `channel` varchar(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `createUser` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `orgId` bigint(20) DEFAULT NULL,
  `customerDesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fmis_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `fmis_order_detail`;
CREATE TABLE `fmis_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderId` bigint(20) DEFAULT NULL,
  `flowNo` varchar(50) DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `finishTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `responseText` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps
-- ----------------------------
DROP TABLE IF EXISTS `gps`;
CREATE TABLE `gps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'gps型号id',
  `supplier_id` int(11) DEFAULT NULL,
  `supplier_name` varchar(50) DEFAULT NULL,
  `model_id` bigint(20) DEFAULT NULL COMMENT '型号id',
  `model_name` varchar(50) DEFAULT NULL COMMENT 'gps型号名称',
  `type` int(11) DEFAULT NULL COMMENT '0 无线 1 有线',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'gps入库价格',
  `imei` varchar(50) DEFAULT '' COMMENT 'IMEI号',
  `sim` varchar(50) DEFAULT '' COMMENT 'sim号',
  `group_id` bigint(3) DEFAULT NULL COMMENT 'groupid或者分公司id 转义为库id ',
  `group_name` varchar(50) DEFAULT NULL COMMENT '库名',
  `stock_status` int(2) DEFAULT NULL COMMENT '状态 0待入库 1 在库 2已出库',
  `exception_type` int(2) DEFAULT NULL COMMENT '异常类型',
  `exception_name` varchar(50) DEFAULT NULL COMMENT '异常名称',
  `exception_reason` varchar(50) DEFAULT NULL COMMENT '异常原因',
  `stock_in_time` timestamp NULL DEFAULT NULL COMMENT '入库时间',
  `destination` varchar(50) DEFAULT NULL COMMENT '去向 ',
  `out_stock_reason` int(1) DEFAULT NULL COMMENT '0 已领用 1 已安装 2 已退回 3 维修 4 丢失 5 已分配',
  `branch_id` int(11) DEFAULT NULL COMMENT '所属机构id',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '处理时间',
  `branch_name` varchar(50) DEFAULT NULL COMMENT '所属机构名称',
  `destination_id` bigint(3) DEFAULT NULL COMMENT '去向id -1丢失，-2供应商,-3客户',
  `is_pre_assigned` tinyint(11) DEFAULT '0',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '处理人id',
  `dealer_name` varchar(50) DEFAULT NULL COMMENT '处理人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4426 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_allot_bill
-- ----------------------------
DROP TABLE IF EXISTS `gps_allot_bill`;
CREATE TABLE `gps_allot_bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL COMMENT '申请明细表id',
  `apply_num` bigint(20) DEFAULT NULL COMMENT '申请数量',
  `alloted_num` bigint(20) DEFAULT NULL COMMENT '已分配数量',
  `express_no` varchar(255) DEFAULT NULL COMMENT '快递单号',
  `allot_time` timestamp NULL DEFAULT NULL COMMENT '分配日期',
  `allot_user_id` bigint(20) DEFAULT NULL COMMENT '申请人ID',
  `allot_user_name` varchar(50) DEFAULT NULL COMMENT '申请人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='GPS批量分配表';

-- ----------------------------
-- Table structure for gps_allot_detail
-- ----------------------------
DROP TABLE IF EXISTS `gps_allot_detail`;
CREATE TABLE `gps_allot_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL COMMENT '申请明细表id',
  `allot_id` bigint(20) DEFAULT NULL COMMENT '分配表ID',
  `gps_id` bigint(20) DEFAULT NULL COMMENT 'GPSId',
  `allot_serial` varchar(255) DEFAULT NULL COMMENT '分配单唯一序号',
  `save_time` timestamp NULL DEFAULT NULL COMMENT '保存时间',
  `effect_time` timestamp NULL DEFAULT NULL COMMENT '分配生效时间',
  `allot_user_id` bigint(20) DEFAULT NULL COMMENT '分配人人ID',
  `allot_user_name` varchar(50) DEFAULT NULL COMMENT '分配人名称',
  `allot_status` tinyint(1) DEFAULT '0' COMMENT '分配状态 只保存false 生效后true',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=885 DEFAULT CHARSET=utf8 COMMENT='分配明细表';

-- ----------------------------
-- Table structure for gps_business
-- ----------------------------
DROP TABLE IF EXISTS `gps_business`;
CREATE TABLE `gps_business` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gps_id` bigint(20) DEFAULT NULL,
  `business_id` bigint(20) DEFAULT NULL COMMENT '业务id ',
  `type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_business_type
-- ----------------------------
DROP TABLE IF EXISTS `gps_business_type`;
CREATE TABLE `gps_business_type` (
  `id` varchar(255) DEFAULT NULL,
  `business_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_contract
-- ----------------------------
DROP TABLE IF EXISTS `gps_contract`;
CREATE TABLE `gps_contract` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `contract_no` varchar(255) DEFAULT NULL COMMENT '合同编号',
  `apply_org_name` varchar(255) DEFAULT NULL COMMENT '申请机构名称',
  `status` int(1) DEFAULT '0' COMMENT '合同状态，0已签合同，1入库中，2已入库',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 0删除，1没有删除',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `order_number` bigint(11) DEFAULT NULL COMMENT '订购数量',
  `apply_org_id` bigint(11) DEFAULT NULL COMMENT '申请机构id',
  `gps_factory_id` bigint(11) DEFAULT NULL,
  `gps_factory_name` varchar(255) DEFAULT NULL COMMENT 'GPS提供商',
  `purchase_user` varchar(255) DEFAULT NULL COMMENT '申请人名称',
  `purchase_user_id` bigint(11) DEFAULT NULL COMMENT '申请人id',
  `serial_num` bigint(11) DEFAULT NULL,
  `org_code` varchar(50) DEFAULT NULL COMMENT '公司代号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_contract_details
-- ----------------------------
DROP TABLE IF EXISTS `gps_contract_details`;
CREATE TABLE `gps_contract_details` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(11) DEFAULT NULL COMMENT '合同id',
  `apply_item_id` bigint(11) DEFAULT NULL COMMENT 'Gps明细id',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除,0没有删除，1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_offline_warning
-- ----------------------------
DROP TABLE IF EXISTS `gps_offline_warning`;
CREATE TABLE `gps_offline_warning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `imei` varchar(50) DEFAULT NULL,
  `off_line_days` double(11,0) DEFAULT NULL COMMENT '离线天数',
  `alarm_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '预警时间',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `send_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_lng` varchar(50) DEFAULT NULL COMMENT '最近一次纬度',
  `last_lat` varchar(50) DEFAULT NULL COMMENT '最近一次经度',
  `last_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最近一次设备在线时间',
  `status` int(11) DEFAULT NULL,
  `supplier` int(50) DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_purchase_apply
-- ----------------------------
DROP TABLE IF EXISTS `gps_purchase_apply`;
CREATE TABLE `gps_purchase_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_no` varchar(80) DEFAULT NULL COMMENT '申请单号',
  `apply_org_id` bigint(20) DEFAULT NULL COMMENT '机构id',
  `apply_org_name` varchar(255) DEFAULT NULL COMMENT '机构名称',
  `apply_stock_id` bigint(20) DEFAULT NULL COMMENT '所属库id',
  `apply_stock_name` varchar(255) DEFAULT NULL COMMENT '所属库名称',
  `apply_user_id` bigint(20) DEFAULT NULL COMMENT '申请人ID',
  `apply_user_name` varchar(50) DEFAULT NULL COMMENT '申请人名称',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
  `apply_date` timestamp NULL DEFAULT NULL COMMENT '申请日期',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '录入时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` smallint(1) DEFAULT '0' COMMENT '删除标记:默认false,删除变true',
  `serial` bigint(20) DEFAULT NULL,
  `org_code` varchar(50) DEFAULT NULL COMMENT '机构编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='GPS采购申请表';

-- ----------------------------
-- Table structure for gps_purchase_item
-- ----------------------------
DROP TABLE IF EXISTS `gps_purchase_item`;
CREATE TABLE `gps_purchase_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) DEFAULT NULL COMMENT '申请表id',
  `apply_no` varchar(80) DEFAULT NULL COMMENT '申请单号',
  `apply_org_id` bigint(20) DEFAULT NULL COMMENT '机构id',
  `apply_org_name` varchar(255) DEFAULT NULL COMMENT '机构名称',
  `apply_stock_id` bigint(20) DEFAULT NULL COMMENT '所属库id',
  `apply_stock_name` varchar(255) DEFAULT NULL COMMENT '所属库名称',
  `gps_factory_code` varchar(255) DEFAULT NULL COMMENT '厂商code',
  `gps_factory` varchar(255) DEFAULT NULL COMMENT 'gps厂商',
  `model_type_code` varchar(255) DEFAULT NULL COMMENT 'gps型号code',
  `model_type` varchar(255) DEFAULT NULL COMMENT '型号',
  `gps_type_code` varchar(255) DEFAULT NULL COMMENT '类型:1有线2无线3无线+有线',
  `gps_type` varchar(255) DEFAULT NULL COMMENT '型号',
  `apply_num` bigint(20) DEFAULT NULL COMMENT '申请数量',
  `per_price` decimal(24,6) DEFAULT NULL COMMENT '单价',
  `status` int(11) DEFAULT NULL COMMENT '状态 1:发起GPS申请,2:分公司副总审批,3:总部审批中心,4:付款审批,5:申请完成,6:已签合同,7:入库中,8:已入库',
  `status_desc` varchar(255) DEFAULT NULL COMMENT '状态描述',
  `apply_user_id` bigint(20) DEFAULT NULL COMMENT '申请人ID',
  `apply_user_name` varchar(50) DEFAULT NULL COMMENT '申请人名称',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
  `apply_date` timestamp NULL DEFAULT NULL COMMENT '申请日期',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标记:默认false,删除变true',
  `is_contract` tinyint(1) DEFAULT '0' COMMENT '签合同标记:默认false,签合同变true',
  `is_allot_complete` tinyint(1) DEFAULT '0' COMMENT '分配标记:默认false,分配完成变true',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8 COMMENT='GPS采购申请明细表';

-- ----------------------------
-- Table structure for gps_return
-- ----------------------------
DROP TABLE IF EXISTS `gps_return`;
CREATE TABLE `gps_return` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `return_no` varchar(255) DEFAULT NULL COMMENT '返修单号',
  `serial` bigint(20) DEFAULT NULL COMMENT '返修单号序列',
  `handle_time` timestamp NULL DEFAULT NULL COMMENT '处理时间',
  `express_no` varchar(255) DEFAULT NULL COMMENT '快递单号',
  `user_id` bigint(20) DEFAULT NULL COMMENT '处理人',
  `user_name` varchar(255) DEFAULT NULL COMMENT '处理人',
  `org_code` varchar(50) DEFAULT NULL COMMENT '机构编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_return_detail
-- ----------------------------
DROP TABLE IF EXISTS `gps_return_detail`;
CREATE TABLE `gps_return_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `return_id` bigint(20) DEFAULT NULL COMMENT '退回主表id',
  `gps_id` bigint(20) DEFAULT NULL,
  `handle_time` timestamp NULL DEFAULT NULL,
  `express_no` varchar(255) DEFAULT NULL COMMENT '快递单号',
  `return_no` varchar(255) DEFAULT NULL COMMENT '返修单号',
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_stock_enter_info
-- ----------------------------
DROP TABLE IF EXISTS `gps_stock_enter_info`;
CREATE TABLE `gps_stock_enter_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '入库单id',
  `business_id` varchar(50) DEFAULT NULL COMMENT '入库订单编号',
  `business_type` varchar(1) DEFAULT NULL,
  `express_no` varchar(20) DEFAULT NULL COMMENT '快递单号',
  `express_date` timestamp NULL DEFAULT NULL COMMENT '入库日期',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '入库日期',
  `create_user` varchar(50) DEFAULT NULL COMMENT '入库人',
  `is_confirm` bit(1) DEFAULT NULL,
  `stock_num` int(11) DEFAULT NULL,
  `deliver_status` tinyint(1) DEFAULT NULL COMMENT '入库状态 0 未到货 1 到货',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_stock_info_detail
-- ----------------------------
DROP TABLE IF EXISTS `gps_stock_info_detail`;
CREATE TABLE `gps_stock_info_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_enter_id` bigint(20) DEFAULT NULL,
  `gps_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6218 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_supplier_template
-- ----------------------------
DROP TABLE IF EXISTS `gps_supplier_template`;
CREATE TABLE `gps_supplier_template` (
  `id` int(11) NOT NULL,
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `template_path` varchar(255) DEFAULT NULL COMMENT '导入模板路径',
  `data_start_row` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_template_setting
-- ----------------------------
DROP TABLE IF EXISTS `gps_template_setting`;
CREATE TABLE `gps_template_setting` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `template_id` bigint(2) DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `execel_id` varchar(2) DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_track
-- ----------------------------
DROP TABLE IF EXISTS `gps_track`;
CREATE TABLE `gps_track` (
  `id` bigint(20) DEFAULT NULL,
  `gps_id` bigint(20) DEFAULT NULL,
  `from_group_id` bigint(20) DEFAULT NULL,
  `from_group_name` varchar(255) DEFAULT NULL,
  `target_group_id` bigint(20) DEFAULT NULL,
  `target_group_name` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_user` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_use_install
-- ----------------------------
DROP TABLE IF EXISTS `gps_use_install`;
CREATE TABLE `gps_use_install` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL,
  `use_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `use_person` varchar(255) DEFAULT NULL,
  `install_date` date DEFAULT NULL,
  `install_person` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gps_use_install_detail
-- ----------------------------
DROP TABLE IF EXISTS `gps_use_install_detail`;
CREATE TABLE `gps_use_install_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `use_id` bigint(20) DEFAULT NULL,
  `gps_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for graylog
-- ----------------------------
DROP TABLE IF EXISTS `graylog`;
CREATE TABLE `graylog` (
  `timestamp` varchar(255) DEFAULT NULL,
  `requestUrl` varchar(255) DEFAULT NULL,
  `responseTime` bigint(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guide_page
-- ----------------------------
DROP TABLE IF EXISTS `guide_page`;
CREATE TABLE `guide_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `guide_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for insurance_type_config
-- ----------------------------
DROP TABLE IF EXISTS `insurance_type_config`;
CREATE TABLE `insurance_type_config` (
  `id` bigint(20) DEFAULT NULL,
  `insurance_type` int(11) DEFAULT NULL,
  `insurance_name` varchar(765) DEFAULT NULL,
  `sort_no` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(765) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for interview_info
-- ----------------------------
DROP TABLE IF EXISTS `interview_info`;
CREATE TABLE `interview_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `product_type` int(2) DEFAULT '1' COMMENT '面签产品 1:车贷 2:房屋装修贷',
  `customer_name` varchar(64) NOT NULL COMMENT '姓名',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(25) NOT NULL COMMENT '证件号码',
  `message` text COMMENT '报文信息',
  `relate_status` int(1) NOT NULL DEFAULT '0' COMMENT '是否关联业务(0:未关联;1:已关联)',
  `interview_type` int(1) NOT NULL DEFAULT '2' COMMENT '面签方式：1人工面签,2机器面签',
  `back_photo` varchar(500) DEFAULT NULL COMMENT '背景图',
  `loan_term` varchar(4) DEFAULT NULL COMMENT '贷款分期期限(月)',
  `serial_no` varchar(500) DEFAULT NULL COMMENT '序列号',
  `external_serial_no` varchar(500) DEFAULT NULL COMMENT '外部序列号',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:失效;1:有效)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COMMENT='面签信息表';

-- ----------------------------
-- Table structure for interview_info_video
-- ----------------------------
DROP TABLE IF EXISTS `interview_info_video`;
CREATE TABLE `interview_info_video` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `interview_id` bigint(20) DEFAULT NULL COMMENT ' 关联的面签信息id ',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `file_type` int(2) DEFAULT NULL COMMENT '文档类型（1：图片，2：视频，3：pdf，4：word）',
  `file_path` varchar(500) DEFAULT NULL COMMENT '上传路径',
  `file_id` varchar(64) NOT NULL DEFAULT '' COMMENT '网关传递过来的文件id',
  `download_status` varchar(64) DEFAULT NULL COMMENT '下载状态枚举名 枚举：FileDownLoadStatusEnum',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:失效;1:有效)',
  `file_name` varchar(100) DEFAULT NULL COMMENT '文件名',
  `download_path` varchar(500) DEFAULT NULL COMMENT '上传路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COMMENT='面签信息视频记录表';

-- ----------------------------
-- Table structure for interview_verify_record
-- ----------------------------
DROP TABLE IF EXISTS `interview_verify_record`;
CREATE TABLE `interview_verify_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `business_id` bigint(20) NOT NULL COMMENT '业务Id',
  `business_no` varchar(32) NOT NULL COMMENT '业务编号',
  `business_type` varchar(64) NOT NULL COMMENT '业务流程标识',
  `question` varchar(255) DEFAULT NULL COMMENT '提问文案',
  `standard_answer` varchar(255) DEFAULT NULL COMMENT '参考答案',
  `actual_answer` varchar(255) DEFAULT NULL COMMENT '实际回答',
  `manual_judge_result` int(11) DEFAULT NULL COMMENT '人工判断结果(0-错误 1-正确)',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0-停用 1-启用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_business_id` (`business_id`) USING BTREE,
  KEY `idx_business_no` (`business_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=161970 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for kettle_log
-- ----------------------------
DROP TABLE IF EXISTS `kettle_log`;
CREATE TABLE `kettle_log` (
  `ID_JOB` int(11) DEFAULT NULL,
  `CHANNEL_ID` varchar(255) DEFAULT NULL,
  `JOBNAME` varchar(255) DEFAULT NULL,
  `STATUS` varchar(15) DEFAULT NULL,
  `LINES_READ` bigint(20) DEFAULT NULL,
  `LINES_WRITTEN` bigint(20) DEFAULT NULL,
  `LINES_UPDATED` bigint(20) DEFAULT NULL,
  `LINES_INPUT` bigint(20) DEFAULT NULL,
  `LINES_OUTPUT` bigint(20) DEFAULT NULL,
  `LINES_REJECTED` bigint(20) DEFAULT NULL,
  `ERRORS` bigint(20) DEFAULT NULL,
  `STARTDATE` datetime DEFAULT NULL,
  `ENDDATE` datetime DEFAULT NULL,
  `LOGDATE` datetime DEFAULT NULL,
  `DEPDATE` datetime DEFAULT NULL,
  `REPLAYDATE` datetime DEFAULT NULL,
  `LOG_FIELD` mediumtext,
  KEY `IDX_kettle_log_1` (`ID_JOB`),
  KEY `IDX_kettle_log_2` (`ERRORS`,`STATUS`,`JOBNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for kettle_syn
-- ----------------------------
DROP TABLE IF EXISTS `kettle_syn`;
CREATE TABLE `kettle_syn` (
  `syntable` varchar(200) DEFAULT NULL,
  `syntime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for lawsuit_defendant
-- ----------------------------
DROP TABLE IF EXISTS `lawsuit_defendant`;
CREATE TABLE `lawsuit_defendant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lawsuit_id` bigint(20) NOT NULL COMMENT '诉讼表主键ID',
  `defendant_type` int(11) DEFAULT '1' COMMENT '被告对象类型：1:人，2:公司机构',
  `defendant_id` bigint(20) DEFAULT NULL COMMENT '被告人ID，或者分公司ID，根据defendant_type确定',
  `defendant_name` varchar(255) DEFAULT NULL COMMENT '被告人（单位）名称',
  `relationship` int(11) DEFAULT NULL COMMENT '与客户之间的关系：  1:担保人，2：反担保人，3：本人,4:配偶',
  `card_type` int(11) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1571 DEFAULT CHARSET=utf8 COMMENT='诉讼被告人信息表';

-- ----------------------------
-- Table structure for lawsuit_info
-- ----------------------------
DROP TABLE IF EXISTS `lawsuit_info`;
CREATE TABLE `lawsuit_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lawsuit_num` varchar(255) NOT NULL COMMENT '诉讼信息标识号，根据规则系统生成(暂定)',
  `law_case_no` varchar(255) DEFAULT NULL COMMENT '案件编号,立案时录入',
  `project_id` bigint(20) NOT NULL COMMENT '贷款项目ID',
  `project_no` varchar(255) NOT NULL COMMENT '贷款编号',
  `customer_id` bigint(11) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户姓名',
  `customer_mobile` varchar(255) DEFAULT NULL COMMENT '手机号',
  `card_type` int(11) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `bank_id` bigint(20) DEFAULT NULL COMMENT '银行ID',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '银行名称',
  `manager_id` bigint(20) DEFAULT NULL COMMENT '客户经理ID',
  `manager_name` varchar(255) DEFAULT NULL COMMENT '贷款客户经理名称',
  `company_id` bigint(20) DEFAULT NULL COMMENT '贷款所属机构ID',
  `company_name` varchar(255) DEFAULT NULL COMMENT '贷款所属公司名称',
  `lawsuit_type` int(11) DEFAULT NULL COMMENT '诉讼类型: 1:公司起诉，2:银行起诉',
  `lawsuit_status` int(11) DEFAULT NULL COMMENT '诉讼,案件状态:1:引调，2:立案，3:案件送达，4:案件公告，5:开庭审理，6:强制执行，7:撤诉',
  `target_amount` decimal(24,6) DEFAULT NULL COMMENT '目标金额',
  `amount_advanced` decimal(24,6) DEFAULT NULL COMMENT '垫款余额',
  `loan_balance` decimal(24,6) DEFAULT NULL COMMENT '贷款余额',
  `receivable_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '回收总金额',
  `judicial_cost` decimal(24,6) DEFAULT NULL COMMENT '司法费用',
  `approve_status` int(11) DEFAULT '1' COMMENT '审批状态:1,未起诉，2：起诉审批中，3：起诉已通过，6 已撤诉',
  `base_situation_desc` varchar(1500) DEFAULT NULL COMMENT '案件基本情况描述',
  `business_group_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人业务组id',
  `business_group_name` varchar(255) DEFAULT NULL COMMENT '贷款发起人业务组名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '操作人(当前登入)机构ID',
  `org_name` varchar(255) DEFAULT NULL COMMENT '机构名称，操作人(当前登入)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作用户ID,操作人(当前登入)',
  `user_name` varchar(255) DEFAULT NULL COMMENT '操作人姓名，操作人(当前登入)',
  `filing_case_No` varchar(50) DEFAULT NULL COMMENT '立案案号',
  `filing_case_date` datetime DEFAULT NULL COMMENT '立案日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(30) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_lawsuit_num` (`lawsuit_num`) USING BTREE,
  KEY `idx_mtime` (`modify_time`),
  KEY `index_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=682 DEFAULT CHARSET=utf8 COMMENT='诉讼基本信息表';

-- ----------------------------
-- Table structure for lawsuit_nol_pros
-- ----------------------------
DROP TABLE IF EXISTS `lawsuit_nol_pros`;
CREATE TABLE `lawsuit_nol_pros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `lawsuit_id` bigint(20) DEFAULT NULL COMMENT '诉讼信息表ID',
  `nol_pros_reason_type` int(11) DEFAULT NULL COMMENT '撤诉理由类型：1,全额结清垫款本息及银行贷款，2，结清全部垫款，落实后续还款计划及担保措施，3:结清部分垫款，落实后续还款计划及担保措施，4:其他理由',
  `nol_pros_other_reason` varchar(1500) DEFAULT NULL COMMENT '撤诉其他理由',
  `risk_desc` varchar(1500) DEFAULT NULL COMMENT '风险描述',
  `resolved_way_desc` varchar(1500) DEFAULT NULL COMMENT '解决方法描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='撤诉申请信息表';

-- ----------------------------
-- Table structure for lawsuit_process
-- ----------------------------
DROP TABLE IF EXISTS `lawsuit_process`;
CREATE TABLE `lawsuit_process` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `lawsuit_id` bigint(20) DEFAULT NULL COMMENT '诉讼表主键ID',
  `lawsuit_status` int(11) DEFAULT NULL COMMENT '诉讼,案件状态:1:引调，2:立案，3:案件送达，4:案件公告，5:开庭审理，6:强制执行，7:撤诉',
  `lawsuit_desc` varchar(1500) DEFAULT NULL COMMENT '诉讼进程描述',
  `check_time` datetime DEFAULT NULL COMMENT '进程登记日期',
  `conciliation_case_no` varchar(50) DEFAULT NULL COMMENT '引调案号',
  `conciliation_amount` decimal(24,6) DEFAULT NULL COMMENT '诉讼标的金额',
  `conciliation_judge` varchar(50) DEFAULT NULL COMMENT '承办引调法官',
  `conciliation_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `filing_case_no` varchar(50) DEFAULT NULL COMMENT '立案案号',
  `filing_case_judge` varchar(50) DEFAULT NULL COMMENT '承办立案法官',
  `filing_case_fee` decimal(24,6) DEFAULT NULL COMMENT '诉讼费用',
  `filing_case_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `filing_case_date` date DEFAULT NULL COMMENT '开庭时间',
  `filing_case_place` varchar(255) DEFAULT NULL COMMENT '开庭地点',
  `case_service_conciliation` int(1) DEFAULT NULL COMMENT '是否送达调解 1:是 2：否',
  `case_service_date` date DEFAULT NULL COMMENT '调解时间',
  `case_service_amount` decimal(24,6) DEFAULT NULL COMMENT '调解金额',
  `case_service_plan` varchar(300) DEFAULT NULL COMMENT '调解方案',
  `case_notice_conciliation` int(1) DEFAULT NULL COMMENT '是否公告调解 1:是 2：否',
  `case_notice_fee` decimal(24,6) DEFAULT NULL COMMENT '公告费用',
  `case_notice_date` date DEFAULT NULL COMMENT '调解时间',
  `case_notice_amount` decimal(24,6) DEFAULT NULL COMMENT '调解金额',
  `case_notice_plan` varchar(300) DEFAULT NULL COMMENT '调解方案',
  `hold_hearing_amount` decimal(24,6) DEFAULT NULL COMMENT '判决金额',
  `hold_hearing_court` varchar(50) DEFAULT NULL COMMENT '开庭法院',
  `enforcement_case_no` varchar(50) DEFAULT NULL COMMENT '强制执行案号',
  `enforcement_amount` decimal(24,6) DEFAULT NULL COMMENT '强制执行标的',
  `enforcement_fee` decimal(24,6) DEFAULT NULL COMMENT '强制执行费用',
  `enforcement_judge` varchar(50) DEFAULT NULL COMMENT '承办执行法官',
  `enforcement_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `enforcement_result` varchar(300) DEFAULT NULL COMMENT '执行结果',
  `nolle_prosequi_reason` varchar(300) DEFAULT NULL COMMENT '撤诉原因',
  `org_id` bigint(20) DEFAULT NULL COMMENT '操作人(当前登入)机构ID',
  `org_name` varchar(50) DEFAULT NULL COMMENT '机构名称，操作人(当前登入)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作用户ID,操作人(当前登入)',
  `user_name` varchar(50) DEFAULT NULL COMMENT '操作人姓名，操作人(当前登入)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`),
  KEY `idx_lawsuit_id` (`lawsuit_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8 COMMENT='诉讼进程信息表';

-- ----------------------------
-- Table structure for lawsuit_process_file
-- ----------------------------
DROP TABLE IF EXISTS `lawsuit_process_file`;
CREATE TABLE `lawsuit_process_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `process_id` bigint(20) DEFAULT NULL COMMENT '诉讼进程ID',
  `process_file` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `process_file_name` varchar(255) DEFAULT NULL COMMENT '诉讼进程上传文件的名称',
  `process_size` double DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='诉讼进程文件表';

-- ----------------------------
-- Table structure for license_plate_info
-- ----------------------------
DROP TABLE IF EXISTS `license_plate_info`;
CREATE TABLE `license_plate_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `loan_car_id` bigint(20) NOT NULL COMMENT '汽车ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `is_registered` int(4) NOT NULL COMMENT '是否已上牌（1：是，2:否）',
  `register_type` int(4) DEFAULT NULL COMMENT '上牌类型（1：公司，2：客户，3:车行）',
  `register_date` date DEFAULT NULL COMMENT '上牌时间',
  `plate_no` varchar(255) DEFAULT NULL COMMENT '车牌号码',
  `plate_area` varchar(255) DEFAULT NULL COMMENT '上牌县市',
  `operator_uid` bigint(20) DEFAULT NULL COMMENT '上牌经办人userId',
  `operator_realname` varchar(255) DEFAULT NULL COMMENT '上牌经办人姓名',
  `register_target` int(4) DEFAULT NULL COMMENT '上牌对象 1:公司，2：个人',
  `company_name` varchar(255) DEFAULT NULL COMMENT '企业名称，仅当上牌对象为公司时有值。',
  `company_code` varchar(255) DEFAULT NULL COMMENT '企业机构代码证，仅当上牌对象为公司时有值。',
  `warrant_date` date DEFAULT NULL COMMENT '收到权证日期',
  `fail_reason` varchar(1000) DEFAULT NULL COMMENT '未上牌原因(1:要示本人到场，2：资料不齐全，3：拍牌，4：其他)',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_loan_car_id` (`loan_car_id`),
  KEY `license_plate_info_project_id` (`project_id`),
  KEY `IDX_LOAN_CAR_ID` (`loan_car_id`),
  KEY `license_plate_info_operator_uid` (`operator_uid`),
  KEY `u_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50847 DEFAULT CHARSET=utf8 COMMENT='上牌登记表';

-- ----------------------------
-- Table structure for loan_apply
-- ----------------------------
DROP TABLE IF EXISTS `loan_apply`;
CREATE TABLE `loan_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `relative_apply_id` bigint(20) DEFAULT NULL COMMENT '关联申请编号',
  `flow_type` varchar(30) DEFAULT NULL COMMENT '流程类型',
  `node_key` varchar(50) DEFAULT NULL COMMENT '节点编号',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(50) NOT NULL COMMENT '项目编号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户主键',
  `customer_no` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `credit_id` bigint(20) DEFAULT NULL COMMENT '征信申请流水号',
  `business_type_id` int(10) DEFAULT NULL COMMENT '业务品种ID(1:信用卡贷款(普通模式),2:信用卡贷款(银行直销),3:个人消费贷款)',
  `business_type_name` varchar(50) DEFAULT NULL COMMENT '业务品种Name',
  `product_id` int(10) DEFAULT NULL COMMENT '金融产品ID',
  `product_name` varchar(100) DEFAULT NULL COMMENT '金融产品名称',
  `status` int(10) DEFAULT NULL COMMENT '贷款状态(1:拒绝，2：通过，3：审核中)',
  `data_source` int(1) DEFAULT NULL COMMENT '数据来源（1：PC端，2：APP端）',
  `dealer_order_id` bigint(20) DEFAULT NULL COMMENT '车商订单流水号',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：是，2：否）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '用户组ID',
  `user_group_name` varchar(50) DEFAULT NULL COMMENT '用户组名称',
  `manager_id` bigint(10) DEFAULT NULL COMMENT '经营管理部业务组ID',
  `manager_name` varchar(50) DEFAULT NULL COMMENT '经营管理部业务组NAME',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `is_didi` int(1) DEFAULT NULL COMMENT '是否为滴滴业务 1是 2否',
  `is_service_ticket` int(1) DEFAULT '2' COMMENT '是否需要服务发票(1:是 2:否)',
  `driver_license_ocr` varchar(255) DEFAULT NULL COMMENT '驾照OCR识别结果',
  `yuntu_order_no` varchar(32) DEFAULT NULL COMMENT '云图订单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_apply_project_id` (`project_id`,`id`),
  KEY `IDX_CUSTOMER_ID` (`customer_id`),
  KEY `index_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63285 DEFAULT CHARSET=utf8 COMMENT='贷款申请表';

-- ----------------------------
-- Table structure for loan_apply_copy
-- ----------------------------
DROP TABLE IF EXISTS `loan_apply_copy`;
CREATE TABLE `loan_apply_copy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `relative_apply_id` bigint(20) DEFAULT NULL COMMENT '关联申请编号',
  `flow_type` varchar(30) DEFAULT NULL COMMENT '流程类型',
  `node_key` varchar(50) DEFAULT NULL COMMENT '节点编号',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(50) NOT NULL COMMENT '项目编号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户主键',
  `customer_no` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `credit_id` bigint(20) DEFAULT NULL COMMENT '征信申请流水号',
  `business_type_id` int(10) DEFAULT NULL COMMENT '业务品种ID(1:信用卡贷款(普通模式),2:信用卡贷款(银行直销),3:个人消费贷款)',
  `business_type_name` varchar(50) DEFAULT NULL COMMENT '业务品种Name',
  `product_id` int(10) DEFAULT NULL COMMENT '金融产品ID',
  `product_name` varchar(100) DEFAULT NULL COMMENT '金融产品名称',
  `status` int(10) DEFAULT NULL COMMENT '贷款状态(1:拒绝，2：通过，3：审核中)',
  `data_source` int(1) DEFAULT NULL COMMENT '数据来源（1：PC端，2：APP端）',
  `dealer_order_id` bigint(20) DEFAULT NULL COMMENT '车商订单流水号',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：是，2：否）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '用户组ID',
  `user_group_name` varchar(50) DEFAULT NULL COMMENT '用户组名称',
  `manager_id` bigint(10) DEFAULT NULL COMMENT '经营管理部业务组ID',
  `manager_name` varchar(50) DEFAULT NULL COMMENT '经营管理部业务组NAME',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `is_didi` int(1) DEFAULT NULL COMMENT '是否为滴滴业务 1是 2否',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_apply_project_id` (`project_id`,`id`),
  KEY `IDX_CUSTOMER_ID` (`customer_id`),
  KEY `index_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60904 DEFAULT CHARSET=utf8 COMMENT='贷款申请表';

-- ----------------------------
-- Table structure for loan_apply_ratio
-- ----------------------------
DROP TABLE IF EXISTS `loan_apply_ratio`;
CREATE TABLE `loan_apply_ratio` (
  `id` bigint(200) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `loan_apply_id` bigint(200) NOT NULL COMMENT '贷款申请ID',
  `loan_ratio` decimal(10,2) NOT NULL COMMENT '贷款比例',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_apply_vin_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_apply_vin_info`;
CREATE TABLE `loan_apply_vin_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `province_code` varchar(15) NOT NULL COMMENT '省份编码',
  `city_code` varchar(15) NOT NULL COMMENT '城市编码',
  `city_name` varchar(255) NOT NULL,
  `car_type` int(1) NOT NULL DEFAULT '0' COMMENT '查询类型（1：vin，2：carId）',
  `vin` varchar(17) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `brand_code` varchar(32) NOT NULL COMMENT '品牌编码',
  `brand_name` varchar(50) NOT NULL COMMENT '品牌名称',
  `make_id` int(11) NOT NULL,
  `make_code` varchar(32) NOT NULL COMMENT '车系ID',
  `make_name` varchar(50) NOT NULL COMMENT '车系名称',
  `model_id` int(11) NOT NULL,
  `model_code` varchar(32) NOT NULL COMMENT '车型ID',
  `model_name` varchar(128) NOT NULL COMMENT '车型名称',
  `car_json` varchar(5000) NOT NULL COMMENT '款式列表json',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态（1：未生效，2：生效，-1：已删除）',
  `source` int(1) NOT NULL DEFAULT '0' COMMENT '来源（1：车虫，2：未知）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `index_vin` (`vin`) USING BTREE,
  KEY `index_model_code` (`model_code`) USING BTREE,
  KEY `city_code` (`city_code`,`vin`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 COMMENT='车辆价格信息表';

-- ----------------------------
-- Table structure for loan_approve_customer
-- ----------------------------
DROP TABLE IF EXISTS `loan_approve_customer`;
CREATE TABLE `loan_approve_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `customer_no` varchar(50) NOT NULL COMMENT '客户编号',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `en_customer_name` varchar(50) DEFAULT NULL COMMENT '英文名',
  `customer_type` int(10) DEFAULT NULL COMMENT '客户类型（1：个人客户，2：企业客户）',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `card_no_valid` tinyint(1) DEFAULT '0' COMMENT '证件是否长期有效 0:否,1:是',
  `card_no_valid_time` date DEFAULT NULL COMMENT '证件有效期',
  `pigeonhole_credit_id` bigint(20) DEFAULT NULL COMMENT '借款人归档征信申请流水号',
  `licence_issuing_authority` varchar(100) DEFAULT NULL COMMENT '发证机关',
  `customer_source` int(10) DEFAULT NULL COMMENT '客户来源（1：车果网，2：内部推荐）',
  `source_serialno` varchar(50) DEFAULT NULL COMMENT '客户来源流水号',
  `sex` int(1) DEFAULT NULL COMMENT '性别（1：男，2：女）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `mobile_phone` varchar(100) DEFAULT NULL COMMENT '手机号码',
  `home_phone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `native_place` varchar(150) DEFAULT NULL COMMENT '籍贯',
  `education` int(10) DEFAULT NULL COMMENT '学历(1：初中及以下，2：高中，3：大专，4：本科，5：硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1：自有住房，2：贷款购房，3：租房：4：其他)',
  `current_house_area` decimal(6,2) DEFAULT NULL COMMENT '当前住宅面积(平方米)',
  `mortgage_repayment` varchar(50) DEFAULT NULL COMMENT '住房月还款情况',
  `driver_licence` int(1) DEFAULT NULL COMMENT '客户驾照情况（１：无，２：有：３：正在学车）',
  `provide_business_licence` int(1) DEFAULT NULL COMMENT '提供营业执照类型（1：无；2：有；3：有且具备实体营业场所）',
  `provide_account_statement` int(1) DEFAULT NULL COMMENT '提供银行流水类型（1：无；2：有；3：有且2倍以上月供）',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `profession_code` int(10) DEFAULT NULL COMMENT '职业编码',
  `post` int(10) DEFAULT NULL COMMENT '职务',
  `post_name` varchar(50) DEFAULT NULL COMMENT '职务名称',
  `industry` int(10) DEFAULT NULL COMMENT '行业',
  `work_nature` varchar(50) DEFAULT '' COMMENT '工作单位性质',
  `work_nature_code` int(10) DEFAULT NULL COMMENT '工作单位性质编码',
  `employ_time` date DEFAULT NULL COMMENT '入职时间',
  `monthly_income` int(10) DEFAULT NULL COMMENT '个人月收入',
  `yearly_income` decimal(24,6) DEFAULT NULL COMMENT '年收入',
  `personal_asset_sum` decimal(24,6) DEFAULT NULL COMMENT '个人总资产(万)',
  `reserved_funds` int(10) DEFAULT NULL COMMENT '公积金（1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上）',
  `reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `cur_address_time` date DEFAULT NULL COMMENT '现居住地入住时间',
  `company_name` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `company_phone` varchar(20) DEFAULT NULL COMMENT '单位电话',
  `company_address_pid` varchar(10) DEFAULT NULL COMMENT '单位地址ID',
  `company_address_pname` varchar(50) DEFAULT NULL COMMENT '单位地址名称',
  `company_address_cid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化市id',
  `company_address_cname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化市Name',
  `company_address_rid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化区id',
  `company_address_rname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化区name',
  `company_address_detail` varchar(200) DEFAULT NULL COMMENT '单位详细地址',
  `company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址经度坐标',
  `company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址纬度坐标',
  `home_address_pid` varchar(10) DEFAULT NULL COMMENT '家庭地址ID',
  `home_address_pname` varchar(50) DEFAULT NULL COMMENT '家庭地址名称',
  `home_address_cid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(200) DEFAULT NULL COMMENT '家庭详细地址',
  `home_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址经度坐标',
  `home_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址纬度坐标',
  `spouse_id` bigint(20) DEFAULT NULL COMMENT '配偶客户ID',
  `spouse_name` varchar(100) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_card_type` int(10) DEFAULT NULL COMMENT '配偶证件类型(1：身份证，2：军官证，3：侨胞证，4：外籍人士)',
  `spouse_card_no` varchar(20) DEFAULT NULL COMMENT '配偶证件编号',
  `spouse_pigeonhole_credit_id` bigint(20) DEFAULT NULL COMMENT '配偶归档征信申请流水号',
  `spouse_mobile_phone` varchar(100) DEFAULT NULL COMMENT '配偶手机号',
  `spouse_permant_address` varchar(200) DEFAULT NULL COMMENT '配偶户籍地址',
  `spouse_reserved_funds` int(11) DEFAULT NULL COMMENT '配偶公积金(1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上)',
  `spouse_reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `spouse_social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `spouse_driver_licence` int(1) DEFAULT NULL COMMENT '配偶驾照情况（１：无，２：有：３：正在学车）',
  `spouse_company_name` varchar(200) DEFAULT NULL COMMENT '配偶单位名称',
  `spouse_company_address_pid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址省代码',
  `spouse_company_address_pname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址省',
  `spouse_company_address_cid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址市代码',
  `spouse_company_address_cname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址市',
  `spouse_company_address_rid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址县代码',
  `spouse_company_address_rname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址县',
  `spouse_company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址经度坐标',
  `spouse_company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址纬坐标',
  `spouse_company_address` varchar(200) DEFAULT NULL COMMENT '配偶单位地址',
  `spouse_company_phone` varchar(20) DEFAULT NULL COMMENT '配偶单位电话',
  `spouse_monthly_income` int(10) DEFAULT NULL COMMENT '配偶月薪',
  `spouse_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '配偶年收入(万)',
  `is_agency` int(1) DEFAULT NULL COMMENT '是否代购(1:是，2：否)',
  `real_car_owner` varchar(100) DEFAULT NULL COMMENT '实际用车人',
  `register_date` datetime DEFAULT NULL COMMENT '建档日期',
  `joint_obligor` varchar(30) DEFAULT NULL COMMENT '共同还款人',
  `customer_score_a` decimal(10,2) DEFAULT NULL COMMENT '客户评分A',
  `customer_score_b` decimal(10,2) DEFAULT NULL COMMENT '客户评分B',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `guarantor_driver_licence` int(11) DEFAULT NULL COMMENT '担保人驾驶证情况1、无2、有3、正在学车',
  `delivery_address_pid` varchar(10) DEFAULT NULL COMMENT '收件地址ID',
  `delivery_address_pname` varchar(50) DEFAULT NULL COMMENT '收件地址名称',
  `delivery_address_cid` varchar(10) DEFAULT NULL COMMENT '收件地址格式化市id',
  `delivery_address_cname` varchar(50) DEFAULT NULL COMMENT '收件地址格式化市Name',
  `delivery_address_rid` varchar(10) DEFAULT NULL COMMENT '收件地址格式化区id',
  `delivery_address_rname` varchar(50) DEFAULT NULL COMMENT '收件地址格式化区name',
  `delivery_address_detail` varchar(200) DEFAULT NULL COMMENT '收件详细地址',
  `delivery_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址经度坐标',
  `delivery_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址纬度坐标',
  `monthly_liabilities` decimal(24,4) DEFAULT '0.0000' COMMENT '月负债',
  `other_debt_balance` decimal(24,6) DEFAULT NULL COMMENT '其他负债余额(元)',
  `house_yearly_income` decimal(24,6) DEFAULT '0.000000' COMMENT '家庭年收入',
  `survey_report` varchar(3000) DEFAULT NULL COMMENT '调查报告',
  `card_collect_method` int(1) NOT NULL DEFAULT '1' COMMENT '开卡领取方式 1-自取 2-寄送单位 3-寄送住宅',
  `cmpy_postcode` varchar(31) DEFAULT NULL COMMENT '公司邮编',
  `home_postcode` varchar(31) DEFAULT NULL COMMENT '家庭邮编',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `loan_approve_customer_customer_id` (`customer_id`),
  KEY `idx_card_no` (`card_no`),
  KEY `idx_name` (`customer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=97197 DEFAULT CHARSET=utf8 COMMENT='贷款客户审批表';

-- ----------------------------
-- Table structure for loan_approve_customer_copy1
-- ----------------------------
DROP TABLE IF EXISTS `loan_approve_customer_copy1`;
CREATE TABLE `loan_approve_customer_copy1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `customer_no` varchar(50) NOT NULL COMMENT '客户编号',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `en_customer_name` varchar(50) DEFAULT NULL COMMENT '英文名',
  `customer_type` int(10) DEFAULT NULL COMMENT '客户类型（1：个人客户，2：企业客户）',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `card_no_valid` tinyint(1) DEFAULT '0' COMMENT '证件是否长期有效 0:否,1:是',
  `card_no_valid_time` date DEFAULT NULL COMMENT '证件有效期',
  `pigeonhole_credit_id` bigint(20) DEFAULT NULL COMMENT '借款人归档征信申请流水号',
  `licence_issuing_authority` varchar(100) DEFAULT NULL COMMENT '发证机关',
  `customer_source` int(10) DEFAULT NULL COMMENT '客户来源（1：车果网，2：内部推荐）',
  `source_serialno` varchar(50) DEFAULT NULL COMMENT '客户来源流水号',
  `sex` int(1) DEFAULT NULL COMMENT '性别（1：男，2：女）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `mobile_phone` varchar(100) DEFAULT NULL COMMENT '手机号码',
  `home_phone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `native_place` varchar(150) DEFAULT NULL COMMENT '籍贯',
  `education` int(10) DEFAULT NULL COMMENT '学历(1：初中及以下，2：高中，3：大专，4：本科，5：硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1：自有住房，2：贷款购房，3：租房：4：其他)',
  `mortgage_repayment` varchar(50) DEFAULT NULL COMMENT '住房月还款情况',
  `driver_licence` int(1) DEFAULT NULL COMMENT '客户驾照情况（１：无，２：有：３：正在学车）',
  `provide_business_licence` int(1) DEFAULT NULL COMMENT '提供营业执照类型（1：无；2：有；3：有且具备实体营业场所）',
  `provide_account_statement` int(1) DEFAULT NULL COMMENT '提供银行流水类型（1：无；2：有；3：有且2倍以上月供）',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `profession_code` int(10) DEFAULT NULL COMMENT '职业编码',
  `post` int(10) DEFAULT NULL COMMENT '职务',
  `post_name` varchar(50) DEFAULT NULL COMMENT '职务名称',
  `industry` int(10) DEFAULT NULL COMMENT '行业',
  `work_nature` varchar(50) DEFAULT '' COMMENT '工作单位性质',
  `work_nature_code` int(10) DEFAULT NULL COMMENT '工作单位性质编码',
  `employ_time` date DEFAULT NULL COMMENT '入职时间',
  `monthly_income` int(10) DEFAULT NULL COMMENT '个人月收入',
  `yearly_income` decimal(24,6) DEFAULT NULL COMMENT '年收入',
  `house_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '家庭年收入',
  `monthly_liabilities` decimal(24,6) DEFAULT NULL COMMENT '月负债',
  `reserved_funds` int(10) DEFAULT NULL COMMENT '公积金（1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上）',
  `reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `cur_address_time` date DEFAULT NULL COMMENT '现居住地入住时间',
  `company_name` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `company_phone` varchar(20) DEFAULT NULL COMMENT '单位电话',
  `company_address_pid` varchar(10) DEFAULT NULL COMMENT '单位地址ID',
  `company_address_pname` varchar(50) DEFAULT NULL COMMENT '单位地址名称',
  `company_address_cid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化市id',
  `company_address_cname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化市Name',
  `company_address_rid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化区id',
  `company_address_rname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化区name',
  `company_address_detail` varchar(200) DEFAULT NULL COMMENT '单位详细地址',
  `company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址经度坐标',
  `company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址纬度坐标',
  `home_address_pid` varchar(10) DEFAULT NULL COMMENT '家庭地址ID',
  `home_address_pname` varchar(50) DEFAULT NULL COMMENT '家庭地址名称',
  `home_address_cid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(200) DEFAULT NULL COMMENT '家庭详细地址',
  `home_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址经度坐标',
  `home_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址纬度坐标',
  `spouse_id` bigint(20) DEFAULT NULL COMMENT '配偶客户ID',
  `spouse_name` varchar(100) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_card_type` int(10) DEFAULT NULL COMMENT '配偶证件类型(1：身份证，2：军官证，3：侨胞证，4：外籍人士)',
  `spouse_card_no` varchar(20) DEFAULT NULL COMMENT '配偶证件编号',
  `spouse_pigeonhole_credit_id` bigint(20) DEFAULT NULL COMMENT '配偶归档征信申请流水号',
  `spouse_mobile_phone` varchar(100) DEFAULT NULL COMMENT '配偶手机号',
  `spouse_permant_address` varchar(200) DEFAULT NULL COMMENT '配偶户籍地址',
  `spouse_reserved_funds` int(11) DEFAULT NULL COMMENT '配偶公积金(1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上)',
  `spouse_reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `spouse_social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `spouse_driver_licence` int(1) DEFAULT NULL COMMENT '配偶驾照情况（１：无，２：有：３：正在学车）',
  `spouse_company_name` varchar(200) DEFAULT NULL COMMENT '配偶单位名称',
  `spouse_company_address_pid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址省代码',
  `spouse_company_address_pname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址省',
  `spouse_company_address_cid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址市代码',
  `spouse_company_address_cname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址市',
  `spouse_company_address_rid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址县代码',
  `spouse_company_address_rname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址县',
  `spouse_company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址经度坐标',
  `spouse_company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址纬坐标',
  `spouse_company_address` varchar(200) DEFAULT NULL COMMENT '配偶单位地址',
  `spouse_company_phone` varchar(20) DEFAULT NULL COMMENT '配偶单位电话',
  `spouse_monthly_income` int(10) DEFAULT NULL COMMENT '配偶月薪',
  `is_agency` int(1) DEFAULT NULL COMMENT '是否代购(1:是，2：否)',
  `real_car_owner` varchar(100) DEFAULT NULL COMMENT '实际用车人',
  `register_date` datetime DEFAULT NULL COMMENT '建档日期',
  `joint_obligor` varchar(30) DEFAULT NULL COMMENT '共同还款人',
  `customer_score_a` decimal(10,2) DEFAULT NULL COMMENT '客户评分A',
  `customer_score_b` decimal(10,2) DEFAULT NULL COMMENT '客户评分B',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `guarantor_driver_licence` int(11) DEFAULT NULL COMMENT '担保人驾驶证情况1、无2、有3、正在学车',
  `delivery_address_pid` varchar(10) DEFAULT NULL COMMENT '收件地址ID',
  `delivery_address_pname` varchar(50) DEFAULT NULL COMMENT '收件地址名称',
  `delivery_address_cid` varchar(10) DEFAULT NULL COMMENT '收件地址格式化市id',
  `delivery_address_cname` varchar(50) DEFAULT NULL COMMENT '收件地址格式化市Name',
  `delivery_address_rid` varchar(10) DEFAULT '' COMMENT '收件地址格式化区id',
  `delivery_address_rname` varchar(50) DEFAULT NULL COMMENT '收件地址格式化区name',
  `delivery_address_detail` varchar(200) DEFAULT NULL COMMENT '收件详细地址',
  `delivery_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址经度坐标',
  `delivery_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址纬度坐标',
  `survey_report` varchar(3000) DEFAULT NULL COMMENT '调查报告',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `loan_approve_customer_customer_id` (`customer_id`),
  KEY `idx_card_no` (`card_no`),
  KEY `idx_name` (`customer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=159190 DEFAULT CHARSET=utf8 COMMENT='贷款客户审批表';

-- ----------------------------
-- Table structure for loan_approve_fee
-- ----------------------------
DROP TABLE IF EXISTS `loan_approve_fee`;
CREATE TABLE `loan_approve_fee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `premium_type` int(10) DEFAULT NULL COMMENT '第一年保费缴费类型（1：公司，2：车行，2：客户）',
  `insurance_amount` decimal(24,6) DEFAULT NULL COMMENT '保费金额',
  `insurance_company_id` bigint(20) DEFAULT NULL COMMENT '保险公司ID',
  `insurance_company` varchar(100) DEFAULT NULL COMMENT '保险公司',
  `account_deposit` decimal(24,6) DEFAULT NULL COMMENT '上牌抵押押金',
  `is_renewal` int(1) DEFAULT NULL COMMENT '是否续保(1:是，2：否)',
  `renewal_deposit` decimal(24,6) DEFAULT NULL COMMENT '续保押金',
  `is_pb` int(1) DEFAULT NULL COMMENT '是否履约保证金（1：是，2：否）',
  `pb_deposit` decimal(24,6) DEFAULT NULL COMMENT '履约保证金',
  `cost_type` int(10) DEFAULT NULL COMMENT '工本费类型（1：公司，2：车行，3：客户）',
  `cost_amount` decimal(24,0) DEFAULT NULL COMMENT '工本费金额',
  `predicted_purchasetax` int(10) DEFAULT NULL COMMENT '预计车辆购置税类型（1：公司，2：车行，3：客户）',
  `purchase_tax` decimal(24,6) DEFAULT NULL COMMENT '预计车辆购置税金额',
  `guaranty_risk_amount` decimal(24,6) DEFAULT NULL COMMENT '按揭手续费',
  `service_fee` decimal(24,6) DEFAULT NULL COMMENT '按揭服务费',
  `bank_irs_fee` decimal(24,6) DEFAULT NULL COMMENT '银行利差',
  `license_fee` decimal(24,6) DEFAULT NULL COMMENT '上牌费',
  `door_survey_fee` decimal(24,6) DEFAULT NULL COMMENT '上门调查费',
  `agency_fee` decimal(24,6) DEFAULT NULL COMMENT '车行服务费',
  `outsource_survey_fee` decimal(24,6) DEFAULT NULL COMMENT '外包调查费',
  `gps_number` int(10) DEFAULT NULL COMMENT 'gps数量',
  `gps_type` int(10) DEFAULT NULL COMMENT 'gps类型',
  `gps_producer` varchar(100) DEFAULT NULL COMMENT 'GPS厂家',
  `gps_installation_fee` decimal(24,6) DEFAULT NULL COMMENT 'gps安装费',
  `liability_amount` decimal(24,6) DEFAULT NULL COMMENT '责信险',
  `other_fee` decimal(24,6) DEFAULT NULL COMMENT '其他费用',
  `total_fee` decimal(24,6) DEFAULT NULL COMMENT '合计费用',
  `guarantee_service_fee` decimal(24,6) DEFAULT NULL COMMENT '担保服务费',
  `bank_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '银行首付金额',
  `bank_installment_amount` decimal(24,6) DEFAULT NULL COMMENT '银行分期金额',
  `bank_installment_fee` decimal(24,6) DEFAULT NULL COMMENT '银行分期手续费',
  `extra_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '附加费分期金额',
  `extra_loan_handing_fee` decimal(24,6) DEFAULT NULL COMMENT '附加费分期手续费',
  `notice_downpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期偿还本金',
  `notice_downpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期利息',
  `notice_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期总金额',
  `notice_periodpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期偿还本金',
  `notice_periodpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期利息',
  `notice_periodpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期总金额',
  `notice_finalpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期偿还本金',
  `notice_finalpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期利息',
  `notice_finalpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期总金额',
  `notice_downpayment_car_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期车辆贷款偿还本金',
  `notice_downpayment_car_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期车辆贷款偿还利息',
  `notice_downpayment_car_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期车辆贷款偿还总额',
  `notice_periodpayment_car_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期车辆贷款偿还本金',
  `notice_periodpayment_car_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期车辆贷款偿还利息',
  `notice_periodpayment_car_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期车辆贷款偿还总额',
  `notice_downpayment_extra_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期附加费偿还本金',
  `notice_downpayment_extra_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期附加费偿还利息',
  `notice_downpayment_extra_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)首期附加费偿还总额',
  `notice_periodpayment_extra_loan_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期附加费偿还本金',
  `notice_periodpayment_extra_loan_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期附加费偿还利息',
  `notice_periodpayment_extra_loan_total` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期附加费偿还总额',
  `contract_downpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)首期偿还本金',
  `contract_downpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)首期利息',
  `contract_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)首期总金额',
  `contract_periodpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)每期偿还本金',
  `contract_periodpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)每期利息',
  `contract_periodpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)每期总金额',
  `contract_finalpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)末期偿还本金',
  `contract_finalpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(还款合同)末期利息',
  `contract_finalpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)末期总金额',
  `valuation_fee` decimal(24,6) DEFAULT NULL COMMENT '评估费',
  `bill_date` varchar(10) DEFAULT NULL COMMENT '账单日期',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用(1:启用，2：停用)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `is_advance_discount` int(1) DEFAULT '2' COMMENT '是否垫付贴息(1:是，2:否)',
  `other_comsumer_loan` decimal(25,2) DEFAULT '0.00' COMMENT '其他消费贷(车商返利金额)',
  `agent_fee_rate` decimal(24,2) DEFAULT '0.00' COMMENT '代办费率(车商返利比例)',
  `rebate_type_code` int(2) DEFAULT '0' COMMENT '返利方式: 1 按贷款总额 2 按车辆贷款额 0 无需返利',
  `rebate_relate_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '关键人返利金额',
  `rebate_relate_rate` decimal(24,6) DEFAULT '0.000000' COMMENT '关键人返利比例',
  `rebate_bottom_rate` decimal(24,6) DEFAULT '0.000000' COMMENT '保底费率',
  `rebate_floating_rate` decimal(24,6) DEFAULT '0.000000' COMMENT '上浮费率',
  `branch_company_floating_ratio` decimal(24,6) DEFAULT '0.000000' COMMENT '分公司配置的上浮比例',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `loan_approve_fee_old_id` (`old_id`),
  KEY `loan_approve_fee_sys_type` (`sys_type`),
  KEY `loan_approve_fee_user_id` (`user_id`),
  KEY `loan_approve_fee_org_id` (`org_id`),
  KEY `index_insurance_company_id` (`insurance_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56899 DEFAULT CHARSET=utf8 COMMENT='贷款费用信息表';

-- ----------------------------
-- Table structure for loan_approve_guarantor
-- ----------------------------
DROP TABLE IF EXISTS `loan_approve_guarantor`;
CREATE TABLE `loan_approve_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `credit_id` bigint(20) DEFAULT NULL COMMENT '征信主键',
  `guarantor_id` bigint(20) DEFAULT NULL COMMENT '担保人编号',
  `guarantor_no` varchar(30) DEFAULT NULL COMMENT '保证人编号',
  `guarantor_name` varchar(50) NOT NULL COMMENT '保证人名称',
  `card_type` int(10) NOT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(20) NOT NULL COMMENT '证件编号',
  `mobile_phone` varchar(100) DEFAULT NULL COMMENT '手机号码',
  `customer_type` int(10) DEFAULT NULL COMMENT '客户类型（1：个人客户，2：企业客户）',
  `customer_source` int(10) DEFAULT NULL COMMENT '客户来源（1：车果网，2：内部推荐）',
  `source_serialno` varchar(50) DEFAULT NULL COMMENT '客户来源流水号',
  `sex` int(1) DEFAULT NULL COMMENT '性别 1 男，0 女',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `home_phone` varchar(100) DEFAULT NULL COMMENT '家庭电话',
  `native_place` varchar(50) DEFAULT NULL COMMENT '籍贯',
  `education` int(10) DEFAULT NULL COMMENT '学历(1：初中及以下，2：高中，3：大专，4：本科，5：硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1：自有住房，2：贷款购房，3：租房：4：其他)',
  `mortgage_repayment` varchar(50) DEFAULT NULL COMMENT '住房月还款情况',
  `driver_licence` int(1) DEFAULT NULL COMMENT '客户驾照情况（１：无，２：有：３：正在学车）',
  `provide_business_licence` int(1) DEFAULT NULL COMMENT '提供营业执照类型（1：无；2：有；3：有且具备实体营业场所）',
  `provide_account_statement` int(1) DEFAULT NULL COMMENT '提供银行流水类型（1：无；2：有；3：有且2倍以上月供）',
  `profession_code` int(1) DEFAULT NULL COMMENT '职业编码',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `industry` int(10) DEFAULT NULL COMMENT '行业',
  `monthly_income` int(10) DEFAULT NULL COMMENT '个人月收入',
  `yearly_income` decimal(24,6) DEFAULT NULL COMMENT '个人年收入(万)',
  `social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `reserved_funds` int(10) DEFAULT NULL COMMENT '公积金（1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上）',
  `company_name` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `company_phone` varchar(100) DEFAULT NULL COMMENT '单位电话',
  `company_address_pid` varchar(10) DEFAULT NULL COMMENT '单位地址ID',
  `company_address_pname` varchar(50) DEFAULT NULL COMMENT '单位地址名称',
  `company_address_cid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化市id',
  `company_address_cname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化市Name',
  `company_address_rid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化区id',
  `company_address_rname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化区name',
  `company_address_detail` varchar(200) DEFAULT NULL COMMENT '单位详细地址',
  `company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址经度坐标',
  `company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址纬度坐标',
  `home_address_pid` varchar(10) DEFAULT NULL COMMENT '家庭地址ID',
  `home_address_pname` varchar(50) DEFAULT NULL COMMENT '家庭地址名称',
  `home_address_cid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(200) DEFAULT NULL COMMENT '家庭详细地址',
  `home_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址经度坐标',
  `home_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址纬度坐标',
  `spouse_name` varchar(20) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_card_type` int(10) DEFAULT NULL COMMENT '配偶证件类型(1：身份证，2：军官证，3：侨胞证，4：外籍人士)',
  `spouse_card_no` varchar(20) DEFAULT NULL COMMENT '配偶证件编号',
  `spouse_mobile_phone` varchar(100) DEFAULT NULL COMMENT '配偶手机号码',
  `spouse_permant_address` varchar(200) DEFAULT NULL COMMENT '配偶户籍地址',
  `spouse_reserved_funds` int(11) DEFAULT NULL COMMENT '配偶公积金(1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上)',
  `spouse_company_name` varchar(200) DEFAULT NULL COMMENT '配偶单位名称',
  `spouse_company_address_pid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址省代码',
  `spouse_company_address_pname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址省',
  `spouse_company_address_cid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址市代码',
  `spouse_company_address_cname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址市',
  `spouse_company_address_rid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址县代码',
  `spouse_company_address_rname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址县',
  `spouse_company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址经度坐标',
  `spouse_company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址纬坐标',
  `spouse_company_address` varchar(200) DEFAULT NULL COMMENT '配偶单位地址',
  `spouse_company_phone` varchar(20) DEFAULT NULL COMMENT '配偶单位电话',
  `spouse_monthly_income` int(10) DEFAULT NULL COMMENT '配偶月薪',
  `spouse_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '配偶个人年收入(万)',
  `register_date` datetime DEFAULT NULL COMMENT '建档日期',
  `relationship_with_loaner` int(10) DEFAULT NULL COMMENT '与借款人关系(1：本人，2：夫妻，3：父亲，4：母亲，5：姐妹，6：兄弟，7：子女)',
  `guaranty_relationship` int(10) DEFAULT NULL COMMENT '担保关系(1:担保人，2:反担保人)',
  `remark` varchar(100) DEFAULT NULL COMMENT '说明',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_guarantor_project_id` (`project_id`,`card_type`,`card_no`),
  KEY `loan_approve_guarantor_projectid_index` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20454 DEFAULT CHARSET=utf8 COMMENT='贷款审批保证人表';

-- ----------------------------
-- Table structure for loan_approve_payment
-- ----------------------------
DROP TABLE IF EXISTS `loan_approve_payment`;
CREATE TABLE `loan_approve_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `guarantee_corporation_id` bigint(20) DEFAULT NULL COMMENT '担保公司编号',
  `guarantee_corporation_name` varchar(100) DEFAULT NULL COMMENT '担保公司名称',
  `guarantee_corporation_account_name` varchar(100) DEFAULT NULL COMMENT '担保公司账户开户名称',
  `guarantee_corporation_account_no` varchar(32) DEFAULT NULL COMMENT '担保公司账户开户号',
  `guarantee_corporation_bank` varchar(100) DEFAULT NULL COMMENT '担保公司开户支行',
  `guarantee_corporation_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '担保公司付款金额',
  `guarantee_corporation_payment_date` date DEFAULT NULL COMMENT '担保公司付款日期',
  `guarantee_corporation_payment_user_id` bigint(20) DEFAULT NULL COMMENT '担保公司付款人ID',
  `guarantee_corporation_payment_user_name` varchar(50) DEFAULT NULL COMMENT '担保公司付款人NAME',
  `guarantee_corporation_payment_remark` varchar(200) DEFAULT NULL COMMENT '担保公司付款说明',
  `capital_pool_account_name` varchar(100) DEFAULT NULL COMMENT '资金池收款账户名',
  `capital_pool_account_no` varchar(32) DEFAULT NULL COMMENT '资金池收款账户账号',
  `capital_pool_bank` varchar(32) DEFAULT NULL COMMENT '资金池收款账户开户支行',
  `capital_pool_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '资金池打款总额',
  `capital_pool_payment_date` date DEFAULT NULL COMMENT '打款日期',
  `capital_pool_payment_user_id` bigint(20) DEFAULT NULL COMMENT '打款人ID',
  `capital_pool_payment_user_name` varchar(50) DEFAULT NULL COMMENT '打款人NAME',
  `capital_pool_payment_remark` varchar(200) DEFAULT NULL COMMENT '打款说明',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '合作车商ID',
  `dealer_name` varchar(100) DEFAULT NULL COMMENT '合作车商Name',
  `employ_dealer_id` bigint(20) DEFAULT NULL COMMENT '经销商ID',
  `employ_dealer_name` varchar(255) DEFAULT NULL COMMENT '经销商名称',
  `dealer_account_name` varchar(100) DEFAULT NULL COMMENT '合作车商收款账户名',
  `dealer_account_no` varchar(32) DEFAULT NULL COMMENT '合作车商收款账户账号',
  `dealer_bank` varchar(32) DEFAULT NULL COMMENT '合作车商收款账户开户支行',
  `dealer_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '实际打款总额',
  `dealer_payment_date` date DEFAULT NULL COMMENT '打款日期',
  `dealer_payment_user_id` bigint(20) DEFAULT NULL COMMENT '打款人ID',
  `dealer_payment_user_name` varchar(50) DEFAULT NULL COMMENT '打款人NAME',
  `dealer_payment_remark` varchar(200) DEFAULT NULL COMMENT '说明',
  `bank_id` bigint(20) DEFAULT NULL COMMENT '银行ID',
  `bank_name` varchar(100) DEFAULT NULL COMMENT '银行Name',
  `bank_payment_date` date DEFAULT NULL COMMENT '银行放款日期',
  `bank_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '银行放款金额',
  `bank_payment_remark` varchar(200) DEFAULT NULL COMMENT '银行放款备注',
  `bank_payment_user_id` bigint(20) DEFAULT NULL COMMENT '银行打款登记人ID',
  `bank_payment_user_name` varchar(50) DEFAULT NULL COMMENT '银行打款用户Name',
  `bank_payment_status` int(10) DEFAULT NULL COMMENT '银行放款状态（1：登记中，2：已登记）',
  `export_status` int(11) DEFAULT '1' COMMENT '导出状态(1:未导出,2:已导出)',
  `open_card_fee` decimal(20,6) DEFAULT '0.000000' COMMENT '开卡费',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dealer_account_type` int(11) DEFAULT NULL COMMENT '车商账户类型,1:对公账户,2:个人账户',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `pay_status` int(5) DEFAULT '0' COMMENT '支付状态0 初始化 1付款中 2付款成功 3 付款失败 4人工付款',
  `pay_type` int(5) DEFAULT '0' COMMENT '0人工付款 1CBS系统 2 工行直连 3 浙商直连',
  `bank_card_no` varchar(64) DEFAULT NULL COMMENT '卡号',
  `unpay_reason` varchar(255) DEFAULT NULL,
  `is_pay` int(11) DEFAULT NULL,
  `loan_manager` varchar(255) DEFAULT NULL COMMENT '银行放款人员名称',
  `bank_lending_status` bigint(20) DEFAULT NULL COMMENT '银行放款状态',
  `has_query_bank` int(11) DEFAULT NULL COMMENT '是否已查詢銀行',
  `query_return` datetime DEFAULT NULL COMMENT '银行进度查询返回时间',
  `advance_amount` decimal(24,6) DEFAULT NULL COMMENT '垫款金额',
  `advance_date` date DEFAULT NULL COMMENT '垫款日期',
  `appoint_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '约定还款金额',
  `appoint_settlement_date` date DEFAULT NULL COMMENT '约定结清日期',
  `repayment_num` int(63) DEFAULT '0' COMMENT '还款次数',
  `repayment_manage_customer_source` int(7) DEFAULT '0' COMMENT '还款管理客户来源(0:银行 1:公司 2:银行强制结清)',
  `pay_off_status` int(2) DEFAULT '0' COMMENT '是否还清状态(0:否 1:是)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `index_bank_id` (`bank_id`),
  KEY `index_sys_type` (`sys_type`),
  KEY `idx_amount` (`bank_payment_amount`),
  KEY `index_dealer_id` (`dealer_id`),
  KEY `idx_mtime` (`modify_time`),
  KEY `idx_dealerdate` (`dealer_payment_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=156993 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for loan_approve_project
-- ----------------------------
DROP TABLE IF EXISTS `loan_approve_project`;
CREATE TABLE `loan_approve_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `relative_apply_id1` bigint(20) NOT NULL COMMENT '关联申请编号1',
  `relative_apply_id2` bigint(20) DEFAULT NULL COMMENT '关联申请编号2',
  `flow_type` varchar(30) DEFAULT NULL COMMENT '流程类型',
  `node_key` varchar(50) DEFAULT NULL COMMENT '节点编号',
  `credit_id` bigint(20) NOT NULL COMMENT '征信申请流水号',
  `project_no` varchar(50) NOT NULL COMMENT '项目编号',
  `business_type_id` int(10) DEFAULT NULL COMMENT '业务品种ID(1:信用卡贷款(普通模式),2:信用卡贷款(银行直销),3:个人消费贷款)',
  `business_type_name` varchar(50) DEFAULT NULL COMMENT '业务品种Name',
  `product_id` int(10) DEFAULT NULL COMMENT '金融产品ID',
  `product_name` varchar(100) DEFAULT NULL COMMENT '金融产品Name',
  `status` int(10) DEFAULT NULL COMMENT '贷款状态(1:拒绝，2：通过，3：审核中)',
  `data_source` int(1) DEFAULT NULL COMMENT '数据来源（1：PC端，2：APP端）',
  `dealer_order_id` bigint(20) DEFAULT NULL COMMENT '车商订单流水号',
  `car_type` varchar(10) DEFAULT NULL COMMENT '汽车类型（1：新车，2：二手车）',
  `car_id` bigint(10) DEFAULT NULL COMMENT '二手车主键',
  `car_serialno` varchar(30) DEFAULT NULL COMMENT '二手车流水号',
  `car_brand` varchar(10) DEFAULT NULL COMMENT '品牌名称',
  `car_brand_name` varchar(150) DEFAULT NULL COMMENT '品牌名称',
  `car_make` varchar(10) DEFAULT NULL COMMENT '车系名称',
  `car_make_name` varchar(150) DEFAULT NULL COMMENT '车系名称',
  `car_model` varchar(10) DEFAULT NULL COMMENT '汽车款型',
  `car_model_name` varchar(150) DEFAULT NULL COMMENT '车型名称',
  `body_structure` varchar(50) DEFAULT NULL COMMENT '车身结构',
  `is_imported` int(1) DEFAULT '0' COMMENT '是否进口车（1：是，2：否）',
  `is_advance` int(1) DEFAULT '0' COMMENT '是否垫款（1：是，2：否）',
  `online_price` decimal(24,4) DEFAULT NULL COMMENT '网络车价',
  `billing_price` decimal(24,4) DEFAULT NULL COMMENT '开票价格',
  `evaluation_price` decimal(24,6) DEFAULT NULL COMMENT '二手车评估价格',
  `sell_price` decimal(24,6) DEFAULT NULL COMMENT '二手车销售价格',
  `second_hand_car_price` decimal(20,6) DEFAULT NULL COMMENT '二手车价格',
  `loan_amount` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `required_amount` decimal(24,4) DEFAULT NULL COMMENT '申请金额',
  `benchmark_rate` decimal(20,6) DEFAULT NULL COMMENT '基准费率',
  `loan_term` int(10) DEFAULT NULL COMMENT '贷款期限(1:12期 2:24期 3:18期 4:36期)',
  `loan_ratio` decimal(24,6) DEFAULT NULL COMMENT '贷款比例',
  `handing_fee` decimal(24,6) DEFAULT NULL COMMENT '手续费率',
  `repayment_amount` decimal(24,4) DEFAULT NULL COMMENT '预期月均还款额',
  `monthly_liabilities` decimal(24,4) DEFAULT '0.0000' COMMENT '月负债',
  `down_payment_amount` decimal(24,4) DEFAULT NULL COMMENT '首付款',
  `payment_method` int(10) DEFAULT NULL COMMENT '打款方式',
  `delivery_method` int(10) DEFAULT NULL COMMENT '提车方式(1:现金，2：非现金)',
  `payment_level` int(10) DEFAULT NULL COMMENT '付款等级（1：一般，2：紧急）',
  `settle_method` int(10) DEFAULT NULL COMMENT '结算方式（1：车行结算，2：个人结算，3：无需结算）',
  `tested_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '试算月还款额',
  `guarantee_corporation_id` bigint(20) DEFAULT NULL COMMENT '担保公司编号',
  `guarantee_corporation_name` varchar(200) DEFAULT NULL COMMENT '担保公司名称',
  `receivable_amount` decimal(24,6) DEFAULT NULL COMMENT '应收金额（银行直销专用，等于费用合计）',
  `collected_amount` decimal(24,6) DEFAULT NULL COMMENT '已收金额',
  `collected_date` date DEFAULT NULL COMMENT '收款日期（银行直销专用）',
  `pre_collected_amount` decimal(24,6) DEFAULT NULL COMMENT '预收金额',
  `payable_amount` decimal(24,6) DEFAULT NULL COMMENT '应付金额',
  `is_discount` int(1) DEFAULT '2' COMMENT '是否贴息(1:是，2:否)',
  `discount_policy_id` bigint(20) DEFAULT '0' COMMENT '贴息政策编号',
  `discount_policy_name` varchar(100) DEFAULT NULL COMMENT '贴息政策名称',
  `discount_case_id` bigint(20) DEFAULT '0' COMMENT '贴息方案编号',
  `discount_margin` decimal(24,6) DEFAULT '0.000000' COMMENT '贴息差额',
  `discount_car_policy` decimal(24,6) DEFAULT '0.000000' COMMENT '车商贴息政策',
  `position_merge` int(1) DEFAULT '0' COMMENT '两岗合并(0:否，1:是)',
  `discount_case_name` varchar(100) DEFAULT NULL COMMENT '贴息方案名称',
  `discount_amount` decimal(24,4) DEFAULT NULL COMMENT '贴息金额',
  `xzz_discount_amount` decimal(24,4) DEFAULT NULL COMMENT '新总总贴息金额',
  `main_signer_id` bigint(20) DEFAULT NULL COMMENT '主签单员用户id',
  `main_signer_name` varchar(50) DEFAULT NULL COMMENT '主签单员名称',
  `main_signer_weight` decimal(10,2) DEFAULT NULL COMMENT '主签单员权重',
  `vice_signer_id` bigint(10) DEFAULT NULL COMMENT '副签单员用户id',
  `vice_signer_name` varchar(50) DEFAULT NULL COMMENT '副签单员名称',
  `vice_signer_weight` decimal(10,2) DEFAULT NULL COMMENT '副签单员权重',
  `sign_date` datetime DEFAULT NULL COMMENT '签单日期',
  `launch_date` date DEFAULT NULL COMMENT '贷款发起时间',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人ID',
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '贷款发起人NAME',
  `launch_org_id` bigint(20) DEFAULT NULL COMMENT '贷款发起机构ID',
  `launch_org_name` varchar(100) DEFAULT NULL COMMENT '贷款发起机构Name',
  `review_date` date DEFAULT NULL COMMENT '业务提交日期',
  `review_user_id` bigint(20) DEFAULT NULL COMMENT '业务提交用户ID',
  `review_user_name` varchar(50) DEFAULT NULL COMMENT '业务提交用户Name',
  `review_org_id` bigint(20) DEFAULT NULL COMMENT '业务提交用户ID',
  `review_org_name` varchar(100) DEFAULT NULL COMMENT '业务提交用户Name',
  `approve_date` date DEFAULT NULL COMMENT '审批时间',
  `approve_user_id` bigint(20) DEFAULT NULL COMMENT '审批人ID',
  `approve_user_name` varchar(50) DEFAULT NULL COMMENT '审批人NAME',
  `approve_org_id` bigint(20) DEFAULT NULL COMMENT '业务提交用户ID',
  `approve_org_name` varchar(100) DEFAULT NULL COMMENT '业务提交用户Name',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '车行id',
  `dealer_name` varchar(100) DEFAULT NULL COMMENT '车行名称',
  `dealer_grade` int(1) DEFAULT '3' COMMENT '推荐商级别: 3,4S店;4,二网',
  `employ_dealer_id` bigint(20) DEFAULT NULL COMMENT '经销商ID',
  `employ_dealer_name` varchar(255) DEFAULT NULL COMMENT '经销商名称',
  `dealer_fee_id` bigint(20) DEFAULT NULL COMMENT '车商费用ID',
  `dealer_fee_name` varchar(100) DEFAULT NULL COMMENT '车商费用名称',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(32) DEFAULT NULL COMMENT '合作银行名称',
  `is_public_license` int(1) unsigned zerofill DEFAULT NULL COMMENT '是否公牌（1：是，2：否）',
  `license_company` varchar(50) DEFAULT NULL COMMENT '公牌所属公司',
  `is_concerned_customer` int(1) DEFAULT NULL COMMENT '是否关注客户（1：是，2：否）',
  `is_agency` int(1) DEFAULT NULL COMMENT '是否代购（1：是，2：否）',
  `is_gps_installed1` int(1) DEFAULT NULL COMMENT '按公司规定是否应安装gps（1：是，2：否）',
  `is_gps_installed2` int(1) DEFAULT NULL COMMENT '按银行规定是否应安装gps（1：是，2：否）',
  `policy_finish_flag` int(1) DEFAULT NULL COMMENT '首保登记是否完成标识 1：待登记   2已登记',
  `visit_address_pid` varchar(10) DEFAULT NULL COMMENT '上门地址ID',
  `visit_address_pname` varchar(50) DEFAULT NULL COMMENT '上门地址名称',
  `visit_address_cid` varchar(10) DEFAULT NULL COMMENT '上门地址格式化市id',
  `visit_address_cname` varchar(50) DEFAULT NULL COMMENT '上门地址格式化市Name',
  `visit_address_rid` varchar(10) DEFAULT NULL COMMENT '上门地址格式化区id',
  `visit_address_rname` varchar(50) DEFAULT NULL COMMENT '上门地址格式化区name',
  `visit_address_detail` varchar(200) DEFAULT NULL COMMENT '上门详细地址',
  `visit_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '上门地址经度坐标',
  `visit_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '上门地址纬度坐标',
  `visit_address_gps_detail` varchar(200) DEFAULT NULL COMMENT '定位详细地址',
  `visit_address_gps_name` varchar(100) DEFAULT NULL COMMENT '定位详细地址Name',
  `real_address_pid` varchar(10) DEFAULT NULL COMMENT '实际上门地址ID',
  `real_address_pname` varchar(50) DEFAULT NULL COMMENT '实际上门地址Name',
  `real_address_cid` varchar(10) DEFAULT NULL COMMENT '实际上门地址格式化市id',
  `real_address_cname` varchar(50) DEFAULT NULL COMMENT '实际上门地址格式化市Name',
  `real_address_rid` varchar(10) DEFAULT NULL COMMENT '实际上门地址格式化区id',
  `real_address_rname` varchar(50) DEFAULT NULL COMMENT '实际上门地址格式化区name',
  `real_address_detail` varchar(200) DEFAULT NULL COMMENT '实际上门详细地址',
  `real_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '实际上门地址经度坐标',
  `real_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '实际上门地址纬度坐标',
  `gps_no` varchar(100) DEFAULT NULL COMMENT 'GPS设备编号',
  `gps_use_date` date DEFAULT NULL COMMENT 'gps领用时间',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：是，2：否）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '用户组ID',
  `user_group_name` varchar(50) DEFAULT NULL COMMENT '用户组名称',
  `manager_id` bigint(10) DEFAULT NULL COMMENT '经营管理部用户ID',
  `manager_name` varchar(50) DEFAULT NULL COMMENT '经营管理部用户NAME',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `free_door` varchar(20) DEFAULT '0' COMMENT '是否免上门 0:否,1:是',
  `insurance_state` tinyint(2) DEFAULT NULL COMMENT '保险分发状态 0或者null：待分发(待投保) 1.待审核(待投保)  2. 已登记(修改保单查询)  3.无效 4.退回（可重新分发跟带分发一个意思） >10.审核的几个状态 (12.初审，13.中审，14.复审 15.审核通过)',
  `insurance_id` bigint(20) DEFAULT '0' COMMENT '投保公司编号',
  `insurance_name` varchar(100) DEFAULT NULL COMMENT '投保公司名称',
  `insurance_time` datetime DEFAULT NULL COMMENT '投保公司分发日期',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `policy_number` varchar(100) DEFAULT NULL COMMENT '保单号',
  `insurance_approve_time` datetime DEFAULT NULL COMMENT '投保公司分发日期',
  `insurance_remark` varchar(100) DEFAULT NULL COMMENT '分发退回说明',
  `insurance_back_uid` bigint(20) DEFAULT NULL COMMENT '退回人账号编号',
  `insurance_back_realname` varchar(100) DEFAULT NULL COMMENT '退回人姓名',
  `remark` varchar(200) DEFAULT NULL COMMENT '标识字段',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `document_check_status` int(10) DEFAULT '1' COMMENT '资料核对状态（1:待核对，2:有误，3:无误）',
  `document_check_result` varchar(200) DEFAULT NULL COMMENT '资料核对结果',
  `is_completed` int(10) DEFAULT NULL COMMENT '资料是否齐全（1:是，2:否）',
  `export_status` int(1) DEFAULT NULL COMMENT '已付款数据导出状态（1：已导出，不是1表示未导出）',
  `is_didi` int(1) DEFAULT NULL COMMENT '是否为滴滴业务 1是 2否',
  `province_code` varchar(15) DEFAULT NULL COMMENT '省份编码',
  `province_name` varchar(255) DEFAULT NULL COMMENT '省份名称',
  `city_code` varchar(15) DEFAULT NULL COMMENT '城市编码',
  `city_name` varchar(255) DEFAULT NULL COMMENT '城市名称',
  `query_user_name` varchar(255) DEFAULT NULL COMMENT '查询人',
  `warning_car_name` varchar(255) DEFAULT NULL COMMENT '预警款式名称',
  `warning_level` varchar(255) DEFAULT NULL COMMENT '城市名称',
  `warning_result` varchar(255) DEFAULT NULL COMMENT '城市名称',
  `init_vin` varchar(17) DEFAULT NULL COMMENT '发起车架号',
  `budget_vin` varchar(17) DEFAULT NULL COMMENT '预算车架号',
  `new_price` decimal(10,2) DEFAULT NULL COMMENT '新车优惠价',
  `car_loan_amount` decimal(24,4) DEFAULT NULL COMMENT '车辆贷款金额',
  `customer_car_status` int(2) NOT NULL DEFAULT '1' COMMENT '人车状态（1：正常，2：失联）',
  `is_service_ticket` int(1) DEFAULT '2' COMMENT '是否需要服务发票(1:是 2:否)',
  `bank_loan_status` int(2) NOT NULL DEFAULT '0' COMMENT '银行贷款状态',
  `bank_loan_msg` varchar(255) DEFAULT NULL COMMENT '银行贷款状态描述',
  `is_econtract` int(1) NOT NULL DEFAULT '0' COMMENT '银行合同是否电签 0-否 1-是',
  `econtract_project_no` varchar(31) DEFAULT NULL COMMENT '预留字段-电子合同项目编号',
  `econtract_status` int(1) NOT NULL DEFAULT '0' COMMENT '电子合同签约状态 0-未签订 1-待签订 2-已签订 3-待重签 4-已重签',
  `is_buy_accident_insurance` int(1) NOT NULL DEFAULT '0' COMMENT '是否购买人生意外险(0:否 1:是)',
  `is_buy_decorate_amount` int(1) NOT NULL DEFAULT '0' COMMENT '是否购买其他费用(车辆盗抢服务费)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  UNIQUE KEY `uq_index_project_no` (`project_no`),
  KEY `loan_approve_project_co_bank_id` (`co_bank_id`),
  KEY `loan_approve_project_dealer_id` (`dealer_id`),
  KEY `loan_approve_project_sys_type` (`sys_type`),
  KEY `loan_approve_project_main_signer_id` (`main_signer_id`),
  KEY `loan_approve_project_vice_signer_id` (`vice_signer_id`),
  KEY `launch_org_id` (`launch_org_id`),
  KEY `idx_lap_credit_id` (`credit_id`) USING BTREE,
  KEY `loan_approve_project_org_id` (`org_id`,`status`) USING BTREE,
  KEY `ldx_lap_modify_time` (`modify_time`) USING HASH,
  KEY `idx_lap_slp` (`status`,`launch_org_id`,`project_id`),
  KEY `loan_approve_project_user_group_id` (`user_group_id`,`org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=160254 DEFAULT CHARSET=utf8 COMMENT='贷款项目审批表';

-- ----------------------------
-- Table structure for loan_car_fee
-- ----------------------------
DROP TABLE IF EXISTS `loan_car_fee`;
CREATE TABLE `loan_car_fee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目编号',
  `loan_fee_info_id` bigint(20) DEFAULT NULL COMMENT '贷款费用信息表',
  `liability_amount` decimal(24,6) DEFAULT NULL COMMENT '责信险',
  `other_fee` decimal(24,6) DEFAULT NULL COMMENT '其他费用',
  `total_fee` decimal(24,6) DEFAULT NULL COMMENT '合计费用',
  `gps_loan_fee` decimal(12,4) DEFAULT NULL COMMENT 'GPS贷款金额(元)  (v2.5.0)',
  `guarantee_service_fee` decimal(12,4) DEFAULT NULL COMMENT '其他综合服务费贷款金额(元) (v2.5.0)',
  `purchase_amount` decimal(24,6) DEFAULT NULL COMMENT '购车协议价',
  `bank_downpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '首付金额',
  `bank_downpayment_ratio` decimal(24,6) DEFAULT NULL COMMENT '首付比例',
  `car_purchase_amount` decimal(24,6) DEFAULT NULL COMMENT '购车贷款金额',
  `premium_purchase_amount` decimal(24,6) DEFAULT NULL COMMENT '保费贷款金额',
  `tax_purchase_amount` decimal(24,6) DEFAULT NULL COMMENT '购置税贷款金额',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '操作人',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_project_id_loan_fee_info_id` (`project_id`,`loan_fee_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119172 DEFAULT CHARSET=utf8 COMMENT='贷款汽车费用表，此表作为loan_fee_info在汽车消费分期业务条件下的记录费用的扩展表';

-- ----------------------------
-- Table structure for loan_car_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_car_info`;
CREATE TABLE `loan_car_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `car_frame_no` varchar(255) DEFAULT NULL COMMENT '车架号码',
  `car_engine_no` varchar(255) DEFAULT NULL COMMENT '发动机号码',
  `car_engine_model_name` varchar(255) DEFAULT NULL COMMENT '发动机型号',
  `bill_no` varchar(255) DEFAULT NULL COMMENT '发票号码',
  `bill_company_name` varchar(255) DEFAULT NULL COMMENT '开票单位',
  `bill_date` date DEFAULT NULL COMMENT '发票日期',
  `max_capacity` varchar(255) DEFAULT NULL COMMENT '限乘人数',
  `car_type` int(1) NOT NULL DEFAULT '1' COMMENT '汽车类型：枚举类型 1:新车,2:二手车',
  `car_database_type` int(1) NOT NULL DEFAULT '0' COMMENT '车型库类型：枚举参考代码',
  `car_database_id` varchar(100) DEFAULT NULL COMMENT '对应车型库中的ID',
  `car_brand_code` varchar(255) DEFAULT NULL COMMENT '车辆品牌编码',
  `car_brand_name` varchar(255) DEFAULT NULL COMMENT '车辆品牌名称',
  `car_make_code` varchar(255) DEFAULT NULL COMMENT '车系编码',
  `car_make_name` varchar(255) DEFAULT NULL COMMENT '车系名称',
  `car_model_code` varchar(255) DEFAULT NULL COMMENT '车型编码',
  `car_model_name` varchar(255) DEFAULT NULL COMMENT '车型名称',
  `displacement` varchar(255) DEFAULT NULL COMMENT '汽车排量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `province` varchar(15) DEFAULT NULL COMMENT '购车省',
  `province_code` varchar(255) DEFAULT NULL COMMENT '购车省编码',
  `city` varchar(15) DEFAULT NULL COMMENT '购车市',
  `city_code` varchar(255) DEFAULT NULL COMMENT '购车市编码',
  `area` varchar(15) DEFAULT NULL COMMENT '购车区/县',
  `area_code` varchar(255) DEFAULT NULL COMMENT '购车区/县编码',
  `new_car_guide_price` decimal(24,6) DEFAULT NULL COMMENT '新车指导价',
  `factory_time` varchar(20) DEFAULT NULL COMMENT '出厂日期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '车商主键(车商表中的 ID)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_project_id` (`project_id`) USING BTREE,
  KEY `idx_car_frame_no` (`car_frame_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110451 DEFAULT CHARSET=utf8 COMMENT='汽车消费分期信息扩展表';

-- ----------------------------
-- Table structure for loan_car_license_plate_fail_record
-- ----------------------------
DROP TABLE IF EXISTS `loan_car_license_plate_fail_record`;
CREATE TABLE `loan_car_license_plate_fail_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `loan_car_id` bigint(20) NOT NULL COMMENT '汽车ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `operator_name` varchar(32) DEFAULT NULL COMMENT '操作人姓名',
  `operator_date` datetime DEFAULT NULL COMMENT '操作人日期',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '未上牌原因(1:要示本人到场,2:资料不齐全,3:拍牌,4:其他)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_loan_car_id` (`loan_car_id`) USING BTREE,
  KEY `index_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='车辆上牌失败记录表';

-- ----------------------------
-- Table structure for loan_car_plate_area
-- ----------------------------
DROP TABLE IF EXISTS `loan_car_plate_area`;
CREATE TABLE `loan_car_plate_area` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `area_full_name` varchar(20) NOT NULL COMMENT '地区全称',
  `area_name` varchar(5) NOT NULL COMMENT '地区简称',
  `parent_id` bigint(11) NOT NULL COMMENT '父ID',
  `seq` double NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `index_area_name` (`area_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3388 DEFAULT CHARSET=utf8 COMMENT='车牌地区映射表';

-- ----------------------------
-- Table structure for loan_collection_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_collection_info`;
CREATE TABLE `loan_collection_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `plan_no` bigint(20) NOT NULL COMMENT '期数',
  `collection_obj_id` bigint(20) DEFAULT NULL COMMENT '催收对象id',
  `collection_obj_realname` varchar(255) DEFAULT NULL COMMENT '催收对象姓名',
  `collection_type` int(11) DEFAULT NULL COMMENT '1:电话催收,2:上门催收',
  `is_outsource` int(11) DEFAULT '2' COMMENT '委外,1:是,2:否',
  `collection_date` datetime DEFAULT NULL COMMENT '催收日期',
  `collection_address_pid` varchar(10) DEFAULT NULL COMMENT '催收地址省ID',
  `collection_address_pname` varchar(50) DEFAULT NULL COMMENT '催收地址省名称',
  `collection_address_cid` varchar(10) DEFAULT NULL COMMENT '催收地址市id',
  `collection_address_cname` varchar(50) DEFAULT NULL COMMENT '催收地址市Name',
  `collection_address_rid` varchar(10) DEFAULT NULL COMMENT '催收地址区id',
  `collection_address_rname` varchar(50) DEFAULT NULL COMMENT '催收地址区name',
  `collection_address_detail` varchar(255) DEFAULT NULL COMMENT '催收详细地址',
  `collection_result` int(11) DEFAULT NULL COMMENT '1:愿意还款,2:不愿还款',
  `collection_user_id` bigint(20) DEFAULT NULL COMMENT '催收人id',
  `collection_user_realname` varchar(32) DEFAULT NULL COMMENT '催收人姓名',
  `will_payment_date` datetime DEFAULT NULL COMMENT '意愿还款日期',
  `will_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '意愿还款金额',
  `is_full_payment` int(11) DEFAULT '2' COMMENT '1:是全额还款2:否',
  `remark` varchar(512) DEFAULT NULL COMMENT '情况描述',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`) USING BTREE,
  KEY `loan_collection_info_collection_address_pname` (`collection_address_pname`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8 COMMENT='催收基本信息表';

-- ----------------------------
-- Table structure for loan_contract_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_contract_info`;
CREATE TABLE `loan_contract_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `contract_no` varchar(255) DEFAULT NULL COMMENT '银行合同编号(放款合同编号)',
  `iou_number` varchar(100) DEFAULT NULL COMMENT '借据编号',
  `contract_amount` double(20,2) DEFAULT NULL COMMENT '合同金额(银行放款金额)',
  `bank_no` varchar(255) DEFAULT NULL COMMENT '银行放款账号',
  `payment_loan_date` datetime DEFAULT NULL COMMENT '放款日期',
  `plan_no` bigint(20) DEFAULT NULL COMMENT '放款期数',
  `repayment_no` varchar(255) DEFAULT NULL COMMENT ' 代扣卡号：取借款人银行卡号（2.5.0） ',
  `interest_start_date` date DEFAULT NULL COMMENT '合同起始日期',
  `interest_end_date` date DEFAULT NULL COMMENT '合同到期日期',
  `first_repayment_date` date DEFAULT NULL COMMENT '首个扣款日(首期还款日)',
  `register_date` date DEFAULT NULL COMMENT '登记日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `contract_status` int(11) NOT NULL DEFAULT '1' COMMENT '放款结果 1:未放款;2:已放款;3:放款拒绝',
  `apply_status` int(11) NOT NULL DEFAULT '0' COMMENT '申请放款状态 0:未申请；1:申请成功',
  `loan_refusal_reason` varchar(255) DEFAULT '' COMMENT '放款拒绝说明',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '操作人',
  `loan_type` int(11) NOT NULL DEFAULT '1' COMMENT '放款结果 1:主贷;2:附加贷',
  `bank_loan_serial_no` varchar(100) DEFAULT NULL COMMENT '小微信贷申请编号（申请成功后银行返回）',
  `rate_change_type` tinyint(3) DEFAULT NULL COMMENT '利率定价方式 参见枚举：com.ftcs.venus.cls.enums.loan.BankRateChangeTypeEnum',
  `rate_type` tinyint(3) DEFAULT NULL COMMENT '利率类型 参见枚举：com.ftcs.venus.cls.enums.loan.BankRateTypeEnum',
  `sub_product_type` int(10) DEFAULT NULL COMMENT '产品子类 参见枚举：com.ftcs.venus.cls.enums.loan.LoanSubProductTypeEnum',
  `rate_float_type` tinyint(3) DEFAULT NULL COMMENT '利率浮动方式 参见枚举：com.ftcs.venus.cls.enums.loan.BankRateFloatTypeEnum',
  `repay_type` tinyint(3) DEFAULT NULL COMMENT '还款方式 参见枚举：com.ftcs.venus.cls.enums.loan.BankRepayTypeEnum',
  `repay_period` tinyint(3) DEFAULT NULL COMMENT '还款周期 参见枚举：com.ftcs.venus.cls.enums.loan.BankRepayPeriodEnum',
  `repay_day_of_month` tinyint(3) DEFAULT NULL COMMENT '还款日',
  `recount_type` tinyint(3) DEFAULT NULL COMMENT '提前还款后的重算方式 参见枚举：com.ftcs.venus.cls.enums.loan.BankRecountType',
  `payment_type` tinyint(3) DEFAULT NULL COMMENT '支付方式 参见枚举：com.ftcs.venus.cls.enums.loan.BankPaymentTypeEnum',
  `float_period_base_term` tinyint(3) DEFAULT NULL COMMENT '浮动周期基期  参见枚举：com.ftcs.venus.cls.enums.loan.BankFloatPeriodBaseTerm',
  `overdue_principal_interest_add_type` tinyint(3) DEFAULT NULL COMMENT '逾期本金罚息利率增量选项 参见枚举：com.ftcs.venus.cls.enums.loan.BankRateAddFloatTypeEnum',
  `overdue_principal_interest_add_num` decimal(16,6) DEFAULT NULL COMMENT '逾期本金罚息利率浮动比',
  `overdue_compound_interest_add_type` tinyint(3) DEFAULT NULL COMMENT '逾期利率复利利率增量选项 参见枚举：com.ftcs.venus.cls.enums.loan.BankRateAddFloatTypeEnum',
  `overdue_compound_interest_add_num` decimal(16,6) DEFAULT NULL COMMENT '逾期利率复利利率浮动比',
  `overdue_principal_compound_interest_add_type` tinyint(3) DEFAULT NULL COMMENT '逾期本金罚息复利利率增量选项 参见枚举：com.ftcs.venus.cls.enums.loan.BankRateAddFloatTypeEnum',
  `overdue_principal_compound_interest_add_num` decimal(16,6) DEFAULT NULL COMMENT '逾期本金罚息复利利率浮动比',
  `purpose` varchar(500) DEFAULT NULL COMMENT '贷款用途',
  `loan_account_no` varchar(30) DEFAULT NULL COMMENT '入账账号',
  `rate_add_num` decimal(16,6) DEFAULT NULL COMMENT '利率增量',
  `float_period_num` tinyint(3) DEFAULT NULL COMMENT '浮动周期',
  `next_float_date` timestamp NULL DEFAULT NULL COMMENT '下次浮动日期',
  `put_out_serial_no` varchar(50) DEFAULT NULL COMMENT '借贷出帐流水号',
  `invoke_mango_DBI024_status` tinyint(3) DEFAULT NULL COMMENT '调用芒果银行DBI024状态 详见枚举:com.ftcs.venus.cls.enums.loan.InvokeBankFacadeStatusEnum',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE,
  KEY `idx_iou_number` (`iou_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=147596 DEFAULT CHARSET=utf8 COMMENT='合同登记表';

-- ----------------------------
-- Table structure for loan_contract_relevance
-- ----------------------------
DROP TABLE IF EXISTS `loan_contract_relevance`;
CREATE TABLE `loan_contract_relevance` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `contract_type` int(1) NOT NULL COMMENT '合同类型（1：抵押合同，2：还款合同，3：抵押委托书，4：抵押申请表）',
  `contract_name` varchar(100) NOT NULL COMMENT '合同名称',
  `contract_no` varchar(50) NOT NULL COMMENT '合同编号',
  `contract_status` int(1) NOT NULL COMMENT '合同状态',
  `signed_state` int(1) DEFAULT '1' COMMENT '签单状态(1:未签单,2:已签单)',
  `signed_time` datetime DEFAULT NULL COMMENT '签单时间',
  `contract_write_state` int(1) DEFAULT '1' COMMENT '合同抄写状态(1:未抄写,2:已抄写) ',
  `contract_write_time` datetime DEFAULT NULL COMMENT '合同抄写时间',
  `guaranty_state` int(1) DEFAULT '1' COMMENT '抵押状态(1:未抵押,2:已抵押)',
  `guaranty_time` datetime DEFAULT NULL COMMENT '抵押时间',
  `bank_check_state` int(1) DEFAULT '1' COMMENT '银行核销状态(1:未核销,已核销)',
  `bank_check_time` datetime DEFAULT NULL COMMENT '银行核销时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空白合同关联表';

-- ----------------------------
-- Table structure for loan_contract_repay_plan
-- ----------------------------
DROP TABLE IF EXISTS `loan_contract_repay_plan`;
CREATE TABLE `loan_contract_repay_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `contract_id` bigint(20) NOT NULL COMMENT '合同主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `loan_type` int(11) DEFAULT '1' COMMENT '放款类型 1:主贷;2:附加贷（V2.5.0）',
  `plan_no` bigint(20) DEFAULT NULL COMMENT '期数',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `being_amount` decimal(24,4) DEFAULT NULL COMMENT '期初余额',
  `repay_amount` decimal(24,4) DEFAULT NULL COMMENT '本期还款',
  `discount_amount` decimal(24,4) DEFAULT NULL COMMENT '贴息金额',
  `end_amount` decimal(24,4) DEFAULT NULL COMMENT '期末余额',
  `sys_type` varchar(50) DEFAULT 'CLS' COMMENT '数据来源标识',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `current_term_principle` decimal(24,6) DEFAULT NULL COMMENT '本期本金',
  `current_term_interest` decimal(24,6) DEFAULT NULL COMMENT '本期利息',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '逾期总额',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `last_repayment_date` date DEFAULT NULL COMMENT '最近还款日期',
  `current_bank_repayment_time` datetime DEFAULT NULL COMMENT '当前银行还款日',
  `actual_amount` decimal(24,4) DEFAULT NULL COMMENT '实际还款金额',
  `overdue_flag` bit(1) DEFAULT b'0',
  `interest_days` int(11) DEFAULT NULL COMMENT '计息天数(2.5.3)',
  `loan_balance` decimal(24,6) DEFAULT NULL COMMENT '贷款余额(2.5.3)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_project_id` (`project_id`) USING BTREE,
  KEY `index_contract_id` (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3587095 DEFAULT CHARSET=utf8 COMMENT='合同还款计划表';

-- ----------------------------
-- Table structure for loan_customer_contacter
-- ----------------------------
DROP TABLE IF EXISTS `loan_customer_contacter`;
CREATE TABLE `loan_customer_contacter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贷款紧急联系人Id',
  `project_id` bigint(20) NOT NULL COMMENT '贷款Id',
  `name` varchar(32) NOT NULL COMMENT '姓名',
  `en_name` varchar(64) DEFAULT NULL COMMENT '英文名',
  `mobile_phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `borrower_relationship` int(11) DEFAULT NULL COMMENT '与借款人关系(1:本人;2:夫妻;其余见数据字典)',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=178053 DEFAULT CHARSET=utf8 COMMENT='贷款紧急联系人表，用于记录紧急联系人的相关信息';

-- ----------------------------
-- Table structure for loan_customer_hfr
-- ----------------------------
DROP TABLE IF EXISTS `loan_customer_hfr`;
CREATE TABLE `loan_customer_hfr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `apply_id` bigint(20) NOT NULL COMMENT '申请主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `card_type` int(10) NOT NULL COMMENT '证件类型',
  `card_no` varchar(20) NOT NULL COMMENT '证件编号',
  `file_path` varchar(255) DEFAULT NULL COMMENT '照片地址',
  `similarity_degree` int(11) DEFAULT NULL COMMENT '相似度',
  `result` varchar(255) DEFAULT NULL COMMENT '人脸识别结果',
  `contrast_status` int(1) DEFAULT '0' COMMENT '人脸识别结果状态 0-未通过 1-通过',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int(1) DEFAULT '0' COMMENT '识别状态(0：未识别，1已识别)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='贷款客户人脸识别结果表';

-- ----------------------------
-- Table structure for loan_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_customer_info`;
CREATE TABLE `loan_customer_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `apply_id` bigint(20) NOT NULL COMMENT '申请主键',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `customer_no` varchar(50) NOT NULL COMMENT '客户编号',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `en_customer_name` varchar(50) DEFAULT NULL COMMENT '英文名',
  `customer_type` int(10) DEFAULT NULL COMMENT '客户类型（1：个人客户，2：企业客户）',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(20) DEFAULT NULL COMMENT '证件号码',
  `card_no_valid` tinyint(1) DEFAULT '0' COMMENT '证件是否长期有效 0:否,1:是',
  `card_no_valid_time` date DEFAULT NULL COMMENT '证件有效期',
  `licence_issuing_authority` varchar(100) DEFAULT NULL COMMENT '发证机关',
  `customer_source` int(10) DEFAULT NULL COMMENT '客户来源（1：车果网，2：内部推荐）',
  `source_serialno` varchar(50) DEFAULT NULL COMMENT '客户来源流水号',
  `sex` int(1) DEFAULT NULL COMMENT '性别 1 男，0 女',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `mobile_phone` varchar(100) DEFAULT NULL COMMENT '手机号码',
  `home_phone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `native_place` varchar(150) DEFAULT NULL COMMENT '籍贯',
  `education` int(10) DEFAULT NULL COMMENT '学历(1：初中及以下，2：高中，3：大专，4：本科，5：硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(1：自有住房，2：贷款购房，3：租房：4：其他)',
  `current_house_area` decimal(6,2) DEFAULT NULL COMMENT '当前住宅面积(平方米)',
  `mortgage_repayment` varchar(50) DEFAULT NULL COMMENT '住房月还款情况',
  `driver_licence` int(1) DEFAULT NULL COMMENT '客户驾照情况（１：无，２：有：３：正在学车）',
  `provide_business_licence` int(1) DEFAULT NULL COMMENT '提供营业执照类型（1：无；2：有；3：有且具备实体营业场所）',
  `provide_account_statement` int(1) DEFAULT NULL COMMENT '提供银行流水类型（1：无；2：有；3：有且2倍以上月供）',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `profession_code` int(10) DEFAULT NULL COMMENT '职业编码',
  `post` int(10) DEFAULT NULL COMMENT '职务',
  `post_name` varchar(50) DEFAULT NULL COMMENT '职务名称',
  `industry` int(10) DEFAULT NULL COMMENT '行业',
  `work_nature` varchar(50) DEFAULT '' COMMENT '工作单位性质',
  `work_nature_code` int(10) DEFAULT NULL COMMENT '工作单位性质编码',
  `employ_time` date DEFAULT NULL COMMENT '入职时间',
  `monthly_income` int(10) DEFAULT NULL COMMENT '个人月收入',
  `yearly_income` decimal(24,6) DEFAULT NULL COMMENT '年收入',
  `personal_asset_sum` decimal(24,6) DEFAULT NULL COMMENT '个人总资产(万)',
  `monthly_liabilities` decimal(24,6) DEFAULT NULL COMMENT '月负债',
  `other_debt_balance` decimal(24,6) DEFAULT NULL COMMENT '其他负债余额(元)',
  `reserved_funds` int(10) DEFAULT NULL COMMENT '公积金（1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上）',
  `reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `cur_address_time` date DEFAULT NULL COMMENT '现居住地入住时间',
  `company_name` varchar(100) DEFAULT NULL COMMENT '工作单位',
  `company_phone` varchar(20) DEFAULT NULL COMMENT '单位电话',
  `company_address_pid` varchar(10) DEFAULT NULL COMMENT '单位地址ID',
  `company_address_pname` varchar(50) DEFAULT NULL COMMENT '单位地址名称',
  `company_address_cid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化市id',
  `company_address_cname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化市Name',
  `company_address_rid` varchar(10) DEFAULT NULL COMMENT '单位地址格式化区id',
  `company_address_rname` varchar(50) DEFAULT NULL COMMENT '单位地址格式化区name',
  `company_address_detail` varchar(200) DEFAULT NULL COMMENT '单位详细地址',
  `company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址经度坐标',
  `company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '单位地址纬度坐标',
  `home_address_pid` varchar(10) DEFAULT NULL COMMENT '家庭地址ID',
  `home_address_pname` varchar(50) DEFAULT NULL COMMENT '家庭地址名称',
  `home_address_cid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化市id',
  `home_address_cname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化市Name',
  `home_address_rid` varchar(10) DEFAULT NULL COMMENT '家庭地址格式化区id',
  `home_address_rname` varchar(50) DEFAULT NULL COMMENT '家庭地址格式化区name',
  `home_address_detail` varchar(200) DEFAULT NULL COMMENT '家庭详细地址',
  `home_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址经度坐标',
  `home_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '家庭地址纬度坐标',
  `delivery_address_pid` varchar(10) DEFAULT NULL COMMENT '收件地址ID',
  `delivery_address_pname` varchar(50) DEFAULT NULL COMMENT '收件地址名称',
  `delivery_address_cid` varchar(10) DEFAULT NULL COMMENT '收件地址格式化市id',
  `delivery_address_cname` varchar(50) DEFAULT NULL COMMENT '收件地址格式化市Name',
  `delivery_address_rid` varchar(10) DEFAULT '' COMMENT '收件地址格式化区id',
  `delivery_address_rname` varchar(50) DEFAULT NULL COMMENT '收件地址格式化区name',
  `delivery_address_detail` varchar(200) DEFAULT NULL COMMENT '收件详细地址',
  `delivery_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址经度坐标',
  `delivery_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址纬度坐标',
  `spouse_id` bigint(20) DEFAULT NULL COMMENT '配偶客户ID',
  `spouse_name` varchar(100) DEFAULT NULL COMMENT '配偶姓名',
  `spouse_card_type` int(10) DEFAULT NULL COMMENT '配偶证件类型(1：身份证，2：军官证，3：侨胞证，4：外籍人士)',
  `spouse_card_no` varchar(20) DEFAULT NULL COMMENT '配偶证件编号',
  `spouse_mobile_phone` varchar(100) DEFAULT NULL COMMENT '配偶手机号',
  `spouse_permant_address` varchar(200) DEFAULT NULL COMMENT '配偶户籍地址',
  `spouse_reserved_funds` int(11) DEFAULT NULL COMMENT '配偶公积金(1：无，2：1-500，3：501-1000，4：1001-1500，5：1501-2000，6：2001-2500，7：2501-3000，8：3000以上)',
  `spouse_reserved_funds_year` varchar(20) DEFAULT NULL COMMENT '公积金年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `spouse_social_year` varchar(20) DEFAULT NULL COMMENT '社保年限 1:无,2:一年以内,3:1年-3年,4:3年以上',
  `spouse_driver_licence` int(1) DEFAULT NULL COMMENT '配偶驾照情况（１：无，２：有：３：正在学车）',
  `spouse_company_name` varchar(200) DEFAULT NULL COMMENT '配偶单位名称',
  `spouse_company_address_pid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址省代码',
  `spouse_company_address_pname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址省',
  `spouse_company_address_cid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址市代码',
  `spouse_company_address_cname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址市',
  `spouse_company_address_rid` varchar(11) DEFAULT NULL COMMENT '配偶单位地址县代码',
  `spouse_company_address_rname` varchar(30) DEFAULT NULL COMMENT '配偶单位地址县',
  `spouse_company_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址经度坐标',
  `spouse_company_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '配偶单位地址纬坐标',
  `spouse_company_address` varchar(200) DEFAULT NULL COMMENT '配偶单位地址',
  `spouse_company_phone` varchar(20) DEFAULT NULL COMMENT '配偶单位电话',
  `spouse_monthly_income` int(10) DEFAULT NULL COMMENT '配偶月薪',
  `is_agency` int(1) DEFAULT NULL COMMENT '是否代购(1:是，2：否)',
  `real_car_owner` varchar(100) DEFAULT NULL COMMENT '实际用车人',
  `register_date` datetime DEFAULT NULL COMMENT '建档日期',
  `joint_obligor` varchar(30) DEFAULT NULL COMMENT '共同还款人',
  `customer_score_a` decimal(10,2) DEFAULT NULL COMMENT '客户评分A',
  `customer_score_b` decimal(10,2) DEFAULT NULL COMMENT '客户评分B',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `save_status` int(1) DEFAULT NULL COMMENT '保存状态，０：未保存，１：暂存，２：已保存',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `guarantor_driver_licence` int(11) DEFAULT NULL COMMENT '担保人驾驶证情况1、无2、有3、正在学车',
  `domicile_type` int(10) DEFAULT NULL COMMENT '户籍性质1:农业,2,非农',
  `spouse_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '配偶年收入（万元）',
  `house_yearly_income` decimal(24,6) DEFAULT NULL COMMENT '家庭年收入（万元）',
  `cmpy_postcode` varchar(50) DEFAULT NULL COMMENT '工作单位邮编',
  `home_postcode` varchar(50) DEFAULT NULL COMMENT '家庭住址邮编',
  `survey_report` varchar(3000) DEFAULT NULL COMMENT '调查报告',
  `card_collect_method` int(1) NOT NULL DEFAULT '1' COMMENT '开卡领取方式 1-自取 2-寄送单位 3-寄送住宅',
  PRIMARY KEY (`id`),
  UNIQUE KEY `apply_id` (`apply_id`) USING BTREE,
  UNIQUE KEY `uk_customer_apply_id` (`project_id`,`apply_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62551 DEFAULT CHARSET=utf8 COMMENT='贷款客户信息表';

-- ----------------------------
-- Table structure for loan_customer_project_his
-- ----------------------------
DROP TABLE IF EXISTS `loan_customer_project_his`;
CREATE TABLE `loan_customer_project_his` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(32) NOT NULL COMMENT '证件号码',
  `project_id` bigint(20) NOT NULL COMMENT '贷款Id',
  `project_no` varchar(32) NOT NULL COMMENT '贷款编号',
  `loan_status` int(11) NOT NULL COMMENT '贷款状态',
  `business_relationship` int(11) DEFAULT NULL COMMENT '业务关系 1借款人;2:共同偿债人 ',
  `overrule_operator_id` bigint(11) DEFAULT NULL COMMENT '[否决/关闭]操作人id',
  `overrule_operator_name` varchar(32) DEFAULT NULL COMMENT '[否决/关闭]操作人姓名',
  `overrule_time` datetime DEFAULT NULL COMMENT '[否决/关闭]签署时间',
  `overrule_note` varchar(1024) DEFAULT NULL COMMENT '[否决/关闭]签署时间',
  `is_over` int(11) DEFAULT '0' COMMENT '是否[否决/关闭]完成 1 是 0 否',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65706 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='贷款客户历史记录表';

-- ----------------------------
-- Table structure for loan_customer_relavant
-- ----------------------------
DROP TABLE IF EXISTS `loan_customer_relavant`;
CREATE TABLE `loan_customer_relavant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贷款关联人Id',
  `project_id` bigint(20) NOT NULL COMMENT '贷款Id',
  `name` varchar(32) NOT NULL COMMENT '姓名',
  `en_name` varchar(64) DEFAULT NULL COMMENT '英文名',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(25) NOT NULL COMMENT '证件号码',
  `cert_valid_start_date` varchar(16) DEFAULT NULL COMMENT '证件有效期起始日',
  `cert_valid_end_date` varchar(16) DEFAULT NULL COMMENT '证件有效期截止日',
  `licence_issuing_authority` varchar(32) DEFAULT NULL COMMENT '发证机关',
  `mobile_phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(16) DEFAULT NULL COMMENT '出生日期',
  `gender` int(11) DEFAULT NULL COMMENT '性别(1:男;2:女)',
  `marital_status` int(11) DEFAULT NULL COMMENT '婚姻状态(见数据字典或枚举)',
  `borrower_relationship` int(11) DEFAULT NULL COMMENT '与借款人关系(1:本人;2:夫妻;其余见数据字典)',
  `business_relationship` int(11) DEFAULT NULL COMMENT '业务关系(1借款人;2:共同偿债人;3:担保人)',
  `native_place` varchar(128) DEFAULT NULL COMMENT '籍贯',
  `domicile_type` int(10) DEFAULT NULL COMMENT '户籍性质1:农业,2,非农',
  `domicile_address` varchar(128) DEFAULT NULL COMMENT '户籍地址',
  `education` int(10) DEFAULT NULL COMMENT '学历(1:初中及以下;2:高中;3:大专;4:本科;5:硕士及以上)',
  `degree` int(10) DEFAULT NULL COMMENT '学位(0:无;1:学士;2:硕士;3:博士)',
  `housing_status` int(10) DEFAULT NULL COMMENT '住房情况(见数据字典或枚举)',
  `driver_licence` int(1) DEFAULT NULL COMMENT '驾照情况(0:无;1:有)',
  `personal_monthly_income` decimal(12,4) DEFAULT NULL COMMENT '个人月收入(元)',
  `household_monthly_income` decimal(12,4) DEFAULT NULL COMMENT '家庭月收入(元)',
  `personal_yearly_income` decimal(12,4) DEFAULT NULL COMMENT '个人年收入(元)',
  `household_yearly_income` decimal(12,4) DEFAULT NULL COMMENT '家庭年收入(元)',
  `personal_asset_sum` decimal(12,4) DEFAULT NULL COMMENT '个人总资产(元)',
  `personal_debt_balance` decimal(12,4) DEFAULT NULL COMMENT '个人总负债(元)',
  `housing_provident_fund_monthly_payment` decimal(12,4) DEFAULT NULL COMMENT '住房公积金月缴总额(元)',
  `housing_provident_fund_year` int(11) DEFAULT NULL COMMENT '住房公积金缴纳年限(0:无;1:一年以内;2:1年-3年;3:3年以上)',
  `social_insurance_monthly_payment` decimal(12,4) DEFAULT NULL COMMENT '社保月缴总额(元)',
  `social_insurance_year` int(11) DEFAULT NULL COMMENT '社保缴纳年限(0:无;1:一年以内;2:1年-3年;3:3年以上)',
  `industry_code` varchar(16) DEFAULT NULL COMMENT '行业编码',
  `industry_name` varchar(32) DEFAULT NULL COMMENT '行业名称',
  `profession_code` varchar(16) DEFAULT NULL COMMENT '职业编码',
  `profession_name` varchar(32) DEFAULT NULL COMMENT '职业名称',
  `post_code` varchar(16) DEFAULT NULL COMMENT '职务编码',
  `post_name` varchar(32) DEFAULT NULL COMMENT '职务名称',
  `work_unit_nature_code` varchar(16) DEFAULT NULL COMMENT '工作单位性质编码',
  `work_unit_nature_name` varchar(32) DEFAULT NULL COMMENT '工作单位性质名称',
  `work_unit_name` varchar(64) DEFAULT NULL COMMENT '工作单位名称',
  `work_unit_phone` varchar(32) DEFAULT NULL COMMENT '工作单位固定电话',
  `work_unit_postcode` varchar(32) DEFAULT NULL COMMENT '工作单位邮编',
  `work_unit_address_pid` varchar(16) DEFAULT NULL COMMENT '工作单位地址省Id',
  `work_unit_address_pname` varchar(32) DEFAULT NULL COMMENT '工作单位地址省名',
  `work_unit_address_cid` varchar(16) DEFAULT NULL COMMENT '工作单位地址市Id',
  `work_unit_address_cname` varchar(32) DEFAULT NULL COMMENT '工作单位地址市名',
  `work_unit_address_rid` varchar(16) DEFAULT NULL COMMENT '工作单位地址区Id',
  `work_unit_address_rname` varchar(32) DEFAULT NULL COMMENT '工作单位地址区名',
  `work_unit_address_detail` varchar(128) DEFAULT NULL COMMENT '工作单位详细地址',
  `work_unit_induction_time` date DEFAULT NULL COMMENT '工作单位入职时间',
  `home_phone` varchar(32) DEFAULT NULL COMMENT '家庭固定电话',
  `home_postcode` varchar(32) DEFAULT NULL COMMENT '家庭住址邮编',
  `home_address_pid` varchar(16) DEFAULT NULL COMMENT '家庭地址省Id',
  `home_address_pname` varchar(32) DEFAULT NULL COMMENT '家庭地址省名',
  `home_address_cid` varchar(16) DEFAULT NULL COMMENT '家庭地址市Id',
  `home_address_cname` varchar(32) DEFAULT NULL COMMENT '家庭地址市名',
  `home_address_rid` varchar(16) DEFAULT NULL COMMENT '家庭地址区Id',
  `home_address_rname` varchar(32) DEFAULT NULL COMMENT '家庭地址区名',
  `home_address_detail` varchar(128) DEFAULT NULL COMMENT '家庭详细地址',
  `habitation_phone` varchar(32) DEFAULT NULL COMMENT '邮寄地址固定电话',
  `habitation_postcode` varchar(32) DEFAULT NULL COMMENT '邮寄地址邮编',
  `habitation_address_pid` varchar(16) DEFAULT NULL COMMENT '邮寄地址省Id',
  `habitation_address_pname` varchar(32) DEFAULT NULL COMMENT '邮寄地址省名',
  `habitation_address_cid` varchar(16) DEFAULT NULL COMMENT '邮寄地址市Id',
  `habitation_address_cname` varchar(32) DEFAULT NULL COMMENT '邮寄地址市名',
  `habitation_address_rid` varchar(16) DEFAULT NULL COMMENT '邮寄地址区Id',
  `habitation_address_rname` varchar(32) DEFAULT NULL COMMENT '邮寄地址区名',
  `habitation_address_detail` varchar(128) DEFAULT NULL COMMENT '邮寄地址详细地址',
  `bank_card_no` varchar(32) DEFAULT NULL COMMENT '银行卡号',
  `bank_sub_account` varchar(32) DEFAULT NULL COMMENT '二类户账号（2.5.0）',
  `bank_card_reserve_mobile_phone` varchar(16) DEFAULT NULL COMMENT '银行卡预留手机号',
  `bank_card_openning_bank_name` varchar(32) DEFAULT NULL COMMENT '银行卡开户行名称',
  `bank_card_cnaps_code` varchar(32) DEFAULT NULL COMMENT '银行卡开户行联行号',
  `auth_result` int(11) DEFAULT '0' COMMENT '鉴权结果(0:不通过;1:通过)',
  `auth_remark` varchar(255) DEFAULT NULL COMMENT '鉴权结果说明',
  `signing_authorize_link` varchar(512) DEFAULT NULL COMMENT '签约授权地址(v2.5.0)',
  `sign_result` int(11) DEFAULT '0' COMMENT '签约结果(0:未签约;1:已签约)',
  `send_sms_result` int(11) DEFAULT '0' COMMENT '短信发送结果(0, "短信未发送"; 1, "短信已发送";)',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE,
  KEY `idx_cert_no_cert_type` (`cert_no`,`cert_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=152625 DEFAULT CHARSET=utf8 COMMENT='贷款关联人表,用于记录贷款关联的借款人、共同偿债人、担保人等信息';

-- ----------------------------
-- Table structure for loan_deposit_return
-- ----------------------------
DROP TABLE IF EXISTS `loan_deposit_return`;
CREATE TABLE `loan_deposit_return` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `pb_deposit` decimal(24,6) DEFAULT NULL COMMENT '履约保证金余额',
  `renewal_deposit` decimal(24,6) DEFAULT NULL COMMENT '续保冲减保证金',
  `advance_balance` decimal(24,6) DEFAULT NULL COMMENT '垫款余额',
  `other_rebate` decimal(24,6) DEFAULT NULL COMMENT '其他扣减金额',
  `return_amount` decimal(24,6) DEFAULT NULL COMMENT '应退金额',
  `return_account_name` varchar(100) DEFAULT NULL COMMENT '退款账户名称',
  `return_account_no` varchar(50) DEFAULT NULL COMMENT '退款银行账户',
  `return_bank` varchar(100) DEFAULT NULL COMMENT '退款银行开户行名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '清退情况描述',
  `return_status` int(1) DEFAULT NULL COMMENT '清退状态(1：未清退；2：清退中；3：已清退；4：已关闭)',
  `return_date` date DEFAULT NULL COMMENT '情况日期',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用(1:启用，2：停用)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`),
  KEY `index_project_id` (`project_id`),
  KEY `index_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='贷款结清数据记录表';

-- ----------------------------
-- Table structure for loan_deposit_return_file
-- ----------------------------
DROP TABLE IF EXISTS `loan_deposit_return_file`;
CREATE TABLE `loan_deposit_return_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deposit_id` bigint(20) DEFAULT NULL COMMENT '履约保证金ID',
  `deposit_file` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `deposit_file_name` varchar(255) DEFAULT NULL COMMENT '文件的名称',
  `deposit_size` double DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='履约保证金清退材料附件表';

-- ----------------------------
-- Table structure for loan_dm
-- ----------------------------
DROP TABLE IF EXISTS `loan_dm`;
CREATE TABLE `loan_dm` (
  `project_id` bigint(20) NOT NULL COMMENT '项目ID',
  `customer_name` varchar(50) DEFAULT NULL,
  `id_no` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `card_no` varchar(50) DEFAULT NULL COMMENT '卡号',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '放款金额',
  `lending_date` timestamp NULL DEFAULT NULL COMMENT '放款日期',
  `term` int(11) DEFAULT NULL COMMENT '总期数',
  `current_term` int(11) DEFAULT NULL COMMENT '当前期数',
  `loan_balance` decimal(10,2) DEFAULT NULL COMMENT '贷款余额',
  `auth_amt` decimal(10,2) DEFAULT NULL COMMENT '授权金额',
  `optimal_repayment_amt` decimal(10,2) DEFAULT NULL COMMENT '昨日最优还款额',
  `card_balance` decimal(10,2) DEFAULT NULL COMMENT '卡片余额',
  `monthly_repayment` decimal(10,2) DEFAULT NULL COMMENT '月还款额',
  `booked_amt` decimal(10,2) DEFAULT NULL COMMENT '已入账金额',
  `unpayment_principal` decimal(10,2) DEFAULT NULL COMMENT '未还本金',
  `unpayment_charge` decimal(10,2) DEFAULT NULL COMMENT '未还利息',
  `last_overdue_date` timestamp NULL DEFAULT NULL COMMENT '最近逾期日期',
  `last_penalty_date` timestamp NULL DEFAULT NULL COMMENT '滞纳金最后交付日期',
  `sum_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `con_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `batch_status` int(11) DEFAULT '0' COMMENT '跑批状态 0 未跑批 1 已跑批',
  PRIMARY KEY (`project_id`),
  KEY `project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_document
-- ----------------------------
DROP TABLE IF EXISTS `loan_document`;
CREATE TABLE `loan_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `object_type` varchar(50) NOT NULL COMMENT '业务类型',
  `object_no` bigint(20) NOT NULL COMMENT '申请主键',
  `dir_id` bigint(20) NOT NULL COMMENT '贷款文档编号',
  `file_type` varchar(10) DEFAULT NULL COMMENT '文档类型（1：图片，2：视频，3：pdf，4：word）',
  `file_name` varchar(200) DEFAULT NULL COMMENT '文件名称',
  `file_size` decimal(18,2) DEFAULT '0.00' COMMENT '文件大小（kb）',
  `file_format` varchar(20) DEFAULT NULL COMMENT '文件格式',
  `file_path` varchar(300) DEFAULT NULL COMMENT '上传路径',
  `file_down_load_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '文件下载状态（0：待下载 1：下载成功 2：下载失败 3：文件不符合规范）',
  `file_id` varchar(64) NOT NULL DEFAULT '' COMMENT '网关传递过来的文件id',
  `thumb_file` varchar(250) DEFAULT NULL COMMENT '上传路径',
  `photograph_longitude` decimal(20,15) DEFAULT NULL COMMENT '拍摄地址经度坐标',
  `photograph_latitude` decimal(20,15) DEFAULT NULL COMMENT '拍摄纬度坐标',
  `photograph_time` varchar(50) DEFAULT NULL COMMENT '拍摄时间',
  `is_inuse` int(1) DEFAULT NULL COMMENT '使用启用（1：启用2：停用）',
  `user_id` bigint(20) DEFAULT NULL COMMENT '上传用户编号',
  `user_name` varchar(30) DEFAULT NULL COMMENT '上传用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '上传机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '上传机构编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `modify_realname` varchar(255) DEFAULT NULL COMMENT '删除人姓名',
  `modify_uid` bigint(20) DEFAULT NULL COMMENT '删除人uid',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `client_serial_num` varchar(100) DEFAULT NULL COMMENT '设备号',
  `flag` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`,`create_time`),
  KEY `idx_object_type_object_no` (`object_type`,`object_no`) USING BTREE,
  KEY `idx_file_id` (`file_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=986929 DEFAULT CHARSET=utf8 COMMENT='贷款文档管理表'
/*!50100 PARTITION BY RANGE (to_days(create_time))
(PARTITION loan_document_2017_08 VALUES LESS THAN (736938) ENGINE = InnoDB,
 PARTITION loan_document_2017_09 VALUES LESS THAN (736968) ENGINE = InnoDB,
 PARTITION loan_document_2017_10 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION loan_document_2017_11 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION loan_document_2017_12 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION loan_document_2018_01 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION loan_document_2018_02 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION loan_document_2018_03 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION loan_document_2018_04 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION loan_document_2018_05 VALUES LESS THAN (737211) ENGINE = InnoDB,
 PARTITION loan_document_2018_06 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION loan_document_2018_07 VALUES LESS THAN (737272) ENGINE = InnoDB,
 PARTITION loan_document_2018_08 VALUES LESS THAN (737303) ENGINE = InnoDB,
 PARTITION loan_document_2018_09 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION loan_document_2018_10 VALUES LESS THAN (737364) ENGINE = InnoDB,
 PARTITION loan_document_2018_11 VALUES LESS THAN (737394) ENGINE = InnoDB,
 PARTITION loan_document_2018_12 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION loan_document_2019_01 VALUES LESS THAN (737456) ENGINE = InnoDB,
 PARTITION loan_document_2019_02 VALUES LESS THAN (737484) ENGINE = InnoDB,
 PARTITION loan_document_2019_03 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION loan_document_2019_04 VALUES LESS THAN (737545) ENGINE = InnoDB,
 PARTITION loan_document_2019_05 VALUES LESS THAN (737576) ENGINE = InnoDB,
 PARTITION loan_document_2019_06 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION loan_document_2019_07 VALUES LESS THAN (737637) ENGINE = InnoDB,
 PARTITION loan_document_2019_08 VALUES LESS THAN (737668) ENGINE = InnoDB,
 PARTITION loan_document_2019_09 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION loan_document_2019_10 VALUES LESS THAN (737729) ENGINE = InnoDB,
 PARTITION loan_document_2019_11 VALUES LESS THAN (737759) ENGINE = InnoDB,
 PARTITION loan_document_2019_12 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION loan_document_2020_01 VALUES LESS THAN (737821) ENGINE = InnoDB,
 PARTITION loan_document_2020_02 VALUES LESS THAN (737850) ENGINE = InnoDB,
 PARTITION loan_document_2020_03 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION loan_document_2020_04 VALUES LESS THAN (737911) ENGINE = InnoDB,
 PARTITION loan_document_2020_05 VALUES LESS THAN (737942) ENGINE = InnoDB,
 PARTITION loan_document_2020_06 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION loan_document_2020_07 VALUES LESS THAN (738003) ENGINE = InnoDB,
 PARTITION loan_document_2020_08 VALUES LESS THAN (738034) ENGINE = InnoDB,
 PARTITION loan_document_2020_09 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION loan_document_2020_10 VALUES LESS THAN (738095) ENGINE = InnoDB,
 PARTITION loan_document_2020_11 VALUES LESS THAN (738125) ENGINE = InnoDB,
 PARTITION loan_document_2020_12 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION loan_document_2021_01 VALUES LESS THAN (738187) ENGINE = InnoDB,
 PARTITION loan_document_2021_02 VALUES LESS THAN (738215) ENGINE = InnoDB,
 PARTITION loan_document_2021_03 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION loan_document_2021_04 VALUES LESS THAN (738276) ENGINE = InnoDB,
 PARTITION loan_document_2021_05 VALUES LESS THAN (738307) ENGINE = InnoDB,
 PARTITION loan_document_2021_06 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION loan_document_2021_07 VALUES LESS THAN (738368) ENGINE = InnoDB,
 PARTITION loan_document_2021_08 VALUES LESS THAN (738399) ENGINE = InnoDB,
 PARTITION loan_document_2021_09 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION loan_document_2021_10 VALUES LESS THAN (738460) ENGINE = InnoDB,
 PARTITION loan_document_2021_11 VALUES LESS THAN (738490) ENGINE = InnoDB,
 PARTITION loan_document_2021_12 VALUES LESS THAN (738521) ENGINE = InnoDB,
 PARTITION loan_document_2022 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for loan_document_dir
-- ----------------------------
DROP TABLE IF EXISTS `loan_document_dir`;
CREATE TABLE `loan_document_dir` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(40) DEFAULT NULL COMMENT '目录code',
  `directory_path` varchar(900) DEFAULT NULL COMMENT '目录名称',
  `directory_full_name` varchar(255) DEFAULT NULL COMMENT '多媒体资料全称',
  `parent_dic_id` bigint(20) DEFAULT NULL COMMENT '上级目录id',
  `object_type` varchar(300) DEFAULT NULL COMMENT '业务类型',
  `dir_class` varchar(150) DEFAULT NULL COMMENT '目录分类（1：电子签约资料，2：书面签约资料，3：汽车消费分期资料，4：二手车评估报告，0：其他）',
  `doc_type` varchar(30) DEFAULT NULL COMMENT '目录存放的文件类型（1：图片，2：视频，3：pdf，4：word）',
  `max_file_limit` int(11) DEFAULT NULL COMMENT '最大文件数量限制',
  `max_size_per_file` int(4) DEFAULT NULL COMMENT '单个文件大小限制，单位M',
  `can_supply` tinyint(4) DEFAULT NULL COMMENT '是否可补件：1是；0否',
  `sort` int(10) DEFAULT NULL,
  `is_inuse` tinyint(1) DEFAULT NULL COMMENT '是否可用:1是，0否',
  `chk_disabled` tinyint(1) DEFAULT NULL COMMENT '是否可编辑（1:是，0:否）',
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_parent_dic_id` (`parent_dic_id`) USING BTREE,
  KEY `idx_object_type` (`object_type`) USING BTREE,
  KEY `idx_code` (`code`) USING BTREE,
  KEY `idx_is_inuse` (`is_inuse`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_document_dir_flow
-- ----------------------------
DROP TABLE IF EXISTS `loan_document_dir_flow`;
CREATE TABLE `loan_document_dir_flow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flow_type` varchar(150) DEFAULT NULL COMMENT '流程名',
  `node_code` varchar(150) DEFAULT NULL COMMENT '节点code码',
  `dir_id` bigint(20) DEFAULT NULL COMMENT '目录id',
  `can_upload` int(1) DEFAULT NULL COMMENT '是否能上传：1是0否',
  `can_download` int(1) DEFAULT NULL COMMENT '是否能下载：1是，0否',
  `can_delete` int(1) DEFAULT NULL COMMENT '是否能删除:1是0否',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否可用：1是0否',
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_flow_type_node_code` (`flow_type`,`node_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2337 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_document_query_his
-- ----------------------------
DROP TABLE IF EXISTS `loan_document_query_his`;
CREATE TABLE `loan_document_query_his` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `flow_task_id` bigint(20) DEFAULT NULL COMMENT '申请主键',
  `flow_type` varchar(30) DEFAULT NULL COMMENT '流程类型',
  `node_key` varchar(50) DEFAULT NULL COMMENT '节点编号',
  `apply_id` bigint(20) DEFAULT NULL COMMENT '申请主键',
  `dir_id` bigint(20) DEFAULT NULL COMMENT '贷款文档编号',
  `doc_id` bigint(20) DEFAULT NULL COMMENT '贷款文档编号',
  `operator_id` bigint(11) DEFAULT NULL COMMENT '操作人外键',
  `operator_name` varchar(20) DEFAULT NULL COMMENT '操作人姓名',
  `is_read` int(1) DEFAULT NULL COMMENT '是否阅读',
  `read_count` int(10) DEFAULT NULL COMMENT '是否阅读',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_dir_id_doc_id` (`dir_id`,`doc_id`) USING BTREE,
  KEY `idx_apply_id_operator_id` (`apply_id`,`operator_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9502 DEFAULT CHARSET=utf8 COMMENT='贷款文档阅读历史记录表';

-- ----------------------------
-- Table structure for loan_document_usage
-- ----------------------------
DROP TABLE IF EXISTS `loan_document_usage`;
CREATE TABLE `loan_document_usage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表Id',
  `project_id` bigint(20) NOT NULL COMMENT '贷款Id',
  `loan_document_id` bigint(20) NOT NULL COMMENT '贷款文档管理表',
  `identification` varchar(32) DEFAULT NULL COMMENT '文件标识：存合同模板编号',
  `biz_type` varchar(32) DEFAULT NULL COMMENT '业务类型',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='多媒体文件用途表';

-- ----------------------------
-- Table structure for loan_fee_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_fee_info`;
CREATE TABLE `loan_fee_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贷款费用信息Id',
  `project_id` bigint(20) NOT NULL COMMENT '贷款Id',
  `loan_amount` decimal(12,4) DEFAULT NULL COMMENT '贷款分期金额(元)',
  `loan_amount_handing_fee` decimal(12,4) DEFAULT NULL COMMENT '贷款金额分期手续费(元)',
  `extra_loan_amount` decimal(12,4) DEFAULT NULL COMMENT '专项贷金额(元)',
  `extra_loan_amount_handing_fee` decimal(12,4) DEFAULT NULL COMMENT '附加贷款金额分期手续费(元)',
  `total_loan_amount` decimal(12,4) DEFAULT NULL COMMENT '贷款总额(元)= (主)贷款分期金额(元)（loan_amount）+ 专项贷金额(元)（）',
  `total_loan_amount_handing_fee` decimal(12,4) DEFAULT NULL COMMENT '贷款总金额分期手续费(元)',
  `other_loan_fee` decimal(12,4) DEFAULT NULL COMMENT '其他贷款费用(元)',
  `total_loan_fee` decimal(12,4) DEFAULT NULL COMMENT '贷款总费用(元）',
  `loan_term` varchar(4) DEFAULT NULL COMMENT '贷款期数(月)',
  `loan_handing_fee_rate` decimal(8,4) DEFAULT NULL COMMENT '利率(%)',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `extra_repayment` decimal(12,4) DEFAULT NULL COMMENT '附加贷应还总额(元）=  银行附加贷放款金额(元)* （1+利率(%)））',
  `loan_repayment` decimal(12,4) DEFAULT NULL COMMENT '(主)贷款应还总额(元）= 银行(主)贷款放款金额(元)* （1+利率(%)））',
  `total_repayment` decimal(12,4) DEFAULT NULL COMMENT '放款总额：车贷放款金额+附加贷放款金额',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59286 DEFAULT CHARSET=utf8 COMMENT='贷款费用信息表，用于记录贷款最基础的费用信息';

-- ----------------------------
-- Table structure for loan_icbc_files
-- ----------------------------
DROP TABLE IF EXISTS `loan_icbc_files`;
CREATE TABLE `loan_icbc_files` (
  `file_key` varchar(64) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL COMMENT '文件目录',
  `file_type` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `update_date_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`file_key`),
  KEY `idx_lif_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_info_report
-- ----------------------------
DROP TABLE IF EXISTS `loan_info_report`;
CREATE TABLE `loan_info_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `loan_info_project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `loan_info_project_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `loan_info_cooperation_bank` varchar(255) DEFAULT NULL COMMENT '合作银行',
  `loan_info_business_type` int(4) DEFAULT NULL COMMENT '业务品种 1：信用卡贷款（普通模式），2：信用卡贷款（银行直销），3：个人消费贷款',
  `loan_info_financial_product` varchar(255) DEFAULT NULL COMMENT '金融产品',
  `loan_info_ammount` decimal(24,6) DEFAULT NULL COMMENT '贷款金额',
  `loan_info_years` int(4) DEFAULT NULL COMMENT '期限 1：12个月，2：18个月，3：24个月，4：36个月',
  `loan_info_interest_rate` decimal(24,6) DEFAULT NULL COMMENT '利率',
  `loan_customer_manager_uid` bigint(20) DEFAULT NULL COMMENT '客户经理uid',
  `loan_customer_manager_realname` varchar(255) DEFAULT NULL COMMENT '客户经理姓名',
  `loan_region_manager_uid` bigint(20) DEFAULT NULL COMMENT '区域经理uid',
  `loan_region_manger_realname` varchar(255) DEFAULT NULL COMMENT '区域经理姓名',
  `loan_risk_manager_uid` bigint(20) DEFAULT NULL COMMENT '风险经理uid',
  `loan_risk_manager_realname` varchar(255) DEFAULT NULL COMMENT '风险经理姓名',
  `loan_branch_company_id` bigint(20) DEFAULT NULL COMMENT '机构id',
  `loan_branch_company_name` varchar(255) DEFAULT NULL COMMENT '机构名称',
  `loan_business_group_id` bigint(20) DEFAULT NULL COMMENT '业务组id',
  `loan_business_group_name` varchar(255) DEFAULT NULL COMMENT '业务组名称',
  `customer_info_realname` varchar(255) DEFAULT NULL COMMENT '客户姓名',
  `customer_info_card_no` varchar(255) DEFAULT NULL COMMENT '身份证号码',
  `customer_info_phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `timeline_loan_launch` date DEFAULT NULL COMMENT '贷款发起日期',
  `timeline_loan_sign` datetime DEFAULT NULL COMMENT '签单日期',
  `timeline_company_pay` date DEFAULT NULL COMMENT '公司付款日期',
  `timeline_bank_pay` date DEFAULT NULL COMMENT '银行放款日期',
  `timeline_document_transfer` date DEFAULT NULL COMMENT '签单移交审核日期',
  `timeline_document_audit` date DEFAULT NULL COMMENT '审核移交抄写日期',
  `timeline_document_copy` date DEFAULT NULL COMMENT '抄写移交复核日期',
  `timeline_document_check` date DEFAULT NULL COMMENT '复核移交归档日期',
  `timeline_document_archive` date DEFAULT NULL COMMENT '档案归档日期',
  `timeline_contract_send` date DEFAULT NULL COMMENT '合同移交银行发件日期',
  `timeline_contract_receive` date DEFAULT NULL COMMENT '驻行内勤收件日期',
  `timeline_license_plate` date DEFAULT NULL COMMENT '上牌日期',
  `timeline_plege` date DEFAULT NULL COMMENT '抵押日期',
  `loan_car_type` int(4) DEFAULT NULL COMMENT '汽车类型 1:新车，2：二手车',
  `loan_car_brand_info` varchar(255) DEFAULT NULL COMMENT '汽车品牌+车系+车型',
  `loan_car_plate_no` varchar(255) DEFAULT NULL COMMENT '车牌号码',
  `loan_fee_initial_payment` decimal(24,6) DEFAULT NULL COMMENT '首付款',
  `loan_fee_initial_payment_percentage` decimal(24,6) DEFAULT NULL COMMENT '首付比例',
  `loan_fee_official_price` decimal(24,6) DEFAULT NULL COMMENT '开票价',
  `loan_fee_company_payment` decimal(24,6) DEFAULT NULL COMMENT '公司付款金额',
  `loan_fee_bank_payment` decimal(24,6) DEFAULT NULL COMMENT '银行放款金额',
  `loan_fee_initial_premium` decimal(24,6) DEFAULT NULL COMMENT '首年保费',
  `loan_fee_assurance_risk_payment` decimal(24,6) DEFAULT NULL COMMENT '担保风险金',
  `loan_fee_gps_amount` int(4) DEFAULT NULL COMMENT 'GPS台数',
  `loan_fee_gps_install` decimal(24,6) DEFAULT NULL COMMENT 'GPS安装费',
  `loan_fee_service` decimal(24,6) DEFAULT NULL COMMENT '服务费',
  `loan_fee_pb_deposit` decimal(24,6) DEFAULT NULL COMMENT '履约保证金',
  `loan_fee_other` decimal(24,6) DEFAULT NULL COMMENT '其他费用',
  `loan_fee_total` decimal(24,6) DEFAULT NULL COMMENT '费用合计',
  `car_dealer_company` varchar(255) DEFAULT NULL COMMENT '车行',
  `car_dealer_reward_percentage` decimal(24,6) DEFAULT NULL COMMENT '车行返点',
  `car_dealer_sales_percentage` decimal(24,6) DEFAULT NULL COMMENT '销售团队返点',
  `car_dealer_fixed_percentage` decimal(24,6) DEFAULT NULL COMMENT '定额返点',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `flow_type` varchar(30) DEFAULT NULL COMMENT '流程类型',
  `node_key` varchar(50) DEFAULT NULL COMMENT '节点编号',
  `task_create_time` datetime DEFAULT NULL COMMENT '创建时间，即：流转到当前节点的时间',
  `task_deal_user_id` bigint(11) NOT NULL COMMENT '当前处理人id',
  `task_deal_user_realname` varchar(20) NOT NULL COMMENT '当前处理人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `loan_info_address_pid` varchar(10) DEFAULT NULL COMMENT '地址省ID',
  `loan_info_address_pname` varchar(50) DEFAULT NULL COMMENT '地址省名称',
  `loan_info_address_cid` varchar(10) DEFAULT NULL COMMENT '地址市ID',
  `loan_info_address_cname` varchar(50) DEFAULT NULL COMMENT '地址市名称',
  `loan_info_address_rid` varchar(10) DEFAULT NULL COMMENT '地址区ID',
  `loan_info_address_rname` varchar(50) DEFAULT NULL COMMENT '地址区名称',
  `loan_info_status` int(10) DEFAULT NULL COMMENT '贷款状态(1:拒绝，2：通过，3：审核中)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='贷款统计信息总表';

-- ----------------------------
-- Table structure for loan_insurance_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_insurance_info`;
CREATE TABLE `loan_insurance_info` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `insurance_no` varchar(40) DEFAULT NULL COMMENT '保单编号',
  `insurance_company_id` bigint(11) DEFAULT NULL COMMENT '保险公司ID',
  `insurance_company_name` varchar(45) NOT NULL COMMENT '保险公司名称',
  `insurance_type_key` varchar(20) NOT NULL COMMENT '险种类型',
  `insurance_type_name` varchar(20) NOT NULL COMMENT '险种类型名称',
  `insurance_start_time` datetime DEFAULT NULL COMMENT '保险开始时间',
  `insurance_end_time` datetime DEFAULT NULL COMMENT '保险结束时间',
  `insurance_fee_total` decimal(24,4) DEFAULT NULL COMMENT '保费合计',
  `insurance_status` int(1) DEFAULT NULL COMMENT '保险状态（1 : 公司；2 ： 车行；3  ： 客户）',
  `remark` varchar(256) NOT NULL COMMENT '备注',
  `creator` varchar(20) NOT NULL COMMENT '登记人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '险种状态（0:已删除，1:正常）',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行',
  `orgnaization_people` varchar(255) DEFAULT NULL COMMENT '保单经办人',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  KEY `IDX_PROJECT_ID` (`project_id`),
  KEY `loan_insurance_info_insurance_company_id` (`insurance_company_id`),
  KEY `loan_insurance_info_sys_type` (`sys_type`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='项目保单表';

-- ----------------------------
-- Table structure for loan_insurance_info_detail
-- ----------------------------
DROP TABLE IF EXISTS `loan_insurance_info_detail`;
CREATE TABLE `loan_insurance_info_detail` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `loan_insurance_id` bigint(11) DEFAULT NULL COMMENT '项目保单表ID',
  `insurance_type_id` bigint(11) DEFAULT NULL COMMENT '险种ID',
  `insurance_type_name` varchar(20) NOT NULL COMMENT '险种名称',
  `insurance_fee` decimal(24,4) DEFAULT NULL COMMENT '保费',
  `insurance_status` int(1) DEFAULT NULL COMMENT '保险状态',
  `creator` varchar(20) DEFAULT NULL COMMENT '登记人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `insurance_money` decimal(10,2) DEFAULT NULL COMMENT '保额',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `type_config_id` bigint(20) DEFAULT NULL COMMENT '险种配置表自定义ID',
  PRIMARY KEY (`id`),
  KEY `IDX_LOAN_INSURANCE_ID` (`loan_insurance_id`) USING BTREE,
  KEY `index_insurance_type_id` (`insurance_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COMMENT='项目保单明细表';

-- ----------------------------
-- Table structure for loan_insurance_renewal_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_insurance_renewal_info`;
CREATE TABLE `loan_insurance_renewal_info` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `insurance_company_id` bigint(20) NOT NULL COMMENT '保险公司ID',
  `insurance_company_name` varchar(45) NOT NULL COMMENT '保险公司名称',
  `insurance_type_key` varchar(20) NOT NULL COMMENT '险种类型',
  `insurance_type_name` varchar(20) NOT NULL COMMENT '险种类型名称',
  `insurance_no` varchar(40) DEFAULT NULL COMMENT '保险单号',
  `insurance_fee_total` decimal(10,2) DEFAULT NULL,
  `insurance_start_time` datetime DEFAULT NULL COMMENT '保险开始时间',
  `insurance_end_time` datetime DEFAULT NULL COMMENT '保险结束时间',
  `bank_name` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT NULL COMMENT '区分首保续保（status！=null 是首保   否则是续保）',
  `insurance_status` int(1) DEFAULT NULL COMMENT '保险状态(首保) 1：公司 2：车行 3：客户',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `orgnaization_people` varchar(20) DEFAULT NULL COMMENT '保单经办人',
  `user_name` varchar(20) NOT NULL COMMENT '登记人',
  `cav_status` int(1) NOT NULL DEFAULT '2' COMMENT '1:已核销, 2:未核销, 3: 已退单',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_valid` int(1) DEFAULT NULL COMMENT '是否有效（0 ：已删除；1 ： 正常）',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `user_id` int(11) DEFAULT NULL COMMENT '登记人ID',
  PRIMARY KEY (`id`),
  KEY `IDX_PROJECT_ID` (`project_id`),
  KEY `index_insurance_company_id` (`insurance_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='项目保单表';

-- ----------------------------
-- Table structure for loan_insurance_renewal_info_detail
-- ----------------------------
DROP TABLE IF EXISTS `loan_insurance_renewal_info_detail`;
CREATE TABLE `loan_insurance_renewal_info_detail` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键，数据库自动增长序列',
  `loan_insurance_id` bigint(11) DEFAULT NULL COMMENT '项目保单表ID',
  `insurance_type_id` bigint(11) DEFAULT NULL COMMENT '险种ID',
  `insurance_type_name` varchar(20) NOT NULL COMMENT '险种名称',
  `insurance_fee` decimal(10,2) DEFAULT NULL,
  `insurance_money` decimal(10,2) DEFAULT NULL COMMENT '保额',
  `user_name` varchar(20) DEFAULT NULL COMMENT '登记人',
  `sys_type` varchar(255) DEFAULT NULL COMMENT '系统标识',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `type_config_id` bigint(20) DEFAULT NULL COMMENT '险种配置表ID',
  PRIMARY KEY (`id`),
  KEY `IDX_LOAN_INSURANCE_ID` (`loan_insurance_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='项目保单险种明细表';

-- ----------------------------
-- Table structure for loan_insurance_renewal_info_phone
-- ----------------------------
DROP TABLE IF EXISTS `loan_insurance_renewal_info_phone`;
CREATE TABLE `loan_insurance_renewal_info_phone` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(11) DEFAULT NULL COMMENT '贷款id',
  `phone_object` int(1) DEFAULT NULL COMMENT '联系对象 0:本人  1：配偶',
  `phone_name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `note` varchar(255) DEFAULT NULL COMMENT '情况描述',
  `phone_result` int(1) DEFAULT NULL COMMENT '联系结果 0:客户已保 1：车行已保 2：无法接通 3：待跟进  4：无法沟通 5：同意续保  ',
  `user_name` varchar(20) DEFAULT NULL COMMENT '经办人',
  `orgnaization_time` datetime DEFAULT NULL COMMENT '经办时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `user_id` int(11) DEFAULT NULL COMMENT '登记人ID',
  PRIMARY KEY (`id`),
  KEY `index_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='续保电话记录';

-- ----------------------------
-- Table structure for loan_overdue_contract_repay_plan
-- ----------------------------
DROP TABLE IF EXISTS `loan_overdue_contract_repay_plan`;
CREATE TABLE `loan_overdue_contract_repay_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `contract_id` bigint(20) NOT NULL COMMENT '合同主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `plan_no` bigint(20) DEFAULT NULL COMMENT '期数',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `being_amount` decimal(24,4) DEFAULT NULL COMMENT '期初余额',
  `repay_amount` decimal(24,4) DEFAULT NULL COMMENT '本期还款',
  `discount_amount` decimal(24,4) DEFAULT NULL COMMENT '贴息金额',
  `end_amount` decimal(24,4) DEFAULT NULL COMMENT '期末余额',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `current_term_principle` decimal(24,6) DEFAULT NULL COMMENT '本期本金',
  `current_term_interest` decimal(24,6) DEFAULT NULL COMMENT '本期利息(2016-07-30转义为贷款余额)',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '逾期总额(2016-06-27后用比较金额来替代)',
  `last_overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '最后的逾期金额',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `last_repayment_date` date DEFAULT NULL COMMENT '最近还款日期',
  `current_bank_repayment_time` datetime DEFAULT NULL COMMENT '当前银行还款日',
  `import_date` date DEFAULT NULL COMMENT '导入日期',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `INDEX_CONTRACT_ID` (`contract_id`),
  KEY `idx_mtime` (`modify_time`),
  KEY `idx_project_id_plan_no` (`project_id`,`plan_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同还款计划表';

-- ----------------------------
-- Table structure for loan_overdue_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_overdue_info`;
CREATE TABLE `loan_overdue_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `mobile_phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名称',
  `launch_org_id` bigint(20) DEFAULT NULL COMMENT '贷款发起机构ID',
  `launch_org_name` varchar(100) DEFAULT NULL COMMENT '贷款发起机构Name',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '用户组ID',
  `user_group_name` varchar(255) DEFAULT NULL COMMENT '用户组名称',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人ID',
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '贷款发起人NAME',
  `plate_no` varchar(20) DEFAULT NULL COMMENT '车牌号码',
  `repayment_card_no` varchar(255) DEFAULT NULL COMMENT '还款卡号',
  `current_plan_no` bigint(20) DEFAULT NULL COMMENT '当前期数',
  `current_plan_repay_amount` date DEFAULT NULL COMMENT '当前期数还款额',
  `current_bank_repayment_time` datetime DEFAULT NULL COMMENT '当前银行还款日',
  `advance_count` int(11) DEFAULT '0' COMMENT '垫款次数',
  `advance_balance_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '垫款余额',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `current_term_principle` decimal(24,6) DEFAULT NULL COMMENT '本期本金',
  `current_term_interest` decimal(24,6) DEFAULT NULL COMMENT '本期利息(2016-07-30转义为贷款余额)',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '逾期总额(2016-06-27后用比较金额来替代)',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `last_repayment_date` date DEFAULT NULL COMMENT '最近还款日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_settled` tinyint(1) DEFAULT '0' COMMENT '0:未结清，1:已结清。',
  `flag_status` int(1) DEFAULT '2' COMMENT '标记状态 1：当前逾期 2:历史逾期',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `open_staff_id` bigint(20) DEFAULT NULL COMMENT '外勤人员id',
  `open_staff_name` varchar(50) DEFAULT NULL COMMENT '外勤人员name',
  `overdue_status` varchar(255) DEFAULT NULL,
  `total_term_num` int(11) DEFAULT NULL,
  `loan_left_amt` decimal(50,0) DEFAULT NULL,
  `bank_payment_date` datetime DEFAULT NULL,
  `bill_date` varchar(10) DEFAULT NULL COMMENT '账单日期',
  `overdue_days` int(2) DEFAULT NULL,
  `account_balance` decimal(10,0) DEFAULT NULL,
  `bank_overdue_status` tinyint(4) DEFAULT NULL,
  `cal_overdue_status` tinyint(4) DEFAULT NULL,
  `overdue_amt_rate` decimal(5,2) DEFAULT NULL COMMENT '比较金额/月供',
  `history_term` tinyint(1) DEFAULT '0',
  `is_petition` tinyint(1) DEFAULT '0' COMMENT '0:未分配上访，1:已分配上访',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mtime` (`modify_time`) USING BTREE,
  KEY `loan_overdu_info_project_id` (`project_id`) USING BTREE,
  KEY `idx_history` (`history_term`) USING BTREE,
  KEY `loan_overdu_info_current_no` (`current_plan_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=550033 DEFAULT CHARSET=utf8 COMMENT='贷款逾期数据记录表';

-- ----------------------------
-- Table structure for loan_overdue_info_copy
-- ----------------------------
DROP TABLE IF EXISTS `loan_overdue_info_copy`;
CREATE TABLE `loan_overdue_info_copy` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `mobile_phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名称',
  `launch_org_id` bigint(20) DEFAULT NULL COMMENT '贷款发起机构ID',
  `launch_org_name` varchar(100) DEFAULT NULL COMMENT '贷款发起机构Name',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '用户组ID',
  `user_group_name` varchar(255) DEFAULT NULL COMMENT '用户组名称',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人ID',
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '贷款发起人NAME',
  `plate_no` varchar(20) DEFAULT NULL COMMENT '车牌号码',
  `repayment_card_no` varchar(255) DEFAULT NULL COMMENT '还款卡号',
  `current_plan_no` bigint(20) DEFAULT NULL COMMENT '当前期数',
  `current_plan_repay_amount` date DEFAULT NULL COMMENT '当前期数还款额',
  `current_bank_repayment_time` datetime DEFAULT NULL COMMENT '当前银行还款日',
  `advance_count` int(11) DEFAULT '0' COMMENT '垫款次数',
  `advance_balance_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '垫款余额',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `current_term_principle` decimal(24,6) DEFAULT NULL COMMENT '本期本金',
  `current_term_interest` decimal(24,6) DEFAULT NULL COMMENT '本期利息(2016-07-30转义为贷款余额)',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '逾期总额(2016-06-27后用比较金额来替代)',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `last_repayment_date` date DEFAULT NULL COMMENT '最近还款日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_settled` tinyint(1) DEFAULT '0' COMMENT '0:未结清，1:已结清。',
  `flag_status` int(1) DEFAULT '2' COMMENT '标记状态 1：当前逾期 2:历史逾期',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `open_staff_id` bigint(20) DEFAULT NULL COMMENT '外勤人员id',
  `open_staff_name` varchar(50) DEFAULT NULL COMMENT '外勤人员name',
  `overdue_status` varchar(255) DEFAULT NULL,
  `total_term_num` int(11) DEFAULT NULL,
  `loan_left_amt` decimal(50,0) DEFAULT NULL,
  `bank_payment_date` datetime DEFAULT NULL,
  `overdue_days` int(11) DEFAULT NULL,
  `account_balance` decimal(10,0) DEFAULT NULL,
  `bank_overdue_status` tinyint(1) DEFAULT NULL,
  `cal_overdue_status` tinyint(1) DEFAULT NULL,
  `overdue_amt_rate` decimal(5,2) DEFAULT NULL COMMENT '比较金额/月供',
  `history_term` tinyint(1) DEFAULT '0',
  `suit_no` varchar(255) DEFAULT NULL COMMENT '诉讼申请编号',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_history` (`history_term`)
) ENGINE=InnoDB AUTO_INCREMENT=56823 DEFAULT CHARSET=utf8 COMMENT='贷款逾期数据记录表';

-- ----------------------------
-- Table structure for loan_overdue_info_rpt
-- ----------------------------
DROP TABLE IF EXISTS `loan_overdue_info_rpt`;
CREATE TABLE `loan_overdue_info_rpt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(255) NOT NULL COMMENT '项目编号',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `mobile_phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(255) DEFAULT NULL COMMENT '合作银行名称',
  `launch_org_id` bigint(20) DEFAULT NULL COMMENT '贷款发起机构ID',
  `launch_org_name` varchar(100) DEFAULT NULL COMMENT '贷款发起机构Name',
  `user_group_id` bigint(20) DEFAULT NULL COMMENT '用户组ID',
  `user_group_name` varchar(255) DEFAULT NULL COMMENT '用户组名称',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人ID',
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '贷款发起人NAME',
  `plate_no` varchar(20) DEFAULT NULL COMMENT '车牌号码',
  `repayment_card_no` varchar(255) DEFAULT NULL COMMENT '还款卡号',
  `current_plan_no` bigint(20) DEFAULT NULL COMMENT '当前期数',
  `current_plan_repay_amount` date DEFAULT NULL COMMENT '当前期数还款额',
  `current_bank_repayment_time` datetime DEFAULT NULL COMMENT '当前银行还款日',
  `advance_count` int(11) DEFAULT '0' COMMENT '垫款次数',
  `advance_balance_amount` decimal(24,6) DEFAULT '0.000000' COMMENT '垫款余额',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `current_term_principle` decimal(24,6) DEFAULT NULL COMMENT '本期本金',
  `current_term_interest` decimal(24,6) DEFAULT NULL COMMENT '本期利息(2016-07-30转义为贷款余额)',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '逾期总额(2016-06-27后用比较金额来替代)',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `last_repayment_date` date DEFAULT NULL COMMENT '最近还款日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_settled` tinyint(1) DEFAULT '0' COMMENT '0:未结清，1:已结清。',
  `flag_status` int(1) DEFAULT '2' COMMENT '标记状态 1：当前逾期 2:历史逾期',
  `old_id` varchar(50) DEFAULT NULL COMMENT '旧主键',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `open_staff_id` bigint(20) DEFAULT NULL COMMENT '外勤人员id',
  `open_staff_name` varchar(50) DEFAULT NULL COMMENT '外勤人员name',
  `overdue_status` varchar(255) DEFAULT NULL,
  `total_term_num` int(11) DEFAULT NULL COMMENT '总期数',
  `loan_left_amt` decimal(50,0) DEFAULT NULL COMMENT '贷款余额',
  `bank_payment_date` datetime DEFAULT NULL,
  `bill_date` varchar(10) DEFAULT NULL COMMENT '账单日期',
  `overdue_days` int(2) DEFAULT NULL,
  `account_balance` decimal(10,0) DEFAULT NULL,
  `bank_overdue_status` tinyint(4) DEFAULT NULL,
  `cal_overdue_status` tinyint(4) DEFAULT NULL,
  `overdue_amt_rate` decimal(5,2) DEFAULT NULL COMMENT '比较金额/月供',
  `history_term` tinyint(1) DEFAULT '0',
  `is_petition` tinyint(1) DEFAULT '0' COMMENT '0:未分配上访，1:已分配上访',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '放款金额',
  `auth_amt` decimal(10,2) DEFAULT NULL COMMENT '授权金额',
  `booked_amt` decimal(10,2) DEFAULT NULL COMMENT '已入账金额',
  `unpayment_principal` decimal(10,2) DEFAULT NULL COMMENT '未还本金',
  `unpayment_charge` decimal(10,2) DEFAULT NULL COMMENT '未还利息',
  `last_overdue_date` timestamp NULL DEFAULT NULL COMMENT '最近逾期日期',
  `last_penalty_date` timestamp NULL DEFAULT NULL COMMENT '滞纳金最后交付日期',
  `product_id` int(10) DEFAULT NULL COMMENT '金融产品ID',
  `product_name` varchar(100) DEFAULT NULL COMMENT '金融产品Name',
  `car_info` varchar(255) DEFAULT NULL COMMENT '汽车信息',
  `car_type` varchar(10) DEFAULT NULL COMMENT '汽车类型（1：新车，2：二手车）',
  `main_signer_id` bigint(20) DEFAULT NULL COMMENT '风险经理id',
  `main_signer_name` varchar(50) DEFAULT NULL COMMENT '风险经理',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '车行id',
  `dealer_name` varchar(100) DEFAULT NULL COMMENT '车行名称',
  `home_address` varchar(255) DEFAULT NULL COMMENT '家庭详细地址',
  `is_discount` int(1) DEFAULT '2' COMMENT '是否贴息(1:是，2:否)',
  `notice_periodpayment_capital` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期偿还本金',
  `notice_periodpayment_interest` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期利息',
  `interest_start_date` date DEFAULT NULL COMMENT '开始息日',
  `etl_date` date DEFAULT NULL COMMENT '数据日期',
  PRIMARY KEY (`id`,`project_id`),
  KEY `loi_project_id` (`project_id`) USING BTREE,
  KEY `idx_launch_org_id` (`launch_org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=125732 DEFAULT CHARSET=utf8 COMMENT='贷款逾期数据报表';

-- ----------------------------
-- Table structure for loan_overdue_load_his
-- ----------------------------
DROP TABLE IF EXISTS `loan_overdue_load_his`;
CREATE TABLE `loan_overdue_load_his` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行id(2016-07-01作废)',
  `co_bank_name` varchar(32) DEFAULT NULL COMMENT '合作银行名称(2016-07-01作废)',
  `templet_id` bigint(20) DEFAULT NULL COMMENT '导入模板ID',
  `templet_name` varchar(100) DEFAULT NULL COMMENT '导入模板Name',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(50) DEFAULT NULL COMMENT '证件号码',
  `mobile_phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `repayment_card_no` varchar(50) DEFAULT NULL COMMENT '还款卡号',
  `month_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '月还款额',
  `current_term_principle` decimal(24,6) DEFAULT NULL COMMENT '本期本金',
  `current_term_interest` decimal(24,6) DEFAULT NULL COMMENT '本期利息(2016-07-30转义为贷款余额)',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `overdue_total_amount` decimal(24,6) DEFAULT NULL COMMENT '逾期总额',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `last_repayment_date` date DEFAULT NULL COMMENT '最近还款日期',
  `create_time` datetime NOT NULL COMMENT '导入时间',
  `before_match_status` int(11) DEFAULT NULL COMMENT '之前匹配状态  1:匹配成功 2:匹配失败 3:匹配重复',
  `before_project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `before_plan_no` bigint(20) DEFAULT NULL COMMENT '之前的期数',
  `total_plan_no` bigint(20) DEFAULT NULL,
  `loan_left_amt` decimal(10,0) DEFAULT NULL,
  `loan_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_co_bank_id_templet_id_create_time` (`templet_id`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1727 DEFAULT CHARSET=utf8 COMMENT='贷款逾期数据导入记录表';

-- ----------------------------
-- Table structure for loan_payback_remind
-- ----------------------------
DROP TABLE IF EXISTS `loan_payback_remind`;
CREATE TABLE `loan_payback_remind` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `mobile_phone` bigint(30) DEFAULT NULL COMMENT '手机号',
  `productname` varchar(10) DEFAULT NULL COMMENT '委托方',
  `name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `money` bigint(30) DEFAULT NULL COMMENT '金额 （18~19月供，20~24昨日最优）',
  `bt_date` date DEFAULT NULL COMMENT '统计日期',
  `type` int(1) DEFAULT NULL COMMENT '类型（1:18~19,2:20~24，3：无意义）',
  `is_value` int(1) NOT NULL DEFAULT '1' COMMENT '是否有效（0：无效，1：有效）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123521 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_payment_detail
-- ----------------------------
DROP TABLE IF EXISTS `loan_payment_detail`;
CREATE TABLE `loan_payment_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL COMMENT 'loan_payment_info主键',
  `payment_mode` int(3) DEFAULT NULL COMMENT '0人工付款 1 招行CBS  2 工行直连 3 浙商直连',
  `payment_type` int(3) DEFAULT NULL COMMENT '1贷款申请资金部付款\r\n            2贷款申请分公司付款\r\n            ',
  `payee_amount` decimal(24,6) DEFAULT NULL COMMENT '金额',
  `account_name` varchar(100) DEFAULT NULL COMMENT '收款人名称',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `trans_time` datetime DEFAULT NULL COMMENT '交易时间',
  `batch_no` varchar(30) DEFAULT NULL COMMENT '交易流水号',
  `trans_status` int(3) DEFAULT NULL COMMENT '交易状态1、人工付款：付款类型为人工付款的交易数据\r\n2、付款中：通过接口进行付款提交成功的初始状态\r\n3、付款成功：通过接口进行付款成功；\r\n4、付款失败：通过接口进行付款失败；（可重新提交）\r\n5、付款失败（重新提交）：通过接口进行付款失败后重新提交\r\n6、付款失败（人工处理）：通过接口进行付款失败后转人工处理\r\n',
  `remarks` varchar(500) DEFAULT NULL COMMENT '交易备注',
  `payment_no` varchar(30) DEFAULT NULL COMMENT '生成的支付编号',
  `opening_bank` varchar(20) DEFAULT NULL COMMENT '公司类型',
  `open_bank_name` varchar(100) DEFAULT NULL COMMENT '银行名称',
  `sub_bank_name` varchar(150) DEFAULT NULL COMMENT '支行名称',
  `card_number` varchar(50) DEFAULT NULL COMMENT '卡号',
  `bank_code` varchar(20) DEFAULT NULL COMMENT '联行号',
  `priority_flag` int(5) DEFAULT '0' COMMENT '0非加急  1加急',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54094 DEFAULT CHARSET=utf8 COMMENT='项目付款明细表';

-- ----------------------------
-- Table structure for loan_payment_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_payment_info`;
CREATE TABLE `loan_payment_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `apply_id` bigint(20) NOT NULL COMMENT '申请主键',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目编号',
  `guarantee_corporation_id` bigint(20) DEFAULT NULL COMMENT '担保公司编号',
  `guarantee_corporation_name` varchar(200) DEFAULT NULL COMMENT '担保公司名称',
  `guarantee_corporation_account_name` varchar(200) DEFAULT NULL COMMENT '担保公司账户开户名称',
  `guarantee_corporation_account_no` varchar(32) DEFAULT NULL COMMENT '担保公司账户开户号',
  `guarantee_corporation_bank` varchar(100) DEFAULT NULL COMMENT '担保公司开户支行',
  `guarantee_corporation_payment_date` date DEFAULT NULL COMMENT '担保公司付款日期',
  `guarantee_corporation_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '担保公司付款金额',
  `guarantee_corporation_payment_user_id` bigint(20) DEFAULT NULL COMMENT '付款人ID',
  `guarantee_corporation_payment_user_name` varchar(50) DEFAULT NULL COMMENT '付款人NAME',
  `guarantee_corporation_payment_remark` varchar(200) DEFAULT NULL COMMENT '担保公司付款说明',
  `capital_pool_account_name` varchar(100) DEFAULT NULL COMMENT '资金池收款账户名',
  `capital_pool_account_no` varchar(32) DEFAULT NULL COMMENT '资金池收款账户账号',
  `capital_pool_bank` varchar(32) DEFAULT NULL COMMENT '资金池收款账户开户支行',
  `capital_pool_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '资金池打款总额',
  `capital_pool_payment_date` date DEFAULT NULL COMMENT '打款日期',
  `capital_pool_payment_user_id` bigint(20) DEFAULT NULL COMMENT '打款人ID',
  `capital_pool_payment_user_name` varchar(50) DEFAULT NULL COMMENT '打款人NAME',
  `capital_pool_payment_remark` varchar(200) DEFAULT NULL COMMENT '打款说明',
  `dealer_id` bigint(20) DEFAULT NULL COMMENT '合作车商编号',
  `dealer_name` varchar(100) DEFAULT NULL COMMENT '合作车商名称',
  `employ_dealer_id` bigint(20) DEFAULT NULL COMMENT '经销商ID',
  `employ_dealer_name` varchar(255) DEFAULT NULL COMMENT '经销商名称',
  `dealer_account_name` varchar(100) DEFAULT NULL COMMENT '合作车商收款账户名',
  `dealer_account_no` varchar(32) DEFAULT NULL COMMENT '合作车商收款账户账号',
  `dealer_bank` varchar(32) DEFAULT NULL COMMENT '合作车商收款账户开户支行',
  `dealer_payment_amount` decimal(24,6) DEFAULT NULL COMMENT '实际打款总额',
  `dealer_payment_date` date DEFAULT NULL COMMENT '打款日期',
  `dealer_payment_user_id` bigint(20) DEFAULT NULL COMMENT '打款人ID',
  `dealer_payment_user_name` varchar(50) DEFAULT NULL COMMENT '打款人NAME',
  `dealer_payment_remark` varchar(200) DEFAULT NULL COMMENT '打款说明',
  `payee_method` int(10) DEFAULT NULL COMMENT '收款处理方式（1：差额处理；2：全额回款）',
  `payment_direction` int(1) DEFAULT NULL COMMENT '支付方向',
  `payee_amount` decimal(24,6) DEFAULT NULL COMMENT '收款金额',
  `payee_date` date DEFAULT NULL COMMENT '退款时间',
  `return_cash_pool_amount` decimal(24,6) DEFAULT NULL COMMENT '返回资金池金额',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用（1：启用，2：停用）',
  `save_status` int(1) DEFAULT NULL COMMENT '保存状态，０：未保存，１：暂存，２：已保存',
  `user_id` bigint(20) DEFAULT NULL COMMENT '登记人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '用户机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '用户机构编号',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dealer_account_type` int(11) DEFAULT NULL COMMENT '车商账户类型,1:对公账户,2:个人账户',
  `pay_status` int(5) DEFAULT '0' COMMENT '支付状态0 初始化 1付款中 2付款成功 3 付款失败 4人工付款',
  `pay_type` int(5) DEFAULT '0' COMMENT '0人工付款 1CBS系统 2 工行直连 3 浙商直连',
  PRIMARY KEY (`id`),
  UNIQUE KEY `apply_id` (`apply_id`) USING BTREE,
  UNIQUE KEY `uk_payment_apply_id` (`project_id`,`apply_id`),
  KEY `IDX_PROJECT_ID` (`project_id`) USING BTREE,
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=61712 DEFAULT CHARSET=utf8 COMMENT='项目付款信息';

-- ----------------------------
-- Table structure for loan_payment_logs
-- ----------------------------
DROP TABLE IF EXISTS `loan_payment_logs`;
CREATE TABLE `loan_payment_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL COMMENT 'loan_payment_detail主键',
  `payment_no` varchar(30) DEFAULT NULL COMMENT '生成的支付编号',
  `create_time` datetime DEFAULT NULL COMMENT '操作时间',
  `trans_status` int(3) DEFAULT NULL COMMENT '交易状态支付状态 0 初始化 1发送请求 2接收请求 3付款成功 4 付款失败 5人工付款',
  `input_remarks` mediumtext COMMENT '请求报文',
  `remarks` longtext COMMENT '备注信息',
  `response_code` varchar(50) DEFAULT NULL,
  `response_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8 COMMENT='明细操作日志表';

-- ----------------------------
-- Table structure for loan_payment_record
-- ----------------------------
DROP TABLE IF EXISTS `loan_payment_record`;
CREATE TABLE `loan_payment_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL,
  `record_name` varchar(110) DEFAULT NULL COMMENT '记录名称',
  `trans_time` timestamp NULL DEFAULT NULL COMMENT '交易时间',
  `pay_amt` decimal(20,4) DEFAULT NULL COMMENT '打款金额',
  `pay_acc_id` bigint(20) DEFAULT NULL COMMENT '打款账户Id',
  `pay_acc_no` varchar(50) DEFAULT NULL COMMENT '打款账号',
  `pay_acc_name` varchar(110) DEFAULT NULL COMMENT '打款账户名',
  `pay_acc_bank` varchar(110) DEFAULT NULL COMMENT '打款账户开户行',
  `payee_acc_id` bigint(20) DEFAULT NULL COMMENT '收款账户Id',
  `payee_acc_no` varchar(50) DEFAULT NULL COMMENT '收款账号',
  `payee_acc_name` varchar(110) DEFAULT NULL COMMENT '收款账户名',
  `payee_acc_bank` varchar(110) DEFAULT NULL COMMENT '收款账户开户行',
  `user_id` bigint(20) DEFAULT NULL COMMENT '处理人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '处理人名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '处理人意见',
  `trading_acc_type` int(2) DEFAULT NULL COMMENT '交易账户类型（1资金部与分公司之间2分公司与经销商之间',
  `pay_direction` int(2) DEFAULT NULL COMMENT '付款方向（1正向：资金部往分公司或分公司往经销商2反之）',
  `node_key` varchar(100) DEFAULT NULL COMMENT '流程节点',
  `create_time` datetime DEFAULT NULL,
  `is_consume_acc` int(2) DEFAULT NULL COMMENT '是否是消费贷',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5413 DEFAULT CHARSET=utf8 COMMENT='打款记录表';

-- ----------------------------
-- Table structure for loan_post_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_post_info`;
CREATE TABLE `loan_post_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCardNo` varchar(255) DEFAULT NULL,
  `customerName` varchar(255) DEFAULT NULL,
  `bankCardNo` varchar(50) DEFAULT NULL,
  `loanAmount` double(255,2) DEFAULT NULL,
  `ortrxDate` date DEFAULT NULL,
  `totolNum` int(11) DEFAULT NULL,
  `leftNum` int(11) DEFAULT NULL,
  `leftAmount` varchar(255) DEFAULT NULL,
  `dtopAmt` varchar(255) DEFAULT NULL,
  `monthPayAmt` varchar(255) DEFAULT NULL,
  `serialOverdue` varchar(255) DEFAULT NULL,
  `totalOverdue` varchar(255) DEFAULT NULL,
  `lastestOverdueDate` varchar(50) DEFAULT NULL,
  `overdueAmt` varchar(255) DEFAULT NULL,
  `projectid` varchar(255) DEFAULT NULL,
  `loanStatus` int(255) DEFAULT NULL,
  `currentNum` int(11) DEFAULT NULL,
  `updateDate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_project_ext
-- ----------------------------
DROP TABLE IF EXISTS `loan_project_ext`;
CREATE TABLE `loan_project_ext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贷款扩展表Id',
  `project_id` bigint(20) NOT NULL COMMENT '贷款Id',
  `external_serial_no` varchar(32) DEFAULT NULL COMMENT '与此贷款关联的外部订单流水号(预留备用字段)',
  `sign_result` int(11) NOT NULL DEFAULT '0' COMMENT '签约结果(0:未签约;1:已签约)',
  `sign_finish_time` datetime DEFAULT NULL COMMENT '签约完成时间',
  `auth_result` int(11) DEFAULT '0' COMMENT '鉴权总结果(0:不通过;1:通过)',
  `yuntu_order_no` varchar(32) DEFAULT NULL COMMENT '云图自动化审批订单号',
  `yuntu_order_result` int(11) DEFAULT NULL COMMENT '云图订单结果(-1:异常;0:转人工审批;1:通过)',
  `patch_record_no` varchar(32) DEFAULT NULL COMMENT '补件记录编号',
  `patch_record_status` int(11) DEFAULT NULL COMMENT '补件状态(0-未补件;1-已补件)',
  `settle_status` int(11) DEFAULT '0' COMMENT '结清状态(v2.5.0) 对应枚举 SettleMergeStausEnum',
  `loan_status` int(11) NOT NULL COMMENT '贷款状态(见数据字典或枚举)',
  `loan_result` int(11) DEFAULT NULL COMMENT '贷款审批结果(0:审批不通过;1:审批通过)',
  `payment_status` int(11) DEFAULT '0' COMMENT '放款状态(v2.5.0) 对应枚举 LoanContractMergeStatusEnum',
  `interview_id` bigint(20) DEFAULT NULL COMMENT ' 关联的面签信息id ',
  `signing_authorize_link_total` varchar(512) DEFAULT NULL COMMENT '总签约授权地址（h5）(v2.5.0)',
  `interview_status` int(1) NOT NULL DEFAULT '0' COMMENT ' 面签状态 0:未面签 1:已面签 ',
  `interview_verify_result` int(11) DEFAULT NULL COMMENT '面签电核结果(0-不通过 1-通过)',
  `flow_type` varchar(32) DEFAULT NULL COMMENT '流程标识',
  `flow_node_key` varchar(32) DEFAULT NULL COMMENT '流程节点标识',
  `flow_node_index` int(11) DEFAULT NULL COMMENT '流程节点索引',
  `flow_node_name` varchar(16) DEFAULT NULL COMMENT '流程节点名称',
  `data_review_time` datetime DEFAULT NULL COMMENT '资料复核时间(v2.5.0)',
  `flow_create_time` datetime DEFAULT NULL COMMENT '流程创建时间',
  `business_approval_time` datetime DEFAULT NULL COMMENT '业务审批时间',
  `loan_approval_time` datetime DEFAULT NULL COMMENT '放款审批时间',
  `payment_loan_date` datetime DEFAULT NULL COMMENT '放款日期',
  `flow_finish_time` datetime DEFAULT NULL COMMENT '流程结束时间',
  `bank_sub_account` varchar(30) DEFAULT NULL COMMENT '二类户账号（2.5.0）',
  `mango_acct_no` varchar(30) DEFAULT NULL COMMENT '芒果开户账号（2.5.1）',
  `host_cust_no` varchar(31) DEFAULT NULL COMMENT '二类户开户后的核心客户号',
  `bank_card_no` varchar(30) DEFAULT NULL COMMENT '用户银行卡（代扣卡）（2.5.0）',
  `loan_purpose` varchar(512) DEFAULT NULL COMMENT '贷款用途（v2.5.1）',
  `extra_loan_purpose` varchar(512) DEFAULT NULL COMMENT '贷款用途（v2.5.1）',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_project_id` (`project_id`) USING BTREE,
  KEY `idx_loan_status` (`loan_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59392 DEFAULT CHARSET=utf8 COMMENT='贷款扩展表，用于记录贷款进件及审批的相关扩展信息';

-- ----------------------------
-- Table structure for loan_project_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_project_info`;
CREATE TABLE `loan_project_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '贷款Id',
  `project_no` varchar(32) NOT NULL COMMENT '贷款编号',
  `credit_id` bigint(20) NOT NULL COMMENT '征信Id',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户Id',
  `customer_name` varchar(32) NOT NULL COMMENT '客户名称',
  `car_dealer_social_code` bigint(20) DEFAULT NULL COMMENT '车商社会信用统一代码',
  `auth_type` varchar(4) DEFAULT NULL COMMENT '鉴权类型(见数据字典)',
  `cert_type` varchar(4) NOT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(32) NOT NULL COMMENT '证件号码',
  `biz_type` varchar(4) NOT NULL COMMENT '业务类型(汽车消费分期01 其他见数据字典)',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型(如0101:新车;0102:二手车;其余见数据字典))',
  `sign_type` int(11) NOT NULL COMMENT '签约类型(1:电子签约;2:纸质)',
  `agency_org_id` bigint(20) NOT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) NOT NULL COMMENT '合作单位名称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `apply_time` datetime NOT NULL COMMENT '进件时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_no` (`project_no`) USING BTREE,
  KEY `idx_credit_id` (`credit_id`) USING BTREE,
  KEY `idx_cert_no` (`cert_no`) USING BTREE,
  KEY `idx_cccb` (`customer_name`,`cert_type`,`cert_no`,`biz_type`) USING BTREE COMMENT '证件类型、证件号码、姓名、业务类型联合索引',
  KEY `idx_sub_org_id` (`sub_org_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59417 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='贷款主表，用于记录贷款进件的基础信息';

-- ----------------------------
-- Table structure for loan_record_supplement_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_record_supplement_info`;
CREATE TABLE `loan_record_supplement_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `project_id` bigint(20) NOT NULL COMMENT '贷款项目Id',
  `project_no` varchar(64) NOT NULL COMMENT '贷款项目编号',
  `record_no` varchar(64) DEFAULT NULL COMMENT '补录编号',
  `record_type` int(11) DEFAULT NULL COMMENT '补录类型(1-待新增 2-待替换)',
  `record_receive_message` text COMMENT '待补录报文',
  `record_receive_opinion` varchar(128) DEFAULT NULL COMMENT '待补录原因',
  `record_supply_message` mediumtext COMMENT '补录报文',
  `record_status` int(11) DEFAULT '0' COMMENT '补录状态(0-待补录 1-已补录)',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人Id',
  `operator_name` varchar(32) DEFAULT NULL COMMENT '操作人姓名',
  `submitter_id` bigint(20) DEFAULT NULL COMMENT '提交人Id',
  `submitter_name` varchar(32) DEFAULT NULL COMMENT '提交人姓名',
  `record_receive_time` datetime DEFAULT NULL COMMENT '补录通知时间',
  `record_submit_time` datetime DEFAULT NULL COMMENT '补录提交时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`) USING BTREE,
  KEY `idx_project_no` (`project_no`) USING BTREE,
  KEY `idx_record_no` (`record_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='申贷补录信息表';

-- ----------------------------
-- Table structure for loan_repayment_his
-- ----------------------------
DROP TABLE IF EXISTS `loan_repayment_his`;
CREATE TABLE `loan_repayment_his` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(32) NOT NULL COMMENT '业务编号',
  `customer_name` varchar(32) DEFAULT NULL COMMENT '客户姓名',
  `cert_type` varchar(4) DEFAULT NULL COMMENT '证件类型',
  `cert_no` varchar(32) DEFAULT NULL COMMENT '证件号码',
  `iou_number` varchar(32) DEFAULT NULL COMMENT '借据编号',
  `loan_type` int(11) NOT NULL DEFAULT '1' COMMENT '放款结果 1:主贷;2:附加贷',
  `contract_amount` double(20,2) DEFAULT NULL COMMENT '合同金额（放款金额）',
  `payment_loan_date` datetime DEFAULT NULL COMMENT '放款日期',
  `total_term` bigint(20) DEFAULT NULL COMMENT '放款期数',
  `left_term` varchar(4) DEFAULT NULL COMMENT '剩余期数',
  `repay_total_amount` decimal(24,6) DEFAULT NULL COMMENT '应还总额',
  `repay_capital` decimal(24,6) DEFAULT NULL COMMENT '应还本金',
  `repay_interest` decimal(24,6) DEFAULT NULL COMMENT '应还利息',
  `repay_default` decimal(24,6) DEFAULT NULL COMMENT '应还罚息',
  `repay_compound_interest` decimal(20,6) DEFAULT NULL COMMENT '应还复利',
  `repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '实际还款金额',
  `loan_left_amount` decimal(20,6) DEFAULT NULL COMMENT '贷款余额',
  `current_overdue_days` int(11) DEFAULT NULL COMMENT '当前逾期天数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计违约期数',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '当前连续违约期数',
  `last_overdue_date` date DEFAULT NULL COMMENT '上次违约日期',
  `repayment_status` int(11) DEFAULT NULL COMMENT '还款状态 0:正常、1:逾期',
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='还款管理表（历史表）';

-- ----------------------------
-- Table structure for loan_repayment_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_repayment_info`;
CREATE TABLE `loan_repayment_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(32) NOT NULL COMMENT '业务编号',
  `customer_name` varchar(32) DEFAULT NULL COMMENT '客户姓名',
  `cert_type` varchar(4) DEFAULT NULL COMMENT '证件类型',
  `cert_no` varchar(32) DEFAULT NULL COMMENT '证件号码',
  `iou_number` varchar(32) DEFAULT NULL COMMENT '借据编号',
  `loan_type` int(11) NOT NULL DEFAULT '1' COMMENT '放款结果 1:主贷;2:附加贷',
  `contract_amount` double(20,2) DEFAULT NULL COMMENT '合同金额（放款金额）',
  `payment_loan_date` datetime DEFAULT NULL COMMENT '放款日期',
  `total_term` bigint(20) DEFAULT NULL COMMENT '放款期数',
  `left_term` varchar(4) DEFAULT NULL COMMENT '剩余期数',
  `repay_total_amount` decimal(24,6) DEFAULT NULL COMMENT '应还总额',
  `repay_capital` decimal(24,6) DEFAULT NULL COMMENT '应还本金',
  `repay_interest` decimal(24,6) DEFAULT NULL COMMENT '应还利息',
  `repay_default` decimal(24,6) DEFAULT NULL COMMENT '应还罚息',
  `repay_compound_interest` decimal(20,6) DEFAULT NULL COMMENT '应还复利',
  `repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '实际还款金额',
  `loan_left_amount` decimal(20,6) DEFAULT NULL COMMENT '贷款余额',
  `current_overdue_days` int(11) DEFAULT NULL COMMENT '当前逾期天数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计违约期数',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '当前连续违约期数',
  `last_overdue_date` date DEFAULT NULL COMMENT '上次违约日期',
  `biz_type` varchar(4) NOT NULL COMMENT '业务类型',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `agency_org_id` bigint(20) NOT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) NOT NULL COMMENT '合作单位名称',
  `repayment_status` int(11) DEFAULT NULL COMMENT '还款状态 0:正常、1:逾期',
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unq_iou_number` (`iou_number`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='还款管理表（展示）';

-- ----------------------------
-- Table structure for loan_repayment_info_copy20200713
-- ----------------------------
DROP TABLE IF EXISTS `loan_repayment_info_copy20200713`;
CREATE TABLE `loan_repayment_info_copy20200713` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `customer_name` varchar(32) DEFAULT NULL COMMENT '客户名称',
  `cert_type` varchar(4) DEFAULT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(32) DEFAULT NULL COMMENT '证件号码',
  `iou_number` varchar(32) DEFAULT NULL COMMENT '借据编号',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '开卡银行（历史字段）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '卡号（历史字段）',
  `account_name` varchar(100) DEFAULT NULL COMMENT '收款人名称（历史字段）',
  `repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '还款金额',
  `repayment_date` date DEFAULT NULL COMMENT '还款日期',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `remaining_period` varchar(4) DEFAULT NULL COMMENT '剩余期数',
  `yesterday_balance` decimal(24,6) DEFAULT NULL COMMENT '昨日余额',
  `current_overdue_days` int(11) DEFAULT NULL COMMENT '当前逾期天数',
  `current_continuity_overdue_periods` int(11) DEFAULT NULL COMMENT '当前连续逾期期数',
  `cumulative_defaults_number` int(11) DEFAULT NULL COMMENT '累计违约次数',
  `repayment_status` int(11) DEFAULT NULL COMMENT '还款状态 1 正常、0 逾期',
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `matching_results` int(1) NOT NULL DEFAULT '0' COMMENT '匹配结果(0 失败, 1 正常)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) NOT NULL COMMENT '创建人ID',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建人',
  `modify_user` varchar(20) DEFAULT NULL COMMENT '更新人',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_repayment_info_tmp
-- ----------------------------
DROP TABLE IF EXISTS `loan_repayment_info_tmp`;
CREATE TABLE `loan_repayment_info_tmp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `project_no` varchar(32) DEFAULT NULL COMMENT '贷款编号',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '开卡银行（历史字段）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '卡号（历史字段）',
  `account_name` varchar(100) DEFAULT NULL COMMENT '收款人名称（历史字段）',
  `repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '还款金额',
  `repayment_date` date DEFAULT NULL COMMENT '还款日期',
  `yesterday_repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '昨日最优还款额',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `remaining_period` varchar(4) DEFAULT NULL COMMENT '剩余期数',
  `yesterday_balance` decimal(24,6) DEFAULT NULL COMMENT '昨日余额',
  `current_overdue_days` int(11) DEFAULT NULL COMMENT '当前逾期天数',
  `current_continuity_overdue_periods` int(11) DEFAULT NULL COMMENT '当前连续逾期期数',
  `cumulative_defaults_number` int(11) DEFAULT NULL COMMENT '累计违约次数',
  `repayment_status` int(11) DEFAULT NULL COMMENT '还款状态 1 正常、0 逾期',
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `matching_results` int(1) NOT NULL DEFAULT '0' COMMENT '匹配结果(0 失败, 1 正常)',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户Id',
  `customer_name` varchar(32) NOT NULL COMMENT '客户名称',
  `cert_type` varchar(4) DEFAULT NULL COMMENT '证件类型(身份证01,其他见数据字典)',
  `cert_no` varchar(32) NOT NULL COMMENT '证件号码',
  `biz_type` varchar(4) DEFAULT NULL COMMENT '业务类型(汽车消费分期01 其他见数据字典)',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型(如0101:新车;0102:二手车;其余见数据字典))',
  `agency_org_id` bigint(20) DEFAULT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) DEFAULT NULL COMMENT '合作单位名称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `loan_term` varchar(4) DEFAULT NULL COMMENT '贷款分期期限(月)',
  `total_repayment` decimal(12,4) DEFAULT NULL COMMENT '应还总额(元）= 贷款总费用* （1+贷款分期手续费率(%)））',
  `iou_number` varchar(30) DEFAULT NULL COMMENT '借据编号',
  `contract_amount` double(20,2) DEFAULT NULL COMMENT '合同金额(银行放款金额)',
  `payment_loan_date` datetime DEFAULT NULL COMMENT '放款日期',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint(20) NOT NULL COMMENT '创建人ID',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建人',
  `modify_user` varchar(20) DEFAULT NULL COMMENT '更新人',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE,
  KEY `idx_project_no` (`project_no`) USING BTREE,
  KEY `idx_cert_no_cert_type` (`cert_no`,`cert_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8 COMMENT='还款记录临时表';

-- ----------------------------
-- Table structure for loan_repayment_record
-- ----------------------------
DROP TABLE IF EXISTS `loan_repayment_record`;
CREATE TABLE `loan_repayment_record` (
  `repay_id` bigint(20) NOT NULL COMMENT '还款历史表his_id',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(32) NOT NULL COMMENT '业务编号',
  `iou_number` varchar(32) DEFAULT NULL COMMENT '借据编号',
  `loan_type` int(11) NOT NULL DEFAULT '1' COMMENT '放款类型 1:主贷;2:附加贷',
  `repayment_amount` decimal(24,6) DEFAULT NULL COMMENT '实际还款金额',
  `repayment_date` date DEFAULT NULL COMMENT '还款日期（数据日期）',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`repay_id`) USING BTREE,
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='还款记录表';

-- ----------------------------
-- Table structure for loan_report_data_version
-- ----------------------------
DROP TABLE IF EXISTS `loan_report_data_version`;
CREATE TABLE `loan_report_data_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123577 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_report_detail
-- ----------------------------
DROP TABLE IF EXISTS `loan_report_detail`;
CREATE TABLE `loan_report_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pay_apply_id` int(11) DEFAULT NULL COMMENT '垫付车款Id',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目主键',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请Id',
  `loan_project_no` varchar(50) DEFAULT NULL COMMENT '贷款编号',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `advance_pay_date` datetime DEFAULT NULL COMMENT '垫款时间',
  `advance_pay_amt` decimal(50,4) DEFAULT NULL COMMENT '垫款金额',
  `loan_status` int(1) DEFAULT '1' COMMENT '贷款状态(1未发起2审核中3审核通过2结清)',
  `loan_status_desc` varchar(50) DEFAULT NULL COMMENT '贷款状态',
  `bank_repayment_status` int(1) DEFAULT NULL COMMENT '放款状态(0:未放款 1:已放款)',
  `car_plate_status` int(1) DEFAULT NULL COMMENT '上牌状态(1:已上牌 2:未上牌)',
  `pledge_status` int(1) DEFAULT NULL COMMENT '抵押状态(0未抵押1已抵押)',
  `contract_status` int(1) DEFAULT NULL COMMENT '合同移交银行状态(1已登记2未登记)',
  `contract_to_bank_date` datetime DEFAULT NULL COMMENT '合同移交银行日期',
  `business_type` int(1) DEFAULT NULL COMMENT '业务品种(1信用卡贷款(普通模式) 2信用卡贷款(银行直销) 3个人消费贷款)',
  `loan_amt` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `loan_term` int(1) DEFAULT NULL COMMENT '贷款期数',
  `notice_periodpayment_amount` decimal(24,6) DEFAULT NULL COMMENT '(用卡须知)每期总金额',
  `handing_fee` decimal(24,6) DEFAULT NULL COMMENT '手续费率',
  `pre_pay_ratio` decimal(24,6) DEFAULT NULL COMMENT '首付比例',
  `car_type` int(1) DEFAULT NULL COMMENT '汽车类型(1新车,2二手车)',
  `car_type_desc` varchar(50) DEFAULT NULL COMMENT '汽车类型',
  `sign_date` datetime DEFAULT NULL COMMENT '签单日期',
  `enter_date` datetime DEFAULT NULL COMMENT '业务录入日期',
  `bank_pay_amt` decimal(24,4) DEFAULT NULL COMMENT '银行放款金额',
  `bank_pay_date` datetime DEFAULT NULL COMMENT '放款日期',
  `plate_date` datetime DEFAULT NULL COMMENT '上牌日期',
  `pledge_date` datetime DEFAULT NULL COMMENT '抵押日期',
  `review_date` datetime DEFAULT NULL COMMENT '资料复核日期',
  `archive_date` datetime DEFAULT NULL COMMENT '归档日期',
  `copy_contract_date` datetime DEFAULT NULL COMMENT '合同抄写日期',
  `org_id` bigint(20) DEFAULT NULL COMMENT '机构Id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `group_id` bigint(20) DEFAULT NULL COMMENT '业务组id',
  `group_name` varchar(100) DEFAULT NULL COMMENT '业务组名称',
  `manager_id` bigint(20) DEFAULT NULL COMMENT '客户经理id',
  `manager_name` varchar(50) DEFAULT NULL COMMENT '客户经理',
  `invest_manager_id` bigint(20) DEFAULT NULL COMMENT '风险经理id',
  `invest_manager` varchar(50) DEFAULT NULL COMMENT '风险经理',
  `car_dealer_id` bigint(20) DEFAULT NULL COMMENT '车商Id',
  `car_dealer_name` varchar(100) DEFAULT NULL COMMENT '车商名称',
  `dealer_manager_id` bigint(20) DEFAULT NULL COMMENT '管护客户经理id',
  `dealer_manager_name` varchar(100) DEFAULT NULL COMMENT '管护客户经理',
  `dealer_managergroup_id` bigint(20) DEFAULT NULL COMMENT '管护业务组id',
  `dealer_managergroup_name` varchar(100) DEFAULT NULL COMMENT '管护业务组',
  `dealer_managercompany_id` bigint(20) DEFAULT NULL COMMENT '管护机构',
  `dealer_managercompany_name` varchar(100) DEFAULT NULL COMMENT '管护机构',
  `dealer_managerdepartment_id` bigint(20) DEFAULT NULL COMMENT '管护部门id',
  `dealer_managerdepartment_name` varchar(100) DEFAULT NULL COMMENT '管护部门',
  `co_bank_id` bigint(20) DEFAULT NULL COMMENT '合作银行Id',
  `co_bank_name` varchar(100) DEFAULT NULL COMMENT '合作银行名称',
  `mobile_phone` varchar(50) DEFAULT NULL,
  `bank_pledge_status` int(1) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户Id',
  `business_type_name` varchar(50) DEFAULT NULL COMMENT '业务品种Name',
  `id_no` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `billing_price` decimal(24,4) DEFAULT NULL COMMENT '开票价格',
  `down_payment_amount` decimal(24,4) DEFAULT NULL COMMENT '首付款',
  `car_loan_amount` decimal(24,4) DEFAULT NULL COMMENT '车辆贷款金额',
  `purchase_tax` decimal(24,4) DEFAULT NULL COMMENT '购置税',
  `insurance_amount` decimal(24,4) DEFAULT NULL COMMENT '保险金额',
  `benchmark_rate` decimal(20,6) DEFAULT NULL COMMENT '基准费率',
  `real_rate` decimal(24,6) DEFAULT NULL COMMENT '实际费率',
  `pledge_complete_date` date DEFAULT NULL COMMENT '抵押完成时间',
  `credit_apply_date` datetime DEFAULT NULL COMMENT '资信记录创建时间',
  `office_remark` varchar(200) DEFAULT NULL COMMENT '情况描述（办事处）',
  `bank_remark` varchar(200) DEFAULT NULL COMMENT '情况描述（银行）',
  `area_manager_name` varchar(500) DEFAULT NULL COMMENT '区域经理',
  `car_frame_no` varchar(30) DEFAULT NULL COMMENT '车架号码',
  `plate_no` varchar(20) DEFAULT NULL COMMENT '车牌号码',
  `car_info` varchar(255) DEFAULT NULL COMMENT '车辆信息',
  `profession` varchar(100) DEFAULT NULL COMMENT '职业',
  `marital_status` int(10) DEFAULT NULL COMMENT '婚姻状态（1：已婚，2：未婚，3：离异，4：丧偶）',
  `is_two_card` tinyint(1) DEFAULT NULL COMMENT '是否两证（1：是，0：否）',
  `is_single_noneed_guarantee` int(2) DEFAULT NULL COMMENT '是否单身免担保（1：是，2：否）',
  `is_approve_exception` int(2) DEFAULT NULL COMMENT '是否特例审批（1：是，2：否）',
  `is_single_sign` int(2) DEFAULT NULL COMMENT '是否单签（1：是，2：否）',
  `is_agency` int(2) DEFAULT NULL COMMENT '是否代购（1：是，2：否）',
  `is_concerned_customer` int(2) DEFAULT NULL COMMENT '免家访（1：否，2：是）',
  `is_gps_installed` int(2) DEFAULT NULL COMMENT '是否免GPS（1：否，2：是）',
  `bank_lending_status` int(11) DEFAULT NULL COMMENT '银行放款状态',
  `required_amount` decimal(24,4) DEFAULT NULL COMMENT '申请金额',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `guarantee_corporation_name` varchar(200) DEFAULT NULL COMMENT '担保公司名称',
  `deliver_status` int(1) DEFAULT NULL COMMENT '文档传递状态(1:未传递，2:已传递，3:已关闭，4:待归档，5:已归档 )',
  `life_accident_insurance` decimal(31,0) DEFAULT '0' COMMENT '人生意外险费用',
  `instalment_interview_voucher` int(1) DEFAULT '0' COMMENT '专项分期付款面签凭证(0:无，1:有）',
  `guarantee_service_fee` decimal(24,6) DEFAULT NULL COMMENT '担保服务费',
  `gps_fee` decimal(24,6) DEFAULT NULL COMMENT 'gps费 预算单里其他费用',
  `total_additional_fee` decimal(24,6) DEFAULT NULL COMMENT '合计附加费',
  `other_comsumer_loan` decimal(24,6) DEFAULT NULL COMMENT '其他消费贷',
  `installation_charges` decimal(24,6) DEFAULT NULL COMMENT '分期手续费',
  `credit_line_amount` decimal(24,6) DEFAULT NULL COMMENT '授信总额',
  `pay_back_card_no` varchar(50) DEFAULT NULL COMMENT '还款卡号',
  `delivery_bank_date` datetime DEFAULT NULL COMMENT '数据提交银行时间',
  `guarantee_corporation_id` bigint(20) DEFAULT NULL COMMENT '担保机构id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`) USING BTREE,
  KEY `idx_groupid_orgid` (`group_id`,`org_id`),
  KEY `idx_lrd_loan_apply_id` (`loan_apply_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6701668 DEFAULT CHARSET=utf8 COMMENT='贷款统计报表(详情版)';

-- ----------------------------
-- Table structure for loan_risk_control
-- ----------------------------
DROP TABLE IF EXISTS `loan_risk_control`;
CREATE TABLE `loan_risk_control` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(50) COLLATE utf8mb4_icelandic_ci NOT NULL COMMENT '项目编号',
  `card_no` varchar(50) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '证件号码',
  `card_type` int(1) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `loan_term` int(1) DEFAULT NULL COMMENT '贷款期限(1:12期 2:24期 3:18期 4:36期）',
  `org_id` int(11) DEFAULT NULL COMMENT '机构id',
  `org_name` varchar(50) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '机构',
  `user_group_id` int(11) DEFAULT NULL COMMENT '业务组id',
  `user_group_name` varchar(50) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '业务组',
  `co_bank_id` int(11) DEFAULT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(50) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '合作银行',
  `user_id` int(11) DEFAULT NULL COMMENT '客户经理id',
  `user_name` varchar(50) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '客户经理',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(50) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '客户姓名',
  `dealer_payment_date` date DEFAULT NULL COMMENT '公司垫（付）款日期',
  `bank_payment_date` date DEFAULT NULL COMMENT '银行放款日期',
  `loan_amount` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `required_amount` decimal(24,4) DEFAULT NULL COMMENT '申请金额',
  `car_type` varchar(10) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '汽车类型（1：新车，2：二手车）',
  `car_info` varchar(255) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '车辆信息',
  `is_pay_overdue` int(5) DEFAULT NULL COMMENT '是否垫款超期,1:是,0：否',
  `is_pledge_overdue` int(5) DEFAULT NULL COMMENT '是否抵押超期,1:是,0：否',
  `pledge_fail_reason` varchar(255) COLLATE utf8mb4_icelandic_ci DEFAULT NULL COMMENT '抵押失败原因',
  `left_capital_amount` decimal(24,4) DEFAULT NULL COMMENT '剩余本金',
  `pledge_overdue_days` int(10) DEFAULT NULL COMMENT '未抵押天数',
  `is_overdue` int(5) DEFAULT NULL COMMENT '是否当前逾期（1,逾期 0不逾期）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=578 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_icelandic_ci COMMENT='业务风险统计表';

-- ----------------------------
-- Table structure for loan_risk_rule_record_json
-- ----------------------------
DROP TABLE IF EXISTS `loan_risk_rule_record_json`;
CREATE TABLE `loan_risk_rule_record_json` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `loan_apply_id` bigint(20) DEFAULT NULL COMMENT '贷款申请主键',
  `json_str` mediumtext COMMENT 'json串',
  `hashcode` varchar(32) DEFAULT NULL COMMENT 'hash值 用于校验json串是否需要更新',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `index_loan_apply_id` (`loan_apply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='车贷风险规则业务json表';

-- ----------------------------
-- Table structure for loan_score_item
-- ----------------------------
DROP TABLE IF EXISTS `loan_score_item`;
CREATE TABLE `loan_score_item` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `apply_id` bigint(20) NOT NULL COMMENT '申请主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `with_relationship` int(1) NOT NULL COMMENT '检查对象身份（1：主贷人，2：配偶，3：担保人，4：反担保人）',
  `relative_object_id` bigint(20) NOT NULL COMMENT '关联对象主键',
  `group_id` bigint(20) NOT NULL COMMENT '分组ID',
  `item_id` bigint(20) NOT NULL COMMENT '得分项ID',
  `item_name` varchar(100) DEFAULT NULL COMMENT '得分项名称',
  `item_score` decimal(24,4) DEFAULT NULL COMMENT '得分项分值',
  `group_score_rule` int(1) DEFAULT NULL COMMENT '分组取分规则，随机取值，取分组最大值，求和取值',
  `is_provide` int(1) DEFAULT NULL COMMENT '是否提供材料(1:是，2：否)',
  `file_name` varchar(100) DEFAULT NULL COMMENT '提供材料名称',
  `file_value` int(1) DEFAULT NULL COMMENT '材料提供结果（1：已提供,2:未提供）',
  `remind_message` varchar(200) DEFAULT NULL COMMENT '提供材料提醒内容',
  `is_check` int(1) DEFAULT NULL COMMENT '是否核实材料(1:是，2：否)',
  `check_name` varchar(200) DEFAULT NULL COMMENT '核实材料内容',
  `check_result` int(1) DEFAULT NULL COMMENT '核实项结果（1：已核实，2：未核实）',
  `real_score` decimal(24,4) DEFAULT NULL COMMENT '实际分值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `apply_id_un` (`apply_id`) USING BTREE,
  KEY `project_id_un` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=673989 DEFAULT CHARSET=utf8 COMMENT='客户评分分值表';

-- ----------------------------
-- Table structure for loan_settlement_file
-- ----------------------------
DROP TABLE IF EXISTS `loan_settlement_file`;
CREATE TABLE `loan_settlement_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `settlement_id` bigint(20) DEFAULT NULL COMMENT '结清记录ID',
  `file_biz_type` int(2) DEFAULT '3' COMMENT '文件业务类型（1 上传收据 2 结清材料附件 3 其他）',
  `settlement_file` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `settlement_file_name` varchar(255) DEFAULT NULL COMMENT '文件的名称',
  `settlement_size` double DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='结清登记文件表';

-- ----------------------------
-- Table structure for loan_settlement_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_settlement_info`;
CREATE TABLE `loan_settlement_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `settlement_apply_no` varchar(100) DEFAULT NULL COMMENT '结清申请编号',
  `source` int(1) DEFAULT '0' COMMENT '结清发起来源  0 车贷 1 服务号',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `loan_contract_info_id` bigint(20) NOT NULL COMMENT '放款表ID（合同录入表）',
  `iou_number` varchar(100) DEFAULT NULL COMMENT '借据编号',
  `loan_type` int(11) NOT NULL DEFAULT '1' COMMENT '放款结果 1:主贷;2:附加贷（2.5.0）LoanApplyTypeEnum',
  `loan_amount` decimal(24,6) DEFAULT NULL COMMENT '贷款总额',
  `loan_balance` decimal(24,6) DEFAULT NULL COMMENT '贷款余额',
  `loan_balance_expiry_date` datetime DEFAULT NULL COMMENT '贷款余额有效期',
  `advance_balance` decimal(24,6) DEFAULT NULL COMMENT '垫款余额(20190824改为代偿余额)',
  `advance_balance_expiry_date` datetime DEFAULT NULL COMMENT '代偿余额有效期',
  `pb_deposit` decimal(24,6) DEFAULT NULL COMMENT '履约保证金余额',
  `renewal_deposit` decimal(24,6) DEFAULT NULL COMMENT '续保冲减保证金',
  `need_clear_amt` decimal(24,6) DEFAULT NULL COMMENT '银行待结清金额',
  `bank_clear_amt` decimal(24,6) DEFAULT NULL COMMENT '银行已结清金额',
  `other_balance` decimal(24,6) DEFAULT NULL COMMENT '其他应收',
  `other_balance_expiry_date` datetime DEFAULT NULL COMMENT '其他应收有效期',
  `returnable_deposit` decimal(24,6) DEFAULT NULL COMMENT '应退还客户保证金',
  `remark` varchar(255) DEFAULT NULL COMMENT '结清情况描述',
  `settle_status` int(1) DEFAULT '1' COMMENT '结清状态(1：未结清；2：结清中；3：已结清)',
  `settle_apply_status` int(2) DEFAULT NULL COMMENT '结清申请状态(1：结清审批；2：确认结清；3：核准资料;4:办理结清;5:完成结清;6:审批拒绝;7:取消结清;8:核准不通过)',
  `settlement_date` datetime DEFAULT NULL COMMENT '结清日期(之前为结清流程结束日期,2016-09-15后改为实际结清日期)',
  `settlement_reason` varchar(150) DEFAULT NULL COMMENT '结清申请原因',
  `deposit_account_name` varchar(50) DEFAULT NULL COMMENT '保证金收款账户名称',
  `sub_bank_name` varchar(150) DEFAULT NULL COMMENT '开户网点 支行名称',
  `deposit_account_no` varchar(50) DEFAULT NULL COMMENT '保证金收款账户卡号',
  `addressee_name` varchar(50) DEFAULT NULL COMMENT '收件人姓名',
  `addressee_mobile` varchar(20) DEFAULT NULL COMMENT '收件人电话',
  `addressee_pid` varchar(10) DEFAULT NULL COMMENT '收件人地址省id',
  `addressee_pname` varchar(50) DEFAULT NULL COMMENT '收件人地址省name',
  `addressee_cid` varchar(10) DEFAULT NULL COMMENT '收件人地址市id',
  `addressee_cname` varchar(50) DEFAULT NULL COMMENT '收件人地址市name',
  `addressee_rid` varchar(10) DEFAULT NULL COMMENT '收件人地址区id',
  `addressee_rname` varchar(50) DEFAULT NULL COMMENT '收件人地址区name',
  `addressee_detail` varchar(200) DEFAULT NULL COMMENT '收件人详细地址',
  `is_inuse` int(1) DEFAULT NULL COMMENT '是否启用(1:启用，2：停用)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '经办人ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '经办人名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '经办机构id',
  `org_name` varchar(100) DEFAULT NULL COMMENT '经办机构名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  `is_normal_settle` int(2) DEFAULT NULL COMMENT '是否正常结清1是  0否',
  `settle_type_code` int(2) DEFAULT NULL COMMENT '结清类型（1到期结清 2提前结清 3赎车结清 4卖车结清 5其他方式结清 6 代偿结清）',
  `settle_type` varchar(100) DEFAULT NULL COMMENT '结清类型',
  `other_settle_type` varchar(255) DEFAULT NULL COMMENT '其他结清方式',
  `is_skip_confirm` int(2) NOT NULL DEFAULT '0' COMMENT ' 是否跳过 结清确认（1:跳过 0:不跳过）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=27281 DEFAULT CHARSET=utf8 COMMENT='贷款结清数据记录表';

-- ----------------------------
-- Table structure for loan_special_deal
-- ----------------------------
DROP TABLE IF EXISTS `loan_special_deal`;
CREATE TABLE `loan_special_deal` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `special_type` int(2) DEFAULT NULL COMMENT '类型 1 贷后逾期清单数据 ',
  `original_value` varchar(100) DEFAULT NULL COMMENT '原值',
  `target_value` varchar(100) DEFAULT NULL COMMENT '目标值',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='车贷特殊值处理';

-- ----------------------------
-- Table structure for loan_template_content_list
-- ----------------------------
DROP TABLE IF EXISTS `loan_template_content_list`;
CREATE TABLE `loan_template_content_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content_id` bigint(20) DEFAULT NULL,
  `content_item` varchar(255) DEFAULT NULL,
  `sort_no` int(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan_unsecured
-- ----------------------------
DROP TABLE IF EXISTS `loan_unsecured`;
CREATE TABLE `loan_unsecured` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `order_no` varchar(100) DEFAULT NULL COMMENT '合作机构订单号',
  `card_no` varchar(20) DEFAULT NULL COMMENT '卡号',
  `id_type` varchar(8) DEFAULT NULL COMMENT '证件类型',
  `id_num` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `loan_date` varchar(10) DEFAULT NULL COMMENT '放宽日期',
  `actual_instalment_amount` varchar(20) DEFAULT NULL,
  `actual_installment_number` varchar(10) DEFAULT NULL COMMENT '实际分期期数',
  `car_type` varchar(50) DEFAULT NULL COMMENT '车辆型号',
  `amount_entered` varchar(20) DEFAULT NULL COMMENT '已入账金额',
  `installment_balance` varchar(20) DEFAULT NULL COMMENT '分期余额',
  `unsecured_days` varchar(10) DEFAULT NULL COMMENT '未抵押天数',
  `residual_instalment_price` varchar(20) DEFAULT NULL COMMENT '剩余分期本金',
  `business_guarantor` varchar(50) DEFAULT NULL COMMENT '业务担保方',
  `ownership_branch` varchar(50) DEFAULT NULL COMMENT '所属支行',
  `business_type` varchar(50) DEFAULT NULL COMMENT '分期付款业务种类',
  `project_id` varchar(20) DEFAULT NULL COMMENT '车贷projectId字段',
  PRIMARY KEY (`id`),
  KEY `idx_loan_unsecured_id_num` (`id_num`)
) ENGINE=InnoDB AUTO_INCREMENT=8676 DEFAULT CHARSET=utf8 COMMENT='已放款未抵押明细查询（3）';

-- ----------------------------
-- Table structure for loan_visa_info
-- ----------------------------
DROP TABLE IF EXISTS `loan_visa_info`;
CREATE TABLE `loan_visa_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) DEFAULT NULL,
  `business_no` bigint(20) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mid_agency_ftp_info
-- ----------------------------
DROP TABLE IF EXISTS `mid_agency_ftp_info`;
CREATE TABLE `mid_agency_ftp_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_org_id` bigint(20) DEFAULT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) DEFAULT NULL COMMENT '合作单位名称',
  `ftp_folder` varchar(100) DEFAULT NULL COMMENT 'ftp目录',
  `ftp_url` varchar(100) DEFAULT NULL COMMENT 'ftp地址',
  `ftp_port` int(255) DEFAULT NULL COMMENT 'ftp端口',
  `ftp_user` varchar(50) DEFAULT NULL COMMENT 'ftp用户名',
  `ftp_password` varchar(50) DEFAULT NULL COMMENT 'ftp密码',
  `ftp_type` varchar(20) DEFAULT NULL COMMENT 'ftp类型',
  `is_inuse` int(10) DEFAULT '1' COMMENT '是否启用 1 启用 0 弃用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='合作机构ftp分发配置表';

-- ----------------------------
-- Table structure for mid_repayment_bank_data
-- ----------------------------
DROP TABLE IF EXISTS `mid_repayment_bank_data`;
CREATE TABLE `mid_repayment_bank_data` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户姓名',
  `cert_type` varchar(10) DEFAULT NULL COMMENT '证件类型',
  `cert_no` varchar(50) DEFAULT NULL COMMENT '证件号码',
  `iou_number` varchar(100) DEFAULT NULL COMMENT '借据编号',
  `left_term` int(11) DEFAULT NULL COMMENT '剩余期数',
  `repay_capital` decimal(20,6) DEFAULT NULL COMMENT '应还本金',
  `repay_interest` decimal(20,6) DEFAULT NULL COMMENT '应还利息',
  `repay_default` decimal(20,6) DEFAULT NULL COMMENT '应还罚息',
  `repay_compound_interest` decimal(20,6) DEFAULT NULL COMMENT '应还复利',
  `income_repay_amount` decimal(20,6) DEFAULT NULL COMMENT '还款金额',
  `loan_left_amount` decimal(20,6) DEFAULT NULL COMMENT '贷款余额 昨日剩余贷款金额',
  `overdue_days` int(20) DEFAULT NULL COMMENT '逾期天数',
  `accumulated_overdue_times` int(11) DEFAULT NULL COMMENT '累计逾期次数',
  `continuous_overdue_times` int(11) DEFAULT NULL COMMENT '连续逾期次数',
  `last_overdue_date` date DEFAULT NULL COMMENT '最近逾期日期',
  `agency_org_id` bigint(20) DEFAULT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) DEFAULT NULL COMMENT '合作单位名称',
  `etl_status` int(10) DEFAULT '0' COMMENT '跑批状态：1 已跑批 0 未跑批',
  `ftp_status` int(10) DEFAULT '0' COMMENT 'ftp分发状态（1：已分发，0,未分发）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COMMENT='还款数据落地中间表';

-- ----------------------------
-- Table structure for mid_supp_location_list
-- ----------------------------
DROP TABLE IF EXISTS `mid_supp_location_list`;
CREATE TABLE `mid_supp_location_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loc_code` varchar(20) DEFAULT NULL COMMENT '编码',
  `loc_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `loc_level` int(11) DEFAULT NULL COMMENT '0:省  1：市   2：区',
  `parent_code` varchar(20) DEFAULT NULL COMMENT '父编码',
  `is_valid` tinyint(1) DEFAULT '1' COMMENT '0 无效  1有效',
  `initial` varchar(20) DEFAULT NULL COMMENT '首字母',
  `postcode` varchar(10) DEFAULT NULL,
  `un_pledge_days` int(10) DEFAULT NULL COMMENT '未抵押天数预警阈值',
  `modify_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loc_code_UNIQUE` (`loc_code`),
  KEY `index_loc_name` (`loc_name`),
  KEY `index_loc_level` (`loc_level`),
  KEY `idx_parent_loc_is` (`parent_code`,`loc_level`,`is_valid`)
) ENGINE=InnoDB AUTO_INCREMENT=7805 DEFAULT CHARSET=utf8 COMMENT='中国城市编码表';

-- ----------------------------
-- Table structure for modify_user_group_tmp
-- ----------------------------
DROP TABLE IF EXISTS `modify_user_group_tmp`;
CREATE TABLE `modify_user_group_tmp` (
  `project_id` bigint(20) NOT NULL DEFAULT '0',
  `project_no` varchar(50) NOT NULL DEFAULT '',
  `launch_id` bigint(20) NOT NULL DEFAULT '0',
  `launch_name` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ocr_his
-- ----------------------------
DROP TABLE IF EXISTS `ocr_his`;
CREATE TABLE `ocr_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `homeAddressDetail` varchar(255) DEFAULT NULL COMMENT '地址',
  `cardNo` varchar(255) DEFAULT NULL COMMENT '证件号',
  `licenceIssuingAuthority` varchar(255) DEFAULT NULL COMMENT '发证机关',
  `cardNoValid` int(11) DEFAULT NULL COMMENT '是否长期（0，1）',
  `cardNoValidTime` datetime DEFAULT NULL COMMENT '有效期',
  `customerId` bigint(20) DEFAULT NULL COMMENT '客户id',
  `insure` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=598 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operator_address_info
-- ----------------------------
DROP TABLE IF EXISTS `operator_address_info`;
CREATE TABLE `operator_address_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `relative_id` bigint(11) DEFAULT NULL COMMENT '操作员id',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `province` varchar(20) DEFAULT NULL COMMENT '所在省',
  `city` varchar(20) DEFAULT NULL COMMENT '所在市',
  `area` varchar(20) DEFAULT NULL COMMENT '所在区',
  `province_name` varchar(50) DEFAULT NULL COMMENT '所在省名称',
  `city_name` varchar(50) DEFAULT NULL COMMENT '所在市名称',
  `area_name` varchar(50) DEFAULT NULL COMMENT '所在区名称',
  `address` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `post_code` varchar(8) DEFAULT NULL COMMENT '邮编',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='操作员邮寄地址基本信息表';

-- ----------------------------
-- Table structure for order_pay
-- ----------------------------
DROP TABLE IF EXISTS `order_pay`;
CREATE TABLE `order_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `project_no` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `business_type` int(11) DEFAULT NULL,
  `business_name` varchar(255) DEFAULT NULL COMMENT '流程名称',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户姓名',
  `org_name` varchar(255) DEFAULT NULL COMMENT '分公司名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '分公司id',
  `dealer_name` varchar(255) DEFAULT NULL COMMENT '车上名称',
  `dealer_id` int(11) DEFAULT NULL COMMENT '车商id',
  `loan_amount` decimal(10,0) DEFAULT NULL COMMENT '贷款金额',
  `trans_amount` decimal(10,0) DEFAULT NULL COMMENT '交易金额',
  `pay_account` varchar(255) DEFAULT NULL COMMENT '付款账号',
  `pay_account_name` varchar(255) DEFAULT NULL COMMENT '付款账号名',
  `receive_account` varchar(255) DEFAULT NULL COMMENT '收款账号',
  `receive_account_name` varchar(255) DEFAULT NULL COMMENT '收款账户名',
  `flow_status` int(11) DEFAULT NULL COMMENT '流水状态',
  `pay_apply_time` datetime DEFAULT NULL COMMENT '付款申请时间',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for org_config
-- ----------------------------
DROP TABLE IF EXISTS `org_config`;
CREATE TABLE `org_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL COMMENT '类型:例如自然人识别控制-natureCtrl',
  `org_id` bigint(20) NOT NULL COMMENT '机构ID',
  `org_name` varchar(50) NOT NULL COMMENT '机构名称',
  `config_value` varchar(50) NOT NULL COMMENT '配置的值',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for organization_business_jurisdiction
-- ----------------------------
DROP TABLE IF EXISTS `organization_business_jurisdiction`;
CREATE TABLE `organization_business_jurisdiction` (
  `id` bigint(100) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `master_organization_id` bigint(100) NOT NULL COMMENT '主分公司ID',
  `subordination_organization_id` bigint(100) NOT NULL COMMENT '从分公司ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for other_fee_apply
-- ----------------------------
DROP TABLE IF EXISTS `other_fee_apply`;
CREATE TABLE `other_fee_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cost_type` varchar(50) DEFAULT NULL COMMENT '费用类型',
  `cost_category` varchar(50) DEFAULT NULL COMMENT '费用类别',
  `cost_name` varchar(50) DEFAULT NULL COMMENT '费用名称',
  `application_number` varchar(200) DEFAULT NULL COMMENT '诉讼申请编号',
  `handle_legal` varchar(50) DEFAULT NULL COMMENT '经办法务',
  `case_course` varchar(50) DEFAULT NULL COMMENT '案件进程',
  `loan_number` varchar(200) DEFAULT NULL COMMENT '贷款编号',
  `client_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `client_manager` varchar(50) DEFAULT NULL COMMENT '客户经理',
  `company_name` varchar(200) DEFAULT NULL COMMENT '业务机构',
  `cost_money` bigint(20) DEFAULT NULL COMMENT '申请金额',
  `payment_method` varchar(50) DEFAULT NULL COMMENT '付款方式',
  `payee_name` varchar(50) DEFAULT NULL COMMENT '收款人名称',
  `payee_account` bigint(20) DEFAULT NULL COMMENT '收款账号',
  `payee_bank` varchar(50) DEFAULT NULL COMMENT '收款银行',
  `handle_name` varchar(50) DEFAULT NULL COMMENT '经办人',
  `cost_create_time` datetime DEFAULT NULL COMMENT '费用发生日期',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for overdue_collection_list
-- ----------------------------
DROP TABLE IF EXISTS `overdue_collection_list`;
CREATE TABLE `overdue_collection_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `platno` varchar(5) DEFAULT '' COMMENT '平台编号',
  `assurer_no` varchar(20) DEFAULT NULL COMMENT '担保单位编号',
  `zone_no` varchar(5) DEFAULT NULL COMMENT '业务发生地',
  `data_dt` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `order_no` varchar(100) DEFAULT NULL COMMENT '合作机构订单号',
  `card_no` varchar(30) DEFAULT NULL COMMENT '卡号',
  `name` varchar(100) DEFAULT NULL COMMENT '客户姓名',
  `id_type` varchar(8) DEFAULT NULL COMMENT '证件类型',
  `id_num` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `divi_no` varchar(8) DEFAULT NULL COMMENT '分期业务种类',
  `term` varchar(30) DEFAULT NULL COMMENT '分期期数',
  `left_num` varchar(30) DEFAULT NULL COMMENT '剩余期数',
  `loan_date` varchar(10) DEFAULT NULL COMMENT '放宽日期',
  `op_brno` varchar(10) DEFAULT NULL COMMENT '经办支行',
  `confirm_amt` varchar(18) DEFAULT NULL COMMENT '贷款金额',
  `hdwcrman_authamt` varchar(18) DEFAULT NULL COMMENT '贷款余额',
  `hdwrsism_authamt` varchar(18) DEFAULT NULL COMMENT '授权金额',
  `dtop_amt` varchar(18) DEFAULT NULL COMMENT '昨日最优还款额',
  `lstbal` varchar(18) DEFAULT NULL COMMENT '昨日余额',
  `monre_pay` varchar(18) DEFAULT NULL COMMENT '月还款额(EACHAMT+EACHPFEE)',
  `real_amt` varchar(18) DEFAULT NULL COMMENT '已入帐金额',
  `unpayb_amt` varchar(18) DEFAULT NULL COMMENT '分期付款未还款本金',
  `unpayb_fee` varchar(18) DEFAULT NULL COMMENT '分期付款未还款手续费',
  `hdwrsism_conerdate` varchar(10) DEFAULT NULL COMMENT '上次违约日期',
  `hdwrsism_errdate` varchar(10) DEFAULT NULL COMMENT '上次违约日期',
  `err_num` varchar(3) DEFAULT NULL COMMENT '累计违约次数',
  `coner_num` varchar(3) DEFAULT NULL COMMENT '连续违约次数',
  `project_id` varchar(20) DEFAULT NULL COMMENT '车贷projectId字段',
  PRIMARY KEY (`id`),
  KEY `inx_overdue_collection_list_id_num` (`id_num`)
) ENGINE=InnoDB AUTO_INCREMENT=654641 DEFAULT CHARSET=utf8 COMMENT='逾期催收清单文件(1)';

-- ----------------------------
-- Table structure for overdue_daily_info
-- ----------------------------
DROP TABLE IF EXISTS `overdue_daily_info`;
CREATE TABLE `overdue_daily_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `etl_date` datetime DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(50) DEFAULT NULL,
  `co_bank_id` bigint(20) DEFAULT NULL,
  `co_bank_name` varchar(50) DEFAULT NULL,
  `non_first_term_uncleared_num` int(11) NOT NULL DEFAULT '0' COMMENT '不含首期的放款未结清客户数',
  `first_term_num` int(11) NOT NULL DEFAULT '0' COMMENT '首期放款未结清客户数',
  `first_overdue_num` int(11) NOT NULL DEFAULT '0' COMMENT '首期逾期客户数',
  `yesterday_overdue_num` int(11) NOT NULL DEFAULT '0' COMMENT '昨日逾期客户数',
  `current_overdue_num` int(11) NOT NULL DEFAULT '0' COMMENT '当前逾期数',
  `once_overdue_num` int(11) NOT NULL DEFAULT '0' COMMENT '连续一次逾期客户数',
  `twice_overdue_num` int(11) NOT NULL DEFAULT '0' COMMENT '连续两次逾期客户数',
  `thrice_and_more_num` int(11) NOT NULL DEFAULT '0' COMMENT '连续三次逾期客户数',
  `advance_num` int(11) NOT NULL DEFAULT '0' COMMENT '垫款客户数',
  `advance_amount` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT '垫款总额',
  `advance_payee_num` int(11) NOT NULL DEFAULT '0' COMMENT '垫款回收客户数',
  `advance_payee_amount` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT '垫款回收总额',
  PRIMARY KEY (`id`),
  KEY `etl_date` (`etl_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3436 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for overdue_monthly_info
-- ----------------------------
DROP TABLE IF EXISTS `overdue_monthly_info`;
CREATE TABLE `overdue_monthly_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `etl_date` datetime DEFAULT NULL COMMENT '数据日期',
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(50) DEFAULT NULL,
  `payment_uncleared_num` int(11) NOT NULL DEFAULT '0' COMMENT '放款未结清客户数',
  `overdue_num` int(11) NOT NULL DEFAULT '0' COMMENT '逾期客户数',
  `twice_or_more` int(11) NOT NULL DEFAULT '0' COMMENT '连续逾期2次及以上客户数',
  PRIMARY KEY (`id`),
  KEY `etl_date` (`etl_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for overdue_times_monthly_report
-- ----------------------------
DROP TABLE IF EXISTS `overdue_times_monthly_report`;
CREATE TABLE `overdue_times_monthly_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL COMMENT '机构Id',
  `group_id` bigint(20) DEFAULT NULL COMMENT '业务组Id',
  `n_one` int(11) DEFAULT NULL COMMENT '连续1次逾期',
  `n_two` int(11) DEFAULT NULL COMMENT '连续2次逾期',
  `n_three` int(11) DEFAULT NULL COMMENT '连续3次及以上逾期',
  `year` int(5) DEFAULT NULL,
  `month` int(3) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COMMENT='逾期统计月报';

-- ----------------------------
-- Table structure for pack_loan_config
-- ----------------------------
DROP TABLE IF EXISTS `pack_loan_config`;
CREATE TABLE `pack_loan_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL COMMENT '配置类型（ORG:分公司     DEALER:车商）',
  `reference_id` bigint(20) DEFAULT NULL COMMENT '关联id（车商或者分公司）',
  `open_all` tinyint(2) DEFAULT NULL COMMENT 'true:分公司下所有车商全开放@车贷，false:配置的车商开放@车贷',
  `deleted` tinyint(2) DEFAULT NULL COMMENT 'true/1:已删除/关闭  false/0：未删除/打开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='分公司和车商@车贷业务白名单配置表';

-- ----------------------------
-- Table structure for page_field_valid_config
-- ----------------------------
DROP TABLE IF EXISTS `page_field_valid_config`;
CREATE TABLE `page_field_valid_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `org_name` varchar(768) DEFAULT NULL,
  `co_bank_id` bigint(20) DEFAULT NULL,
  `co_bank_name` varchar(768) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for param_config
-- ----------------------------
DROP TABLE IF EXISTS `param_config`;
CREATE TABLE `param_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(20) DEFAULT NULL,
  `field_value` varchar(20) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for patch_dir_status_info
-- ----------------------------
DROP TABLE IF EXISTS `patch_dir_status_info`;
CREATE TABLE `patch_dir_status_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `business_id` bigint(20) NOT NULL COMMENT '业务Id',
  `business_no` varchar(32) DEFAULT NULL COMMENT '业务编号',
  `business_type` int(11) NOT NULL COMMENT '业务类型(1-通用业务申请)',
  `dir_patch_status_message` text COMMENT '目录补件状态报文(JSON串形式)',
  `is_inuse` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用 0-停用 1-启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_business_id` (`business_id`) USING BTREE,
  KEY `idx_business_no` (`business_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48226 DEFAULT CHARSET=utf8 COMMENT='目录补件状态表';

-- ----------------------------
-- Table structure for patch_record_info
-- ----------------------------
DROP TABLE IF EXISTS `patch_record_info`;
CREATE TABLE `patch_record_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `business_id` bigint(20) NOT NULL COMMENT '业务Id(如贷款id)',
  `business_no` varchar(64) NOT NULL COMMENT '业务编号(如贷款编号)',
  `business_type` int(2) DEFAULT NULL COMMENT '业务类型(1-通用业务申请)',
  `patch_record_no` varchar(64) DEFAULT NULL COMMENT '补录编号',
  `record_type` int(11) DEFAULT NULL COMMENT '操作类型(1-待新增 2-待替换)',
  `record_receive_message` text COMMENT '待补件报文',
  `patch_dir` varchar(1024) DEFAULT NULL COMMENT '待补件目录(目录编码,分割)',
  `record_receive_opinion` varchar(128) DEFAULT NULL COMMENT '补件原因',
  `record_supply_message` mediumtext COMMENT '补件报文',
  `patch_supply_dir` varchar(1024) DEFAULT NULL COMMENT '实际补件目录(目录编码,分割)',
  `record_status` int(11) DEFAULT '0' COMMENT '补件状态(0-待补件 1-已补件  2-已撤销)',
  `is_inuse` int(1) DEFAULT '1' COMMENT '是否有效（1：有效 0：失效）',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人Id',
  `operator_name` varchar(32) DEFAULT NULL COMMENT '操作人姓名',
  `submitter_id` bigint(20) DEFAULT NULL COMMENT '提交人Id',
  `submitter_name` varchar(32) DEFAULT NULL COMMENT '提交人姓名',
  `record_receive_time` datetime DEFAULT NULL COMMENT '补录通知时间',
  `record_cancel_time` datetime DEFAULT NULL COMMENT '补录撤销时间',
  `record_submit_time` datetime DEFAULT NULL COMMENT '补录提交时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_patch_record_no` (`patch_record_no`) USING BTREE,
  KEY `idx_business_id_business_type` (`business_id`,`business_type`) USING BTREE,
  KEY `idx_business_no_business_type` (`business_no`,`business_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52729 DEFAULT CHARSET=utf8 COMMENT='补件信息表';

-- ----------------------------
-- Table structure for pay_apply
-- ----------------------------
DROP TABLE IF EXISTS `pay_apply`;
CREATE TABLE `pay_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(10000) DEFAULT NULL,
  `group_id` varchar(255) DEFAULT NULL,
  `car_brand` int(11) DEFAULT NULL,
  `car_brand_name` varchar(255) DEFAULT NULL,
  `car_group` int(255) DEFAULT NULL,
  `car_group_name` varchar(255) DEFAULT NULL,
  `car_model` varchar(255) DEFAULT NULL,
  `car_model_name` varchar(255) DEFAULT NULL,
  `seller_account` varchar(255) DEFAULT NULL,
  `car_price` decimal(65,2) DEFAULT NULL,
  `car_loan_amt` varchar(255) DEFAULT NULL,
  `loan_terms_num` varchar(255) DEFAULT NULL,
  `deposit_fee` varchar(255) DEFAULT NULL,
  `gps_fee` varchar(255) DEFAULT NULL,
  `mortgage_fee` varchar(255) DEFAULT NULL,
  `licence_fee` varchar(255) DEFAULT NULL,
  `approve_fee` varchar(255) DEFAULT NULL,
  `collect_fee` varchar(255) DEFAULT NULL,
  `other_fee` varchar(255) DEFAULT NULL,
  `deduct_fee` varchar(255) DEFAULT NULL,
  `real_pay_amt` varchar(255) DEFAULT NULL,
  `is_delete` int(11) DEFAULT NULL,
  `remark` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_user` varchar(255) DEFAULT NULL,
  `update_user` varchar(255) DEFAULT NULL,
  `apply_Date` varchar(50) DEFAULT NULL,
  `received_fee` varchar(255) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `fannance_product_id` int(11) DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `invalid_date` date DEFAULT NULL,
  `pay_amt_per_month` decimal(10,0) DEFAULT NULL,
  `company_rate` varchar(255) DEFAULT NULL COMMENT '公司费率',
  `group_name` varchar(255) DEFAULT NULL,
  `seller_acountName` varchar(255) DEFAULT NULL,
  `dealer_accountNo` varchar(255) DEFAULT NULL,
  `open_Bank` varchar(255) DEFAULT NULL,
  `co_bank_name` varchar(255) DEFAULT NULL,
  `fannance_product_name` varchar(255) DEFAULT NULL,
  `dealer_id` bigint(20) DEFAULT NULL,
  `dealer_name` varchar(255) DEFAULT NULL,
  `company_fee_rate` varchar(255) DEFAULT NULL,
  `project_info_id` bigint(20) DEFAULT NULL COMMENT 'loan_project_info.id',
  `org_id` int(11) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=854 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pledge_info
-- ----------------------------
DROP TABLE IF EXISTS `pledge_info`;
CREATE TABLE `pledge_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `pledge_status` int(4) NOT NULL COMMENT '抵押状态 1：已抵押，2：未抵押',
  `pledge_date` date DEFAULT NULL COMMENT '抵押日期',
  `wararnt_no` varchar(50) DEFAULT NULL COMMENT '抵押权证号',
  `pledge_type` int(4) DEFAULT '1' COMMENT '抵押品类型 1:汽车 2:房产',
  `source` int(4) DEFAULT '2' COMMENT '数据来源 1:人工录入 2:合作单位提交',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作员userId',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '操作员姓名',
  `plate_no` varchar(50) DEFAULT NULL COMMENT '车牌号',
  `register_date` timestamp NULL DEFAULT NULL COMMENT '上牌日期',
  `register_target` int(4) DEFAULT NULL COMMENT '上牌对象 1:公司 2:个人',
  `company_name` varchar(150) DEFAULT '' COMMENT '企业名称，仅当上牌对象为公司时有值',
  `company_code` varchar(50) DEFAULT NULL COMMENT '企业机构代码证，仅当上牌对象为公司时有值',
  `storage_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '出入库状态 参见枚举：com.ftcs.venus.cls.enums.pledge.PledgeStorageStatusEnum',
  `first_approve_operator_id` bigint(20) DEFAULT NULL COMMENT '初审经办人id',
  `first_approve_operator_name` varchar(50) DEFAULT NULL COMMENT '初审经办人姓名',
  `first_approve_date` datetime DEFAULT NULL COMMENT '初审日期',
  `pledge_no` varchar(50) DEFAULT NULL COMMENT '押品编号',
  `in_stock_date` datetime DEFAULT NULL COMMENT '入库日期',
  `out_stock_operator_id` bigint(20) DEFAULT NULL COMMENT '出库经办人id',
  `in_stock_operator_id` bigint(20) DEFAULT NULL COMMENT '入库经办人id',
  `out_stock_operator_name` varchar(50) DEFAULT NULL COMMENT '出库经办人姓名',
  `in_stock_operator_name` varchar(50) DEFAULT NULL COMMENT '入库经办人姓名',
  `out_stock_date` datetime DEFAULT NULL COMMENT '出库日期',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_project_id` (`project_id`) USING BTREE,
  KEY `idx_operator_id` (`operator_id`) USING BTREE,
  KEY `idx_modify_time` (`modify_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16175 DEFAULT CHARSET=utf8 COMMENT='抵押登记表';

-- ----------------------------
-- Table structure for post_loan_approve_project
-- ----------------------------
DROP TABLE IF EXISTS `post_loan_approve_project`;
CREATE TABLE `post_loan_approve_project` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(255) NOT NULL COMMENT '项目编号',
  `loan_amount` decimal(24,4) DEFAULT NULL COMMENT '贷款金额',
  `loan_term` int(10) DEFAULT NULL COMMENT '贷款期限',
  `car_brand` varchar(10) DEFAULT NULL COMMENT '品牌名称',
  `car_brand_name` varchar(150) DEFAULT NULL COMMENT '品牌名称',
  `car_make` varchar(10) DEFAULT NULL COMMENT '车系名称',
  `car_make_name` varchar(150) DEFAULT NULL COMMENT '车系名称',
  `car_model` varchar(10) DEFAULT NULL COMMENT '汽车款型',
  `car_model_name` varchar(150) DEFAULT NULL COMMENT '车型名称',
  `status` int(10) DEFAULT NULL COMMENT '贷款状态',
  `co_bank_id` bigint(20) NOT NULL COMMENT '合作银行id',
  `co_bank_name` varchar(255) NOT NULL COMMENT '合作银行名称',
  `launch_user_id` bigint(20) DEFAULT NULL COMMENT '贷款发起人ID',
  `launch_user_name` varchar(50) DEFAULT NULL COMMENT '贷款发起人NAME',
  `user_group_id` bigint(20) NOT NULL COMMENT '用户组ID',
  `user_group_name` varchar(255) NOT NULL COMMENT '用户组名称',
  `launch_org_id` bigint(20) DEFAULT NULL COMMENT '贷款发起机构ID',
  `launch_org_name` varchar(100) DEFAULT NULL COMMENT '贷款发起机构Name',
  `bank_payment_date` date DEFAULT NULL COMMENT '银行放款日期',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `customer_name` varchar(255) NOT NULL COMMENT '客户名称',
  `card_type` int(10) DEFAULT NULL COMMENT '证件类型（1：身份证，2：军官证，3：侨胞证，4：外籍人士）',
  `card_no` varchar(255) DEFAULT NULL COMMENT '证件号码',
  `mobile_phone` varchar(255) NOT NULL COMMENT '手机号码',
  `home_phone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `bill_date` varchar(10) DEFAULT NULL COMMENT '账单日期',
  `plate_no` varchar(20) DEFAULT NULL COMMENT '车牌号码',
  `pledge_status` int(4) DEFAULT NULL COMMENT '抵押状态 1：已抵押，2：未抵押',
  `repayment_card_no` varchar(255) NOT NULL COMMENT '还款卡号',
  `interest_start_date` date DEFAULT NULL COMMENT '开始息日',
  `interest_end_date` date DEFAULT NULL COMMENT '结束息日',
  `first_repayment_date` date DEFAULT NULL COMMENT '首个扣款日',
  `create_time` datetime NOT NULL COMMENT '登记时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isvalid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据是否有效,1:有效,0:无效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `index_repayment_card_no` (`repayment_card_no`),
  KEY `index_card_no` (`card_no`),
  KEY `index_user_group_id` (`user_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='贷款项目表';

-- ----------------------------
-- Table structure for post_loan_file_info
-- ----------------------------
DROP TABLE IF EXISTS `post_loan_file_info`;
CREATE TABLE `post_loan_file_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `table_name` varchar(64) DEFAULT NULL COMMENT '表名',
  `table_key` varchar(64) DEFAULT NULL COMMENT '表主键',
  `table_key_value` varchar(64) DEFAULT NULL COMMENT '表主键值',
  `file_path` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_size` decimal(18,2) DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mtime` (`modify_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2033 DEFAULT CHARSET=utf8 COMMENT='贷后文件表';

-- ----------------------------
-- Table structure for post_loan_import_log
-- ----------------------------
DROP TABLE IF EXISTS `post_loan_import_log`;
CREATE TABLE `post_loan_import_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(255) DEFAULT NULL,
  `IMPORTDATE` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `FILEPATH` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for post_loan_record
-- ----------------------------
DROP TABLE IF EXISTS `post_loan_record`;
CREATE TABLE `post_loan_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` varchar(255) DEFAULT NULL,
  `currentNum` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for print_application
-- ----------------------------
DROP TABLE IF EXISTS `print_application`;
CREATE TABLE `print_application` (
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `project_no` varchar(255) NOT NULL COMMENT '项目编号',
  `print_status` int(4) DEFAULT '0' COMMENT '预算单打印状态，0：未打印，1：已打印 ',
  `update_time` datetime DEFAULT NULL COMMENT '开票价修改时间',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待打印预算单列表';

-- ----------------------------
-- Table structure for pub_card_bin
-- ----------------------------
DROP TABLE IF EXISTS `pub_card_bin`;
CREATE TABLE `pub_card_bin` (
  `BANK_NAME` varchar(255) DEFAULT NULL COMMENT '银行名称',
  `CARD_BIN` varchar(255) NOT NULL COMMENT '卡bin',
  PRIMARY KEY (`CARD_BIN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卡bin表';

-- ----------------------------
-- Table structure for purchase_apply
-- ----------------------------
DROP TABLE IF EXISTS `purchase_apply`;
CREATE TABLE `purchase_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_num` varchar(100) DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  `apply_org_id` bigint(20) DEFAULT NULL,
  `apply_org_name` varchar(100) DEFAULT NULL,
  `apply_user_id` bigint(20) DEFAULT NULL,
  `apply_user_name` varchar(100) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `model_type` varchar(255) DEFAULT NULL,
  `other_request` varchar(255) DEFAULT NULL,
  `request_time` datetime DEFAULT NULL,
  `apply_number` bigint(20) DEFAULT NULL,
  `apply_status` char(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` bigint(20) DEFAULT NULL,
  `update_org_id` bigint(20) DEFAULT NULL,
  `contract_amt` decimal(24,6) DEFAULT NULL,
  `purchase_contract_id` bigint(20) DEFAULT NULL,
  `stock` bigint(20) DEFAULT NULL,
  `not_stock` bigint(20) DEFAULT NULL,
  `user_stock` bigint(20) DEFAULT NULL,
  `remarks` varchar(4000) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for purchase_contract
-- ----------------------------
DROP TABLE IF EXISTS `purchase_contract`;
CREATE TABLE `purchase_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_num` varchar(100) DEFAULT NULL,
  `supplier` varchar(100) DEFAULT NULL,
  `contract_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `purchase_user_id` bigint(20) DEFAULT NULL,
  `purchase_user_name` varchar(100) DEFAULT NULL,
  `remarks` varchar(4000) DEFAULT NULL,
  `contract_status` varchar(1) DEFAULT NULL,
  `handing_apply_org_id` bigint(20) DEFAULT NULL,
  `handing_apply_org_name` varchar(100) DEFAULT NULL,
  `contract_number` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` bigint(20) DEFAULT NULL,
  `update_org_id` bigint(20) DEFAULT NULL,
  `stock` bigint(20) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for purchase_stock
-- ----------------------------
DROP TABLE IF EXISTS `purchase_stock`;
CREATE TABLE `purchase_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `purchase_apply_id` bigint(20) DEFAULT NULL,
  `purchase_contract_id` bigint(20) DEFAULT NULL,
  `purchase_stock_num` varchar(100) DEFAULT NULL,
  `stock_time` datetime DEFAULT NULL,
  `supplier` varchar(100) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `model_type` varchar(100) DEFAULT NULL,
  `other_request` varchar(100) DEFAULT NULL,
  `apply_num` varchar(100) DEFAULT NULL,
  `contract_num` varchar(100) DEFAULT NULL,
  `remarks` varchar(4000) DEFAULT NULL,
  `stock` bigint(20) DEFAULT NULL,
  `del_flag` char(10) DEFAULT NULL,
  `apply_org_id` bigint(20) DEFAULT NULL,
  `apply_org_name` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for purchase_stock_detail
-- ----------------------------
DROP TABLE IF EXISTS `purchase_stock_detail`;
CREATE TABLE `purchase_stock_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `purchase_stock_num` varchar(100) DEFAULT NULL,
  `purchase_apply_id` bigint(20) DEFAULT NULL,
  `purchase_contract_id` bigint(20) DEFAULT NULL,
  `gps_num` varchar(100) DEFAULT NULL,
  `other_attribute` varchar(255) DEFAULT NULL,
  `stock_group_id` bigint(20) DEFAULT NULL,
  `stock_group_name` varchar(255) DEFAULT NULL,
  `stock_time` datetime DEFAULT NULL,
  `remarks` varchar(4000) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  `stock_number` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_user_id` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_user_id` bigint(20) DEFAULT NULL,
  `purchase_stock_id` bigint(20) DEFAULT NULL,
  `stock_status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for purchase_stock_record
-- ----------------------------
DROP TABLE IF EXISTS `purchase_stock_record`;
CREATE TABLE `purchase_stock_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `purchase_stock_detail_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `create_user_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  `install_time` datetime DEFAULT NULL,
  `install_user_name` varchar(100) DEFAULT NULL,
  `remarks` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for receipt_register
-- ----------------------------
DROP TABLE IF EXISTS `receipt_register`;
CREATE TABLE `receipt_register` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fee_manage_id` bigint(20) DEFAULT NULL,
  `fee_category` int(20) DEFAULT NULL,
  `ref_id` bigint(100) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for repayment_card_info
-- ----------------------------
DROP TABLE IF EXISTS `repayment_card_info`;
CREATE TABLE `repayment_card_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `bank_name` varchar(255) DEFAULT NULL COMMENT '开卡银行',
  `card_no` varchar(255) DEFAULT NULL COMMENT '卡号',
  `deliver_type` int(4) DEFAULT NULL COMMENT '送出方式 1：快递，2：客户自取，3：客户经理代送，4：其他',
  `express_company` varchar(255) DEFAULT NULL COMMENT '快递公司',
  `express_no` varchar(255) DEFAULT NULL COMMENT '快递单号',
  `deliver_userid` bigint(20) DEFAULT NULL COMMENT '代送客户经理userId',
  `deliver_realname` varchar(255) DEFAULT NULL COMMENT '代送客户经理姓名',
  `deliver_date` date DEFAULT NULL COMMENT '送出日期（或取卡日期）',
  `delivery_address_pid` varchar(10) DEFAULT NULL COMMENT '收件地址ID',
  `delivery_address_pname` varchar(30) DEFAULT NULL COMMENT '收件地址名称',
  `delivery_address_cid` varchar(10) DEFAULT NULL COMMENT '收件地址格式化市id',
  `delivery_address_cname` varchar(30) DEFAULT NULL COMMENT '收件地址格式化市Name',
  `delivery_address_rid` varchar(10) DEFAULT NULL COMMENT '收件地址格式化区id',
  `delivery_address_rname` varchar(30) DEFAULT NULL COMMENT '收件地址格式化区name',
  `delivery_address_detail` varchar(200) DEFAULT NULL COMMENT '收件详细地址',
  `delivery_address_longitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址经度坐标',
  `delivery_address_latitude` decimal(20,15) DEFAULT NULL COMMENT '收件地址纬度坐标',
  `deliver_addr` varchar(255) DEFAULT NULL COMMENT '收件地址',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `sys_type` varchar(50) DEFAULT NULL COMMENT '系统标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户还款卡管理表';

-- ----------------------------
-- Table structure for role_warning_ref
-- ----------------------------
DROP TABLE IF EXISTS `role_warning_ref`;
CREATE TABLE `role_warning_ref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `warn_type` varchar(80) NOT NULL COMMENT '预警类型',
  `is_inuse` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0:停用;1:启用)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色与预警信息关联关系表';

-- ----------------------------
-- Table structure for rpt_loan_overdue_sum
-- ----------------------------
DROP TABLE IF EXISTS `rpt_loan_overdue_sum`;
CREATE TABLE `rpt_loan_overdue_sum` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `agency_org_id` bigint(20) NOT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) NOT NULL COMMENT '合作单位名称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `biz_type` varchar(4) NOT NULL COMMENT '业务类型',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型',
  `repayment_stock_num` bigint(20) DEFAULT NULL COMMENT '未结清客户数',
  `repayment_yesterday_balance` decimal(20,6) DEFAULT NULL COMMENT '未结清客户贷款余额',
  `overdue_num` bigint(20) DEFAULT NULL COMMENT '逾期客户数',
  `overdue_amount` decimal(20,6) DEFAULT NULL COMMENT '逾期金额',
  `overdue_n1_num` bigint(20) DEFAULT NULL COMMENT 'n1逾期客户数',
  `overdue_n1_amount` decimal(20,6) DEFAULT NULL COMMENT 'n1逾期金额',
  `overdue_n2_num` bigint(20) DEFAULT NULL COMMENT 'n2逾期客户数',
  `overdue_n2_amount` decimal(20,6) DEFAULT NULL COMMENT 'n2逾期金额',
  `overdue_n3_num` bigint(20) DEFAULT NULL COMMENT 'n3逾期客户数',
  `overdue_n3_amount` decimal(20,6) DEFAULT NULL COMMENT 'n3逾期金额',
  `overdue_n4_num` bigint(20) DEFAULT NULL COMMENT 'n4+逾期客户数',
  `overdue_n4_amount` decimal(20,6) DEFAULT NULL COMMENT 'n4+逾期金额',
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_date` (`data_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='逾期统计报表';

-- ----------------------------
-- Table structure for rpt_loan_project_sum
-- ----------------------------
DROP TABLE IF EXISTS `rpt_loan_project_sum`;
CREATE TABLE `rpt_loan_project_sum` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `agency_org_id` bigint(20) NOT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) NOT NULL COMMENT '合作单位名称',
  `agency_short_name` varchar(45) DEFAULT NULL COMMENT '合作单位简称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `biz_type` varchar(4) NOT NULL COMMENT '业务类型',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型',
  `credit_submit_num` bigint(20) DEFAULT NULL COMMENT '征信发起笔数',
  `credit_pass_num` bigint(20) DEFAULT NULL COMMENT '征信通过笔数',
  `credit_fail_num` bigint(20) DEFAULT NULL COMMENT '征信拒绝笔数',
  `loan_apply_num` bigint(20) DEFAULT NULL COMMENT '贷款申请笔数',
  `loan_apply_amount` decimal(20,6) DEFAULT NULL COMMENT '贷款申请金额',
  `loan_pass_num` bigint(20) DEFAULT NULL COMMENT '审批通过笔数',
  `loan_pass_amount` decimal(20,6) DEFAULT NULL COMMENT '审批通过金额',
  `bank_payment_num` bigint(20) DEFAULT NULL COMMENT '放款成功笔数',
  `bank_payment_amount` decimal(20,6) DEFAULT NULL COMMENT '放款成功金额',
  `loan_pledge_num` bigint(20) DEFAULT NULL COMMENT '完成抵押笔数',
  `loan_pledge_amount` decimal(20,6) DEFAULT NULL COMMENT '完成抵押贷款金额',
  `data_review_num` bigint(20) DEFAULT NULL COMMENT '资料复核通过笔数',
  `data_review_amount` decimal(20,6) DEFAULT NULL COMMENT '资料复核通过金额',
  `state_date` date DEFAULT NULL COMMENT '统计日期',
  `state_week` varchar(10) DEFAULT NULL COMMENT '统计周',
  `state_month` bigint(10) DEFAULT NULL COMMENT '统计月',
  `state_year` bigint(10) DEFAULT NULL COMMENT '统计年',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_absbbs` (`agency_org_id`,`branch_org_id`,`sub_org_id`,`biz_type`,`biz_product_type`,`state_date`) USING BTREE,
  KEY `idx_date` (`state_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8 COMMENT='贷款统计报表';

-- ----------------------------
-- Table structure for rpt_loan_unpledge_sum
-- ----------------------------
DROP TABLE IF EXISTS `rpt_loan_unpledge_sum`;
CREATE TABLE `rpt_loan_unpledge_sum` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `agency_org_id` bigint(20) NOT NULL COMMENT '合作单位Id',
  `agency_org_name` varchar(32) NOT NULL COMMENT '合作单位名称',
  `branch_org_id` bigint(20) DEFAULT NULL COMMENT '分行级机构Id',
  `branch_org_name` varchar(32) DEFAULT NULL COMMENT '分行级机构名称',
  `sub_org_id` bigint(20) DEFAULT NULL COMMENT '支行级机构Id',
  `sub_org_name` varchar(32) DEFAULT NULL COMMENT '支行级机构名称',
  `biz_type` varchar(4) NOT NULL COMMENT '业务类型',
  `biz_product_type` varchar(16) DEFAULT NULL COMMENT '业务品种类型',
  `unpledge_duration` bigint(20) DEFAULT NULL COMMENT '未抵押时长code（1 ≤15日;2 16-30日）; 3 31-60日;4 ≥61日',
  `unpledge_duration_name` varchar(32) DEFAULT NULL COMMENT '未抵押时长',
  `unpledge_num` bigint(20) DEFAULT NULL COMMENT '未抵押笔数',
  `unpledge_amount` bigint(20) DEFAULT NULL COMMENT '未抵押业务放款金额',
  `data_date` date DEFAULT NULL COMMENT '数据日期',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_date` (`data_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8 COMMENT='未抵押业务统计';

-- ----------------------------
-- Table structure for second_hand_car_info
-- ----------------------------
DROP TABLE IF EXISTS `second_hand_car_info`;
CREATE TABLE `second_hand_car_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NOT NULL COMMENT '项目主键',
  `loan_car_info_id` bigint(20) NOT NULL COMMENT '车辆信息表ID',
  `first_playing_card_province_code` varchar(15) DEFAULT NULL COMMENT '初次上牌省份编码',
  `first_playing_card_province` varchar(255) DEFAULT NULL COMMENT '初次上牌省份名称',
  `first_playing_card_city_code` varchar(15) DEFAULT NULL COMMENT '初次上牌城市编码',
  `first_playing_card_city` varchar(255) DEFAULT NULL COMMENT '初次上牌城市名称',
  `transfer_total` int(20) DEFAULT NULL COMMENT '累计过户次数',
  `kilometres` int(11) NOT NULL COMMENT '公里数',
  `car_color` varchar(255) DEFAULT NULL COMMENT '车辆颜色',
  `second_hand_car_evaluation_price` decimal(10,2) DEFAULT NULL COMMENT '二手车评估价',
  `estimate_num` varchar(30) DEFAULT NULL COMMENT '二手车评估流水号',
  `card_type` varchar(10) DEFAULT NULL COMMENT '证件类型',
  `card_type_num` varchar(10) DEFAULT NULL COMMENT '证件类型编号',
  `card_num` varchar(30) DEFAULT NULL COMMENT '证件号码',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '客户ID',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `license_date` date DEFAULT NULL COMMENT '上牌时间',
  `new_car_price` decimal(20,6) DEFAULT NULL COMMENT '新车价格',
  `second_hand_car_price` decimal(20,6) DEFAULT NULL COMMENT '二手车价格',
  `first_estimate_source_key` varchar(10) DEFAULT NULL COMMENT '评估结果来源key',
  `first_estimate_source_name` varchar(20) DEFAULT NULL COMMENT '评估结果来源名称',
  `first_estimate_user_id` bigint(20) DEFAULT NULL COMMENT '初评师ID',
  `first_estimate_user_name` varchar(10) DEFAULT NULL COMMENT '初评师名称',
  `original_estimate_num` varchar(30) DEFAULT NULL COMMENT '原评估单号（只有在评估来源为第三方评估机构时才有效）',
  `estimate_organization_key` tinyint(4) DEFAULT NULL COMMENT '评估机构code 详见com.ftcs.venus.cls.enums.UsedCarEstimateOrganizationEnum',
  `estimate_organization_name` varchar(30) DEFAULT NULL COMMENT '评估机构名称（只有在评估来源为第三方评估机构时才有效）',
  `first_estimate_price` decimal(20,6) DEFAULT NULL COMMENT '初评价格',
  `first_estimate_desc` varchar(256) DEFAULT NULL COMMENT '初评描述',
  `first_estimate_datetime` datetime DEFAULT NULL COMMENT '初评日期',
  `second_estimate_user_id` bigint(20) DEFAULT NULL COMMENT '复评师ID',
  `second_estimate_user_name` varchar(10) DEFAULT NULL COMMENT '复评师名称',
  `second_estimate_price` decimal(20,6) DEFAULT NULL COMMENT '复评价格',
  `second_estimate_desc` varchar(100) DEFAULT NULL COMMENT '复评描述',
  `second_estimate_datetime` datetime DEFAULT NULL COMMENT '复评日期',
  `estimate_status` int(11) DEFAULT '0' COMMENT '评估状态（0：评估发起；1：初评中；2：初评完成；3：复评中；4：复评完成 5:已作废）',
  `transfer_date` date DEFAULT NULL COMMENT '过户日期',
  `invoice_price` decimal(20,6) DEFAULT NULL COMMENT '最高评估价格',
  `real_invoice_price` decimal(20,6) DEFAULT NULL COMMENT '开票价',
  `isvalid` tinyint(1) DEFAULT '1' COMMENT '数据是否有效',
  `used_car_month` int(3) DEFAULT NULL COMMENT '二手车使用时间（月）',
  `transfer_status` int(11) DEFAULT NULL COMMENT '过户状态（0：已提交过户申请；1：已完成; 2:贷款作废）',
  `transfer_memo` varchar(100) DEFAULT NULL COMMENT '过户备注',
  `estimate_org_code` varchar(255) DEFAULT NULL COMMENT '第三方评估机构编码',
  `estimate_org_name` varchar(255) DEFAULT NULL COMMENT '第三方评估机构名称',
  `assessment_report_pdf` varchar(255) DEFAULT NULL COMMENT '评估书pdf',
  `assessment_report_h5_url` varchar(255) DEFAULT NULL COMMENT '评估报告pc端h5链接',
  `third_party_estimate_status` int(20) DEFAULT NULL COMMENT '第三方评估状态 0:评估中 1评估成功 2评估失败 3提交失败',
  `third_party_estimate_sale_price` decimal(20,0) DEFAULT NULL COMMENT '第三方评估销售价',
  `third_party_estimate_time` datetime DEFAULT NULL COMMENT '第三方鉴定时间',
  `remark` varchar(2048) DEFAULT NULL COMMENT '第三方评估备注信息',
  `app_assessment_report_h5_url` varchar(255) DEFAULT NULL COMMENT '评估报告app端h5链接',
  `third_party_estimate_apply_time` datetime DEFAULT NULL COMMENT '第三方评估申请时间',
  `use_character` tinyint(4) DEFAULT NULL COMMENT '车辆性质 详见枚举com.ftcs.venus.cls.enums.UseCharacterEnum',
  `support_data_id` bigint(20) DEFAULT NULL COMMENT '对应的support_data库的评估记录id',
  `remarks` varchar(256) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_loan_car_info_id` (`loan_car_info_id`) USING BTREE,
  KEY `estimate_num_index` (`estimate_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1847 DEFAULT CHARSET=utf8 COMMENT='二手车信息表，评估及过户信息';

-- ----------------------------
-- Table structure for settlement_template_file
-- ----------------------------
DROP TABLE IF EXISTS `settlement_template_file`;
CREATE TABLE `settlement_template_file` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `bank_id` bigint(11) DEFAULT NULL COMMENT '合作银行ID',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '合作银行名称',
  `template_file` varchar(255) DEFAULT NULL COMMENT '文件URL',
  `settlement_file_name` varchar(100) DEFAULT NULL COMMENT '文件的名称',
  `settlement_size` double DEFAULT NULL COMMENT '文件大小',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='结清资料模板下载表';

-- ----------------------------
-- Table structure for sign_mid_ftcs_order_no
-- ----------------------------
DROP TABLE IF EXISTS `sign_mid_ftcs_order_no`;
CREATE TABLE `sign_mid_ftcs_order_no` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `business_type` varchar(31) NOT NULL COMMENT '业务类型',
  `business_id` bigint(31) NOT NULL COMMENT '业务id',
  `mid_ftcs_order_no` varchar(40) NOT NULL COMMENT '电子签约中间件订单号',
  `template_no_list` varchar(500) DEFAULT NULL COMMENT '签约合同模板编号列表\n',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_business_type_business_id` (`business_type`,`business_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58247 DEFAULT CHARSET=utf8 COMMENT='客户签约中间件返回的ftcsOrderNo对应星驰业务id表';

-- ----------------------------
-- Table structure for sms_validate_code
-- ----------------------------
DROP TABLE IF EXISTS `sms_validate_code`;
CREATE TABLE `sms_validate_code` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uid` bigint(50) DEFAULT NULL COMMENT '用户ID',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `validate_code` varchar(20) DEFAULT NULL COMMENT '验证码',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` int(1) DEFAULT NULL COMMENT '状态字段：0表示有效，1表示无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for temp_table_scope
-- ----------------------------
DROP TABLE IF EXISTS `temp_table_scope`;
CREATE TABLE `temp_table_scope` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `db` varchar(10) NOT NULL COMMENT '所属',
  `table_scope` varchar(50) NOT NULL COMMENT '表名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='星驰使用表';

-- ----------------------------
-- Table structure for user_biz_statistics
-- ----------------------------
DROP TABLE IF EXISTS `user_biz_statistics`;
CREATE TABLE `user_biz_statistics` (
  `user_id` int(55) NOT NULL COMMENT '用户id',
  `business_type` varchar(100) NOT NULL COMMENT '业务类型，标识此为哪一种业务对象',
  `node_key` varchar(100) NOT NULL DEFAULT '' COMMENT '流程节点的key',
  `operator_num` int(55) DEFAULT NULL COMMENT '任务数',
  `operator_avg_minute` decimal(55,2) DEFAULT NULL COMMENT '平均操作分钟数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  UNIQUE KEY `unq_uid_type_key` (`user_id`,`business_type`,`node_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户平均处理时效';

-- ----------------------------
-- Table structure for validation_rule
-- ----------------------------
DROP TABLE IF EXISTS `validation_rule`;
CREATE TABLE `validation_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) NOT NULL COMMENT '请求类名',
  `description` varchar(500) NOT NULL COMMENT '规则说明',
  `js_expression` text NOT NULL COMMENT '验证表达式',
  `param_list` varchar(500) DEFAULT NULL COMMENT '参数列表,多个参数用|隔开，尾部不带分隔符',
  `sort` int(4) NOT NULL DEFAULT '0' COMMENT '规则优先级，最大越优先',
  `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '停用标示(0:启用,1:停用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_class_name` (`class_name`,`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='校验规则表';

-- ----------------------------
-- Table structure for validation_rule_param
-- ----------------------------
DROP TABLE IF EXISTS `validation_rule_param`;
CREATE TABLE `validation_rule_param` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(50) NOT NULL COMMENT '参数名称',
  `description` varchar(1000) NOT NULL COMMENT '参数说明',
  `param_bean` varchar(255) NOT NULL COMMENT '参数获取器',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_fnerp_pn` (`param_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='校验规则参数表';

-- ----------------------------
-- Table structure for warning_notice
-- ----------------------------
DROP TABLE IF EXISTS `warning_notice`;
CREATE TABLE `warning_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_id` bigint(20) DEFAULT NULL COMMENT '业务id',
  `project_id` bigint(20) DEFAULT NULL,
  `project_no` varchar(50) DEFAULT NULL COMMENT '项目编号',
  `customer_name` varchar(50) DEFAULT NULL,
  `warning_type` int(2) DEFAULT NULL COMMENT '预警类型code',
  `warning_type_name` varchar(50) DEFAULT NULL COMMENT '预警类型名称',
  `warning_reason` varchar(255) DEFAULT NULL COMMENT '预警原因',
  `warning_time` datetime DEFAULT NULL COMMENT '预警时间',
  `create_time` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `org_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_type` (`project_id`,`warning_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8 COMMENT='预警消息';

-- ----------------------------
-- Table structure for warning_operation_record
-- ----------------------------
DROP TABLE IF EXISTS `warning_operation_record`;
CREATE TABLE `warning_operation_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `business_id` bigint(20) DEFAULT NULL COMMENT '业务ID',
  `business_no` varchar(80) DEFAULT NULL COMMENT '业务编码',
  `business_type` varchar(80) DEFAULT NULL COMMENT '业务类型',
  `warn_type` varchar(80) NOT NULL COMMENT '预警类型',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '处理状态 0：待处理 1：已处理',
  `apply_time` datetime NOT NULL COMMENT '预警时间',
  `owner` bigint(20) DEFAULT NULL COMMENT '任务所属人ID',
  `operator_time` datetime DEFAULT NULL COMMENT '处理时间',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '处理人ID',
  `operator_name` varchar(100) DEFAULT NULL COMMENT '处理人名称',
  `operator_remark` varchar(300) DEFAULT NULL COMMENT '处理说明',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='预警信息表';

-- ----------------------------
-- Table structure for workday_config
-- ----------------------------
DROP TABLE IF EXISTS `workday_config`;
CREATE TABLE `workday_config` (
  `id` bigint(31) NOT NULL AUTO_INCREMENT COMMENT ' ',
  `work_date` date DEFAULT NULL COMMENT '日期',
  `start_time` varchar(31) DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(31) DEFAULT NULL COMMENT '结束时间',
  `weeks` varchar(31) DEFAULT NULL COMMENT '星期',
  `is_workday` int(1) DEFAULT NULL COMMENT '是否工作日 0:不是 1:是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15362 DEFAULT CHARSET=utf8 COMMENT='工作日配置表';

-- ----------------------------
-- View structure for account_balance_statistics_view
-- ----------------------------
DROP VIEW IF EXISTS `account_balance_statistics_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `account_balance_statistics_view` AS select `m`.`acc_id` AS `acc_id`,`m`.`org_id` AS `org_id`,`m`.`acc_name` AS `acc_name`,`m`.`card_number` AS `card_number`,`m`.`etl_date` AS `etl_date`,`m`.`money_in` AS `money_in`,`m`.`money_out` AS `money_out`,`m`.`today_balance` AS `today_balance`,`m`.`other_amount` AS `other_amount`,`m`.`dealer_to_company_payee` AS `dealer_to_company_payee`,`m`.`dealer_to_third_payee` AS `dealer_to_third_payee` from (select `t`.`id` AS `acc_id`,`t`.`company_id` AS `org_id`,`t`.`acc_name` AS `acc_name`,`t`.`card_number` AS `card_number`,`t`.`register_date` AS `etl_date`,`t`.`money_in` AS `money_in`,`t`.`money_out` AS `money_out`,`t`.`today_balance` AS `today_balance`,`t`.`other_amount` AS `other_amount`,sum(`abp`.`dealer_to_company`) AS `dealer_to_company_payee`,sum(`abp`.`dealer_to_third`) AS `dealer_to_third_payee` from (((select `cai`.`id` AS `id`,`cai`.`company_id` AS `company_id`,`cai`.`acc_name` AS `acc_name`,`cai`.`card_number` AS `card_number`,`ab`.`register_date` AS `register_date`,`ab`.`money_in` AS `money_in`,`ab`.`money_out` AS `money_out`,`ab`.`today_balance` AS `today_balance`,sum(`bd`.`amount`) AS `other_amount` from ((`cls`.`company_acc_info` `cai` join `cls`.`account_balance` `ab` on((`cai`.`id` = `ab`.`acc_id`))) join `cls`.`balance_detail` `bd` on((`ab`.`id` = `bd`.`balance_id`))) where (`cai`.`is_advance` = 1) group by `ab`.`id`)) `t` left join `cls`.`account_balance_payee` `abp` on(((`t`.`id` = `abp`.`acc_id`) and (`abp`.`payee_date` = `t`.`register_date`) and (`abp`.`deleted` = 0)))) group by `t`.`id`,`t`.`register_date`) `m`;

-- ----------------------------
-- View structure for loan_info_view
-- ----------------------------
DROP VIEW IF EXISTS `loan_info_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `loan_info_view` AS select `lap2`.`id` AS `id`,`lap1`.`relative_apply_id1` AS `relative_apply_id1`,`lap1`.`relative_apply_id2` AS `relative_apply_id2`,`lap1`.`flow_type` AS `flow_type`,`lap1`.`node_key` AS `node_key`,`lap1`.`credit_id` AS `credit_id`,`lap1`.`project_id` AS `project_id`,`lap1`.`project_no` AS `project_no`,`lac`.`customer_id` AS `customer_id`,`lac`.`customer_no` AS `customer_no`,`lac`.`customer_name` AS `customer_name`,`lac`.`sex` AS `sex`,`lac`.`card_type` AS `card_type`,`lac`.`card_no` AS `card_no`,`lac`.`mobile_phone` AS `mobile_phone`,`lac`.`joint_obligor` AS `joint_obligor`,concat(`lac`.`home_address_pname`,`lac`.`home_address_cname`,`lac`.`home_address_rname`,`lac`.`home_address_detail`) AS `home_address`,`lap1`.`business_type_id` AS `business_type_id`,`lap1`.`business_type_name` AS `business_type_name`,`lap1`.`product_id` AS `product_id`,`lap1`.`product_name` AS `product_name`,`lap1`.`status` AS `STATUS`,`lap1`.`data_source` AS `data_source`,`lap1`.`car_type` AS `car_type`,`lap1`.`car_serialno` AS `car_serialno`,`lap1`.`car_brand` AS `car_brand`,`lap1`.`car_brand_name` AS `car_brand_name`,`lap1`.`car_make` AS `car_make`,`lap1`.`car_make_name` AS `car_make_name`,`lap1`.`car_model` AS `car_model`,`lap1`.`car_model_name` AS `car_model_name`,`lap1`.`loan_amount` AS `loan_amount`,`lap1`.`required_amount` AS `required_amount`,`lap1`.`loan_term` AS `loan_term`,`lap1`.`loan_ratio` AS `loan_ratio`,`lap1`.`handing_fee` AS `handing_fee`,`lap1`.`repayment_amount` AS `repayment_amount`,`lap1`.`down_payment_amount` AS `down_payment_amount`,`lap1`.`payment_method` AS `payment_method`,`lap1`.`delivery_method` AS `delivery_method`,`lap1`.`payment_level` AS `payment_level`,`lap1`.`settle_method` AS `settle_method`,`lap1`.`tested_repayment_amount` AS `tested_repayment_amount`,`lap1`.`receivable_amount` AS `receivable_amount`,`lap1`.`collected_amount` AS `collected_amount`,`lap1`.`pre_collected_amount` AS `pre_collected_amount`,`lap1`.`payable_amount` AS `payable_amount`,`lap1`.`policy_finish_flag` AS `policy_finish_flag`,`lap1`.`launch_date` AS `launch_date`,`lap1`.`launch_user_id` AS `launch_user_id`,`lap1`.`launch_user_name` AS `launch_user_name`,`lap1`.`sign_date` AS `sign_date`,`lap1`.`main_signer_id` AS `main_signer_id`,`lap1`.`vice_signer_id` AS `vice_signer_id`,`lap1`.`vice_signer_name` AS `vice_signer_name`,`lap1`.`main_signer_name` AS `main_signer_name`,`lap1`.`review_date` AS `review_date`,`lap1`.`review_user_id` AS `review_user_id`,`lap1`.`review_user_name` AS `review_user_name`,`lap1`.`approve_date` AS `approve_date`,`lap1`.`approve_user_id` AS `approve_user_id`,`lap1`.`approve_user_name` AS `approve_user_name`,`lap1`.`dealer_id` AS `dealer_id`,`lap1`.`dealer_name` AS `dealer_name`,`lap1`.`co_bank_id` AS `co_bank_id`,`lap1`.`co_bank_name` AS `co_bank_name`,`lap1`.`user_id` AS `user_id`,`lap1`.`user_name` AS `user_name`,`lap1`.`user_group_id` AS `user_group_id`,`lap1`.`user_group_name` AS `user_group_name`,`lap1`.`manager_id` AS `manager_id`,`lap1`.`manager_name` AS `manager_name`,`lap1`.`org_id` AS `org_id`,`lap1`.`org_name` AS `org_name`,`lap1`.`gps_no` AS `gps_no`,`lap2`.`guarantee_corporation_payment_date` AS `guarantee_corporation_payment_date`,`lap2`.`guarantee_corporation_payment_amount` AS `guarantee_corporation_payment_amount`,`lap2`.`dealer_payment_date` AS `dealer_payment_date`,`lap2`.`dealer_payment_amount` AS `dealer_payment_amount`,`lap2`.`bank_payment_date` AS `bank_payment_date`,`lap2`.`bank_payment_amount` AS `bank_payment_amount`,`lap2`.`bank_payment_status` AS `bank_payment_status`,`lap1`.`create_time` AS `create_time`,`lap1`.`modify_time` AS `modify_time`,`lap1`.`insurance_state` AS `insurance_state`,`lap1`.`insurance_id` AS `insurance_id`,`lap1`.`insurance_name` AS `insurance_name`,`lap1`.`insurance_time` AS `insurance_time`,`lap1`.`billing_price` AS `billing_price`,`lap1`.`policy_number` AS `policy_number`,`lap1`.`insurance_approve_time` AS `insurance_approve_time`,`lap1`.`body_structure` AS `body_structure`,`lap1`.`province_code` AS `province_code`,`lap1`.`province_name` AS `province_name`,`lap1`.`city_code` AS `city_code`,`lap1`.`city_name` AS `city_name`,`lap1`.`init_vin` AS `init_vin`,`lap1`.`budget_vin` AS `budget_vin`,`lap1`.`warning_level` AS `warning_level`,`lap1`.`warning_result` AS `warning_result`,`lap1`.`new_price` AS `new_price`,`lap1`.`query_user_name` AS `query_user_name`,`lap1`.`warning_car_name` AS `warning_car_name`,`lap1`.`launch_org_id` AS `launch_org_id`,`lap1`.`launch_org_name` AS `launch_org_name`,`lap2`.`pay_status` AS `pay_status`,`lap2`.`is_pay` AS `is_pay`,`lap2`.`unpay_reason` AS `unpay_reason`,`lap2`.`loan_manager` AS `loan_manager`,`lap3`.`plate_no` AS `plate_no`,`lap4`.`repayment_no` AS `repayment_no`,`lap2`.`bank_lending_status` AS `bank_lending_status`,`lap2`.`has_query_bank` AS `has_query_bank`,`lap2`.`query_return` AS `query_return`,`lap2`.`bank_card_no` AS `bank_card_no`,`lap2`.`guarantee_corporation_account_no` AS `guarantee_corporation_account_no`,`lap1`.`guarantee_corporation_id` AS `guarantee_corporation_id` from ((((`loan_approve_project` `lap1` left join `loan_approve_customer` `lac` on((`lac`.`project_id` = `lap1`.`project_id`))) left join `loan_approve_payment` `lap2` on((`lap2`.`project_id` = `lap1`.`project_id`))) left join `license_plate_info` `lap3` on((`lap3`.`project_id` = `lap1`.`project_id`))) left join `loan_contract_info` `lap4` on((`lap4`.`project_id` = `lap1`.`project_id`)));

-- ----------------------------
-- View structure for loan_info_view_new
-- ----------------------------
DROP VIEW IF EXISTS `loan_info_view_new`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `loan_info_view_new` AS select `lap2`.`id` AS `id`,`lap1`.`relative_apply_id1` AS `relative_apply_id1`,`lap1`.`relative_apply_id2` AS `relative_apply_id2`,`lap1`.`flow_type` AS `flow_type`,`lap1`.`node_key` AS `node_key`,`lap1`.`credit_id` AS `credit_id`,`lap1`.`project_id` AS `project_id`,`lap1`.`project_no` AS `project_no`,`lac`.`customer_id` AS `customer_id`,`lac`.`customer_no` AS `customer_no`,`lac`.`customer_name` AS `customer_name`,`lac`.`sex` AS `sex`,`lac`.`card_type` AS `card_type`,`lac`.`card_no` AS `card_no`,`lac`.`mobile_phone` AS `mobile_phone`,`lac`.`joint_obligor` AS `joint_obligor`,concat(`lac`.`home_address_pname`,`lac`.`home_address_cname`,`lac`.`home_address_rname`,`lac`.`home_address_detail`) AS `home_address`,`lap1`.`business_type_id` AS `business_type_id`,`lap1`.`business_type_name` AS `business_type_name`,`lap1`.`product_id` AS `product_id`,`lap1`.`product_name` AS `product_name`,`lap1`.`status` AS `STATUS`,`lap1`.`data_source` AS `data_source`,`lap1`.`car_type` AS `car_type`,`lap1`.`car_serialno` AS `car_serialno`,`lap1`.`car_brand` AS `car_brand`,`lap1`.`car_brand_name` AS `car_brand_name`,`lap1`.`car_make` AS `car_make`,`lap1`.`car_make_name` AS `car_make_name`,`lap1`.`car_model` AS `car_model`,`lap1`.`car_model_name` AS `car_model_name`,`lap1`.`loan_amount` AS `loan_amount`,`lap1`.`required_amount` AS `required_amount`,`lap1`.`loan_term` AS `loan_term`,`lap1`.`loan_ratio` AS `loan_ratio`,`lap1`.`handing_fee` AS `handing_fee`,`lap1`.`repayment_amount` AS `repayment_amount`,`lap1`.`down_payment_amount` AS `down_payment_amount`,`lap1`.`payment_method` AS `payment_method`,`lap1`.`delivery_method` AS `delivery_method`,`lap1`.`payment_level` AS `payment_level`,`lap1`.`settle_method` AS `settle_method`,`lap1`.`tested_repayment_amount` AS `tested_repayment_amount`,`lap1`.`receivable_amount` AS `receivable_amount`,`lap1`.`collected_amount` AS `collected_amount`,`lap1`.`pre_collected_amount` AS `pre_collected_amount`,`lap1`.`payable_amount` AS `payable_amount`,`lap1`.`policy_finish_flag` AS `policy_finish_flag`,`lap1`.`launch_date` AS `launch_date`,`lap1`.`launch_user_id` AS `launch_user_id`,`lap1`.`launch_user_name` AS `launch_user_name`,`lap1`.`sign_date` AS `sign_date`,`lap1`.`main_signer_id` AS `main_signer_id`,`lap1`.`vice_signer_id` AS `vice_signer_id`,`lap1`.`vice_signer_name` AS `vice_signer_name`,`lap1`.`main_signer_name` AS `main_signer_name`,`lap1`.`review_date` AS `review_date`,`lap1`.`review_user_id` AS `review_user_id`,`lap1`.`review_user_name` AS `review_user_name`,`lap1`.`approve_date` AS `approve_date`,`lap1`.`approve_user_id` AS `approve_user_id`,`lap1`.`approve_user_name` AS `approve_user_name`,`lap1`.`dealer_id` AS `dealer_id`,`lap1`.`dealer_name` AS `dealer_name`,`lap1`.`co_bank_id` AS `co_bank_id`,`lap1`.`co_bank_name` AS `co_bank_name`,`lap1`.`user_id` AS `user_id`,`lap1`.`user_name` AS `user_name`,`lap1`.`user_group_id` AS `user_group_id`,`lap1`.`user_group_name` AS `user_group_name`,`lap1`.`manager_id` AS `manager_id`,`lap1`.`manager_name` AS `manager_name`,`lap1`.`org_id` AS `org_id`,`lap1`.`org_name` AS `org_name`,`lap1`.`gps_no` AS `gps_no`,`lap2`.`guarantee_corporation_payment_date` AS `guarantee_corporation_payment_date`,`lap2`.`guarantee_corporation_payment_amount` AS `guarantee_corporation_payment_amount`,`lap2`.`dealer_payment_date` AS `dealer_payment_date`,`lap2`.`dealer_payment_amount` AS `dealer_payment_amount`,`lap2`.`bank_payment_date` AS `bank_payment_date`,`lap2`.`bank_payment_amount` AS `bank_payment_amount`,`lap2`.`bank_payment_status` AS `bank_payment_status`,`lap1`.`create_time` AS `create_time`,`lap1`.`modify_time` AS `modify_time`,`lap1`.`insurance_state` AS `insurance_state`,`lap1`.`insurance_id` AS `insurance_id`,`lap1`.`insurance_name` AS `insurance_name`,`lap1`.`insurance_time` AS `insurance_time`,`lap1`.`billing_price` AS `billing_price`,`lap1`.`policy_number` AS `policy_number`,`lap1`.`insurance_approve_time` AS `insurance_approve_time`,`lap1`.`body_structure` AS `body_structure`,`lap1`.`province_code` AS `province_code`,`lap1`.`province_name` AS `province_name`,`lap1`.`city_code` AS `city_code`,`lap1`.`city_name` AS `city_name`,`lap1`.`init_vin` AS `init_vin`,`lap1`.`budget_vin` AS `budget_vin`,`lap1`.`warning_level` AS `warning_level`,`lap1`.`warning_result` AS `warning_result`,`lap1`.`new_price` AS `new_price`,`lap1`.`query_user_name` AS `query_user_name`,`lap1`.`warning_car_name` AS `warning_car_name`,`lap2`.`pay_status` AS `pay_status`,`lap3`.`plate_no` AS `plate_no`,`lap4`.`repayment_no` AS `repayment_no`,`lap5`.`use_date` AS `gps_use_date`,`lap5`.`install_date` AS `gps_install_date`,`lap5`.`install_person` AS `gps_install_person`,`lap5`.`remark` AS `gps_install_remark`,`lap6`.`gps_producer` AS `gps_producer`,`lap6`.`gps_type` AS `gps_type` from ((((((`loan_approve_project` `lap1` left join `loan_approve_customer` `lac` on((`lac`.`project_id` = `lap1`.`project_id`))) left join `loan_approve_payment` `lap2` on((`lap2`.`project_id` = `lap1`.`project_id`))) left join `license_plate_info` `lap3` on((`lap3`.`project_id` = `lap1`.`project_id`))) left join `loan_contract_info` `lap4` on((`lap4`.`project_id` = `lap1`.`project_id`))) left join `gps_use_install` `lap5` on((`lap5`.`project_id` = `lap1`.`project_id`))) left join `loan_fee_info` `lap6` on((`lap6`.`apply_id` = (case when (`lap1`.`relative_apply_id2` is not null) then `lap1`.`relative_apply_id2` else `lap1`.`relative_apply_id1` end))));

-- ----------------------------
-- View structure for loan_project_view
-- ----------------------------
DROP VIEW IF EXISTS `loan_project_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `loan_project_view` AS select `lpi`.`id` AS `project_id`,`lpi`.`project_no` AS `project_no`,`lpi`.`biz_type` AS `biz_type`,`lpi`.`biz_product_type` AS `biz_product_type`,`lpi`.`agency_org_id` AS `agency_org_id`,`lpi`.`agency_org_name` AS `agency_org_name`,`lpi`.`branch_org_id` AS `branch_org_id`,`lpi`.`branch_org_name` AS `branch_org_name`,`lpi`.`sub_org_id` AS `sub_org_id`,`lpi`.`sub_org_name` AS `sub_org_name`,`lpi`.`create_time` AS `create_time`,`lpi`.`sign_type` AS `sign_type`,`lpe`.`sign_result` AS `sign_result`,`lpe`.`flow_type` AS `flow_type`,`lpe`.`flow_node_key` AS `flow_node_key`,`lpe`.`flow_node_index` AS `flow_node_index`,`lpe`.`flow_node_name` AS `flow_node_name`,`lpe`.`flow_finish_time` AS `flow_finish_time`,`lpe`.`loan_result` AS `loan_result`,`lpe`.`loan_status` AS `loan_status`,`lpe`.`payment_status` AS `payment_status`,`lpe`.`settle_status` AS `settle_status`,`lpe`.`is_inuse` AS `is_inuse`,`cc`.`id` AS `credit_id`,`cc`.`customer_id` AS `customer_id`,`cc`.`customer_name` AS `customer_name`,`cc`.`cert_type` AS `cert_type`,`cc`.`cert_no` AS `cert_no`,`cc`.`create_time` AS `credit_create_time` from ((`loan_project_info` `lpi` left join `loan_project_ext` `lpe` on((`lpi`.`id` = `lpe`.`project_id`))) left join `customer_credit` `cc` on((`lpi`.`credit_id` = `cc`.`id`)));

-- ----------------------------
-- View structure for loan_view
-- ----------------------------
DROP VIEW IF EXISTS `loan_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `loan_view` AS select `loan_project_info`.`car_make_name` AS `car_make_name`,`loan_project_info`.`car_model_name` AS `car_model_name`,`loan_project_info`.`dealer_name` AS `dealer_name`,`loan_project_info`.`project_id` AS `project_id` from `loan_project_info`;

-- ----------------------------
-- Procedure structure for initHistoryCreditNode
-- ----------------------------
DROP PROCEDURE IF EXISTS `initHistoryCreditNode`;
delimiter ;;
CREATE PROCEDURE `cls`.`initHistoryCreditNode`()
BEGIN
DECLARE creditId BIGINT;
DECLARE taskId BIGINT;
DECLARE nodeKey VARCHAR(50);
DECLARE nodeIndex INT;
DECLARE nodeName VARCHAR(50);
DECLARE done INT DEFAULT FALSE;
DECLARE creditIdCur CURSOR FOR SELECT id FROM customer_credit;


DECLARE taskIdCur CURSOR FOR SELECT MAX(id)AS task_id FROM business_object_process_info WHERE business_object_id = creditId and business_type='CREDIT_FLOW';

-- 将结束标志绑定到游标
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

-- 打开游标
OPEN creditIdCur;

-- 遍历
read_loop :
LOOP
	FETCH creditIdCur INTO creditId;


IF done THEN
	LEAVE read_loop;
END
IF;



OPEN taskIdCur;

inner_loop :
LOOP
	FETCH taskIdCur INTO taskId;


IF done THEN
	LEAVE inner_loop;
END
IF;

select node_key into nodeKey from business_object_process_info bi where bi.id = taskId and business_type='CREDIT_FLOW';
select node_index into nodeIndex from business_object_process_info bi where bi.id = taskId and business_type='CREDIT_FLOW';
select node_name into nodeName from business_object_process_info bi where bi.id = taskId and business_type='CREDIT_FLOW';

UPDATE customer_credit cc
SET cc.node_index = nodeIndex,
cc.node_key = nodeKey,
cc.node_name = nodeName
WHERE
	id = creditId;


SET nodeKey = "";
SET nodeName = "";
set nodeIndex = 0;

END
LOOP
;

CLOSE taskIdCur;


SET done = FALSE;


END
LOOP
;

CLOSE creditIdCur;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for mock_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `mock_insert`;
delimiter ;;
CREATE PROCEDURE `cls`.`mock_insert`(in source_customer_name varchar(32), in duplicate_nums int)
BEGIN

	DECLARE i INT DEFAULT 0;
	SET @dateParam = DATE_FORMAT(now(), '%Y%m%d%H%i%S');
	select id, card_no into @sourceCustomerId ,@sourceCardNo from customer_base_info where customer_name = source_customer_name;
  set @sourceCreditRelId = (select id from customer_credit_relavant where full_name = source_customer_name);
	SELECT apply_id, project_id into @sourceApplyId, @sourceProjectId from loan_customer_info where customer_name = source_customer_name;

	WHILE i < duplicate_nums DO
		# 证件号码替换为 x(原证件号码) + yyyyMMddHHmmss(14) + i(序列)
		set @tmpDateParam = @dateParam + i;
		set @tmpDateLength = LENGTH(@tmpDateParam);
		set @tmpCardNo = CONCAT(substring(@sourceCardNo, 1, 18 - @tmpDateLength), @tmpDateParam);
		set @tmpCustomerName = CONCAT(source_customer_name,i);
		#1. 客户
		INSERT INTO customer_base_info(customer_name, en_customer_name, customer_no, customer_number, source, manager_id, register_date, gender, card_type, card_no,
																	card_no_valid, card_no_valid_time,licence_issuing_authority, birthday, age, marital_status, mobile, home_phone, native_place, education,
																	housing_status, month_repayment, driver_licence, profession,profession_code, post, post_name, industry, work_nature, work_nature_code, employ_time,
																	monthly_income, yearly_income, company, work_phone, reserved_funds, reserved_funds_year, social_year, company_address_province_code, company_address_province,
																	company_address_city_code, company_address_city, company_address_county_code, company_address_county,company_address, home_address_province_code, home_address_province,
																	home_address_city_code, home_address_city, home_address_county_code, home_address_county, home_address_village,
																	cur_address_time, spouse_name, spouse_card_type, spouse_card_no, spouse_mobile, spouse_native_place, spouse_reserved_funds, spouse_company, spouse_reserved_funds_year,
																	spouse_driver_licence, spouse_company_phone, spouse_company_addr_province_code, spouse_company_addr_province, spouse_company_addr_city_code, spouse_company_addr_city,
																	spouse_company_addr_county_code, spouse_company_addr_county, spouse_company_addr, spouse_monthly_income, modify_time, `status`, risk_status)
													SELECT @tmpCustomerName, en_customer_name, CONCAT('MGK',@tmpCardNo), customer_number, source, manager_id, register_date, gender, card_type, @tmpCardNo,
																	card_no_valid, card_no_valid_time,licence_issuing_authority, birthday, age, marital_status, mobile, home_phone, native_place, education,
																	housing_status, month_repayment, driver_licence, profession,profession_code, post, post_name, industry, work_nature, work_nature_code, employ_time,
																	monthly_income, yearly_income, company, work_phone, reserved_funds, reserved_funds_year, social_year, company_address_province_code, company_address_province,
																	company_address_city_code, company_address_city, company_address_county_code, company_address_county,company_address, home_address_province_code, home_address_province,
																	home_address_city_code, home_address_city, home_address_county_code, home_address_county, home_address_village,
																	cur_address_time, spouse_name, spouse_card_type, spouse_card_no, spouse_mobile, spouse_native_place, spouse_reserved_funds, spouse_company, spouse_reserved_funds_year,
																	spouse_driver_licence, spouse_company_phone, spouse_company_addr_province_code, spouse_company_addr_province, spouse_company_addr_city_code, spouse_company_addr_city,
																	spouse_company_addr_county_code, spouse_company_addr_county, spouse_company_addr, spouse_monthly_income, modify_time, `status`, risk_status 
													 from customer_base_info t where t.customer_name = source_customer_name;
		set @tmpCustomerId = (select id from customer_base_info where card_no = @tmpCardNo);
		insert into customer_manager(customer_id, manager_id, manager_name, management_type, organization, depart, business_team, create_time, `status`, is_read)
									SELECT @tmpCustomerId, manager_id, manager_name, management_type, organization, depart, business_team, create_time, `status`, is_read 
									from customer_manager where customer_id = @sourceCustomerId;
		#2. 征信
		INSERT into customer_credit(source, credit_no,serial_number, credit_type,customer_id, customer_name, card_type, card_no,marital_status, inqury_bank_id, inqury_bank, business_group_id, business_group,
									customer_manager_id, customer_manager, credit_status, create_time, submit_time, modify_time, estimate_loan_amount, auto_credit_send, node_index, node_key, node_name)
									SELECT source, CONCAT('CI',@tmpCardNo),serial_number, credit_type,@tmpCustomerId, @tmpCustomerName, card_type, @tmpCardNo,marital_status, inqury_bank_id, inqury_bank, business_group_id, business_group,
												customer_manager_id, customer_manager, credit_status, create_time, submit_time, modify_time, estimate_loan_amount, auto_credit_send, node_index, node_key, node_name
									from customer_credit where customer_id = @sourceCustomerId;
		set @tmpCreditId = (select id from customer_credit where customer_id = @tmpCustomerId);
		insert INTO customer_credit_relavant(credit_id, full_name, card_type, card_id, credit_status, credit_result, mobile, borrower_relationship, guarantee_relationship, check_type,
										credit_memo_flag, overdue_type, five_class, check_result, staff_id, staff_name, check_date, credit_remark, net_report_date, credit_report_id, 
										create_time, modify_time, risk_status, mortgage_balance, other_balance,loan_repayment, marital_status, report_user, is_sended)
									SELECT @tmpCreditId, @tmpCustomerName, card_type, @tmpCardNo, credit_status, credit_result, mobile, borrower_relationship, guarantee_relationship, check_type,
											credit_memo_flag, overdue_type, five_class, check_result, staff_id, staff_name, check_date, credit_remark, net_report_date, credit_report_id, 
											create_time, modify_time, risk_status, mortgage_balance, other_balance,loan_repayment, marital_status, report_user, is_sended
									FROM customer_credit_relavant where id = @sourceCreditRelId;
		set @tmpCreditRelId = (SELECT id from customer_credit_relavant where credit_id = @tmpCreditId);
		insert into customer_credit_file(credit_relavant_id, credit_file, credit_file_size, credit_type, create_time, modify_time, `status`, push_status)
									SELECT @tmpCreditRelId, credit_file, credit_file_size, credit_type, create_time, modify_time, `status`, push_status 
									from customer_credit_file where credit_relavant_id = @sourceCreditRelId;
		#3. 贷款	loan_apply	loan_approve_contacter	loan_approve_customer	loan_approve_fee	loan_approve_guarantor	loan_approve_payment	loan_approve_project	loan_approve_score_item
		insert INTO loan_apply(flow_type, node_key, project_no, customer_id, customer_no, credit_id, business_type_id, business_type_name,product_id, product_name, `status`, data_source, is_inuse,
										user_id, user_name, user_group_id, user_group_name, org_id, org_name, create_time, modify_time)
									SELECT flow_type, node_key, CONCAT('MOCK', @tmpCardNo), @tmpCustomerId, CONCAT('MGK',@tmpCardNo), @tmpCreditId, business_type_id, business_type_name,product_id, product_name, `status`, data_source, is_inuse,
										user_id, user_name, user_group_id, user_group_name, org_id, org_name, create_time, modify_time
									FROM loan_apply where id = @sourceApplyId;
		set @tmpProjectId = (select id FROM loan_apply where customer_id = @tmpCustomerId);
		update loan_apply set project_id = @tmpProjectId where id = @tmpProjectId;
		
		INSERT INTO loan_approve_contacter(project_id, emergency_contact, relationship, contact_address, mobile_phone, is_car_user, is_inuse, user_id, user_name, org_id, org_name, create_time )
								SELECT @tmpProjectId,emergency_contact, relationship, contact_address, mobile_phone, is_car_user, is_inuse, user_id, user_name, org_id, org_name, create_time
									FROM loan_approve_contacter where project_id = @sourceApplyId;

		INSERT INTO loan_approve_customer(project_id, customer_id, customer_no,customer_name, en_customer_name, card_type, card_no, card_no_valid,licence_issuing_authority,customer_source, source_serialno,sex,birthday,
age, marital_status, mobile_phone, native_place, education, housing_status,mortgage_repayment, driver_licence, profession, profession_code, post, post_name, industry, work_nature,work_nature_code,
employ_time, monthly_income, yearly_income, reserved_funds, reserved_funds_year, social_year, cur_address_time, company_name, company_phone, company_address_pid, company_address_pname,
company_address_cid, company_address_cname, company_address_rid, company_address_rname, company_address_detail, home_address_pid, home_address_pname, home_address_cid, home_address_cname,
home_address_rid, home_address_rname, home_address_detail, is_agency, real_car_owner, register_date, joint_obligor, customer_score_a, customer_score_b, is_inuse, user_id, user_name,
org_id, org_name, create_time ,modify_time, delivery_address_pid, delivery_address_pname, delivery_address_cname, delivery_address_cid, delivery_address_rid, delivery_address_rname,
delivery_address_detail)
		SELECT @tmpProjectId, @tmpCustomerId, CONCAT('MGK',@tmpCardNo),@tmpCustomerName, en_customer_name, card_type, @tmpCardNo, card_no_valid,licence_issuing_authority,customer_source, source_serialno,sex,birthday,
age, marital_status, mobile_phone, native_place, education, housing_status,mortgage_repayment, driver_licence, profession, profession_code, post, post_name, industry, work_nature,work_nature_code,
employ_time, monthly_income, yearly_income, reserved_funds, reserved_funds_year, social_year, cur_address_time, company_name, company_phone, company_address_pid, company_address_pname,
company_address_cid, company_address_cname, company_address_rid, company_address_rname, company_address_detail, home_address_pid, home_address_pname, home_address_cid, home_address_cname,
home_address_rid, home_address_rname, home_address_detail, is_agency, real_car_owner, register_date, joint_obligor, customer_score_a, customer_score_b, is_inuse, user_id, user_name,
org_id, org_name, create_time ,modify_time, delivery_address_pid, delivery_address_pname, delivery_address_cname, delivery_address_cid, delivery_address_rid, delivery_address_rname,
delivery_address_detail	FROM loan_approve_customer where project_id = @sourceApplyId;

		INSERT INTO loan_approve_fee (project_id,premium_type,insurance_amount,insurance_company_id,insurance_company,account_deposit,is_renewal,renewal_deposit,is_pb,pb_deposit,cost_type,cost_amount,predicted_purchasetax,purchase_tax,guaranty_risk_amount,
service_fee,bank_irs_fee,license_fee,door_survey_fee,agency_fee,outsource_survey_fee,gps_number,gps_type,gps_producer,gps_installation_fee,liability_amount,other_fee,total_fee,guarantee_service_fee,bank_downpayment_amount,
bank_installment_amount,bank_installment_fee,notice_downpayment_capital,notice_downpayment_interest,notice_downpayment_amount,notice_periodpayment_capital,notice_periodpayment_interest,notice_periodpayment_amount,
notice_finalpayment_capital,notice_finalpayment_interest,notice_finalpayment_amount,contract_downpayment_capital,contract_downpayment_interest,contract_downpayment_amount,contract_periodpayment_capital,contract_periodpayment_interest,
contract_periodpayment_amount,contract_finalpayment_capital,contract_finalpayment_interest,contract_finalpayment_amount,valuation_fee,bill_date,remark,is_inuse,user_id,user_name,org_id,org_name,create_time,modify_time,old_id,sys_type,is_advance_discount)
SELECT @tmpProjectId,premium_type,insurance_amount,insurance_company_id,insurance_company,account_deposit,is_renewal,renewal_deposit,is_pb,pb_deposit,cost_type,cost_amount,predicted_purchasetax,purchase_tax,guaranty_risk_amount,
service_fee,bank_irs_fee,license_fee,door_survey_fee,agency_fee,outsource_survey_fee,gps_number,gps_type,gps_producer,gps_installation_fee,liability_amount,other_fee,total_fee,guarantee_service_fee,bank_downpayment_amount,
bank_installment_amount,bank_installment_fee,notice_downpayment_capital,notice_downpayment_interest,notice_downpayment_amount,notice_periodpayment_capital,notice_periodpayment_interest,notice_periodpayment_amount,
notice_finalpayment_capital,notice_finalpayment_interest,notice_finalpayment_amount,contract_downpayment_capital,contract_downpayment_interest,contract_downpayment_amount,contract_periodpayment_capital,contract_periodpayment_interest,
contract_periodpayment_amount,contract_finalpayment_capital,contract_finalpayment_interest,contract_finalpayment_amount,valuation_fee,bill_date,remark,is_inuse,user_id,user_name,org_id,org_name,create_time,modify_time,old_id,sys_type,is_advance_discount
		FROM loan_approve_fee where project_id = @sourceApplyId;

		INSERT INTO loan_approve_payment (project_id,guarantee_corporation_id,guarantee_corporation_name,guarantee_corporation_account_name,guarantee_corporation_account_no,guarantee_corporation_bank,guarantee_corporation_payment_amount,guarantee_corporation_payment_date,
guarantee_corporation_payment_user_id,guarantee_corporation_payment_user_name,guarantee_corporation_payment_remark,capital_pool_account_name,capital_pool_account_no,capital_pool_bank,capital_pool_payment_amount,capital_pool_payment_date,
capital_pool_payment_user_id,capital_pool_payment_user_name,capital_pool_payment_remark,dealer_id,dealer_name,employ_dealer_id,employ_dealer_name,dealer_account_name,dealer_account_no,dealer_bank,dealer_payment_amount,dealer_payment_date,
dealer_payment_user_id,dealer_payment_user_name,dealer_payment_remark,bank_id,bank_name,bank_payment_date,bank_payment_amount,bank_payment_remark,bank_payment_user_id,bank_payment_user_name,bank_payment_status,export_status,open_card_fee,
create_time,modify_time,dealer_account_type,old_id,sys_type,pay_status,pay_type,bank_card_no,unpay_reason,is_pay,loan_manager)
		SELECT @tmpProjectId,guarantee_corporation_id,guarantee_corporation_name,guarantee_corporation_account_name,guarantee_corporation_account_no,guarantee_corporation_bank,guarantee_corporation_payment_amount,guarantee_corporation_payment_date,
guarantee_corporation_payment_user_id,guarantee_corporation_payment_user_name,guarantee_corporation_payment_remark,capital_pool_account_name,capital_pool_account_no,capital_pool_bank,capital_pool_payment_amount,capital_pool_payment_date,
capital_pool_payment_user_id,capital_pool_payment_user_name,capital_pool_payment_remark,dealer_id,dealer_name,employ_dealer_id,employ_dealer_name,dealer_account_name,dealer_account_no,dealer_bank,dealer_payment_amount,dealer_payment_date,
dealer_payment_user_id,dealer_payment_user_name,dealer_payment_remark,bank_id,bank_name,bank_payment_date,bank_payment_amount,bank_payment_remark,bank_payment_user_id,bank_payment_user_name,bank_payment_status,export_status,open_card_fee,
create_time,modify_time,dealer_account_type,old_id,sys_type,pay_status,pay_type,bank_card_no,unpay_reason,is_pay,loan_manager
		FROM loan_approve_payment where project_id = @sourceApplyId;

		INSERT INTO loan_approve_project(project_id,relative_apply_id1,relative_apply_id2,flow_type,node_key,credit_id,project_no,business_type_id,business_type_name,product_id,product_name,status,data_source,dealer_order_id,car_type,car_id,car_serialno,car_brand,car_brand_name,
car_make,car_make_name,car_model,car_model_name,body_structure,is_imported,is_advance,online_price,billing_price,evaluation_price,sell_price,second_hand_car_price,loan_amount,required_amount,benchmark_rate,loan_term,loan_ratio,handing_fee,
repayment_amount,down_payment_amount,payment_method,delivery_method,payment_level,settle_method,tested_repayment_amount,guarantee_corporation_id,guarantee_corporation_name,receivable_amount,collected_amount,collected_date,pre_collected_amount,
payable_amount,is_discount,discount_policy_id,discount_policy_name,discount_case_id,discount_margin,discount_car_policy,position_merge,discount_case_name,discount_amount,xzz_discount_amount,main_signer_id,main_signer_name,main_signer_weight,
vice_signer_id,vice_signer_name,vice_signer_weight,sign_date,launch_date,launch_user_id,launch_user_name,launch_org_id,launch_org_name,review_date,review_user_id,review_user_name,review_org_id,review_org_name,approve_date,approve_user_id,
approve_user_name,approve_org_id,approve_org_name,dealer_id,dealer_name,dealer_grade,employ_dealer_id,employ_dealer_name,dealer_fee_id,dealer_fee_name,co_bank_id,co_bank_name,is_public_license,license_company,is_concerned_customer,is_agency,
is_gps_installed1,is_gps_installed2,policy_finish_flag,visit_address_pid,visit_address_pname,visit_address_cid,visit_address_cname,visit_address_rid,visit_address_rname,visit_address_detail,visit_address_longitude,visit_address_latitude,
visit_address_gps_detail,visit_address_gps_name,real_address_pid,real_address_pname,real_address_cid,real_address_cname,real_address_rid,real_address_rname,real_address_detail,real_address_longitude,real_address_latitude,
gps_no,gps_use_date,is_inuse,user_id,user_name,user_group_id,user_group_name,manager_id,manager_name,org_id,org_name,create_time,modify_time,free_door,insurance_state,insurance_id,insurance_name,insurance_time,sys_type,policy_number,
insurance_approve_time,insurance_remark,insurance_back_uid,insurance_back_realname,remark,old_id,document_check_status,document_check_result,is_completed,export_status,is_didi,province_code,province_name,city_code,city_name,query_user_name,
warning_car_name,warning_level,warning_result,init_vin,budget_vin,new_price,car_loan_amount,customer_car_status)
		SELECT @tmpProjectId,@tmpProjectId,relative_apply_id2,flow_type,node_key,@tmpCreditId,CONCAT('MOCK', @tmpCardNo),business_type_id,business_type_name,product_id,product_name,status,data_source,dealer_order_id,car_type,car_id,car_serialno,car_brand,car_brand_name,
car_make,car_make_name,car_model,car_model_name,body_structure,is_imported,is_advance,online_price,billing_price,evaluation_price,sell_price,second_hand_car_price,loan_amount,required_amount,benchmark_rate,loan_term,loan_ratio,handing_fee,
repayment_amount,down_payment_amount,payment_method,delivery_method,payment_level,settle_method,tested_repayment_amount,guarantee_corporation_id,guarantee_corporation_name,receivable_amount,collected_amount,collected_date,pre_collected_amount,
payable_amount,is_discount,discount_policy_id,discount_policy_name,discount_case_id,discount_margin,discount_car_policy,position_merge,discount_case_name,discount_amount,xzz_discount_amount,main_signer_id,main_signer_name,main_signer_weight,
vice_signer_id,vice_signer_name,vice_signer_weight,sign_date,launch_date,launch_user_id,launch_user_name,launch_org_id,launch_org_name,review_date,review_user_id,review_user_name,review_org_id,review_org_name,approve_date,approve_user_id,
approve_user_name,approve_org_id,approve_org_name,dealer_id,dealer_name,dealer_grade,employ_dealer_id,employ_dealer_name,dealer_fee_id,dealer_fee_name,co_bank_id,co_bank_name,is_public_license,license_company,is_concerned_customer,is_agency,
is_gps_installed1,is_gps_installed2,policy_finish_flag,visit_address_pid,visit_address_pname,visit_address_cid,visit_address_cname,visit_address_rid,visit_address_rname,visit_address_detail,visit_address_longitude,visit_address_latitude,
visit_address_gps_detail,visit_address_gps_name,real_address_pid,real_address_pname,real_address_cid,real_address_cname,real_address_rid,real_address_rname,real_address_detail,real_address_longitude,real_address_latitude,
gps_no,gps_use_date,is_inuse,user_id,user_name,user_group_id,user_group_name,manager_id,manager_name,org_id,org_name,create_time,modify_time,free_door,insurance_state,insurance_id,insurance_name,insurance_time,sys_type,policy_number,
insurance_approve_time,insurance_remark,insurance_back_uid,insurance_back_realname,remark,old_id,document_check_status,document_check_result,is_completed,export_status,is_didi,province_code,province_name,city_code,city_name,query_user_name,
warning_car_name,warning_level,warning_result,init_vin,budget_vin,new_price,car_loan_amount,customer_car_status
		FROM loan_approve_project where project_id = @sourceApplyId;

		#skip loan_approve_score_item
#loan_car_info	loan_contract_info	loan_contract_repay_plan	loan_customer_contacter	loan_customer_info	
		INSERT INTO loan_car_info(project_id,brand_model_name,car_frame_no,car_engine_no,car_engine_model_name,bill_no,bill_company_name,bill_date,max_capacity,note,gps_no,insurance_status,car_type_desc,create_time,modify_time,contract_print_no,sys_type,policy_no,
car_damage_insurance_amt,invoice_code,displacement,register_no,second_hand_plate_no,trafc_insure_no)
		SELECT @tmpProjectId,brand_model_name,car_frame_no,car_engine_no,car_engine_model_name,bill_no,bill_company_name,bill_date,max_capacity,note,gps_no,insurance_status,car_type_desc,create_time,modify_time,contract_print_no,sys_type,policy_no,car_damage_insurance_amt,
invoice_code,displacement,register_no,second_hand_plate_no,trafc_insure_no
		FROM loan_car_info where project_id = @sourceApplyId;

		INSERT INTO loan_contract_info(project_id,repay_type,contract_no,contract_amount,bank_no,repayment_no,interest_start_date,interest_end_date,first_repayment_date,register_date,note,contract_status,create_time,modify_time,sys_type)
		SELECT @tmpProjectId,repay_type,contract_no,contract_amount,bank_no,repayment_no,interest_start_date,interest_end_date,first_repayment_date,register_date,note,contract_status,create_time,modify_time,sys_type
		from	loan_contract_info where project_id = @sourceApplyId;

		SET @tmpContractId = (SELECT id from loan_contract_info where project_id = @tmpProjectId);
		INSERT INTO loan_contract_repay_plan(contract_id,project_id,plan_no,begin_time,end_time,being_amount,repay_amount,discount_amount,end_amount,sys_type,month_repayment_amount,current_term_principle,current_term_interest,continuous_overdue_times,
accumulated_overdue_times,overdue_total_amount,yesterday_repayment_amount,last_repayment_date,current_bank_repayment_time,actual_amount,overdue_flag)
		SELECT @tmpContractId,@tmpProjectId,plan_no,begin_time,end_time,being_amount,repay_amount,discount_amount,end_amount,sys_type,month_repayment_amount,current_term_principle,current_term_interest,continuous_overdue_times,accumulated_overdue_times,overdue_total_amount,
yesterday_repayment_amount,last_repayment_date,current_bank_repayment_time,actual_amount,overdue_flag
		FROM loan_contract_repay_plan where project_id = @sourceApplyId;

		INSERT INTO loan_customer_contacter(apply_id,project_id,emergency_contact,net_credit_report_id,risk_time,emergency_card_type,emergency_card_no,relationship,contact_address,mobile_phone,is_car_user,is_inuse,user_id,user_name,org_id,org_name,create_time,modify_time)
		SELECT @tmpProjectId,@tmpProjectId,emergency_contact,net_credit_report_id,risk_time,emergency_card_type,emergency_card_no,relationship,contact_address,mobile_phone,is_car_user,is_inuse,user_id,user_name,org_id,org_name,create_time,modify_time
		FROM loan_customer_contacter where project_id = @sourceApplyId;

		INSERT INTO loan_customer_info(apply_id,customer_id,customer_no,project_id,customer_name,en_customer_name,customer_type,card_type,card_no,card_no_valid,card_no_valid_time,licence_issuing_authority,customer_source,source_serialno,sex,birthday,age,marital_status,
mobile_phone,home_phone,native_place,education,degree,housing_status,mortgage_repayment,driver_licence,provide_business_licence,provide_account_statement,profession,profession_code,post,post_name,industry,work_nature,work_nature_code,employ_time,monthly_income,
yearly_income,reserved_funds,reserved_funds_year,social_year,cur_address_time,company_name,company_phone,company_address_pid,company_address_pname,company_address_cid,company_address_cname,company_address_rid,company_address_rname,company_address_detail,company_address_longitude,
company_address_latitude,home_address_pid,home_address_pname,home_address_cid,home_address_cname,home_address_rid,home_address_rname,home_address_detail,home_address_longitude,home_address_latitude,delivery_address_pid,delivery_address_pname,delivery_address_cid,delivery_address_cname,
delivery_address_rid,delivery_address_rname,delivery_address_detail,delivery_address_longitude,delivery_address_latitude,spouse_id,spouse_name,spouse_card_type,spouse_card_no,spouse_mobile_phone,spouse_permant_address,spouse_reserved_funds,spouse_reserved_funds_year,spouse_social_year,
spouse_driver_licence,spouse_company_name,spouse_company_address_pid,spouse_company_address_pname,spouse_company_address_cid,spouse_company_address_cname,spouse_company_address_rid,spouse_company_address_rname,spouse_company_address_longitude,spouse_company_address_latitude,
spouse_company_address,spouse_company_phone,spouse_monthly_income,is_agency,real_car_owner,register_date,joint_obligor,customer_score_a,customer_score_b,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,modify_time,sys_type,guarantor_driver_licence,domicile_type,
spouse_yearly_income,house_yearly_income,cmpy_postcode,home_postcode)
		SELECT @tmpProjectId,@tmpCustomerId,CONCAT('MGK',@tmpCardNo),@tmpProjectId,@tmpCustomerName,en_customer_name,customer_type,card_type,@tmpCardNo,card_no_valid,card_no_valid_time,licence_issuing_authority,customer_source,source_serialno,sex,birthday,age,marital_status,
mobile_phone,home_phone,native_place,education,degree,housing_status,mortgage_repayment,driver_licence,provide_business_licence,provide_account_statement,profession,profession_code,post,post_name,industry,work_nature,work_nature_code,employ_time,monthly_income,
yearly_income,reserved_funds,reserved_funds_year,social_year,cur_address_time,company_name,company_phone,company_address_pid,company_address_pname,company_address_cid,company_address_cname,company_address_rid,company_address_rname,company_address_detail,company_address_longitude,
company_address_latitude,home_address_pid,home_address_pname,home_address_cid,home_address_cname,home_address_rid,home_address_rname,home_address_detail,home_address_longitude,home_address_latitude,delivery_address_pid,delivery_address_pname,delivery_address_cid,delivery_address_cname,
delivery_address_rid,delivery_address_rname,delivery_address_detail,delivery_address_longitude,delivery_address_latitude,spouse_id,spouse_name,spouse_card_type,spouse_card_no,spouse_mobile_phone,spouse_permant_address,spouse_reserved_funds,spouse_reserved_funds_year,spouse_social_year,
spouse_driver_licence,spouse_company_name,spouse_company_address_pid,spouse_company_address_pname,spouse_company_address_cid,spouse_company_address_cname,spouse_company_address_rid,spouse_company_address_rname,spouse_company_address_longitude,spouse_company_address_latitude,
spouse_company_address,spouse_company_phone,spouse_monthly_income,is_agency,real_car_owner,register_date,joint_obligor,customer_score_a,customer_score_b,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,modify_time,sys_type,guarantor_driver_licence,domicile_type,
spouse_yearly_income,house_yearly_income,cmpy_postcode,home_postcode
		FROM loan_customer_info where project_id = @sourceApplyId;
		#loan_document	loan_fee_info	loan_guarantor_info	loan_payment_detail	loan_payment_info loan_project_info	loan_score_item
		INSERT INTO loan_document(object_type,object_no,dir_id,file_type,file_name,file_size,file_format,file_path,thumb_file,photograph_longitude,photograph_latitude,photograph_time,is_inuse,user_id,user_name,org_id,org_name,create_time,modify_time,modify_realname,modify_uid,sys_type,client_serial_num,flag)
		SELECT object_type,@tmpProjectId,dir_id,file_type,file_name,file_size,file_format,file_path,thumb_file,photograph_longitude,photograph_latitude,photograph_time,is_inuse,user_id,user_name,org_id,org_name,create_time,modify_time,modify_realname,modify_uid,sys_type,client_serial_num,flag
		FROM loan_document	where object_no = @sourceApplyId;

		INSERT INTO loan_fee_info(apply_id,project_id,premium_type,insurance_amount,insurance_company_id,insurance_company,account_deposit,is_renewal,renewal_deposit,is_pb,pb_deposit,cost_type,cost_amount,predicted_purchasetax,purchase_tax,guaranty_risk_amount,service_fee,bank_irs_fee,license_fee,door_survey_fee,
agency_fee,outsource_survey_fee,gps_number,gps_type,gps_producer,gps_installation_fee,liability_amount,other_fee,total_fee,guarantee_service_fee,bank_downpayment_amount,bank_installment_amount,bank_installment_fee,notice_downpayment_capital,notice_downpayment_interest,notice_downpayment_amount,
notice_periodpayment_capital,notice_periodpayment_interest,notice_periodpayment_amount,notice_finalpayment_capital,notice_finalpayment_interest,notice_finalpayment_amount,contract_downpayment_capital,contract_downpayment_interest,contract_downpayment_amount,contract_periodpayment_capital,contract_periodpayment_interest,
contract_periodpayment_amount,contract_finalpayment_capital,contract_finalpayment_interest,contract_finalpayment_amount,valuation_fee,bill_date,remark,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,modify_time,is_advance_discount)
		SELECT @tmpProjectId,@tmpProjectId,premium_type,insurance_amount,insurance_company_id,insurance_company,account_deposit,is_renewal,renewal_deposit,is_pb,pb_deposit,cost_type,cost_amount,predicted_purchasetax,purchase_tax,guaranty_risk_amount,service_fee,bank_irs_fee,license_fee,door_survey_fee,
agency_fee,outsource_survey_fee,gps_number,gps_type,gps_producer,gps_installation_fee,liability_amount,other_fee,total_fee,guarantee_service_fee,bank_downpayment_amount,bank_installment_amount,bank_installment_fee,notice_downpayment_capital,notice_downpayment_interest,notice_downpayment_amount,
notice_periodpayment_capital,notice_periodpayment_interest,notice_periodpayment_amount,notice_finalpayment_capital,notice_finalpayment_interest,notice_finalpayment_amount,contract_downpayment_capital,contract_downpayment_interest,contract_downpayment_amount,contract_periodpayment_capital,contract_periodpayment_interest,
contract_periodpayment_amount,contract_finalpayment_capital,contract_finalpayment_interest,contract_finalpayment_amount,valuation_fee,bill_date,remark,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,modify_time,is_advance_discount
		FROM loan_fee_info where project_id = @sourceApplyId;

		INSERT INTO loan_payment_info(apply_id,project_id,guarantee_corporation_id,guarantee_corporation_name,guarantee_corporation_account_name,guarantee_corporation_account_no,guarantee_corporation_bank,guarantee_corporation_payment_date,guarantee_corporation_payment_amount,guarantee_corporation_payment_user_id,
guarantee_corporation_payment_user_name,guarantee_corporation_payment_remark,capital_pool_account_name,capital_pool_account_no,capital_pool_bank,capital_pool_payment_amount,capital_pool_payment_date,capital_pool_payment_user_id,capital_pool_payment_user_name,capital_pool_payment_remark,dealer_id,dealer_name,employ_dealer_id,
employ_dealer_name,dealer_account_name,dealer_account_no,dealer_bank,dealer_payment_amount,dealer_payment_date,dealer_payment_user_id,dealer_payment_user_name,dealer_payment_remark,payee_method,payment_direction,payee_amount,payee_date,return_cash_pool_amount,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,
modify_time,dealer_account_type,pay_status,pay_type)
		SELECT @tmpProjectId,@tmpProjectId,guarantee_corporation_id,guarantee_corporation_name,guarantee_corporation_account_name,guarantee_corporation_account_no,guarantee_corporation_bank,guarantee_corporation_payment_date,guarantee_corporation_payment_amount,guarantee_corporation_payment_user_id,
guarantee_corporation_payment_user_name,guarantee_corporation_payment_remark,capital_pool_account_name,capital_pool_account_no,capital_pool_bank,capital_pool_payment_amount,capital_pool_payment_date,capital_pool_payment_user_id,capital_pool_payment_user_name,capital_pool_payment_remark,dealer_id,dealer_name,employ_dealer_id,
employ_dealer_name,dealer_account_name,dealer_account_no,dealer_bank,dealer_payment_amount,dealer_payment_date,dealer_payment_user_id,dealer_payment_user_name,dealer_payment_remark,payee_method,payment_direction,payee_amount,payee_date,return_cash_pool_amount,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,
modify_time,dealer_account_type,pay_status,pay_type
		FROM loan_payment_info where project_id = @sourceApplyId;

		set @loanApprovePaymentId = (SELECT id from loan_approve_payment where  project_id = @tmpProjectId);
		INSERT INTO loan_payment_detail(apply_id,project_id,pid,payment_mode,payment_type,payee_amount,account_name,user_id,user_name,create_time,trans_time,batch_no,trans_status,remarks,payment_no,opening_bank,open_bank_name,sub_bank_name,card_number,bank_code,priority_flag)
		SELECT @tmpProjectId,@tmpProjectId,@loanApprovePaymentId,payment_mode,payment_type,payee_amount,account_name,user_id,user_name,create_time,trans_time,batch_no,trans_status,remarks,payment_no,opening_bank,open_bank_name,sub_bank_name,card_number,bank_code,priority_flag
		FROM loan_payment_detail where project_id = @sourceApplyId;

		INSERT INTO loan_project_info(apply_id,project_id,project_no,car_type,car_id,car_serialno,car_brand,car_brand_name,car_make,car_make_name,car_model,car_model_name,body_structure,is_imported,is_advance,online_price,billing_price,evaluation_price,sell_price,second_hand_car_price,loan_amount,required_amount,benchmark_rate,
loan_term,loan_ratio,handing_fee,repayment_amount,down_payment_amount,payment_method,delivery_method,payment_level,settle_method,tested_repayment_amount,guarantee_corporation_id,guarantee_corporation_name,receivable_amount,collected_amount,collected_date,collected_remark,pre_collected_amount,payable_amount,is_discount,
discount_policy_id,discount_policy_name,discount_case_id,discount_margin,discount_car_policy,position_merge,discount_case_name,discount_amount,xzz_discount_amount,main_signer_id,main_signer_name,main_signer_weight,vice_signer_id,vice_signer_name,vice_signer_weight,sign_date,launch_date,launch_user_id,launch_user_name,
launch_org_id,launch_org_name,review_date,review_user_id,review_user_name,review_org_id,review_org_name,approve_date,approve_user_id,approve_user_name,approve_org_id,approve_org_name,dealer_id,dealer_name,dealer_grade,employ_dealer_id,employ_dealer_name,dealer_fee_id,dealer_fee_name,co_bank_id,co_bank_name,is_public_license,
license_company,is_concerned_customer,is_agency,is_gps_installed1,is_gps_installed2,visit_address_pid,visit_address_pname,visit_address_cid,visit_address_cname,visit_address_rid,visit_address_rname,visit_address_detail,visit_address_longitude,visit_address_latitude,visit_address_gps_detail,visit_address_gps_name,real_address_pid,
real_address_pname,real_address_cid,real_address_cname,real_address_rid,real_address_rname,real_address_detail,real_address_longitude,real_address_latitude,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,modify_time,free_door,sys_type,modify_flag,is_didi,province_code,province_name,city_code,city_name,
query_user_name,warning_car_name,warning_level,warning_result,init_vin,budget_vin,new_price,is_two_card,car_loan_amount,grade_result,is_single_noneed_guarantee,is_approve_exception)
		SELECT @tmpProjectId,@tmpProjectId,CONCAT('MOCK', @tmpCardNo),car_type,car_id,car_serialno,car_brand,car_brand_name,car_make,car_make_name,car_model,car_model_name,body_structure,is_imported,is_advance,online_price,billing_price,evaluation_price,sell_price,second_hand_car_price,loan_amount,required_amount,benchmark_rate,
loan_term,loan_ratio,handing_fee,repayment_amount,down_payment_amount,payment_method,delivery_method,payment_level,settle_method,tested_repayment_amount,guarantee_corporation_id,guarantee_corporation_name,receivable_amount,collected_amount,collected_date,collected_remark,pre_collected_amount,payable_amount,is_discount,
discount_policy_id,discount_policy_name,discount_case_id,discount_margin,discount_car_policy,position_merge,discount_case_name,discount_amount,xzz_discount_amount,main_signer_id,main_signer_name,main_signer_weight,vice_signer_id,vice_signer_name,vice_signer_weight,sign_date,launch_date,launch_user_id,launch_user_name,
launch_org_id,launch_org_name,review_date,review_user_id,review_user_name,review_org_id,review_org_name,approve_date,approve_user_id,approve_user_name,approve_org_id,approve_org_name,dealer_id,dealer_name,dealer_grade,employ_dealer_id,employ_dealer_name,dealer_fee_id,dealer_fee_name,co_bank_id,co_bank_name,is_public_license,
license_company,is_concerned_customer,is_agency,is_gps_installed1,is_gps_installed2,visit_address_pid,visit_address_pname,visit_address_cid,visit_address_cname,visit_address_rid,visit_address_rname,visit_address_detail,visit_address_longitude,visit_address_latitude,visit_address_gps_detail,visit_address_gps_name,real_address_pid,
real_address_pname,real_address_cid,real_address_cname,real_address_rid,real_address_rname,real_address_detail,real_address_longitude,real_address_latitude,is_inuse,save_status,user_id,user_name,org_id,org_name,create_time,modify_time,free_door,sys_type,modify_flag,is_didi,province_code,province_name,city_code,city_name,
query_user_name,warning_car_name,warning_level,warning_result,init_vin,budget_vin,new_price,is_two_card,car_loan_amount,grade_result,is_single_noneed_guarantee,is_approve_exception
		FROM loan_project_info where project_id = @sourceApplyId;
		#4. 文档传递	document_deliver document_deliver_status
		INSERT INTO document_deliver(current_deliver_status_id,project_id,co_bank_id,card_no,customer_name,project_no,document_no,staff_id,deliver_status,deliver_time,file_sended,guaranty_status,create_time,launch_time,verify_time,copy_time,review_time,classify_time,pigeonhole_time,modify_time,remark,sys_type,bank_send_status,
bank_handle_time,print_status,file_need_send)
		SELECT current_deliver_status_id,@tmpProjectId,co_bank_id,@tmpCardNo,@tmpCustomerName,CONCAT('MOCK', @tmpCardNo),CONCAT('MOCK', @tmpCardNo),staff_id,deliver_status,deliver_time,file_sended,guaranty_status,create_time,launch_time,verify_time,copy_time,review_time,classify_time,pigeonhole_time,modify_time,remark,sys_type,bank_send_status,
bank_handle_time,print_status,file_need_send
		FROM document_deliver where project_id = @sourceApplyId;

		set @tmpDocId = (select id from document_deliver where project_id = @tmpProjectId);
		INSERT document_deliver_status(document_deliver_id,project_id,document_no,staff_id,deliver_status,dest_type,file_sended,guaranty_status,handle_time,create_time,modify_time,receive_time,remark)
		SELECT @tmpDocId,@tmpProjectId,document_no,staff_id,deliver_status,dest_type,file_sended,guaranty_status,handle_time,create_time,modify_time,receive_time,remark
		FROM document_deliver_status where project_id = @sourceApplyId;
		set @tmpDocSatusId = (select id from document_deliver_status where project_id = @tmpProjectId);
		update document_deliver set current_deliver_status_id = @tmpDocSatusId where id = @tmpDocId;
		#document_deliver_customer	document_deliver_fee	document_deliver_guarantor	document_deliver_list
		INSERT INTO document_deliver_customer(project_id,customer_id,customer_no,customer_name,customer_type,card_type,card_no,card_expiry_date,card_or_expiry_date,customer_source,source_serialno,sex,birthday,age,marital_status,mobile_phone,home_phone,native_place,education,degree,housing_status,housing_date,mortgage_repayment,profession,
industry,monthly_income,reserved_funds,company_name,company_phone,company_type,employment_date,company_address_pid,company_address_pname,company_address_cid,company_address_cname,company_address_rid,company_address_rname,company_address_detail,company_address_longitude,company_address_latitude,home_address_pid,home_address_pname,home_address_cid,
home_address_cname,home_address_rid,home_address_rname,home_address_detail,home_address_longitude,home_address_latitude,spouse_name,spouse_card_type,spouse_card_no,spouse_mobile_phone,spouse_permant_address,spouse_reserved_funds,spouse_company_name,spouse_company_address_pid,spouse_company_address_pname,spouse_company_address_cid,
spouse_company_address_cname,spouse_company_address_rid,spouse_company_address_rname,spouse_company_address_longitude,spouse_company_address_latitude,spouse_company_address,spouse_company_phone,spouse_monthly_income,is_agency,real_car_owner,register_date,joint_obligor_id,joint_obligor,customer_score,is_inuse,user_id,user_name,org_id,org_name,
create_time,modify_time,en_customer_name,licence_issuing_authority,post,post_name,yearly_income,profession_code,work_nature_code,domicile_type,spouse_yearly_income,house_yearly_income,cmpy_postcode,home_postcode)
			SELECT @tmpDocId,@tmpCustomerId,CONCAT('MOCK', @tmpCardNo),@tmpCustomerName,customer_type,card_type,@tmpCardNo,card_expiry_date,card_or_expiry_date,customer_source,source_serialno,sex,birthday,age,marital_status,mobile_phone,home_phone,native_place,education,degree,housing_status,housing_date,mortgage_repayment,profession,
industry,monthly_income,reserved_funds,company_name,company_phone,company_type,employment_date,company_address_pid,company_address_pname,company_address_cid,company_address_cname,company_address_rid,company_address_rname,company_address_detail,company_address_longitude,company_address_latitude,home_address_pid,home_address_pname,home_address_cid,
home_address_cname,home_address_rid,home_address_rname,home_address_detail,home_address_longitude,home_address_latitude,spouse_name,spouse_card_type,spouse_card_no,spouse_mobile_phone,spouse_permant_address,spouse_reserved_funds,spouse_company_name,spouse_company_address_pid,spouse_company_address_pname,spouse_company_address_cid,
spouse_company_address_cname,spouse_company_address_rid,spouse_company_address_rname,spouse_company_address_longitude,spouse_company_address_latitude,spouse_company_address,spouse_company_phone,spouse_monthly_income,is_agency,real_car_owner,register_date,joint_obligor_id,joint_obligor,customer_score,is_inuse,user_id,user_name,org_id,org_name,
create_time,modify_time,en_customer_name,licence_issuing_authority,post,post_name,yearly_income,profession_code,work_nature_code,domicile_type,spouse_yearly_income,house_yearly_income,cmpy_postcode,home_postcode
			FROM document_deliver_customer where project_id = @tmpProjectId;

		INSERT INTO document_deliver_list(document_deliver_id,document_name,original_count,duplicate_count,sort,create_time,modify_time)
		SELECT @tmpDocId,document_name,original_count,duplicate_count,sort,create_time,modify_time
		FROM document_deliver_list where document_deliver_id = (SELECT id from  document_deliver where project_id = @sourceApplyId);
		#上牌抵押
		set @tmpCarId = (select id from loan_car_info where  project_id = @tmpProjectId);
		INSERT INTO license_plate_info(loan_car_id,project_id,is_registered,register_type,register_date,plate_no,plate_area,operator_uid,operator_realname,register_target,company_name,company_code,warrant_date,fail_reason,note,create_time,modify_time,sys_type)
		SELECT @tmpCarId,@tmpProjectId,is_registered,register_type,register_date,plate_no,plate_area,operator_uid,operator_realname,register_target,company_name,company_code,warrant_date,fail_reason,note,create_time,modify_time,sys_type
		FROM license_plate_info where project_id = @sourceApplyId;

		INSERT INTO pledge_info(project_id,pledge_status,pledge_date,wararnt_no,operator_uid,operator_realname,remark,note,create_time,modify_time,sys_type,bank_pledge_status,feedback_status,reject_reason,fail_reason,pledge_complete_date,receive_data)
		SELECT @tmpProjectId,pledge_status,pledge_date,wararnt_no,operator_uid,operator_realname,remark,note,create_time,modify_time,sys_type,bank_pledge_status,feedback_status,reject_reason,fail_reason,pledge_complete_date,receive_data
		FROM pledge_info where project_id = @sourceApplyId;

		INSERT INTO repayment_card_info(project_id,bank_name,card_no,deliver_type,express_company,express_no,deliver_userid,deliver_realname,deliver_date,delivery_address_pid,delivery_address_pname,delivery_address_cid,delivery_address_cname,delivery_address_rid,delivery_address_rname,delivery_address_detail,
delivery_address_longitude,delivery_address_latitude,deliver_addr,note,create_time,modify_time,sys_type)
		SELECT @tmpProjectId,bank_name,@tmpCardNo,deliver_type,express_company,express_no,deliver_userid,deliver_realname,deliver_date,delivery_address_pid,delivery_address_pname,delivery_address_cid,delivery_address_cname,delivery_address_rid,delivery_address_rname,delivery_address_detail,
delivery_address_longitude,delivery_address_latitude,deliver_addr,note,create_time,modify_time,sys_type
		FROM repayment_card_info where project_id = @sourceApplyId;
		
		INSERT INTO loan_overdue_info(project_id,project_no,customer_id,customer_name,card_type,card_no,mobile_phone,co_bank_id,co_bank_name,launch_org_id,launch_org_name,user_group_id,user_group_name,launch_user_id,launch_user_name,plate_no,repayment_card_no,current_plan_no,current_plan_repay_amount,
current_bank_repayment_time,advance_count,advance_balance_amount,month_repayment_amount,current_term_principle,current_term_interest,continuous_overdue_times,accumulated_overdue_times,overdue_total_amount,yesterday_repayment_amount,last_repayment_date,create_time,modify_time,is_settled,flag_status,
old_id,sys_type,open_staff_id,open_staff_name,overdue_status,total_term_num,loan_left_amt,bank_payment_date,overdue_days,account_balance,bank_overdue_status,cal_overdue_status,overdue_amt_rate,history_term,suit_no)
		SELECT @tmpProjectId,CONCAT('MOCK', @tmpCardNo),@tmpCustomerId,@tmpCustomerName,card_type,@tmpCardNo,mobile_phone,co_bank_id,co_bank_name,launch_org_id,launch_org_name,user_group_id,user_group_name,launch_user_id,launch_user_name,plate_no,repayment_card_no,current_plan_no,current_plan_repay_amount,
current_bank_repayment_time,advance_count,advance_balance_amount,month_repayment_amount,current_term_principle,current_term_interest,continuous_overdue_times,accumulated_overdue_times,overdue_total_amount,yesterday_repayment_amount,last_repayment_date,create_time,modify_time,is_settled,flag_status,
old_id,sys_type,open_staff_id,open_staff_name,overdue_status,total_term_num,loan_left_amt,bank_payment_date,overdue_days,account_balance,bank_overdue_status,cal_overdue_status,overdue_amt_rate,history_term,suit_no
		FROM loan_overdue_info where project_id = @sourceApplyId;

		INSERT INTO loan_dm(project_id,customer_name,id_no,card_no,amount,lending_date,term,current_term,loan_balance,auth_amt,optimal_repayment_amt,card_balance,monthly_repayment,booked_amt,unpayment_principal,unpayment_charge,last_overdue_date,last_penalty_date,sum_overdue_times,con_overdue_times,status)
		SELECT @tmpProjectId,@tmpCustomerName,@tmpCardNo,@tmpCardNo,amount,lending_date,term,current_term,loan_balance,auth_amt,optimal_repayment_amt,card_balance,monthly_repayment,booked_amt,unpayment_principal,unpayment_charge,last_overdue_date,last_penalty_date,sum_overdue_times,con_overdue_times,status
		FROM loan_dm where project_id = @sourceApplyId;

		set i = i +1;
	end WHILE;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for test
-- ----------------------------
DROP PROCEDURE IF EXISTS `test`;
delimiter ;;
CREATE PROCEDURE `cls`.`test`()
BEGIN

DECLARE num INT;

DECLARE fileId BIGINT;

DECLARE creditRelavantId BIGINT;

DECLARE done INT DEFAULT FALSE;

DECLARE creditRelavantIdCur CURSOR FOR SELECT id FROM customer_credit_relavant;

DECLARE fileIdCur CURSOR FOR SELECT id  FROM customer_credit_file  WHERE credit_relavant_id = creditRelavantId AND STATUS = 0 ORDER BY id asc ;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN creditRelavantIdCur;

read_loop :
LOOP
	FETCH creditRelavantIdCur INTO creditRelavantId;

IF done THEN
	LEAVE read_loop;
END
IF;


SET num = 0;

OPEN fileIdCur;

inner_loop :
LOOP
	FETCH fileIdCur INTO fileId;


IF done THEN
	LEAVE inner_loop;


END
IF;

UPDATE customer_credit_file
SET credit_type = num
WHERE
	id = fileId;


SET num = num + 1;


END
LOOP
;

CLOSE fileIdCur;


SET done = FALSE;


END
LOOP
;

CLOSE creditRelavantIdCur;


END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
