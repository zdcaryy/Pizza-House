-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.5.47-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.5.0.5220
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 ours 的数据库结构
CREATE DATABASE IF NOT EXISTS `ours` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ours`;

-- 导出  表 ours.admins 结构
CREATE TABLE IF NOT EXISTS `admins` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` char(10) NOT NULL COMMENT '商家用户名',
  `passwd` char(10) NOT NULL COMMENT '密码',
  `tel` char(11) NOT NULL COMMENT '电话号',
  `addtime` datetime NOT NULL COMMENT '用户添加时间',
  `photo` text NOT NULL COMMENT '商家头像',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商家管理人员';

-- 正在导出表  ours.admins 的数据：3 rows
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`aid`, `username`, `passwd`, `tel`, `addtime`, `photo`, `status`) VALUES
	(1, 'zdc', '123', '18328810855', '2018-03-22 09:39:37', '', 1),
	(2, 'zp', '123', '18328818467', '2018-03-31 15:52:43', '', 1),
	(3, 'rw', '123', '18328817777', '2018-03-31 15:52:48', '', 1);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- 导出  表 ours.cate 结构
CREATE TABLE IF NOT EXISTS `cate` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `catename` char(50) NOT NULL COMMENT '食品分类名称',
  `childnum` int(11) NOT NULL DEFAULT '0' COMMENT '子类数量',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态：判断是否可用',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='食品栏目列表';

-- 正在导出表  ours.cate 的数据：10 rows
/*!40000 ALTER TABLE `cate` DISABLE KEYS */;
INSERT INTO `cate` (`cid`, `catename`, `childnum`, `status`) VALUES
	(1, '优惠/新品', 9, 1),
	(2, '超值套餐', 4, 1),
	(3, '披萨', 6, 1),
	(4, '意面', 8, 1),
	(5, '饭食', 2, 1),
	(6, '小吃', 2, 1),
	(7, '汤', 3, 1),
	(8, '饮料', 4, 1),
	(9, '首页推荐', 0, 1),
	(10, '首页推荐', 0, 1);
/*!40000 ALTER TABLE `cate` ENABLE KEYS */;

-- 导出  表 ours.comments 结构
CREATE TABLE IF NOT EXISTS `comments` (
  `commentid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `addtime` char(50) NOT NULL COMMENT '添加评论的时间',
  `images` text COMMENT '用户上传的图片',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '评论状态',
  `content` text COMMENT '评论内容',
  PRIMARY KEY (`commentid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- 正在导出表  ours.comments 的数据：2 rows
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`commentid`, `uid`, `addtime`, `images`, `status`, `content`) VALUES
	(3, 2, '2018/4/3 下午11:21:21', NULL, 1, '今天有些不开心，所以一直吃了很多东西，谁让咱吃不胖呢。'),
	(2, 2, '2018/4/3 下午11:20:19', NULL, 1, '真的好吃哈哈。。');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- 导出  表 ours.food 结构
CREATE TABLE IF NOT EXISTS `food` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `foodname` char(50) NOT NULL COMMENT '食品名称',
  `cid` int(11) NOT NULL COMMENT '食品类别',
  `images` text NOT NULL COMMENT '食品图片地址',
  `detail` text COMMENT '食品详情',
  `heartnum` int(11) NOT NULL DEFAULT '0' COMMENT '好评数量',
  `badnum` int(11) NOT NULL DEFAULT '0' COMMENT '差评数量',
  `price` int(11) NOT NULL COMMENT '食品价格',
  `sales` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '是否有货',
  `discount` float NOT NULL DEFAULT '1' COMMENT '折扣',
  `monthsales` int(11) NOT NULL DEFAULT '0' COMMENT '上月销售量',
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='食品表';

