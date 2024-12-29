/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : farm_system

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 05/07/2024 17:18:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/download/1735361914099-702ccf9fb3016b6bc97c222346d1f1a.png', 'ADMIN');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '农产品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '厨具');
INSERT INTO `category` VALUES (2, '水果');
INSERT INTO `category` VALUES (3, '农副产品');
INSERT INTO `category` VALUES (4, '食品区');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `specials` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '特色',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '单位',
  `store` int(11) NULL DEFAULT NULL COMMENT '库存量',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '分类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '农产品信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '筷子', 'http://localhost:9090/files/download/1735363119460-b3f227b5c6ae42d70c87b68f0dd1ce1.png', '优质筷子', '钢材', 0.85, '斤', 2200, 1);
INSERT INTO `goods` VALUES (2, '奥利奥', 'http://localhost:9090/files/download/1735363207062-ec7600da9cf92afcd1958eef2d8617b.png', '好吃的饼干', '巧克力', 9.90, 'kg', 1099, 1);
INSERT INTO `goods` VALUES (4, '黄桃', 'http://localhost:9090/files/download/1735363287822-22bedd759af22e313d4f72c0a520dd6.png', '山东蒙阴黄桃新鲜水果桃子黄金蜜桃黄毛桃', '出口品质，山泉灌溉', 5.88, '斤', 998, 2);
INSERT INTO `goods` VALUES (5, '西红柿', 'http://localhost:9090/files/download/1735363365044-2fb5e2d91828388fc269e1c75d07d5c.png', '沙瓤西红柿', '花样吃法，口感更佳', 21.99, '个', 665, 2);

-- ----------------------------
-- Table structure for goods_stock
-- ----------------------------
DROP TABLE IF EXISTS `goods_stock`;
CREATE TABLE `goods_stock`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `num` int(11) NULL DEFAULT NULL COMMENT '进货数量',
  `channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '进货渠道',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '进货日期',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `delivery_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '到货时间',
  `single_price` int(11) NULL DEFAULT NULL COMMENT '订单总价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '农产品进货' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_stock
-- ----------------------------
INSERT INTO `goods_stock` VALUES (1, 2, 100, '农产品批发市场', '2024-07-05', '1','2024-07-09',9);
INSERT INTO `goods_stock` VALUES (2, 1, 100, '农产品批发市场', '2024-07-05', NULL,'2024-07-09',9);
INSERT INTO `goods_stock` VALUES (3, 2, 100, '农产品批发市场', '2024-07-05', NULL,'2024-07-09',9);
INSERT INTO `goods_stock` VALUES (4, 1, 200, '	 农产品批发市场', '2024-07-05', NULL,'2024-07-09',9);


DROP TABLE IF EXISTS `receive_stock`;
CREATE TABLE `receive_stock`  (
                                `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
                                `num` int(11) NULL DEFAULT NULL COMMENT '进货数量',
                                `channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '进货渠道',
                                `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
                                `delivery_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '到货时间',
                                `single_price` int(11) NULL DEFAULT NULL COMMENT '订单总价',
                                `receive_name` varchar(255) NULL DEFAULT NULL COMMENT '收货员工名称',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '农产品进货' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '好物上新！新鲜黄桃低至5元起！', '好物上新！新鲜黄桃低至5元起！甄选黄桃，口味绝佳，夏日必备！', '2024-07-01 15:00:00');
INSERT INTO `notice` VALUES (2, '夏天最适合吃什么？当然是西瓜更配！', '新鲜无籽麒麟西瓜新鲜上市！农家自种，现摘现发，无添加更健康！', '2024-07-02 15:00:00');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `goods_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品ID',
                           `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
                           `num` int(11) NULL DEFAULT NULL COMMENT '购买数量',
                           `user_id` int(11) NULL DEFAULT NULL COMMENT '下单人',
                           `price` float(11) NULL DEFAULT NULL COMMENT '订单总价',
                           `member_Id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '会员ID',
                           `discount` int(11) NULL DEFAULT NULL COMMENT '折扣',
                           `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单信息' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of orders
