/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50515
Source Host           : localhost:3306
Source Database       : bookrecommendonline

Target Server Type    : MYSQL
Target Server Version : 50515
File Encoding         : 65001

Date: 2022-08-31 10:49:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for db_admin
-- ----------------------------
DROP TABLE IF EXISTS `db_admin`;
CREATE TABLE `db_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) DEFAULT NULL COMMENT '管理员登录名',
  `password` varchar(255) DEFAULT NULL COMMENT '管理员登录密码',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `issuper` int(11) DEFAULT NULL COMMENT '是否是超级管理员（0：不是，1：是）',
  `lastlogintime` varchar(255) DEFAULT NULL COMMENT '最后一次登录时间',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Table structure for db_book
-- ----------------------------
DROP TABLE IF EXISTS `db_book`;
CREATE TABLE `db_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bookname` varchar(255) DEFAULT NULL COMMENT '图书名称',
  `booktypeid` int(11) DEFAULT NULL COMMENT '图书类型外键',
  `image` varchar(255) DEFAULT NULL COMMENT '图书封面',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `press` varchar(255) DEFAULT NULL COMMENT '出版社',
  `price` varchar(255) DEFAULT NULL COMMENT '价格',
  `isbn` varchar(255) DEFAULT NULL COMMENT 'isbn',
  `content` text COMMENT '图书简介',
  `doubanid` varchar(255) DEFAULT NULL COMMENT '豆瓣网站图书id',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `1` (`booktypeid`),
  CONSTRAINT `db_book_ibfk_1` FOREIGN KEY (`booktypeid`) REFERENCES `db_booktype` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8 COMMENT='图书表';

-- ----------------------------
-- Table structure for db_bookcollect
-- ----------------------------
DROP TABLE IF EXISTS `db_bookcollect`;
CREATE TABLE `db_bookcollect` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `bookid` int(11) DEFAULT NULL COMMENT '图书id',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `60` (`userid`),
  KEY `70` (`bookid`),
  CONSTRAINT `60` FOREIGN KEY (`userid`) REFERENCES `db_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `70` FOREIGN KEY (`bookid`) REFERENCES `db_book` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8 COMMENT='图书收藏表';

-- ----------------------------
-- Table structure for db_bookcomment
-- ----------------------------
DROP TABLE IF EXISTS `db_bookcomment`;
CREATE TABLE `db_bookcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `bookid` int(11) DEFAULT NULL COMMENT '图书id',
  `content` text COMMENT '评论内容',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `333` (`userid`),
  KEY `444` (`bookid`),
  CONSTRAINT `333` FOREIGN KEY (`userid`) REFERENCES `db_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `444` FOREIGN KEY (`bookid`) REFERENCES `db_book` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图书评论表';

-- ----------------------------
-- Table structure for db_booklook
-- ----------------------------
DROP TABLE IF EXISTS `db_booklook`;
CREATE TABLE `db_booklook` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `bookid` int(11) DEFAULT NULL COMMENT '图书id',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `606` (`userid`),
  KEY `706` (`bookid`),
  CONSTRAINT `606` FOREIGN KEY (`userid`) REFERENCES `db_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `706` FOREIGN KEY (`bookid`) REFERENCES `db_book` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3001 DEFAULT CHARSET=utf8 COMMENT='图书浏览表';

-- ----------------------------
-- Table structure for db_bookscore
-- ----------------------------
DROP TABLE IF EXISTS `db_bookscore`;
CREATE TABLE `db_bookscore` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(11) DEFAULT NULL COMMENT '用户外键',
  `bookid` int(11) DEFAULT NULL COMMENT '图书外键',
  `score` int(11) DEFAULT NULL COMMENT '图书评分',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `6` (`userid`),
  KEY `7` (`bookid`),
  CONSTRAINT `6` FOREIGN KEY (`userid`) REFERENCES `db_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `7` FOREIGN KEY (`bookid`) REFERENCES `db_book` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8 COMMENT='图书评分表';

-- ----------------------------
-- Table structure for db_booktype
-- ----------------------------
DROP TABLE IF EXISTS `db_booktype`;
CREATE TABLE `db_booktype` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `typename` varchar(255) DEFAULT NULL COMMENT '图书类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='图书类型表';

-- ----------------------------
-- Table structure for db_user
-- ----------------------------
DROP TABLE IF EXISTS `db_user`;
CREATE TABLE `db_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) DEFAULT NULL COMMENT '用户登录名',
  `password` varchar(255) DEFAULT NULL COMMENT '用户登录密码',
  `header` varchar(255) DEFAULT NULL COMMENT '头像',
  `gender` int(11) DEFAULT NULL COMMENT '用户性别（1：男，2：女）',
  `age` int(11) DEFAULT NULL COMMENT '用户年龄',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `lastlogintime` varchar(255) DEFAULT NULL COMMENT '最后一次登录时间',
  `state` int(11) DEFAULT NULL COMMENT '用户状态（1：正常，2：锁定）',
  `createtime` varchar(255) DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Table structure for db_userlabel
-- ----------------------------
DROP TABLE IF EXISTS `db_userlabel`;
CREATE TABLE `db_userlabel` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(11) DEFAULT NULL COMMENT '用户主键',
  `booktypeid` int(11) DEFAULT NULL COMMENT '图书类型主键',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `booktypeid` (`booktypeid`),
  CONSTRAINT `_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `db_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `_ibfk_2` FOREIGN KEY (`booktypeid`) REFERENCES `db_booktype` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='用户喜好标签表';