-- 正在导出表  ours.food 的数据：40 rows
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` (`fid`, `foodname`, `cid`, `images`, `detail`, `heartnum`, `badnum`, `price`, `sales`, `status`, `discount`, `monthsales`) VALUES
	(1, '超级至尊比萨（芝心）', 1, 'images/yh01.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 108, 63, 1, 1, 0),
	(2, '北京潮鸭比萨（芝心）', 1, 'images/yh02.jpg', '特选鲜嫩喷香鸭肉，搭配京味酱，配以黄瓜，京葱等传统辅料，大胆融合中西方经典美味。 主要原料:面团、芝士、鸭肉、蔬菜', 0, 0, 0, 59, 1, 1, 0),
	(3, '2人黑松露比萨套餐', 1, 'images/yh03.jpg', '2人黑松露比萨套餐中包括：野生黑松露比萨普通装一份，三味小吃拼盘一份，可选饮料两份。', 0, 0, 0, 61, 1, 1, 0),
	(4, '黑松露菌菇鸡肉拼超级至尊比萨(铁盘)', 1, 'images/yh04.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 75, 59, 1, 1, 0),
	(5, '野生黑松露菌菇鸡肉比萨（铁盘)', 1, 'images/yh05.jpg', '意大利进口黑松露酱与鲜美菌菇和鸡腿肉巧妙融合，再铺上大片珍贵野生黑松露片，满口鲜香。 ', 0, 0, 108, 59, 1, 1, 0),
	(6, '野生黑松露菌菇鸡肉比萨（芝心)', 1, 'images/yh06.jpg', '意大利进口黑松露酱与鲜美菌菇和鸡腿肉巧妙融合，再铺上大片珍贵野生黑松露片，满口鲜香。 ', 0, 0, 108, 59, 1, 1, 0),
	(7, '黑松露菌菇培根意面', 1, 'images/yh07.jpg', '用美味牛肉汁精心烹调，并加入喷香培根与混合菌菇，以黑松露酱、进口芝士调味并撒上荷兰芹末，最后点缀黑松露片，浓郁入味。', 0, 0, 102, 61, 1, 1, 0),
	(8, '三味小吃拼盘', 1, 'images/yh08.jpg', '薯格（半份），鱼籽酱虾球（4只），浓情烤翅（2块）', 0, 0, 0, 59, 1, 1, 0),
	(9, '经典意式肉酱面', 4, 'images/ym01.jpg', '大颗肉粒搭配浓郁酱汁、加入意大利进口特级初榨橄榄油和细面一起炒制', 0, 0, 108, 59, 1, 1, 0),
	(10, '西班牙风情海鲜意面', 4, 'images/ym02.jpg', 'Q弹鲜美的虾仁和嚼劲十足的鱿鱼，加入纯正西班牙风味酱、进口意面、进口特级初榨橄榄油翻炒入味，鲜香浓郁，萦绕唇齿', 0, 0, 108, 59, 1, 1, 0),
	(11, '松子鸡肉罗勒意面', 4, 'images/ym04.jpg', '罗勒风味青酱汁、鸡肉、烤松仁、洋葱。 主要原料:意大利面、罗勒青酱汁、鸡肉、蔬菜、松仁', 0, 0, 108, 59, 1, 1, 0),
	(12, '黑松露菌菇培根意面', 4, 'images/yh05.jpg', '用美味牛肉汁精心烹调，并加入喷香培根与混合菌菇，以黑松露酱、进口芝士调味并撒上荷兰芹末，最后点缀黑松露片，浓郁入味。', 0, 0, 102, 59, 1, 1, 0),
	(13, '中西融合四拼比萨(芝心)', 2, 'images/piz01.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 102, 59, 1, 1, 0),
	(14, '中西融合四拼比萨(芝心)', 2, 'images/piz02.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 102, 59, 1, 1, 0),
	(15, '中西融合四拼比萨(芝心)', 2, 'images/piz03.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 102, 59, 1, 1, 0),
	(16, '中西融合四拼比萨(芝心)', 2, 'images/piz04.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 88, 59, 1, 1, 0),
	(17, '中西融合四拼比萨(芝心)', 2, 'images/piz05.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 88, 59, 1, 1, 0),
	(18, '中西融合四拼比萨(芝心)', 2, 'images/piz06.jpg', '腊肉肠、意式香肠、火腿、五香牛肉、五香猪肉、搭配菠萝、蘑菇、洋葱、青椒、黑橄榄等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。 主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄', 0, 0, 88, 59, 1, 1, 0),
	(19, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 88, 59, 1, 1, 0),
	(20, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 73, 59, 1, 1, 0),
	(21, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 108, 59, 1, 1, 0),
	(22, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 76, 59, 1, 1, 0),
	(23, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 102, 59, 1, 1, 0),
	(24, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 98, 59, 1, 1, 0),
	(25, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 58, 59, 1, 1, 0),
	(26, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 76, 59, 1, 1, 0),
	(27, '野生黑松露菌菇鸡肉比萨（芝心)', 3, 'images/piz03.jpg', '野生黑松露菌菇鸡肉拼超级至尊比萨 ：一半是野生黑松露菌菇鸡肉铁盘比萨，一半是超级至尊铁盘比萨。主要原料:面饼、芝士、蔬菜、鸡肉、黑松露味调味油、黑松露酱、黑松露片、牛肉粒、猪肉粒、火腿、腊肉肠、菠萝、黑橄榄。', 0, 0, 79, 59, 1, 1, 0),
	(28, '照烧鸡肉炒饭', 5, 'images/fs01.jpg', '精选鸡腿肉丁、东北大米与培根、鸡蛋用照烧酱汁快速翻炒。 主要原料:米饭、鸡腿肉、鸡蛋、培根、洋葱', 0, 0, 20, 80, 1, 1, 0),
	(29, '匈牙利风情牛肉焗饭', 5, 'images/fs02.jpg', '精选香嫩牛肉经匈牙利风味腌料腌制并闷煮入味，肉质酥软，再将经典匈牙利风味酱汁淋于米饭，辅以莫扎里拉芝士焗烤后，牛肉鲜香肉嫩，酱汁醇厚，浓郁匈牙利风情美味，口口难忘。 主要原料:米饭、酱汁、土豆、牛肉、芝士', 0, 0, 18, 43, 1, 1, 0),
	(30, '香草凤尾虾', 6, 'images/xc01.jpg', '鲜美弹滑的凤尾大虾，裹以异域风情的香草调料，金黄酥脆，奇香四溢。', 0, 0, 12, 90, 1, 1, 0),
	(31, '浓情烤翅', 6, 'images/xc02.jpg', '精选全翅经美味香料腌制烘烤而成，入口鲜嫩多汁，回味无穷', 0, 0, 14, 64, 1, 1, 0),
	(32, '意式香浓菜汤', 7, 'images/t02.jpg', '精选培根，与番茄、西兰花、西芹和红腰豆等鲜蔬佐以黄油煨制，用料丰富，营养健康。 主要原料: 培根、番茄、西兰花、西芹、红腰豆、黄油、水', 0, 0, 23, 88, 1, 1, 0),
	(33, '鸡茸蘑菇汤', 7, 'images/t01.jpg', '精选上等新鲜鸡茸与鲜蘑菇煨制，滴滴入味!(200ml)', 0, 0, 18, 87, 1, 1, 0),
	(34, '热柠檬红茶', 8, 'images/yl01.jpg', '主要原料: 红茶、柠檬、水', 0, 0, 12, 77, 1, 1, 0),
	(35, '尊赏丝滑奶茶', 8, 'images/yl02.jpg', '选用优质淡奶及炼乳，更香浓更柔滑*。*与原有同款产品相比', 0, 0, 16, 79, 1, 1, 0),
	(36, '香浓玉米汁（热）', 8, 'images/yl03.jpg', '甜玉米融入香醇乳饮，甜甜在口，暖暖入心', 0, 0, 17, 24, 1, 1, 0),
	(37, '送鸡蘑菇汤', 9, 'img_spider/banner1.jpg', '甜玉米融入香醇乳饮，甜甜在口，暖暖入心', 0, 0, 50, 24, 1, 1, 0),
	(38, '黑松露', 9, 'img_spider/banner2.jpg', '甜玉米融入香醇乳饮，甜甜在口，暖暖入心', 0, 0, 100, 24, 1, 1, 0),
	(39, '39元小食盒', 9, 'img_spider/banner3.jpg', '甜玉米融入香醇乳饮，甜甜在口，暖暖入心', 0, 0, 39, 24, 1, 1, 0),
	(40, '半价123', 9, 'img_spider/banner4.jpg', '甜玉米融入香醇乳饮，甜甜在口，暖暖入心', 0, 0, 20, 24, 1, 1, 0);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;

-- 导出  表 ours.membergrade 结构
CREATE TABLE IF NOT EXISTS `membergrade` (
  `mgid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mgname` char(11) NOT NULL COMMENT '等级名称',
  `mgprice` int(11) NOT NULL DEFAULT '0' COMMENT '会员消费标准',
  `mgdiscount` float NOT NULL DEFAULT '1' COMMENT '会员优惠折扣',
  PRIMARY KEY (`mgid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员等级表';