-- ----------------------------
-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '普通用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'aaa', '123', '青哥哥', 'http://localhost:9090/files/download/1720163458536-微信截图_20240409161139.png', 'USER', '男', '13988997788', 'aaa@163.com');
INSERT INTO `user` VALUES (2, 'ccc', '123', '李四', 'http://localhost:9090/files/download/1720150542794-微信截图_20240409161232.png', 'USER', '女', '13988776655', 'ccc@163.com');
INSERT INTO `user` VALUES (3, 'acc', '123', '小青哥哥', 'http://localhost:9090/files/download/1720163839718-微信截图_20231018172208.png', 'USER', '男', '13988779988', NULL);

SET FOREIGN_KEY_CHECKS = 1;


-- 删除Member表（如果存在）
DROP TABLE IF EXISTS `Member`;

-- 创建Member表
CREATE TABLE `Member` (
                          `ID` int AUTO_INCREMENT PRIMARY KEY,  -- 会员卡号
                          `MemberName` VARCHAR(50),             -- 姓名
                          `Gender` CHAR(1),                     -- 性别
                          `Birthdate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出生日期',
                          `ContactAddress` VARCHAR(255),        -- 联系地址
                          `PhoneNumber` VARCHAR(20),            -- 电话号码
                          `Occupation` VARCHAR(50),             -- 职业
                          `IDNumber` CHAR(18),                  -- 身份证号码
                          `JoinTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '加入时间'
);

-- 向Member表中插入一条记录
INSERT INTO `Member` (ID, MemberName, Gender, BirthDate, ContactAddress, PhoneNumber, Occupation, IDNumber)
VALUES (1, '张伟', 'M', '1980-01-01', '上海市浦东新区陆家嘴环路1000号', '+8613800000000', '软件工程师', '12345619800101001X');

-- 插入第二条记录
INSERT INTO Member (ID, MemberName, Gender, BirthDate, ContactAddress, PhoneNumber, Occupation, IDNumber)
VALUES (2, '李娜', 'F', '1982-05-15', '北京市朝阳区建国门外大街1号', '+8613911111111', '项目经理', '12345619820515002Y');
DROP TABLE IF EXISTS `returns`;
CREATE TABLE `returns`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           /*`orders_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名',*/
                           `orders_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '退单编号',
                           `good_id` int(11) NULL DEFAULT null COMMENT 'ID',
                           `num` int(11) NULL DEFAULT null COMMENT '数量',
                           `total_price` float(11) NULL DEFAULT NULL COMMENT '订单总价',
                           `return_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '退货时间',
                           `return_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经手人',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '退货信息' ROW_FORMAT = Dynamic;
-- ----------------------------
DROP TABLE IF EXISTS `Supplier`;
CREATE TABLE Supplier (
                            ID int AUTO_INCREMENT PRIMARY KEY,  -- 供货商号，假设是唯一的标识符，并且长度不超过20个字符
                          SupplierName VARCHAR(100),           -- 供货商名，允许较长的名字
                          Category VARCHAR(50),                -- 类别，描述供货商所属的类别
                          Address VARCHAR(255),                -- 地址，提供足够的空间存储详细地址
                          LegalRepresentative VARCHAR(100),    -- 法人代表姓名
                          ContactPerson VARCHAR(100),          -- 联系人姓名
                          ContactPhone VARCHAR(20),            -- 联系电话，包括国家代码
                          FaxNumber VARCHAR(20),               -- 传真号码
                          Email VARCHAR(100),                  -- E-mail地址
                          Remarks TEXT                         -- 备注，可以存储更多文本信息
);
-- 插入第一条测试数据
INSERT INTO Supplier (ID, SupplierName, Category, Address, LegalRepresentative, ContactPerson, ContactPhone, FaxNumber, Email, Remarks)
VALUES (1, 'Tech Innovations Inc.', 'Electronics', '123 Tech Road, Innovation City, CA 90210, USA', 'John Doe', 'Jane Smith', '+1-800-555-1234', '+1-800-555-5678', 'contact@techinnovations.com', 'Leading supplier of electronic components.');

-- 插入第二条测试数据
INSERT INTO Supplier (ID, SupplierName, Category, Address, LegalRepresentative, ContactPerson, ContactPhone, FaxNumber, Email, Remarks)
VALUES (2, 'Green Foods Co.', 'Food & Beverage', '456 Green Street, Organic Town, NY 10001, USA', 'Alice Johnson', 'Bob Brown', '+1-800-555-9876', '+1-800-555-6543', 'info@greenfoodsco.com', 'Specializes in organic and natural food products.');