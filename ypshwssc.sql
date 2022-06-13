/*
Navicat MySQL Data Transfer

Source Server         : chenmin
Source Server Version : 50626
Source Host           : 127.0.0.1:3306
Source Database       : ypshwssc

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2022-06-13 20:08:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_address
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address` (
  `addressID` int(20) NOT NULL AUTO_INCREMENT,
  `userID` int(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`addressID`),
  KEY `userID` (`userID`),
  CONSTRAINT `t_address_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `t_user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_address
-- ----------------------------
INSERT INTO `t_address` VALUES ('1', '1', '陈民', '13307471670', '湖南省长沙市天心区');
INSERT INTO `t_address` VALUES ('2', '2', '陈明', '15580807398', '湖南省衡阳市衡阳县');
INSERT INTO `t_address` VALUES ('3', '1', '小七', '13307471901', '湖南省长沙市芙蓉区');
INSERT INTO `t_address` VALUES ('4', '2', '孙西文', '15580807456', '7栋2单元103');
INSERT INTO `t_address` VALUES ('7', '13', '测试者', '13333333333', '湖南科技职业学院');
INSERT INTO `t_address` VALUES ('8', '9', '小七', '13307471670', '湖南科技职业学院');

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `adminID` int(20) NOT NULL AUTO_INCREMENT,
  `admin_head` varchar(50) DEFAULT NULL,
  `admin_name` varchar(20) DEFAULT NULL,
  `admin_pass` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', 'headshot.jpg', 'sxw', '3607964');
INSERT INTO `t_admin` VALUES ('2', 'headshot2.jpg', 'cm', '200225');

-- ----------------------------
-- Table structure for t_cart
-- ----------------------------
DROP TABLE IF EXISTS `t_cart`;
CREATE TABLE `t_cart` (
  `cartID` int(20) NOT NULL AUTO_INCREMENT,
  `goodsID` int(20) DEFAULT NULL,
  `userID` int(20) DEFAULT NULL,
  `goods_num` int(10) DEFAULT NULL,
  PRIMARY KEY (`cartID`),
  KEY `userID` (`userID`),
  KEY `goodsID` (`goodsID`),
  CONSTRAINT `t_cart_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `t_user` (`userID`),
  CONSTRAINT `t_cart_ibfk_2` FOREIGN KEY (`goodsID`) REFERENCES `t_goods` (`goodsID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cart
-- ----------------------------
INSERT INTO `t_cart` VALUES ('59', '9', '1', '1');

-- ----------------------------
-- Table structure for t_collect
-- ----------------------------
DROP TABLE IF EXISTS `t_collect`;
CREATE TABLE `t_collect` (
  `collectID` int(20) NOT NULL AUTO_INCREMENT,
  `goodsID` int(20) DEFAULT NULL,
  `userID` int(20) DEFAULT NULL,
  PRIMARY KEY (`collectID`),
  KEY `userID` (`userID`),
  KEY `goodsID` (`goodsID`),
  CONSTRAINT `t_collect_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `t_user` (`userID`),
  CONSTRAINT `t_collect_ibfk_2` FOREIGN KEY (`goodsID`) REFERENCES `t_goods` (`goodsID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_collect
-- ----------------------------
INSERT INTO `t_collect` VALUES ('29', '7', '1');
INSERT INTO `t_collect` VALUES ('31', '1', '2');
INSERT INTO `t_collect` VALUES ('32', '6', '2');
INSERT INTO `t_collect` VALUES ('33', '9', '2');
INSERT INTO `t_collect` VALUES ('42', '21', '1');
INSERT INTO `t_collect` VALUES ('45', '10', '2');
INSERT INTO `t_collect` VALUES ('46', '14', '1');

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `goodsID` int(20) NOT NULL AUTO_INCREMENT,
  `goods_img` varchar(50) DEFAULT NULL,
  `goods_name` varchar(100) DEFAULT NULL,
  `goods_detail` varchar(100) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  `price_new` decimal(10,2) DEFAULT NULL,
  `support` int(10) DEFAULT NULL,
  `stock` int(20) DEFAULT '999',
  `goods_type` varchar(20) DEFAULT NULL,
  `whether_recommend` int(10) DEFAULT '0',
  `goods_status` varchar(20) DEFAULT '下架',
  PRIMARY KEY (`goodsID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES ('1', 'goods01.png', '石墨烯智能护腰带', 'IOT智能化|液晶数显|无级控温|轻薄', '499.00', '139.00', '4430', '456', '商品众筹', '1', '上架');
INSERT INTO `t_goods` VALUES ('2', 'goods02.png', '米家智能测距仪', '米家智能激光测距仪 黑色', '678.00', '169.00', '7435', '7854', '商品众筹', '0', '上架');
INSERT INTO `t_goods` VALUES ('3', 'goods03.png', '锐珀尔护颈枕', '锐珀尔顽DOU荚护颈枕 豌豆绿', '350.00', '99.00', '4061', '2654', '商品众筹', '0', '上架');
INSERT INTO `t_goods` VALUES ('4', 'goods04.jpg', 'Yeelight智能浴霸Pro', '八合一空调式智能恒温，进口电机，风向随心调节，米家联动', '1399.00', '549.00', '3542', '4757', '商品秒杀', '1', '上架');
INSERT INTO `t_goods` VALUES ('5', 'goods05.jpg', '大水量 | 云米互联网电热水器 白色 50', '大水量 速热\"卫士\" 有品定制 1级能效 双管速热', '1100.00', '649.00', '2310', '2557', '商品秒杀', '0', '上架');
INSERT INTO `t_goods` VALUES ('6', 'goods06.jpg', '摩摩哒实力π智能按摩椅 艾叶绿', '3D摆揉机芯，腰背腿膝热敷，无线充电，科技时尚外观', '8900.00', '4999.00', '1356', '4441', '商品秒杀', '0', '上架');
INSERT INTO `t_goods` VALUES ('7', 'goods07.jpg', '一键智洗|法乐8kg全自动大容量波轮洗衣机 8KG', '10种洗涤模式 健康筒自洁 立体喷瀑式水流 节能量衣进水', '1200.00', '699.00', '4221', '1235', '商品秒杀', '0', '上架');
INSERT INTO `t_goods` VALUES ('8', 'goods08.jpg', '【包拆旧安装】优享版300mm坑距离座+合盖冲水+4档恒温加热+喷射虹吸冲刷+健康活水清洁 300mm坑距', '活水清洗座圈持久恒温，喷射虹吸冲刷', '2999.00', '1499.00', '1330', '5767', '每日新品', '1', '上架');
INSERT INTO `t_goods` VALUES ('9', 'goods09.jpg', '伯希和加厚抗寒羽绒服（情侣款） 【男款】曜石黑 S', '防泼水面料 800蓬松度 90%白鸭绒填充', '789.00', '788.00', '7652', '7878', '每日新品', '0', '上架');
INSERT INTO `t_goods` VALUES ('10', 'goods10.jpg', '乐伽轻便按摩椅沙发 维也纳黄', '行走按摩 无线遥控 可热敷 背靠可调 占地面积小 便携舒适', '1999.00', '1399.00', '6452', '2455', '每日新品', '0', '上架');
INSERT INTO `t_goods` VALUES ('11', 'goods11.jpg', '小莫智能跑步机 RAMP 棕色 RAMP', '16KM/H高峰速，12段大坡度，61cm宽跑台，6点缓震', '3999.00', '2899.00', '1236', '254', '每日新品', '0', '上架');
INSERT INTO `t_goods` VALUES ('12', 'goods12.jpg', '制者baby亲肤棉感不掉绒连帽卫衣 黑色 170/88A', '加绒加厚,亲肤暖绒,抗静电,不易掉绒', '179.00', '129.00', '2351', '45553', '专属推荐', '1', '上架');
INSERT INTO `t_goods` VALUES ('13', 'goods13.jpg', '派凡多功能笔记本支架/阅读架/床上电脑桌/折叠车载小桌板', '阅读架+平板架+电脑桌 三合一，可调节角度，折叠便携', '88.00', '83.00', '3325', '1488', '专属推荐', '0', '上架');
INSERT INTO `t_goods` VALUES ('14', 'goods14.jpg', '深色护目镜哑光白', '仅两台手机重，汽车级安全保护，头部可调节，秋冬/四季两款可选', '139.00', '99.00', '848', '23', '专属推荐', '0', '上架');
INSERT INTO `t_goods` VALUES ('15', 'goods15.jpg', '好太太小米IoT联动智能电动升降晾衣架 白色 语音声控+AI互联+照明伸缩4杆+上门安装保修三年', '米家智能联动，小爱同学声控，北欧风设计，伸缩四杆', '1799.00', '1199.00', '1254', '4477', '专属推荐', '0', '上架');
INSERT INTO `t_goods` VALUES ('16', 'goods16.png', '米家保温杯弹盖版 藏蓝色', '旋薄工艺，内胆高亮点解，内胆316L不锈钢，饮水口可拆卸清洗', '99.00', '89.00', '4563', '112', '专属推荐', '1', '上架');
INSERT INTO `t_goods` VALUES ('17', 'goods17.jpg', '米家智能宠物饮水机滤芯套装 饮水机滤芯', '四重深层过滤，层层拦截杂质，净水软水，材质安全，到期智能提醒', '29.90', '29.90', '4562', '757', '专属推荐', '0', '上架');
INSERT INTO `t_goods` VALUES ('18', 'goods18.png', '婉爱·超级波尔多干红葡萄酒 1支装', '【6支装更优惠】波尔多风味，金奖殊荣，经典混酿', '119.00', '89.00', '4325', '999', '专属推荐', '0', '上架');
INSERT INTO `t_goods` VALUES ('19', 'goods19.jpg', '【包安装|送龙头】惠达现代简约实木浴室柜强大储物实木板 516-60尺寸浴室柜（超强收纳+实木板+送龙头套餐）', '现代简约款,收纳美学专家', '1399.00', '999.00', '4231', '994', '专属推荐', '0', '上架');
INSERT INTO `t_goods` VALUES ('20', 'goods20.jpg', '“唯忆”圣诞限量款爱的熊抱小熊永生花玫瑰花盒', '甄选进口永生花，可爱苔藓小熊怀抱嫣红玫瑰，玫瑰守护真心', '299.00', '59.90', '4987', '999', '商品秒杀', '1', '上架');
INSERT INTO `t_goods` VALUES ('21', 'goods21.jpg', '圣诞树甜白葡萄酒套装（不含酒杯）1套', '高颜值INS风，节日仪式感爆棚，名家出品', '169.00', '119.00', '2010', '210', '每日新品', '0', '上架');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `orderID` int(20) NOT NULL AUTO_INCREMENT,
  `userID` int(20) DEFAULT NULL,
  `order_num` int(10) DEFAULT NULL,
  `order_price` decimal(10,2) DEFAULT NULL,
  `order_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `userID` (`userID`),
  CONSTRAINT `t_order_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `t_user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('1', '1', '4', '1205.00', '2021-11-20 20:05:01', '湖南长沙市天心区');
INSERT INTO `t_order` VALUES ('2', '1', '1', '417.00', '2021-11-09 21:06:56', '湖南长沙市天心区');
INSERT INTO `t_order` VALUES ('3', '1', '1', '338.00', '2021-11-09 14:23:56', '湖南衡阳市衡阳县');
INSERT INTO `t_order` VALUES ('4', '1', '1', '396.00', '2021-11-09 14:23:58', '湖南衡阳市衡阳县');
INSERT INTO `t_order` VALUES ('37', '1', '3', '265.00', '2021-11-16 17:56:50', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('42', '1', '2', '128.90', '2021-11-16 17:57:40', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('43', '1', '1', '89.00', '2021-11-22 09:11:23', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('44', '1', '1', '169.00', '2021-11-25 17:32:55', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('45', '2', '4', '1816.00', '2021-12-05 20:22:32', '7栋2单元103');
INSERT INTO `t_order` VALUES ('46', '2', '3', '1565.00', '2021-12-05 20:25:30', '7栋2单元103');
INSERT INTO `t_order` VALUES ('47', '2', '3', '477.00', '2021-12-06 19:44:52', '湖南省衡阳市衡阳县');
INSERT INTO `t_order` VALUES ('49', '2', '5', '3065.00', '2021-12-08 16:07:42', '7栋2单元103');
INSERT INTO `t_order` VALUES ('50', '9', '1', '699.00', '2021-12-15 17:48:33', '湖南科技职业学院');
INSERT INTO `t_order` VALUES ('51', '9', '1', '1399.00', '2021-12-15 18:56:27', '湖南科技职业学院');
INSERT INTO `t_order` VALUES ('52', '1', '2', '5798.00', '2021-12-21 19:50:41', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('53', '1', '2', '338.00', '2021-12-22 09:22:22', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('56', '13', '2', '917.00', '2021-12-25 20:16:14', '湖南科技职业学院');
INSERT INTO `t_order` VALUES ('57', '2', '3', '887.00', '2021-12-27 19:08:23', '湖南省衡阳市衡阳县');
INSERT INTO `t_order` VALUES ('58', '9', '1', '83.00', '2022-05-13 13:42:13', '湖南科技职业学院');
INSERT INTO `t_order` VALUES ('59', '9', '2', '198.00', '2022-05-13 14:07:53', '湖南科技职业学院');
INSERT INTO `t_order` VALUES ('60', '1', '2', '238.00', '2022-06-01 10:29:13', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('61', '1', '2', '238.00', '2022-06-01 10:29:14', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('62', '1', '2', '238.00', '2022-06-01 10:29:14', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('63', '1', '2', '238.00', '2022-06-01 10:29:21', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('64', '1', '2', '238.00', '2022-06-01 10:29:22', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('65', '1', '2', '238.00', '2022-06-01 10:29:22', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('66', '1', '2', '238.00', '2022-06-01 10:29:23', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('67', '1', '2', '238.00', '2022-06-01 10:29:23', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('68', '1', '2', '238.00', '2022-06-01 10:29:24', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('69', '1', '2', '238.00', '2022-06-01 10:29:24', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('70', '1', '2', '238.00', '2022-06-01 10:29:25', '湖南省长沙市天心区');
INSERT INTO `t_order` VALUES ('71', '1', '2', '238.00', '2022-06-01 10:29:26', '湖南省长沙市芙蓉区');
INSERT INTO `t_order` VALUES ('72', '1', '2', '238.00', '2022-06-01 10:29:27', '湖南省长沙市天心区');

-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail` (
  `orderDetailID` int(20) NOT NULL AUTO_INCREMENT,
  `orderID` int(20) DEFAULT NULL,
  `goodsID` int(20) DEFAULT NULL,
  `goods_num` int(10) DEFAULT NULL,
  `order_status` varchar(20) DEFAULT '待发货',
  PRIMARY KEY (`orderDetailID`),
  KEY `orderID` (`orderID`),
  KEY `goodsID` (`goodsID`),
  CONSTRAINT `t_order_detail_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `t_order` (`orderID`),
  CONSTRAINT `t_order_detail_ibfk_2` FOREIGN KEY (`goodsID`) REFERENCES `t_goods` (`goodsID`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES ('1', '1', '9', '1', '待评价');
INSERT INTO `t_order_detail` VALUES ('2', '2', '1', '1', '待收货');
INSERT INTO `t_order_detail` VALUES ('3', '3', '2', '1', '已完成');
INSERT INTO `t_order_detail` VALUES ('4', '4', '3', '1', '已完成');
INSERT INTO `t_order_detail` VALUES ('5', '1', '1', '3', '待收货');
INSERT INTO `t_order_detail` VALUES ('25', '37', '13', '2', '已完成');
INSERT INTO `t_order_detail` VALUES ('26', '37', '3', '1', '已完成');
INSERT INTO `t_order_detail` VALUES ('33', '42', '14', '1', '待收货');
INSERT INTO `t_order_detail` VALUES ('34', '42', '17', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('35', '43', '16', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('36', '44', '2', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('37', '45', '1', '3', '待发货');
INSERT INTO `t_order_detail` VALUES ('38', '45', '10', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('39', '46', '10', '1', '待收货');
INSERT INTO `t_order_detail` VALUES ('40', '46', '13', '2', '待评价');
INSERT INTO `t_order_detail` VALUES ('41', '47', '1', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('42', '47', '2', '2', '待评价');
INSERT INTO `t_order_detail` VALUES ('45', '49', '10', '2', '待收货');
INSERT INTO `t_order_detail` VALUES ('46', '49', '16', '3', '待收货');
INSERT INTO `t_order_detail` VALUES ('47', '50', '7', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('48', '51', '10', '1', '待收货');
INSERT INTO `t_order_detail` VALUES ('49', '52', '11', '2', '待发货');
INSERT INTO `t_order_detail` VALUES ('50', '53', '2', '2', '待发货');
INSERT INTO `t_order_detail` VALUES ('55', '56', '9', '1', '待评价');
INSERT INTO `t_order_detail` VALUES ('56', '56', '12', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('57', '57', '2', '2', '待发货');
INSERT INTO `t_order_detail` VALUES ('58', '57', '4', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('59', '58', '13', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('60', '59', '14', '2', '待发货');
INSERT INTO `t_order_detail` VALUES ('61', '60', '14', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('62', '60', '1', '1', '待发货');
INSERT INTO `t_order_detail` VALUES ('63', '61', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('64', '61', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('65', '62', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('66', '62', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('67', '63', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('68', '63', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('69', '64', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('70', '64', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('71', '65', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('72', '65', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('73', '66', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('74', '66', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('75', '67', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('76', '67', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('77', '68', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('78', '68', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('79', '69', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('80', '69', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('81', '70', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('82', '70', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('83', '71', '1', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('84', '71', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('85', '72', '14', null, '待发货');
INSERT INTO `t_order_detail` VALUES ('86', '72', '1', null, '待发货');

-- ----------------------------
-- Table structure for t_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_picture`;
CREATE TABLE `t_picture` (
  `pictureID` int(20) NOT NULL AUTO_INCREMENT,
  `goodsID` int(20) DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `image_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pictureID`),
  KEY `goodsID` (`goodsID`),
  CONSTRAINT `t_picture_ibfk_1` FOREIGN KEY (`goodsID`) REFERENCES `t_goods` (`goodsID`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_picture
-- ----------------------------
INSERT INTO `t_picture` VALUES ('1', null, 'lunbo01.jpeg', '轮播图');
INSERT INTO `t_picture` VALUES ('2', null, 'lunbo02.jpeg', '轮播图');
INSERT INTO `t_picture` VALUES ('3', null, 'lunbo03.jpeg', '轮播图');
INSERT INTO `t_picture` VALUES ('4', null, 'lunbo04.jpeg', '轮播图');
INSERT INTO `t_picture` VALUES ('5', null, 'lunbo05.jpeg', '轮播图');
INSERT INTO `t_picture` VALUES ('6', '1', 'detail_01_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('7', '1', 'detail_01_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('8', '1', 'detail_01_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('9', '1', 'detail_01_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('10', '1', 'detail_01_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('11', '1', 'detail_01_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('12', '2', 'detail_02_01.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('13', '2', 'detail_02_02.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('14', '2', 'detail_02_03.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('15', '2', 'detail_02_04.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('16', '2', 'detail_02_05.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('17', '2', 'detail_02_06.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('18', '3', 'detail_03_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('19', '3', 'detail_03_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('20', '3', 'detail_03_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('21', '3', 'detail_03_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('22', '3', 'detail_03_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('23', '3', 'detail_03_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('24', '4', 'detail_04_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('25', '4', 'detail_04_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('26', '4', 'detail_04_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('27', '4', 'detail_04_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('28', '4', 'detail_04_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('29', '4', 'detail_04_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('30', '5', 'detail_05_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('31', '5', 'detail_05_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('32', '5', 'detail_05_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('33', '5', 'detail_05_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('34', '5', 'detail_05_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('35', '5', 'detail_05_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('36', '6', 'detail_06_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('37', '6', 'detail_06_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('38', '6', 'detail_06_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('39', '6', 'detail_06_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('40', '6', 'detail_06_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('41', '6', 'detail_06_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('42', '7', 'detail_07_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('43', '7', 'detail_07_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('44', '7', 'detail_07_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('45', '7', 'detail_07_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('46', '7', 'detail_07_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('47', '8', 'detail_08_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('48', '8', 'detail_08_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('49', '8', 'detail_08_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('50', '8', 'detail_08_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('51', '8', 'detail_08_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('52', '8', 'detail_08_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('53', '9', 'detail_09_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('54', '9', 'detail_09_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('55', '9', 'detail_09_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('56', '9', 'detail_09_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('57', '9', 'detail_09_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('58', '9', 'detail_09_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('59', '10', 'detail_10_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('60', '10', 'detail_10_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('61', '10', 'detail_10_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('62', '10', 'detail_10_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('63', '10', 'detail_10_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('64', '10', 'detail_10_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('65', '11', 'detail_11_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('66', '11', 'detail_11_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('67', '11', 'detail_11_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('68', '11', 'detail_11_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('69', '11', 'detail_11_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('70', '11', 'detail_11_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('71', '12', 'detail_12_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('72', '12', 'detail_12_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('73', '12', 'detail_12_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('74', '12', 'detail_12_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('75', '12', 'detail_12_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('76', '12', 'detail_12_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('77', '13', 'detail_13_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('78', '13', 'detail_13_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('79', '13', 'detail_13_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('80', '13', 'detail_13_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('81', '13', 'detail_13_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('82', '13', 'detail_13_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('83', '14', 'detail_14_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('84', '14', 'detail_14_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('85', '14', 'detail_14_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('86', '14', 'detail_14_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('87', '14', 'detail_14_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('88', '14', 'detail_14_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('90', '15', 'detail_15_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('91', '15', 'detail_15_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('92', '15', 'detail_15_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('93', '15', 'detail_15_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('94', '15', 'detail_15_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('95', '16', 'detail_16_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('96', '16', 'detail_16_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('97', '16', 'detail_16_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('98', '16', 'detail_16_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('99', '16', 'detail_16_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('100', '17', 'detail_17_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('101', '17', 'detail_17_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('102', '17', 'detail_17_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('103', '17', 'detail_17_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('104', '18', 'detail_18_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('105', '18', 'detail_18_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('106', '18', 'detail_18_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('107', '18', 'detail_18_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('108', '18', 'detail_18_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('109', '19', 'detail_19_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('110', '19', 'detail_19_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('111', '19', 'detail_19_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('112', '19', 'detail_19_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('113', '19', 'detail_19_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('114', '19', 'detail_19_06.webp', '详情图');
INSERT INTO `t_picture` VALUES ('115', '1', 'desc_01_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('116', '1', 'desc_01_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('117', '1', 'desc_01_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('118', '1', 'desc_01_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('119', '1', 'desc_01_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('120', '1', 'desc_01_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('121', '2', 'desc_02_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('122', '2', 'desc_02_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('123', '2', 'desc_02_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('124', '2', 'desc_02_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('125', '2', 'desc_02_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('126', '2', 'desc_02_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('127', '3', 'desc_03_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('128', '3', 'desc_03_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('129', '3', 'desc_03_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('130', '3', 'desc_03_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('131', '3', 'desc_03_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('132', '3', 'desc_03_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('133', '4', 'desc_04_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('134', '4', 'desc_04_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('135', '4', 'desc_04_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('136', '4', 'desc_04_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('137', '4', 'desc_04_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('138', '4', 'desc_04_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('139', '5', 'desc_05_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('140', '5', 'desc_05_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('141', '5', 'desc_05_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('142', '5', 'desc_05_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('143', '5', 'desc_05_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('144', '5', 'desc_05_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('145', '6', 'desc_06_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('146', '6', 'desc_06_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('147', '6', 'desc_06_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('148', '6', 'desc_06_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('149', '6', 'desc_06_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('150', '6', 'desc_06_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('151', '7', 'desc_07_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('152', '7', 'desc_07_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('153', '7', 'desc_07_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('154', '7', 'desc_07_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('155', '7', 'desc_07_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('156', '7', 'desc_07_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('157', '8', 'desc_08_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('158', '8', 'desc_08_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('159', '8', 'desc_08_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('160', '8', 'desc_08_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('161', '8', 'desc_08_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('162', '8', 'desc_08_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('163', '9', 'desc_09_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('164', '9', 'desc_09_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('165', '9', 'desc_09_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('166', '9', 'desc_09_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('167', '9', 'desc_09_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('168', '9', 'desc_09_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('169', '10', 'desc_10_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('170', '10', 'desc_10_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('171', '10', 'desc_10_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('172', '10', 'desc_10_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('173', '10', 'desc_10_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('174', '10', 'desc_10_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('175', '11', 'desc_11_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('176', '11', 'desc_11_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('177', '11', 'desc_11_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('178', '11', 'desc_11_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('179', '11', 'desc_11_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('180', '11', 'desc_11_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('181', '12', 'desc_12_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('182', '12', 'desc_12_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('183', '12', 'desc_12_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('184', '12', 'desc_12_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('185', '12', 'desc_12_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('186', '12', 'desc_12_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('187', '13', 'desc_13_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('188', '13', 'desc_13_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('189', '13', 'desc_13_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('190', '13', 'desc_13_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('191', '13', 'desc_13_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('192', '13', 'desc_13_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('193', '14', 'desc_14_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('194', '14', 'desc_14_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('195', '14', 'desc_14_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('196', '14', 'desc_14_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('197', '14', 'desc_14_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('198', '14', 'desc_14_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('199', '15', 'desc_15_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('200', '15', 'desc_15_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('201', '15', 'desc_15_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('202', '15', 'desc_15_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('203', '15', 'desc_15_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('204', '15', 'desc_15_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('205', '16', 'desc_16_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('206', '16', 'desc_16_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('207', '16', 'desc_16_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('208', '16', 'desc_16_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('209', '16', 'desc_16_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('210', '16', 'desc_16_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('211', '17', 'desc_17_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('212', '17', 'desc_17_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('213', '17', 'desc_17_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('214', '17', 'desc_17_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('215', '17', 'desc_17_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('216', '17', 'desc_17_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('217', '18', 'desc_18_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('218', '18', 'desc_18_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('219', '18', 'desc_18_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('220', '18', 'desc_18_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('221', '18', 'desc_18_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('222', '18', 'desc_18_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('223', '19', 'desc_19_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('224', '19', 'desc_19_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('225', '19', 'desc_19_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('226', '19', 'desc_19_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('227', '19', 'desc_19_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('228', '19', 'desc_19_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('229', '20', 'detail_20_01.webp', '详情图');
INSERT INTO `t_picture` VALUES ('230', '20', 'detail_20_02.webp', '详情图');
INSERT INTO `t_picture` VALUES ('231', '20', 'detail_20_03.webp', '详情图');
INSERT INTO `t_picture` VALUES ('233', '20', 'detail_20_04.webp', '详情图');
INSERT INTO `t_picture` VALUES ('234', '20', 'detail_20_05.webp', '详情图');
INSERT INTO `t_picture` VALUES ('235', '20', 'desc_20_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('236', '20', 'desc_20_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('237', '20', 'desc_20_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('238', '20', 'desc_20_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('239', '20', 'desc_20_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('240', '20', 'desc_20_06.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('241', '21', 'detail_21_01.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('242', '21', 'detail_21_02.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('243', '21', 'detail_21_03.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('244', '21', 'detail_21_04.jpeg', '详情图');
INSERT INTO `t_picture` VALUES ('245', '21', 'desc_21_01.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('246', '21', 'desc_21_02.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('247', '21', 'desc_21_03.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('248', '21', 'desc_21_04.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('249', '21', 'desc_21_05.jpeg', '描述图');
INSERT INTO `t_picture` VALUES ('250', '21', 'desc_21_06.jpeg', '描述图');

-- ----------------------------
-- Table structure for t_remark
-- ----------------------------
DROP TABLE IF EXISTS `t_remark`;
CREATE TABLE `t_remark` (
  `remarkID` int(20) NOT NULL AUTO_INCREMENT,
  `goodsID` int(20) DEFAULT NULL,
  `userID` int(20) DEFAULT NULL,
  `remark_content` varchar(200) DEFAULT NULL,
  `remark_img` varchar(50) DEFAULT NULL,
  `remark_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`remarkID`),
  KEY `goodsID` (`goodsID`),
  KEY `userID` (`userID`),
  CONSTRAINT `t_remark_ibfk_1` FOREIGN KEY (`goodsID`) REFERENCES `t_goods` (`goodsID`),
  CONSTRAINT `t_remark_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `t_user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_remark
-- ----------------------------
INSERT INTO `t_remark` VALUES ('1', '1', '1', '产品很好，很喜欢，下次还会来', 'remark_01_01.jpg', '2021-11-02 09:57:45');
INSERT INTO `t_remark` VALUES ('2', '1', '2', '有新货了，记得通知我~东西好便宜，质量非常出乎意料，下次还会来的~好卖家，继续关注！', 'remark_01_02.jpg', '2021-11-02 09:59:07');
INSERT INTO `t_remark` VALUES ('3', '1', '3', '质量非常好，真出乎我的意料，包装非常仔细，非常感谢，祝生意兴隆！', 'remark_01_03.jpg', '2021-11-02 09:59:09');
INSERT INTO `t_remark` VALUES ('4', '1', '4', '发货速度挺快的，赞一个，会再来光顾哒～', 'remark_01_01.jpg', '2021-11-02 09:59:11');
INSERT INTO `t_remark` VALUES ('5', '1', '5', '店家服务的很周到，店家的宝贝我很满意！', 'remark_01_02.jpg', '2021-11-02 09:59:13');
INSERT INTO `t_remark` VALUES ('6', '1', '6', '买来这个是送人的，她很喜欢。卖家的贴心让我感到很温暖。以后我还会来选的。', 'remark_01_03.jpg', '2021-11-02 09:59:15');
INSERT INTO `t_remark` VALUES ('7', '2', '7', '不錯，挺好玩的！要是能給個盒子收藏就好了！或，能給條手帶就更安全了，畢竟在工地經常手忙腳亂的做事！颜值够高，价格实惠，操作简便，服务一流，手感一流，质量上乘，精准度高，反应灵敏', 'remark_02_01.jpg', '2021-11-02 10:21:20');
INSERT INTO `t_remark` VALUES ('8', '2', '8', '反应灵敏，操作简便，反应灵敏，手感一流，颜值够高，孩子非常喜欢', 'remark_02_02.jpg', '2021-11-02 10:21:27');
INSERT INTO `t_remark` VALUES ('10', '2', '10', '操作简便，服务一流，精准度高，质量上乘，质量上乘，精准度高，手感一流，颜值够高', 'remark_02_04.jpg', '2021-11-02 10:21:35');
INSERT INTO `t_remark` VALUES ('11', '2', '1', '拿到手上小巧玲珑，手感是那种磨砂材质，连接米家智能画图，很适合需要测量工作的人员，颜值够高，价格实惠，服务一流，操作简便，手感一流，质量上乘，精准度高，反应灵敏', 'remark_02_05.jpg', '2021-11-02 10:21:44');
INSERT INTO `t_remark` VALUES ('12', '2', '2', '操作简便，价格实惠，服务一流，颜色漂亮，精准度高。值得推荐！', 'remark_02_06.jpg', '2021-11-03 10:21:55');
INSERT INTO `t_remark` VALUES ('13', '3', '3', '赞一个，发货迅速，宝贝和图片差不多。很不错！希望下次合作谢谢掌柜~', 'remark_03_01.jpg', '2021-11-02 10:27:32');
INSERT INTO `t_remark` VALUES ('14', '3', '4', '有了问题能很好的处理，可以信赖的好店家，以后有机会我们再合作', 'remark_03_02.jpg', '2021-11-02 10:27:36');
INSERT INTO `t_remark` VALUES ('15', '3', '5', '宝贝收到了，很喜欢，买家很有信用！\r\n', 'remark_03_03.jpg', '2021-11-02 10:27:40');
INSERT INTO `t_remark` VALUES ('16', '3', '6', '期盼之中，终于等到了心爱的东东，谢谢！', 'remark_03_01.jpg', '2021-11-02 10:27:42');
INSERT INTO `t_remark` VALUES ('17', '3', '7', '最近太忙了，确认晚了，东西是很好的，呵呵，谢了。', 'remark_03_02.jpg', '2021-11-02 10:27:45');
INSERT INTO `t_remark` VALUES ('18', '3', '8', '发货速度挺快的，赞一个，会再来光顾哒～', 'remark_03_03.jpg', '2021-11-23 10:27:58');
INSERT INTO `t_remark` VALUES ('20', '4', '10', '颜值高，性价比好，不用布线很方便，还没有连接小爱同学，等装修好了，再弄。', 'remark_04_02.jpg', '2021-11-02 10:32:37');
INSERT INTO `t_remark` VALUES ('21', '4', '1', '加热快速，颜值担当，功能强大，颜值够高，做工精湛，服务一流，安装简便，制热给力', 'remark_04_03.jpg', '2021-11-02 10:32:44');
INSERT INTO `t_remark` VALUES ('22', '4', '2', '质量上乘，服务一流，做工精湛，制热给力，颜值够高，功能强大，安装简便', 'remark_04_04.jpg', '2021-11-02 10:32:51');
INSERT INTO `t_remark` VALUES ('23', '4', '3', '颜值够高，制热给力，功能强大，质量上乘，安装简便，价格实惠', 'remark_04_05.jpg', '2021-11-02 10:32:57');
INSERT INTO `t_remark` VALUES ('24', '4', '4', '浴霸收到了，附带止逆阀和通风管道，功能强大，颜值够高，做工精湛，价格实惠。', 'remark_04_06.jpg', '2021-11-02 10:33:03');
INSERT INTO `t_remark` VALUES ('25', '5', '5', '颜值够高，安装简便，价格实惠，质量上乘，热水充足', 'remark_05_01.jpg', '2021-11-02 10:38:10');
INSERT INTO `t_remark` VALUES ('26', '5', '6', '安装得非常满意，安装师傅很热心，帮忙把原来旧机拆下。', 'remark_05_02.jpg', '2021-11-02 10:38:15');
INSERT INTO `t_remark` VALUES ('27', '5', '7', '颜值够高，价格实惠，安装简便，热水充足', 'remark_05_03.jpg', '2021-11-02 10:38:24');
INSERT INTO `t_remark` VALUES ('28', '5', '8', '服务一流，颜值够高，安装简便，价格实惠，尺寸适宜，质量上乘，热水充足，设计合理', 'remark_05_04.jpg', '2021-11-02 10:38:34');
INSERT INTO `t_remark` VALUES ('29', '5', '9', '物流速度快，产品质量很好，售后安装服务师傅服务到位技术好', 'remark_05_05.jpg', '2021-11-02 10:38:39');
INSERT INTO `t_remark` VALUES ('30', '5', '10', '安装师傅安装好 物流很快就到了 而且很热情 五星好评', 'remark_05_06.jpg', '2021-11-02 10:39:13');
INSERT INTO `t_remark` VALUES ('32', '6', '2', '价格实惠，价格实惠，服务一流，颜值够高，操作简便，功能强大，做工精湛，颜色漂亮', 'remark_06_02.jpg', '2021-11-02 10:44:13');
INSERT INTO `t_remark` VALUES ('33', '6', '3', '颜值够高，按摩到位，质量上乘，功能强大，做工精湛', 'remark_06_03.jpg', '2021-11-02 10:44:18');
INSERT INTO `t_remark` VALUES ('34', '6', '4', '颜值够高，时尚简约,有现代感的设计外观 操作简便，按钮简单,多种模式一键搞定 功能强大,多种按摩模式,可加热,舒服!', 'remark_06_04.jpg', '2021-11-02 10:44:31');
INSERT INTO `t_remark` VALUES ('35', '6', '5', '颜色漂亮，质量上乘，做工精湛，功能强大，价格实惠', 'remark_06_05.jpg', '2021-11-02 10:44:39');
INSERT INTO `t_remark` VALUES ('36', '6', '6', '操作简便，功能强大，按摩到位，颜值够高，相当的可以，性价比超高。', 'remark_06_06.jpg', '2021-11-02 10:44:46');
INSERT INTO `t_remark` VALUES ('37', '7', '7', '从买到商品到现在，真的是感觉到了客服的用心，服务态度。因为中间有不会使用的插曲，也完美解决了。现在的体验感非常不错，而且市面上10kg的洗衣机这个价格也很实惠。颜值美观大方，不占空间。', 'remark_07_01.jpg', '2021-11-02 10:49:58');
INSERT INTO `t_remark` VALUES ('38', '7', '8', '价格实惠，声响较小，空间充足，操作简便，洗涤干净，服务一流，有品生活必属精品', 'remark_07_02.jpg', '2021-11-02 10:50:02');
INSERT INTO `t_remark` VALUES ('39', '7', '9', '非常不错，价格实惠，动力强劲，操作简便，洗涤干净，强烈推荐。', 'remark_07_03.jpg', '2021-11-02 10:50:06');
INSERT INTO `t_remark` VALUES ('40', '7', '10', '价格实惠，希望耐用。声响较小，动力强劲，价格实惠', 'remark_07_04.jpg', '2021-11-02 10:50:10');
INSERT INTO `t_remark` VALUES ('41', '7', '1', '用过之后感觉很不错，是正品，快递也很给力，果然名副其实', 'remark_07_05.jpg', '2021-11-02 10:50:16');
INSERT INTO `t_remark` VALUES ('42', '7', '2', '大小刚刚好合适，容量也挺满意的，能塞很多进去洗，而且声音也不大，这款性价比是真的OK', 'remark_07_06.jpg', '2021-11-02 10:50:22');
INSERT INTO `t_remark` VALUES ('43', '8', '3', '商品很棒，师傅也很负责任。安装也很准时。', 'remark_08_01.jpg', '2021-11-02 10:55:01');
INSERT INTO `t_remark` VALUES ('44', '8', '4', '商品很棒，好评!', 'remark_08_02.jpg', '2021-11-02 10:55:06');
INSERT INTO `t_remark` VALUES ('45', '8', '5', '商品很棒，好评!', 'remark_08_03.jpg', '2021-11-02 10:55:11');
INSERT INTO `t_remark` VALUES ('46', '8', '6', '商品很棒，师傅也很负责任。安装也很准时。', 'remark_08_04.jpg', '2021-11-02 10:55:15');
INSERT INTO `t_remark` VALUES ('47', '8', '7', '商品很棒，好评!', 'remark_08_05.jpg', '2021-11-02 10:55:21');
INSERT INTO `t_remark` VALUES ('48', '8', '8', '商品很棒，好评!', 'remark_08_06.jpg', '2021-11-02 10:55:27');
INSERT INTO `t_remark` VALUES ('49', '9', '9', '羽绒服非常厚实，里面还有蓄热保暖膜，简约设计非常大气，800蓬松度真不是一般羽绒能比的，看起来非常饱满有型。手感非常好，小雨小雪都能挡住，功能强大。最重要的是羽绒充的是真多，非常满意', 'remark_09_01.jpg', '2021-11-02 10:58:30');
INSERT INTO `t_remark` VALUES ('50', '9', '10', '衣服穿上很舒服，发暖快', 'remark_09_02.jpg', '2021-11-02 10:58:34');
INSERT INTO `t_remark` VALUES ('51', '9', '1', '商品很棒，好评!', 'remark_09_03.jpg', '2021-11-02 10:58:40');
INSERT INTO `t_remark` VALUES ('52', '9', '2', '商品很棒，好评!', 'remark_09_04.jpg', '2021-11-02 10:58:45');
INSERT INTO `t_remark` VALUES ('53', '9', '3', '商品很棒，好评!', 'remark_09_05.jpg', '2021-11-02 10:58:51');
INSERT INTO `t_remark` VALUES ('54', '9', '4', '商品很棒，好评!', 'remark_09_06.jpg', '2021-11-02 10:59:02');
INSERT INTO `t_remark` VALUES ('55', '10', '5', '有新货了，记得通知我~东西好便宜，质量非常出乎意料，下次还会来的~好卖家，继续关注！', 'remark_10_01.jpg', '2021-11-02 11:01:51');
INSERT INTO `t_remark` VALUES ('56', '10', '6', '质量非常好，真出乎我的意料，包装非常仔细，非常感谢，祝生意兴隆！', 'remark_10_02.jpg', '2021-11-02 11:01:55');
INSERT INTO `t_remark` VALUES ('57', '10', '7', '发货速度挺快的，赞一个，会再来光顾哒～\r\n', 'remark_10_03.jpg', '2021-11-02 11:01:59');
INSERT INTO `t_remark` VALUES ('58', '10', '8', '店家服务的很周到，店家的宝贝我很满意！', 'remark_10_04.jpg', '2021-11-02 11:02:03');
INSERT INTO `t_remark` VALUES ('59', '10', '9', '买来这个是送人的，她很喜欢。卖家的贴心让我感到很温暖。', 'remark_10_05.jpg', '2021-11-02 11:02:09');
INSERT INTO `t_remark` VALUES ('60', '10', '10', '赞一个，发货迅速，宝贝和图片差不多。很不错！希望下次合作谢谢掌柜~', 'remark_10_06.jpg', '2021-11-02 11:02:15');
INSERT INTO `t_remark` VALUES ('61', '11', '1', '买的第二台小莫了，颜值够高，服务一流，尺寸适宜，操作简便，值得推荐', 'remark_11_01.jpg', '2021-11-02 11:05:36');
INSERT INTO `t_remark` VALUES ('62', '11', '2', '比预期稍微大一点，不过还能接受，跑步机选了好久，挑了好多，属这款颜值高', 'remark_11_02.jpg', '2021-11-02 11:05:40');
INSERT INTO `t_remark` VALUES ('63', '11', '3', '买个跑步机在家动动也挺好，全家人都可以在家锻炼了！', 'remark_11_03.jpg', '2021-11-02 11:05:45');
INSERT INTO `t_remark` VALUES ('64', '11', '4', '很不错的一款，我先生近90kg跑起来也很稳当，声音在预期范围内。屏幕很大，触摸键灵敏。', 'remark_11_04.jpg', '2021-11-02 11:05:49');
INSERT INTO `t_remark` VALUES ('65', '11', '5', '划船机和跑步机买的都是小莫的，送货上门后预约师傅，很快就帮我安装好了，师傅也是很专业的哦', 'remark_11_05.jpg', '2021-11-02 11:05:54');
INSERT INTO `t_remark` VALUES ('66', '11', '6', '趁着活动入手的，对比了好几家最后选了小莫，颜值没得说', 'remark_11_06.jpg', '2021-11-02 11:05:59');
INSERT INTO `t_remark` VALUES ('67', '12', '7', '尺码很合身，里面还有加绒，很柔软舒服，细节方面也处理的非常好，值了', 'remark_12_01.jpg', '2021-11-02 11:11:12');
INSERT INTO `t_remark` VALUES ('68', '12', '8', '大小合适，质量很好', 'remark_12_02.jpg', '2021-11-02 11:11:20');
INSERT INTO `t_remark` VALUES ('69', '12', '9', '不错，穿到身上软软的，舒服', 'remark_12_03.jpg', '2021-11-02 11:11:24');
INSERT INTO `t_remark` VALUES ('70', '12', '10', '质量很好，性价比高！', 'remark_12_04.jpg', '2021-11-02 11:11:27');
INSERT INTO `t_remark` VALUES ('71', '12', '1', '质量不错，布料穿着也十分舒服。有活动还会继续购买!', 'remark_12_05.jpg', '2021-11-02 11:11:33');
INSERT INTO `t_remark` VALUES ('72', '12', '2', '质量好.现在穿有点薄', 'remark_12_06.jpg', '2021-11-02 11:11:42');
INSERT INTO `t_remark` VALUES ('73', '13', '3', '看书，放大屏板真的舒服，体验是一级的棒，设计理念超前，帅气可爱迷人，质量上乘，尺寸适宜。', 'remark_13_01.jpg', '2021-11-02 11:23:33');
INSERT INTO `t_remark` VALUES ('74', '13', '4', '很好的小桌子，大小刚刚好，给女儿当学习桌用，非常合适，质量过关，很稳固\r\n', 'remark_13_02.jpg', '2021-11-02 11:23:37');
INSERT INTO `t_remark` VALUES ('75', '13', '5', '有个固定书夹，看书学习的时候很方便，质量不错，做工也很精致，与卖家描述的一致！', 'remark_13_03.jpg', '2021-11-02 11:23:41');
INSERT INTO `t_remark` VALUES ('76', '13', '6', '质量上乘，价格实惠，安装简便，看书舒服，设计合理，做工精湛，尺寸适宜', 'remark_13_04.jpg', '2021-11-02 11:23:45');
INSERT INTO `t_remark` VALUES ('77', '13', '7', '质量上乘，安装简便，设计合理，看书舒服', 'remark_13_01.jpg', '2021-11-02 11:23:47');
INSERT INTO `t_remark` VALUES ('78', '13', '8', '不错，好用，这个价格买到这样的东西', 'remark_13_02.jpg', '2021-11-02 11:23:53');
INSERT INTO `t_remark` VALUES ('80', '14', '10', '做工精湛，质感极佳，用料扎实，价格实惠，颜值够高，服务一流，质量上乘，款式一流', 'remark_14_02.jpg', '2021-11-02 11:28:55');
INSERT INTO `t_remark` VALUES ('81', '14', '1', '好评，质量非常好，款式好看，非常赞的。', 'remark_14_03.jpg', '2021-11-02 11:29:02');
INSERT INTO `t_remark` VALUES ('82', '14', '2', '质量非常上乘，用料非常扎实，质感很好！', 'remark_14_04.jpg', '2021-11-02 11:29:06');
INSERT INTO `t_remark` VALUES ('83', '14', '3', '很不错，很合适。', 'remark_14_05.jpg', '2021-11-02 11:29:10');
INSERT INTO `t_remark` VALUES ('84', '14', '4', '很轻，带上没有感觉，刚开始不适应，骑一次就好了，有哈气立马消失那种', 'remark_14_06.jpg', '2021-11-02 11:29:16');
INSERT INTO `t_remark` VALUES ('85', '15', '5', 'nice，质量上乘，颜值够高', 'remark_15_01.jpg', '2021-11-02 11:32:27');
INSERT INTO `t_remark` VALUES ('86', '15', '6', '本来还在纠结什么品牌，第一眼看到这个款，就爱上了，收到之后装上之后，颜值又高，使用又很方便。特别是用音响声控，简直是太方便。价格实惠', 'remark_15_02.jpg', '2021-11-02 11:32:32');
INSERT INTO `t_remark` VALUES ('87', '15', '7', '东西真心不错，好太品牌值得信赖。安装师傅很到位。发货速度也很。有问必答。有需要的朋友可以来购买。值得推荐给大家。选电动晾衣架还的是好太太。', 'remark_15_03.jpg', '2021-11-02 11:32:36');
INSERT INTO `t_remark` VALUES ('88', '15', '8', '质量上乘，价格实惠，服务一流，颜色漂亮，反应灵敏', 'remark_15_04.jpg', '2021-11-02 11:33:34');
INSERT INTO `t_remark` VALUES ('89', '15', '9', '服务一流，基本没有什么噪音，安装师傅很好，运行流畅，颜值很高', 'remark_15_05.jpg', '2021-11-02 11:33:37');
INSERT INTO `t_remark` VALUES ('90', '15', '10', '颜值够高，服务一流，反应灵敏，质量上乘，价格实惠', 'remark_15_06.jpg', '2021-11-02 11:33:42');
INSERT INTO `t_remark` VALUES ('91', '16', '1', '价格实惠，清理方便，服务一流，做工精湛，用料扎实，手感一流，质量上乘，手感一流', 'remark_16_01.jpg', '2021-11-02 11:37:24');
INSERT INTO `t_remark` VALUES ('92', '16', '2', '空间充足，保温性好，价格实惠，做工精湛，手感一流，送礼佳品！', 'remark_16_02.jpg', '2021-11-02 11:37:30');
INSERT INTO `t_remark` VALUES ('93', '16', '3', '手感一流，保温性好，做工精湛，质量上乘，价格时不时有变动', 'remark_16_03.jpg', '2021-11-02 11:37:35');
INSERT INTO `t_remark` VALUES ('94', '16', '4', '真的很好，性价比也很高，质量也很好，物流也快啊！一天就到货了！', 'remark_16_04.jpg', '2021-11-02 11:37:40');
INSERT INTO `t_remark` VALUES ('95', '16', '5', '昨晚特意烧了开水，晚上六点左右装的，今天早上七点钟还是温的，非常棒', 'remark_16_01.jpg', '2021-11-02 11:37:41');
INSERT INTO `t_remark` VALUES ('96', '16', '6', '空间充足，保温性好，价格实惠，做工精湛，质量上乘，颜值够高', 'remark_16_02.jpg', '2021-11-02 11:37:47');
INSERT INTO `t_remark` VALUES ('97', '17', '7', '每月更换，保证猫咪和狗子的饮水安全，猫咪和狗子都非常爱喝流动的水，效果怎么样可以看图片，哈哈！真的是非常好的产品，解决了宠物不爱喝水的问题！', 'remark_17_01.jpg', '2021-11-02 11:40:50');
INSERT INTO `t_remark` VALUES ('98', '17', '8', '挺不错的，一直在用小米的宠物喝水', 'remark_17_02.jpg', '2021-11-02 11:40:54');
INSERT INTO `t_remark` VALUES ('99', '17', '9', '用了一个月真的很脏，我家的猫猫健康很重要。', 'remark_17_03.jpg', '2021-11-02 11:40:57');
INSERT INTO `t_remark` VALUES ('100', '17', '10', '之前买的猫咪饮水机用了段时间提示要更换滤芯了 配送很快 价格也能接受为了猫咪健康', 'remark_17_04.jpg', '2021-11-02 11:41:01');
INSERT INTO `t_remark` VALUES ('101', '17', '1', '饮水机好用！定期会提醒换滤芯。趁着会员活动买的。唯一的缺点就是要邮费。包邮就好了。', 'remark_17_05.jpg', '2021-11-02 11:41:06');
INSERT INTO `t_remark` VALUES ('102', '17', '2', '活动不错，噪音较小，价格实惠', 'remark_17_06.jpg', '2021-11-02 11:41:11');
INSERT INTO `t_remark` VALUES ('103', '18', '3', '价格实惠，口感俱佳，味道不错，品质一流，客服很好，活动给力，色泽俱佳，外观漂亮', 'remark_18_01.jpg', '2021-11-02 11:44:52');
INSERT INTO `t_remark` VALUES ('104', '18', '4', '刚好做活动，价格便宜了很多，性价比超高，真的特别划算，是理想中的产品，质量不错，物流也很快，值得点赞！！', 'remark_18_02.jpg', '2021-11-02 11:44:56');
INSERT INTO `t_remark` VALUES ('105', '18', '5', '价格实惠，口感俱佳', 'remark_18_03.jpg', '2021-11-02 11:45:01');
INSERT INTO `t_remark` VALUES ('106', '18', '6', '价格实惠，清香扑鼻', 'remark_18_04.jpg', '2021-11-02 11:45:05');
INSERT INTO `t_remark` VALUES ('107', '18', '7', '口感很好，已经喝了一瓶了，朋友都说好，性价比超高，等有活动了会继续回购', 'remark_18_05.jpg', '2021-11-02 11:45:11');
INSERT INTO `t_remark` VALUES ('108', '18', '8', '已经多次购买，味道很好，雷总推荐的绝对是好东西。平时公司聚会拿出来大家一起喝，同事们都说酒不错问我在哪里买，果断推荐小米有品，666，清香扑鼻，服务一流', 'remark_18_06.jpg', '2021-11-02 11:45:17');
INSERT INTO `t_remark` VALUES ('109', '19', '9', '样式简单好看，是多层实木的，打开没有味道，标配的水龙头和五金件质量也不错，安装师傅很细心', 'remark_19_01.jpg', '2021-11-02 11:48:20');
INSERT INTO `t_remark` VALUES ('110', '19', '10', '实体店两千多，有品基本算半价了，还送下水，龙头。安装余师傅非常棒。我自己配了个大白的抽拉龙头，洗头也方便，爆赞。德邦物流也很好。', 'remark_19_02.jpg', '2021-11-02 11:48:26');
INSERT INTO `t_remark` VALUES ('111', '19', '1', '非常好，售后很不错，感觉以后都在惠达买了，被圈粉了，颜值够高，价格实惠，质量上乘', 'remark_19_03.jpg', '2021-11-02 11:48:31');
INSERT INTO `t_remark` VALUES ('112', '19', '2', '质量可靠，很棒！', 'remark_19_04.jpg', '2021-11-02 11:48:35');
INSERT INTO `t_remark` VALUES ('113', '19', '3', '东西不错挺好的', 'remark_19_05.jpg', '2021-11-02 11:48:39');
INSERT INTO `t_remark` VALUES ('114', '19', '4', '非常满意的一次购物，产品和安装都是很周到，效果很好，很赞！', 'remark_19_06.jpg', '2021-11-02 11:48:44');
INSERT INTO `t_remark` VALUES ('115', '3', '1', '商品质量非常好家里人使用了都说棒棒棒！', 'remark_03_01.jpg', '2021-11-08 22:54:18');
INSERT INTO `t_remark` VALUES ('118', '3', '1', '商品质量很好', 'remark_03_02.jpg', '2021-11-10 10:25:37');
INSERT INTO `t_remark` VALUES ('119', '2', '1', '商品很好，下次会在光顾！', 'remark_02_02.jpg', '2021-11-21 18:39:53');
INSERT INTO `t_remark` VALUES ('120', '20', '1', '送别人的，挺好看，做工也挺精细的', 'remark_20_01.jpg', '2021-12-19 16:07:23');
INSERT INTO `t_remark` VALUES ('121', '20', '2', '价格实惠，做工精湛，服务一流，礼物很不错', 'remark_20_02.jpg', '2021-12-19 16:09:25');
INSERT INTO `t_remark` VALUES ('122', '20', '3', '清香扑鼻？没有 价格实惠？实惠 做工精湛？见仁见智 质量上乘？实物为准 服务一流？这个是真的 礼物很不错？这个也是真的', 'remark_20_03.jpg', '2021-12-19 16:11:04');
INSERT INTO `t_remark` VALUES ('123', '20', '4', '花很漂亮，超级真实，很心动，自己买来送给自己的！ 看着心里很开心！收到货后中间发生了点问题，卖家给解决，态度很好！美美哒！祝店家生意兴隆！', 'remark_20_04.jpg', '2021-12-19 16:11:49');
INSERT INTO `t_remark` VALUES ('124', '20', '5', '送给媳妇的生日礼物，很喜欢，说是很漂亮，很高兴。', 'remark_20_05.jpg', '2021-12-19 16:12:11');
INSERT INTO `t_remark` VALUES ('125', '20', '6', '第一眼看到的金色叶子，居然是残叶，第一印象很重要啊！整体还算过得去吧…希望爱人会喜欢吧。', 'remark_20_06.jpg', '2021-12-19 16:12:22');
INSERT INTO `t_remark` VALUES ('126', '3', '1', '商品很不错，下次还会购买', 'detail_03_04.webp', '2021-12-22 08:51:59');

-- ----------------------------
-- Table structure for t_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply` (
  `replyID` int(20) NOT NULL AUTO_INCREMENT,
  `remarkID` int(20) DEFAULT NULL,
  `reply_content` varchar(100) DEFAULT NULL,
  `reply_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`replyID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `t_reply_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `t_remark` (`remarkID`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES ('95', '1', '谢谢亲的支持，我们一定都会做的更好！', '2021-11-16 09:20:11');
INSERT INTO `t_reply` VALUES ('96', '2', '感谢亲真情的回复，我们会做得更好！', '2021-11-21 09:20:11');
INSERT INTO `t_reply` VALUES ('97', '4', '不远万里的回复，您的支持就是我们的动力，我们将不负所望坚持下去！', '2021-11-16 09:20:11');
INSERT INTO `t_reply` VALUES ('98', '11', '您的评价就是对我们最大的支持，欢迎下次光临！', '2021-11-04 09:20:11');
INSERT INTO `t_reply` VALUES ('99', '21', '您的支持对我们非常重要，谢谢您的评价！', '2021-11-15 09:20:11');
INSERT INTO `t_reply` VALUES ('100', '3', '谢谢支持！欢迎下次光临！', '2021-11-24 09:20:11');
INSERT INTO `t_reply` VALUES ('101', '7', '谢谢您的支持，欢迎下次光临！', '2021-12-15 21:14:23');
INSERT INTO `t_reply` VALUES ('102', '29', '谢谢您的支持，欢迎下次光临！', '2021-12-15 21:14:46');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `userID` int(20) NOT NULL AUTO_INCREMENT,
  `user_head` varchar(50) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_pass` varchar(20) DEFAULT NULL,
  `user_status` varchar(20) DEFAULT '正常',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'headshot.jpg', 'cm', '123', '安全');
INSERT INTO `t_user` VALUES ('2', 'headshot2.jpg', '小七', '123', '安全');
INSERT INTO `t_user` VALUES ('3', 'user_01.jpg', '孙西文', '123', '安全');
INSERT INTO `t_user` VALUES ('4', 'user_02.jpg', '晚吟', '123', '安全');
INSERT INTO `t_user` VALUES ('5', 'user_03.jpg', '孙西文2号', '123', '冻结');
INSERT INTO `t_user` VALUES ('6', 'user_04.jpg', '孙西文3号', '123', '冻结');
INSERT INTO `t_user` VALUES ('7', 'user_05.jpg', '孙西文1号', '123', '安全');
INSERT INTO `t_user` VALUES ('8', 'user_06.jpg', '蓝桉', '123', '冻结');
INSERT INTO `t_user` VALUES ('9', 'a_7.jpg', '江沉晚眠时尽', '123', '存在风险');
INSERT INTO `t_user` VALUES ('10', 'user_08.jpg', '江沉', '123', '安全');
INSERT INTO `t_user` VALUES ('12', 'user_01.jpg', '123', '123', '安全');
INSERT INTO `t_user` VALUES ('13', 'headshot.jpg', '徐凤年', '123', '安全');

-- ----------------------------
-- Procedure structure for P_order
-- ----------------------------
DROP PROCEDURE IF EXISTS `P_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `P_order`(in user_id int,in goods_id int,in order_id int)
BEGIN
declare goodsNum int;
select goods_num into goodsNum from t_cart where userID=user_id and goodsID=goods_id;
insert into t_order_detail(orderID,goodsID,goods_num) values(order_id,goods_id,goodsNum);
delete from t_cart where userID=user_id  and goodsID=goods_id;
end
;;
DELIMITER ;