-- 正在导出表  ours.membergrade 的数据：6 rows
/*!40000 ALTER TABLE `membergrade` DISABLE KEYS */;
INSERT INTO `membergrade` (`mgid`, `mgname`, `mgprice`, `mgdiscount`) VALUES
	(1, '普通用户', 0, 10),
	(2, '白银会员', 300, 9.9),
	(3, '黄金会员', 600, 8.5),
	(4, '白金会员', 1000, 7),
	(5, '钻石会员', 3000, 6),
	(6, '终身免费会员', 10000, 0);
/*!40000 ALTER TABLE `membergrade` ENABLE KEYS */;

-- 导出  表 ours.orders 结构
CREATE TABLE IF NOT EXISTS `orders` (
  `oid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '订单状态',
  `price` int(11) NOT NULL COMMENT '支付金额',
  `addtime` char(50) NOT NULL COMMENT '订单添加时间',
  `content` text NOT NULL COMMENT '订单内容',
  PRIMARY KEY (`oid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- 正在导出表  ours.orders 的数据：3 rows
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`oid`, `uid`, `status`, `price`, `addtime`, `content`) VALUES
	(1, 1, 1, 210, '2018-4-3 21:29', '超级至尊比萨（芝心）*12人黑松露比萨套餐*1黑松露菌菇培根意面*1'),
	(2, 1, 1, 210, '2018-4-3 21:29', '超级至尊比萨（芝心）*12人黑松露比萨套餐*1黑松露菌菇培根意面*1'),
	(3, 2, 1, 216, '2018-04-04 0:11:39', '超级至尊比萨（芝心）*2');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- 导出  表 ours.users 结构
CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` char(50) NOT NULL COMMENT '用户名',
  `passwd` char(32) NOT NULL COMMENT '密码',
  `tel` char(11) NOT NULL COMMENT '手机号',
  `address` char(50) NOT NULL COMMENT '用户地址',
  `photo` text COMMENT '头像地址',
  `regtime` char(50) NOT NULL COMMENT '注册时间',
  `sex` int(11) DEFAULT '3' COMMENT '1代表男，2代表女，3代表保密',
  `consume` int(11) NOT NULL DEFAULT '0' COMMENT '已经消费',
  `mgid` int(11) NOT NULL DEFAULT '1' COMMENT '1代表普通，2代表白银会员，3代表黄金会员，4代表铂金会员，5代表钻石会员',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='用户列表';

-- 正在导出表  ours.users 的数据：42 rows
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`uid`, `username`, `passwd`, `tel`, `address`, `photo`, `regtime`, `sex`, `consume`, `mgid`) VALUES
	(3, '阴霾天空', 'e10adc3949ba59abbe56e057f20f883e', '18328810856', '成都市', NULL, '2018-04-03 23:24:29', 3, 0, 1),
	(2, '隐约雷鸣', 'e10adc3949ba59abbe56e057f20f883e', '18328810855', '四川省成都市锦江区', NULL, '2018-04-03 23:29:11', 3, 0, 1),
	(4, '即使天无雨', '202cb962ac59075b964b07152d234b70', '18328810857', '成都市', NULL, '2018-04-03 23:29:22', 1, 8, 2),
	(5, '我亦留此地', '202cb962ac59075b964b07152d234b70', '18328810859', '成都市', NULL, '2018-04-03 23:29:23', NULL, 0, 2),
	(6, '但盼风雨来', '202cb962ac59075b964b07152d234b70', '18328810861', '', NULL, '2018-04-03 23:43:27', NULL, 7, 1),
	(7, '能留你在此', '202cb962ac59075b964b07152d234b70', '18328810862', '成都市', NULL, '2018-04-03 23:45:1', 2, 0, 1),
	(8, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 2, 2),
	(9, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 78, 3),
	(10, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 525, 2),
	(11, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 141, 3),
	(12, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 3),
	(13, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 456, 2),
	(14, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 1000, 1),
	(15, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 7788, 4),
	(16, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 5),
	(17, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 252, 1),
	(18, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 14, 1),
	(19, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 25, 1),
	(20, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(21, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 989, 2),
	(22, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(23, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 500000, 2),
	(24, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(25, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 2525, 5),
	(26, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(27, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(28, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 141, 3),
	(29, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(30, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 25, 3),
	(31, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 2),
	(32, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 525, 1),
	(33, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(34, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 25, 2),
	(35, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(36, '小花别样红', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(37, '绕弯儿', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(38, '水电费', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 2),
	(39, '水电费', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(40, 'w三大师傅', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(41, '水电费费', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(42, '的方式', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1),
	(43, '小花', '202cb962ac59075b964b07152d234b70', '18328810911', '成都市', NULL, '2018-04-03 23:29:22', NULL, 0, 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
