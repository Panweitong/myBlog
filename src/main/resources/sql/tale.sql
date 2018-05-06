/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : tale

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-05-06 18:41:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_attach
-- ----------------------------
DROP TABLE IF EXISTS `t_attach`;
CREATE TABLE `t_attach` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL DEFAULT '',
  `ftype` varchar(50) DEFAULT '',
  `fkey` varchar(100) NOT NULL DEFAULT '',
  `author_id` int(10) DEFAULT NULL,
  `created` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_attach
-- ----------------------------
INSERT INTO `t_attach` VALUES ('40', 'readme.html', 'file', '/phbhceqmq6i2vrppcap70pa4ab.html', '1', '1524553148');
INSERT INTO `t_attach` VALUES ('41', '实验一.zip', 'file', '/p0826iio7iiompgippq6e3a0nr.zip', '1', '1524555550');

-- ----------------------------
-- Table structure for t_comments
-- ----------------------------
DROP TABLE IF EXISTS `t_comments`;
CREATE TABLE `t_comments` (
  `coid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned DEFAULT '0',
  `created` int(10) unsigned DEFAULT '0',
  `author` varchar(200) DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT '0',
  `owner_id` int(10) unsigned DEFAULT '0',
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `agent` varchar(200) DEFAULT NULL,
  `content` text,
  `type` varchar(16) DEFAULT 'comment',
  `status` varchar(16) DEFAULT 'approved',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`coid`),
  KEY `cid` (`cid`),
  KEY `created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comments
-- ----------------------------
INSERT INTO `t_comments` VALUES ('1', '6', '1497672195', 'tzs', '0', '1', '101011@gmail.com', 'http://juejin.im', '0:0:0:0:0:0:0:1', null, '棒棒哒，厉害了', 'comment', 'approved', '0');
INSERT INTO `t_comments` VALUES ('2', '6', '1497672339', 'tzs', '0', '1', '101011@gmail.com', 'http://juejin.im', '0:0:0:0:0:0:0:1', null, '再次评论，看看效果', 'comment', 'approved', '0');
INSERT INTO `t_comments` VALUES ('3', '5', '1497676424', 'tzs', '0', '1', '101011@gmail.com', 'http://juejin.im', '0:0:0:0:0:0:0:1', null, 'vswfwfwfw', 'comment', 'approved', '0');
INSERT INTO `t_comments` VALUES ('4', '7', '1521013154', '热心网友', '0', '1', '', '', '0:0:0:0:0:0:0:1', null, '666666666               ', 'comment', 'approved', '0');
INSERT INTO `t_comments` VALUES ('5', '7', '1521013224', '随缘', '0', '1', '1091260466@qq.com', '', '0:0:0:0:0:0:0:1', null, '非常非常好', 'comment', 'approved', '0');
INSERT INTO `t_comments` VALUES ('6', '7', '1521013284', '随缘', '0', '1', '1091260466@qq.com', '', '0:0:0:0:0:0:0:1', null, '666666', 'comment', 'approved', '0');
INSERT INTO `t_comments` VALUES ('7', '7', '1521013354', '随缘', '0', '1', '1091260466@qq.com', '', '0:0:0:0:0:0:0:1', null, '888888888888888', 'comment', 'approved', '0');

-- ----------------------------
-- Table structure for t_contents
-- ----------------------------
DROP TABLE IF EXISTS `t_contents`;
CREATE TABLE `t_contents` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `modified` int(10) unsigned DEFAULT '0',
  `description` text,
  `content` text COMMENT '内容文字',
  `author_id` int(10) unsigned DEFAULT '0',
  `type` varchar(16) DEFAULT 'post',
  `status` varchar(16) DEFAULT 'publish',
  `tags` varchar(200) DEFAULT NULL,
  `categories` varchar(200) DEFAULT NULL,
  `hits` int(10) unsigned DEFAULT '0',
  `comments_num` int(10) unsigned DEFAULT '0',
  `allow_comment` tinyint(1) DEFAULT '1',
  `allow_ping` tinyint(1) DEFAULT '1',
  `allow_feed` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `slug` (`slug`),
  KEY `created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_contents
-- ----------------------------
INSERT INTO `t_contents` VALUES ('1', '关于博客', 'about', '1487853610', '1525603242', null, '## myBlog\r\n\r\n[myBlog](https://github.com/Panweitong/myBlog)  fork from [My Blog](https://github.com/ZHENFENG13/My-Blog) , 该作者是在 [Tale](https://github.com/otale/tale) 博客系统基础上进行修改的。\r\n\r\n`Tale` 使用了轻量级 mvc 框架 `Blade` 开发，默认主题使用了漂亮的 `pinghsu` 。\r\n\r\n`My-Blog` 使用的是 Docker + SpringBoot + Mybatis + thymeleaf 打造的一个个人博客模板。\r\n\r\n***\r\n\r\n[myBlog](https://github.com/Panweitong/myBlog)  在  [My Blog](https://github.com/ZHENFENG13/My-Blog)  的基础上去除了 Docker，采用的是 Spring+SpringMvc + Mybatis + thymeleaf  + MySQL 搭建的一个博客，其中在原来作者的基础上优化了。\r\n\r\n## 开源协议\r\n\r\n[MIT](./LICENSE)\r\n\r\n## 感谢\r\n\r\n[ZHENFENG13](https://github.com/ZHENFENG13)\r\n\r\n[otale](https://github.com/otale)\r\n', '1', 'page', 'publish', null, null, '292', '0', '1', '1', '1');
INSERT INTO `t_contents` VALUES ('5', 'Pyspider框架 —— Python爬虫实战之爬取 V2EX 网站帖子', 'Pyspider-v2ex', '1497323771', '1524123823', 'PySpider：一个国人编写的强大的网络爬虫系统并带有强大的WebUI。采用Python语言编写，分布式架构，支持多种数据库后端，强大的WebUI支持脚本编辑器，任务监视器，项目管理器以及结果查看器。在线示例： http://demo.pyspider.org/\r\n\r\n官方文档： http://docs.pyspider.org/en/latest/\r\n\r\nGithub : https://github.com/binux/pyspider\r\n\r\n本文爬虫代码 Github 地址：https://github.com/zhisheng17/Python-Projects/blob/master/v2ex/V2EX.py', '**背景：**\r\n\r\n**PySpider**：一个国人编写的强大的网络爬虫系统并带有强大的WebUI。采用Python语言编写，分布式架构，支持多种数据库后端，强大的WebUI支持脚本编辑器，任务监视器，项目管理器以及结果查看器。在线示例： **http://demo.pyspider.org/**\r\n\r\n**官方文档： http://docs.pyspider.org/en/latest/** \r\n\r\n**Github :  https://github.com/binux/pyspider** \r\n\r\n本文爬虫代码 Github 地址：**https://github.com/zhisheng17/Python-Projects/blob/master/v2ex/V2EX.py**\r\n\r\n<!-- more -->\r\n\r\n***\r\n\r\n说了这么多，我们还是来看正文吧！\r\n\r\n**前提:** 你已经安装好了Pyspider 和 MySQL-python（保存数据）\r\n\r\n如果你还没安装的话，请看看我的前一篇文章，防止你也走弯路。\r\n\r\n1. [**Pyspider 框架学习时走过的一些坑**](http://blog.csdn.net/tzs_1041218129/article/details/52877949)\r\n\r\n2. [**HTTP 599: SSL certificate problem: unable to get local issuer certificate错误**](http://blog.csdn.net/tzs_1041218129/article/details/52853465)\r\n\r\n我所遇到的一些错误：\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022201123063)\r\n\r\n\r\n首先，**本爬虫目标**：使用 Pyspider 框架爬取 [V2EX](www.v2ex.com) 网站的帖子中的问题和内容，然后将爬取的数据保存在本地。\r\n\r\nV2EX 中大部分的帖子查看是不需要登录的，当然也有些帖子是需要登陆后才能够查看的。（因为后来爬取的时候发现一直 error ，查看具体原因后才知道是需要登录的才可以查看那些帖子的）所以我觉得没必要用到 Cookie，当然如果你非得要登录，那也很简单，简单地方法就是添加你登录后的 cookie 了。\r\n\r\n我们在 https://www.v2ex.com/ 扫了一遍，发现并没有一个列表能包含所有的帖子，只能退而求其次，通过抓取分类下的所有的标签列表页，来遍历所有的帖子： https://www.v2ex.com/?tab=tech 然后是 https://www.v2ex.com/go/programmer  最后每个帖子的详情地址是 （举例）： https://www.v2ex.com/t/314683#reply1\r\n\r\n\r\n\r\n**创建一个项目**\r\n\r\n在 pyspider 的 dashboard 的右下角，点击 “Create” 按钮\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022193415047)\r\n\r\n替换 on_start 函数的 self.crawl 的 URL：\r\n\r\n```\r\n@every(minutes=24 * 60)\r\n    def on_start(self):\r\n        self.crawl(\'https://www.v2ex.com/\', callback=self.index_page, validate_cert=False)\r\n```\r\n\r\n> + self.crawl 告诉 pyspider 抓取指定页面，然后使用 callback 函数对结果进行解析。\r\n> + @every) 修饰器，表示 on_start 每天会执行一次，这样就能抓到最新的帖子了。\r\n> + validate_cert=False 一定要这样，否则会报 HTTP 599: SSL certificate problem: unable to get local issuer certificate错误\r\n\r\n**首页：**\r\n\r\n点击绿色的 run 执行，你会看到 follows 上面有一个红色的 1，切换到 follows 面板，点击绿色的播放按钮：\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022194343052)\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022194412365)\r\n\r\n第二张截图一开始是出现这个问题了，解决办法看前面写的文章，后来问题就不再会出现了。\r\n\r\n<br>\r\n**Tab 列表页 : **\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022194637692)\r\n\r\n在 tab 列表页 中，我们需要提取出所有的主题列表页 的 URL。你可能已经发现了，sample handler 已经提取了非常多大的 URL\r\n\r\n代码：\r\n```\r\n@config(age=10 * 24 * 60 * 60)\r\n    def index_page(self, response):\r\n        for each in response.doc(\'a[href^=\"https://www.v2ex.com/?tab=\"]\').items():\r\n            self.crawl(each.attr.href, callback=self.tab_page, validate_cert=False)\r\n```\r\n\r\n> + 由于帖子列表页和 tab列表页长的并不一样，在这里新建了一个 callback 为 self.tab_page\r\n> + @config(age=10 * 24 * 60 * 60) 在这表示我们认为 10 天内页面有效，不会再次进行更新抓取\r\n\r\n\r\n**Go列表页 : **\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022195235290)\r\n\r\n代码：\r\n\r\n```\r\n@config(age=10 * 24 * 60 * 60)\r\n    def tab_page(self, response):\r\n        for each in response.doc(\'a[href^=\"https://www.v2ex.com/go/\"]\').items():\r\n            self.crawl(each.attr.href, callback=self.board_page, validate_cert=False)\r\n```\r\n\r\n**帖子详情页（T）:**\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022200023793)\r\n\r\n你可以看到结果里面出现了一些reply的东西，对于这些我们是可以不需要的，我们可以去掉。\r\n\r\n同时我们还需要让他自己实现自动翻页功能。\r\n\r\n代码：\r\n```\r\n@config(age=10 * 24 * 60 * 60)\r\n    def board_page(self, response):\r\n        for each in response.doc(\'a[href^=\"https://www.v2ex.com/t/\"]\').items():\r\n            url = each.attr.href\r\n            if url.find(\'#reply\')>0:\r\n                url = url[0:url.find(\'#\')]\r\n            self.crawl(url, callback=self.detail_page, validate_cert=False)\r\n        for each in response.doc(\'a.page_normal\').items():\r\n            self.crawl(each.attr.href, callback=self.board_page, validate_cert=False) #实现自动翻页功能\r\n```\r\n\r\n去掉后的运行截图：\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022200324719)\r\n\r\n实现自动翻页后的截图：\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022201355970)\r\n\r\n此时我们已经可以匹配了所有的帖子的 url 了。\r\n\r\n点击每个帖子后面的按钮就可以查看帖子具体详情了。\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022200539973)\r\n\r\n代码：\r\n\r\n```\r\n@config(priority=2)\r\n    def detail_page(self, response):\r\n        title = response.doc(\'h1\').text()\r\n        content = response.doc(\'div.topic_content\').html().replace(\'\"\', \'\\\\\"\')\r\n        self.add_question(title, content)  #插入数据库\r\n        return {\r\n            \"url\": response.url,\r\n            \"title\": title,\r\n            \"content\": content,\r\n        }\r\n```\r\n\r\n插入数据库的话，需要我们在之前定义一个add_question函数。\r\n\r\n```\r\n#连接数据库\r\ndef __init__(self):\r\n        self.db = MySQLdb.connect(\'localhost\', \'root\', \'root\', \'wenda\', charset=\'utf8\')\r\n\r\n    def add_question(self, title, content):\r\n        try:\r\n            cursor = self.db.cursor()\r\n            sql = \'insert into question(title, content, user_id, created_date, comment_count) values (\"%s\",\"%s\",%d, %s, 0)\' % (title, content, random.randint(1, 10) , \'now()\');   #插入数据库的SQL语句\r\n            print sql\r\n            cursor.execute(sql)\r\n            print cursor.lastrowid\r\n            self.db.commit()\r\n        except Exception, e:\r\n            print e\r\n            self.db.rollback()\r\n```\r\n\r\n查看爬虫运行结果：\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022201700801)\r\n\r\n> 1. 先debug下，再调成running。pyspider框架在windows下的bug\r\n> 2. 设置跑的速度，建议不要跑的太快，否则很容易被发现是爬虫的，人家就会把你的IP给封掉的\r\n> 3. 查看运行工作\r\n> 4. 查看爬取下来的内容\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022202033227)\r\n\r\n![这里写图片描述](http://img.blog.csdn.net/20161022202048258)\r\n\r\n然后再本地数据库GUI软件上查询下就可以看到数据已经保存到本地了。\r\n\r\n自己需要用的话就可以导入出来了。\r\n\r\n在开头我就告诉大家爬虫的代码了，如果详细的看看那个project，你就会找到我上传的爬取数据了。（仅供学习使用，切勿商用！）\r\n\r\n当然你还会看到其他的爬虫代码的了，如果你觉得不错可以给个 Star，或者你也感兴趣的话，你可以fork我的项目，和我一起学习，这个项目长期更新下去。\r\n\r\n**最后：**\r\n\r\n代码：\r\n\r\n```\r\n# created by 10412\r\n# !/usr/bin/env python\r\n# -*- encoding: utf-8 -*-\r\n# Created on 2016-10-20 20:43:00\r\n# Project: V2EX\r\n\r\nfrom pyspider.libs.base_handler import *\r\n\r\nimport re\r\nimport random\r\nimport MySQLdb\r\n\r\nclass Handler(BaseHandler):\r\n    crawl_config = {\r\n    }\r\n\r\n    def __init__(self):\r\n        self.db = MySQLdb.connect(\'localhost\', \'root\', \'root\', \'wenda\', charset=\'utf8\')\r\n\r\n    def add_question(self, title, content):\r\n        try:\r\n            cursor = self.db.cursor()\r\n            sql = \'insert into question(title, content, user_id, created_date, comment_count) values (\"%s\",\"%s\",%d, %s, 0)\' % (title, content, random.randint(1, 10) , \'now()\');\r\n            print sql\r\n            cursor.execute(sql)\r\n            print cursor.lastrowid\r\n            self.db.commit()\r\n        except Exception, e:\r\n            print e\r\n            self.db.rollback()\r\n\r\n\r\n    @every(minutes=24 * 60)\r\n    def on_start(self):\r\n        self.crawl(\'https://www.v2ex.com/\', callback=self.index_page, validate_cert=False)\r\n\r\n    @config(age=10 * 24 * 60 * 60)\r\n    def index_page(self, response):\r\n        for each in response.doc(\'a[href^=\"https://www.v2ex.com/?tab=\"]\').items():\r\n            self.crawl(each.attr.href, callback=self.tab_page, validate_cert=False)\r\n\r\n\r\n    @config(age=10 * 24 * 60 * 60)\r\n    def tab_page(self, response):\r\n        for each in response.doc(\'a[href^=\"https://www.v2ex.com/go/\"]\').items():\r\n            self.crawl(each.attr.href, callback=self.board_page, validate_cert=False)\r\n\r\n\r\n    @config(age=10 * 24 * 60 * 60)\r\n    def board_page(self, response):\r\n        for each in response.doc(\'a[href^=\"https://www.v2ex.com/t/\"]\').items():\r\n            url = each.attr.href\r\n            if url.find(\'#reply\')>0:\r\n                url = url[0:url.find(\'#\')]\r\n            self.crawl(url, callback=self.detail_page, validate_cert=False)\r\n        for each in response.doc(\'a.page_normal\').items():\r\n            self.crawl(each.attr.href, callback=self.board_page, validate_cert=False)\r\n\r\n\r\n    @config(priority=2)\r\n    def detail_page(self, response):\r\n        title = response.doc(\'h1\').text()\r\n        content = response.doc(\'div.topic_content\').html().replace(\'\"\', \'\\\\\"\')\r\n        self.add_question(title, content)  #插入数据库\r\n        return {\r\n            \"url\": response.url,\r\n            \"title\": title,\r\n            \"content\": content,\r\n        }\r\n\r\n\r\n\r\n```', '1', 'post', 'publish', 'Pyspider,Python,爬虫', 'Python', '65', '1', '1', '1', '1');
INSERT INTO `t_contents` VALUES ('7', 'DACE分布式爬虫管理系统使用介绍', 'python', '1520600942', '1524109180', 'DACE分布式爬虫系统(以下简称DACE系统)旨在通过分布式搭建一个快速、高效、稳定的爬虫系统，能够对京东实现全站商品数据采集，同时采集商品评价并且生成评价数据分析报告；各类新闻博客网站的正文提取，能通过谷歌新闻搜索关键字进行批量采集新闻；快速采集猎聘网并进行数据分析生成行业报告。 快速部署新爬虫是本软件的一个特点，无需修改主程序源代码即可实现新的爬虫规则，真正的可插拔式爬虫。能够随时开启和停止爬虫，一键导出爬虫数据，对爬虫状态进行实时监控。后台服务器运行情况通过动态表格实时显示，能对Redis实施一键清除缓存，方便快速部署新爬虫。', '项目地址:  [https://github.com/Panweitong/Distributed-Crawler-v2.0][1]\r\n\r\n1.引言\r\n\r\n1.1编写目的\r\n\r\n编写本使用说明的目的是充分叙述DACE分布式爬虫系统所能实现的功能及其运行环境，以便使用者了解本软件的使用范围和使用方法，并为软件的维护和更新提供必要的信息。\r\n\r\n\r\n\r\n2.概述\r\n\r\n2.1 系统简介\r\n\r\nDACE分布式爬虫系统(以下简称DACE系统)旨在通过分布式搭建一个快速、高效、稳定的爬虫系统，能够对京东实现全站商品数据采集，同时采集商品评价并且生成评价数据分析报告；各类新闻博客网站的正文提取，能通过谷歌新闻搜索关键字进行批量采集新闻；快速采集猎聘网并进行数据分析生成行业报告。\r\n快速部署新爬虫是本软件的一个特点，无需修改主程序源代码即可实现新的爬虫规则，真正的可插拔式爬虫。能够随时开启和停止爬虫，一键导出爬虫数据，对爬虫状态进行实时监控。后台服务器运行情况通过动态表格实时显示，能对Redis实施一键清除缓存，方便快速部署新爬虫。\r\n\r\n\r\n\r\n 2.2系统运行说明\r\n\r\n系统所涉及到的所有爬虫源代码均已部署至云服务器中，通过该链接即可快速访问: http:// 123.207.12.105:5000\r\n目前已经在谷歌浏览器、火狐浏览器、360浏览器、Safari上通过测试，*建议使用以上其中一种浏览器进行访问，以便达到最佳使用效果。\r\n\r\n 2.3版权说明\r\n\r\n“雁过无声”团队拥有本作品内的所有资料（包括但不限于文字、图片、音频、视频资料、源代码及页面设计、编排、软件等）的版权和其他相关知识产权。未经“雁过无声”事先书面许可，对于本作品上的任何内容，任何单位和个人不得以任何方式复制、转载、链接、转贴、引用、刊登、发表或在非“雁过无声”所属服务器上做镜像或以其他任何方式进行使用。\r\n\r\n\r\n\r\n3.软件功能介绍和使用说明\r\n\r\n3.1 入门\r\n\r\n通过http:// 123.207.12.105:5000 快速访问爬虫主页。主页包括爬虫的一些介绍和功能特点，以及相关的数据信息和作者信息。点击“立即体验”跳转到分布式爬虫管理界面，快速上手。\r\n\r\n![请输入图片描述][2]\r\n\r\nDACE系统导航栏包括以下五大板块功能【任务】【项目】【爬虫】【数据分析】，【监控】。第一板块功能是系统管理，用于对系统全局爬虫的管理，随时停止爬虫以及设置定时任务。第二板块是对爬虫的部署和启动，包括京东、新闻博客、猎聘网爬虫的部署。第三板块为四个爬虫的使用入口。第四板块为数据分析，包括正文的摘要和关键字提取，生成招聘网的职位或者行业报告。第五板块是对服务器的运行状态进行监控，以及可以查看爬虫的运行状态。\r\n\r\n4.任务模块\r\n\r\n4.1控制台\r\n\r\n控制台是对系统全局爬虫运行情况的监控，能够显示队列中等待运行的任务、正在运行的任务和已完成的任务。相关术语说明如下：\r\n\r\n\r\n\r\n术语	说明\r\n\r\n任务编号	爬虫的序号\r\n\r\n参数	启爬虫时传入的参数(如有需要时)\r\n\r\n优先级	不同爬虫的优先程度不同\r\n\r\n运行时间	目前爬虫已运行的时长\r\n\r\n开始时间	记录启动爬虫的时间\r\n\r\n日志	从后台传回的爬虫运行情况数据\r\n\r\n动作	从后台传回的爬虫运行情况数据\r\n\r\n清空队列	清空Redis数据库中的缓存数据\r\n\r\n\r\n4.2 定期任务\r\n\r\n能够预先设定任务，后台会在指定时间开启爬虫自动采集，点击“增加任务”开始配置新的定期任务。相关术语说明如下：\r\n\r\n术语	说明\r\n\r\nDay of Month	设定爬虫的启动时间\r\n\r\n小时	爬虫运行时长\r\n\r\n爬虫	指定某个爬虫\r\n\r\n优先级	如有多个定期任务可以设置优先级\r\n![请输入图片描述][3]\r\n\r\n5.项目模块\r\n\r\nDACE系统是以项目为单位对爬虫进行管理，如创建A，B两个项目，A项目中可以创建京东，新闻等若干个爬虫；B项目中可以创建不同使用场景的京东，猎聘网等若干个爬虫，两者互不干扰，实现可插拔式管理爬虫。\r\n![请输入图片描述][4]\r\n\r\n\r\n5.1部署\r\n\r\n已经完成项目创建可以进行部署爬虫，通过EGG文件将爬虫的相关配置上传至服务器。即可完成对爬虫的部署。EGG文件是使用scrapyd-client生成的文件，它包括和爬虫配置相关的源代码，即使是不同规则的爬虫，也能快速进行部署和采集。\r\n\r\n点击“选择文件”，选择已经通过命令打包好的EGG配置文件，点击“提交”完成部署。\r\n![请输入图片描述][5]\r\n \r\n\r\n\r\n\r\n5.2管理\r\n\r\n该面板下会显示当前正在运行的项目，可以对该项目进行删除操作，如果需要切换到其他项目，请点击上方导航栏的“项目”按钮，选择其他项目，也可以创建新的项目。点击创建项目，在弹出窗口中输入项目名称，点击“创建”，即可生成新的项目。\r\n ![请输入图片描述][6]\r\n\r\n \r\n\r\n6.爬虫模块\r\n\r\n该类别下有四个不同类型的爬虫，使用方法如下：\r\n\r\n6.1谷歌新闻搜索\r\n\r\n此功能是通过谷歌的新闻搜索功能，实现对关键字的新闻搜索，并使用DACE系统自主研发的正文提取算法，对新闻网页的正文内容进行提取。\r\n\r\n使用方法：输入“关键字”，设置优先级（可选），点击“开启采集”，后台接收到信号即开始搜索新闻并进行采集。每次搜索会返回所有搜索引擎所有结果。\r\n\r\n相关字段说明：\r\n\r\n术语	说明\r\n\r\n标题	新闻标题\r\n\r\n来源	新闻来源的网站\r\n\r\nURL	新闻链接\r\n\r\n正文	显示提取的出的新闻正文\r\n\r\n操作	弹出窗口显示完整标题和正文信息\r\n\r\n导出数据	一键将数据导出成excel格式\r\n![请输入图片描述][7]\r\n\r\n6.2 新闻博客爬虫\r\n\r\n新闻博客类爬虫拥有一套自主研发的成熟稳定的正文提取算法，目前已经通过测试的网页近百个，能够适应主流的新闻博客网站。使用该爬虫需要放入一个入口URL链接，爬虫以该URL作为起始域名限制，同时需要放入模版URL，爬虫只会提取符合模版URL的页面的正文信息，模版URL的数量没有限制。\r\n\r\n相关字段说明：\r\n\r\n标题：网站标题\r\n\r\n来源：新闻/博客来源的网站\r\n\r\n内容：使用提取算法提取的结果\r\n\r\nURL：新闻/博客的链接\r\n\r\n术语	说明\r\n\r\n标题	文章标题\r\n\r\n来源	新闻/博客来源的网站\r\n\r\n内容	使用提取算法提取的结果\r\n\r\nURL	新闻/博客的链接\r\n![请输入图片描述][8]\r\n\r\n \r\n\r\n \r\n\r\n6.3 猎聘网爬虫\r\n\r\n猎聘爬虫是对猎聘网招聘信息进行抓取和数据结构化的爬虫，通过职位关键字和指定某个地区即可搜索该职位在地区的招聘信息，每次搜索返回4000条左右的招聘数据，时间在8分钟以内可以完成采集。\r\n\r\n相关字段说明：\r\n\r\n术语	说明\r\n\r\n公司名称	提供职位的企业名称\r\n\r\n职位名称	企业提供的岗位薪资\r\n\r\n职位薪资	企业提供的岗位薪资\r\n\r\n工作地点	岗位所在城市\r\n\r\n年龄要求	企业对应聘者的年龄要求\r\n\r\n经验	企业对应聘者的工作经验要求\r\n\r\n职位描述	单位对职位的工作描述和入职要求\r\n\r\n导出数据	一键导出所有招聘信息到excel格式\r\n![请输入图片描述][9]\r\n\r\n\r\n\r\n6.5京东商品爬虫\r\n\r\n该爬虫可以实现对京东全站商品数据的抓取，也可以根据关键字搜索对商品结果进行采集。包括采集商家、商品、评论等信息，点击“评论”按钮可以查看商品评论，同时提供评论数据分析。\r\n\r\n相关字段说明：\r\n\r\n术语	说明\r\n\r\n关键字	需要搜索的商品名称（可输入多个）\r\n\r\n标题	商品名称\r\n\r\n京东价	商品价格\r\n店铺	店铺名\r\n\r\n评价数	包括不同星级的评论和总评论数\r\n\r\n查看评论	点击查看商品评论\r\n\r\n分析评论	对商品评论进行分析\r\n\r\n导出数据	一键将数据导出成excel格式\r\n![请输入图片描述][10]\r\n\r\n\r\n\r\n评论分析功能包括：商品购买时间分布、购买人群分布、购买途径（客户端）、用户等级分布\r\n\r\n商品购买时间分布：\r\n\r\n统计顾客购买该商品的时间分布,目前只对2017年的购买记录进行分析，以月份作为时间单位。\r\n\r\n购买人群分布：\r\n\r\n根据评论内容，统计该商品的购买和使用对象，如该商品是买给男朋友，或者是买给女朋友。\r\n\r\n购买途径：\r\n\r\n用户购买途径可以分为：Android客户端，IPhone客户端，Ipad客户端、微信购买或者PC客户端购买，通过分析，能都了解大众消费者的网上购物途径。\r\n\r\n用户等级分布：\r\n\r\n京东对不同消费人群的消费记录，对用户评定不同的等级，消费越多，等级越高。\r\n![请输入图片描述][11]\r\n\r\n\r\n7.数据分析模块\r\n\r\n7.1文本分析\r\n\r\n文本分析结合DACE系统自主研发的正文提取算法和开源的TextRank算法对新闻和博客类网站进行正文提取和文本分析。\r\n\r\n相关字段说明：\r\n\r\nURL输入框：输入一个包含标题和正文的新闻或博客链接\r\n\r\n提取正文：点击“提取正文”按钮即可对链接的内容进行提取和分析\r\n\r\n文本输入框：输入一段文本，可以对该文本进行摘要提取和关键词提取\r\n\r\n分析文本：点击“分析文本”按钮即可对文本进行分析\r\n\r\n摘要：显示提取出来的摘要\r\n\r\n关键词提取：显示文章的关键词\r\n![请输入图片描述][12]\r\n\r\n\r\n\r\n7.2 猎聘网生成报告\r\n\r\n分布式爬虫的高效率采集能够在5-8分钟内完成对特定地区和岗位的招聘信息抓取（约4000份），并且生成一份职业/行业报告。\r\n\r\n点击“行业报告”à选择地区à输入职位名称à点击生成报告\r\n\r\n等待5-8分钟内（*在此期间请勿进行其他操作，否则将导致无法正常显示行业报告，目前只支持单用户使用该功能，如遇多人同时使用，将会造成失败）。\r\n\r\n\r\n\r\n行业报告包括以下7个部分：\r\n\r\n全国各市对该职位的需求量。\r\n\r\n通过统计招聘信息中的岗位所在地区，分析全国各市对岗位的需求，获取排名前10的地区。\r\n\r\n全国各市的岗位薪资\r\n\r\n由于每个地区的经济水平和行业发展程度存在差异，因此岗位在不同地区的平均薪资是不一样的。结合上部分的职位需求量，统计10个地区的岗位薪资。\r\n\r\n岗位对学历要求\r\n\r\n随着社会的日益发展，许多行业的用人单位都提升了对学历的要求，特别是互联网和科技行业，对硕士以上学历的要求逐渐增多，通过对职位或者行业的分析，可以预测出不同行业的发展速度。\r\n\r\n企业类型和薪资分布情况\r\n\r\n尽管企业招聘相同的技术岗位，但是不同行业的公司对岗位的能力要求和工作范围的差异会造成岗位薪资的差异。通过分析不同类型企业的招聘薪资，得出企业类型和薪资分布情况。\r\n\r\n学历和薪资分布情况\r\n\r\n用人单位根据企业业务需求和工作要求，因此不同级别的企业会招聘不同学历层次的人员，同时不同岗位的职能需要的学历要求也是千差万别，因此通过对招聘信息中的学历-薪资进行分析，得出不同学历层次对岗位薪资的影响作用。\r\n\r\n技能需求量\r\n\r\n随着行业的不断革新和发展，面对新型业务企业也需要掌握不同技能的职员，因此可以通过对职位描述的文字进行分析，提取出该职位需要的技能集合判断当前掌握哪些技能最受企业青睐，给求职人员一个更好的学习方向和行业判断。\r\n\r\n技能价值\r\n\r\n不同的职业技能价值能为企业创造不同的财富和价值，因此企业对于掌握不同技能的应聘者会给予不同的薪资，不同的行业，不同的职位需要的技能不相同，通过统计行业平均薪资和技能的需求量，分析出不同技能的价值。\r\n\r\n地区平均薪资\r\n\r\n如果搜索的地区不为“全国”范围时，会对选择搜索的地区进行平均薪资统计，反映该地区的职位薪酬平均水平。\r\n\r\n词云报告\r\n\r\n词云报告是通过分析招聘信息中的岗位描述，进行关键词的提取生成的词云报告。能够快速发现与该职位相关的热点词语。\r\n![请输入图片描述][13]\r\n\r\n\r\n\r\n\r\n8.监控模块\r\n\r\n8.1实时监控\r\n\r\n实时监控模块可以对DACE系统的爬虫主机进行实时监控，查看服务器运行的内存使用情况和CPU使用情况。如果服务器发生异常，或者负载过大，可以通过实时监控及时发现。\r\n![请输入图片描述][14]\r\n\r\n\r\n  [1]: https://github.com/Panweitong/Distributed-Crawler-v2.0\r\n  [2]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture1-300x155.png\r\n  [3]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture2-300x56.png\r\n  [4]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture3-300x108.png\r\n  [5]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture4-300x137.png\r\n  [6]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture5-300x92.png\r\n  [7]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture6-300x128.png\r\n  [8]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture7-300x145.png\r\n  [9]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture8-300x125.png\r\n  [10]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture9-300x130.png\r\n  [11]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture10-300x168.png\r\n  [12]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture11-300x155.png\r\n  [13]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture12-300x185.png\r\n  [14]: https://743921382.mylightsite.com/wp-content/uploads/2018/03/Picture13-300x156.png', '1', 'post', 'publish', 'python,爬虫', '爬虫,Python', '251', '5', '1', '1', '1');
INSERT INTO `t_contents` VALUES ('9', '我的简历', 'paper', '1521117710', '1524759353', null, '![我的简历](http://localhost:8082/myBlog/static/user/img/spmbkuqooai26o0vl3ecm0p15e.jpg \"我的简历\")', '1', 'page', 'publish', null, null, '203', '0', '1', '1', '1');
INSERT INTO `t_contents` VALUES ('10', 'java并发——四种创建线程方式(转）', null, '1521388541', '1524801808', '并发用来提高运行在单处理器上的程序的性能。 \r\n这听起来有些违背直觉。如果有多个CPU处理器，那么我们让不同CPU并发处理程序一定会让速度变快。但是我们只有一个处理器，并发看起来只会增加上下文切换的开销时间。真的是这样吗？让这个问题的答案反转的是：阻塞。如果我们在执行一段代码中，有一处发生了阻塞，我们只能将整个程序停下来。如果我们采用并发的方式，即使这一处发生了阻塞，其他的任务还可以继续执行，直到程序结束，最后的情况只是一处阻塞，结果还不算太坏。', '**并发概念**\r\n\r\n并发用来提高运行在单处理器上的程序的性能。\r\n这听起来有些违背直觉。如果有多个CPU处理器，那么我们让不同CPU并发处理程序一定会让速度变快。但是我们只有一个处理器，并发看起来只会增加上下文切换的开销时间。真的是这样吗？让这个问题的答案反转的是：阻塞。如果我们在执行一段代码中，有一处发生了阻塞，我们只能将整个程序停下来。如果我们采用并发的方式，即使这一处发生了阻塞，其他的任务还可以继续执行，直到程序结束，最后的情况只是一处阻塞，结果还不算太坏。\r\n事实上，从性能的角度看，如果没有任务会阻塞，那么在单处理器上使用并发就没有任何意义。 ——Bruce Eckel\r\n实现并发最直接的方式就是我们的操作系统做的那样，使用进程。在多任务操作系统中可以通过周期性将CPU从一个进程切换到另一个进程，来实现同时运行多个进程的效果。尽管这样会让进程看起来执行的停停歇歇，但是互不干扰的进程还是非常吸引人。不同的，JAVA中使用线程来实现并发的概念。不同的线程会共享一个进程下的资源和I/O设备，这使得如何控制访问的同步变成了重要的课题。\r\n在单CPU处理器上使用并发程序在任何时刻都只是执行一项工作，因此从理论上讲，肯定可以不用任何任务而编写出相同的程序。但是并发提供了一个重要的组织结构上的好处：类似仿真等程序的设计可以极大地简化。最浅显的例子，比如我们做超级马里奥的小游戏，采用多线程来控制马里奥和怪物的行为就比不使用方便的多。如果在游戏中还有类似菜单的按钮，我们不可能每段代码都去检查这个按钮是否被点击，这个时候使用一个线程就显得方便简洁。\r\n\r\n**线程状态**\r\n\r\n在Thread中的内部嵌套类State中规定，线程一共有6种状态。\r\n\r\n      New 新创建的线程\r\n\r\n      这里的创建新的线程真的是仅仅new了一个线程。创建新的线程，是指刚new出来的线程，这个线程没有通过start的方法来启动。\r\n\r\n      Runnable 可运行\r\n\r\n     一旦我们调用了start方法，这个线程开始工作并处于可运行状态。可运行状态不只包含线程运行，线程中断也被算为可运行状态。一个可运行状态的线程可能在运行也可能没在运行，不要因线程在可运行的状态下没运行而急躁，很有可能这个线程的终止只 \r\n     是为了让其他的线程获得机会。\r\n\r\n     Blocked 被阻塞\r\n    \r\n     一个线程试图去获得一个内部锁时，但这个内部锁被其他的线程持有，这个时候，为了等待去使用这个内部锁，这个线程将会暂时处在被阻塞的状态。当其他线程释放锁的时候，这个线程获得了内部锁，并且从阻塞状态转变为非阻塞状态。\r\n\r\n     Wait 等待\r\n\r\n     一个线程等待另一个线程通知调度器一个条件（condition），这个线程自己进入等待状态。等待状态和阻塞状态很类似，但是他们是存在本质区别的。如果另一个线程通知调度器结束，那么这个线程进行工作，等待状态也随之结束。\r\n\r\n     Timed waiting 计时等待\r\n   \r\n    计时等待和等待是比较相似的，计时等待相比较等待多了一个超时参数。调用他们导致线程会进入计时等待。这个状态将一直保持到超时期满或者接收到适当的通知。相比较直接的等待，变得更加的安全。\r\n\r\n    Terminated 终止\r\n  \r\n    线程终止。线程run方法执行方法体中最后一条语句后，正常退出而自然死亡。或者，出现了在方法中没有捕获的异常，此时终止run方法意外死亡。\r\n\r\n**创建线程**\r\n\r\n1.Thread创建线程\r\n\r\n第一种创建线程的方式是从Java.lang.Thread类派生一个新的线程类，重载它的run()方法。ExtThread类是实现了Thread的一个子类，它重写了run方法。NewThread类是主方法，创建了一个ExtThread的实例，并且通过调用start方法启动了该线程，自动调用了run方法。我们不需要手动调用run方法，而应该调用start方法来让它自动调用run方法。在JAVA的API中，start是这样定义的：\r\npublic void start( ) \r\n使该线程开始执行；\r\nJava 虚拟机调用该线程的 run 方法。\r\n结果是两个线程并发地运行；当前线程（从调用返回给 start 方法）和另一个线程（执行其 run 方法）。\r\n多次启动一个线程是非法的。特别是当线程已经结束执行后，不能再重新启动。\r\n如果我们直接调用run方法，得到的将是在main函数的主线程中调用的run方法，这样没有开启新的线程。\r\nrun方法通常会以某种形式的循环来进行，使得任务一直运行下去直到不再需要，所以要设定跳出循环的条件（或者直接从run方法返回）。通常run方法被写成无限循环的形式，这样就意味着，除非某个条件使得run终止，否则他将永远运行下去。\r\n\r\nNewThread类：\r\n\r\n     package AllThread;\r\n    /**\r\n     * \r\n     * @author QuinnNorris\r\n     * \r\n     *         通过Thread创建新线程\r\n     */\r\n     public class NewThread {\r\n         /**\r\n          * @param args\r\n          */\r\n          public static void main(String[] args) {\r\n              // TODO Auto-generated method stub\r\n\r\n              Thread t1 = new ExtThread();\r\n              // 创建一个ExtThread对象\r\n              t1.start();\r\n              // 调用start方法，运行新的线程，即运行的是t1中的run方法\r\n           }\r\n\r\n     }\r\n\r\nExtThread类：\r\n\r\n      package AllThread;\r\n      /**\r\n       * \r\n       * @author QuinnNorris\r\n       * \r\n       *         Thread的一个实现类\r\n       */\r\n       public class ExtThread extends Thread {\r\n\r\n            @Override\r\n            public void run() {\r\n            // TODO Auto-generated method stub\r\n            System.out.println(\"new thread\");\r\n            }\r\n\r\n      }\r\n\r\n2.实现Runnable接口创建线程\r\n\r\n在JAVA中类仅支持单继承。这样，如果创建自定义线程类的时候是通过扩展 Thread类的方法来实现的，那么这个自定义类就不能再去扩展其他的类，也就无法实现更加复杂的功能。因此，如果自定义类必须扩展其他的类，那么就可以使用实现Runnable接口的方法来定义该类为线程类，这样就可以避免Java单继承所带来的局限性。\r\n\r\nNewRunable类：\r\n\r\n     package AllThread;\r\n\r\n     /**\r\n     * \r\n     * @author QuinnNorris\r\n     * \r\n     *         通过Runnable接口创建新线程\r\n     */\r\n     public class NewRunable {\r\n\r\n         /**\r\n          * @param args\r\n          */\r\n         public static void main(String[] args) {\r\n               // TODO Auto-generated method stub\r\n\r\n              Runnable r = new ImplRunnable();\r\n             // 创建一个Runnable实例类的对象\r\n            Thread t1 = new Thread(r);\r\n            // 由r作为构造器的参数创建一个Thread对象\r\n           // 将这个Runnable子类对象作为参数传入Thread中\r\n           t1.start();\r\n           // 调用start方法，运行新的线程，即运行的是t1中的run方法\r\n          }\r\n\r\n     }\r\n\r\nImplRunnable类：\r\n\r\n    package AllThread;\r\n\r\n    /**\r\n     * \r\n     * @author QuinnNorris\r\n     * \r\n     *         Runnable的一个实现类\r\n     */\r\n     public class ImplRunnable implements Runnable {\r\n\r\n         @Override\r\n         public void run() {\r\n             // TODO Auto-generated method stub\r\n            System.out.println(\"new thread\");\r\n          }\r\n\r\n      }\r\n\r\n多线程资源共享\r\n我们可以利用实现Runnable接口的方式实现多线程的资源共享：把资源保存在Runnable接口中，只创建一份实现了Runnable接口的类的实例，多个Thread对象用同一个Runnable接口实例为参数实例化。但是要注意的是，资源的共享会涉及到同步的问题，如果处理不当，那么数据的谬误、脏数据的出现是必然的事情。每当涉及到资源共享时都要小心谨慎。而且这种资源共享的方法也不是必须的，只要我们能确保最后所有的线程都指向同一个资源，那么他的存放位置不需要被严格规定。\r\n\r\n3.使用执行器（Executor）创建线程池（thread pool）\r\n使用线程池是比前两种相对少见的创建线程做法。从JAVA SE5开始，java.util.concurrent包中的执行器（Executor）将为你管理Thread对象，从而简化了并发编程。如果我们的程序需要用到很多生命周期比较短的线程，那么应该使用线程池，线程池中包含了很多空闲线程，而且这些线程的生命周期不需要我们操心。另一个使用线程池的原因是：如果你的代码需要大量的线程，那么最好使用一个线程池来规定总线程数的上线，防止虚拟机崩溃。这样可以限制最大的并发数量。\r\n\r\n静态方法创建线程池实例\r\n正如Collection类的静态方法都在Collections中一样，执行器Executor创建线程池的静态方法全部在Executors类中：\r\n\r\n       public static ExecutorService newCachedThreadPool()\r\n\r\n创建一个新的线程池。如果需要线程而线程池中无空闲线程时，创建一个新的线程。空闲线程会被保留60秒。\r\n\r\n       public static ExecutorService newFixedThreadPool(int nThreads)\r\n\r\n根据参数值创建一个固定数量线程的线程池。如果所需线程超过池中线程数则会发生等待。空闲线程会被一直保留。\r\n\r\n       public static ExecutorService newSingleThreadExecutor()\r\n\r\n创建一个仅有一个线程的线程池，顺序执行每一个提交的任务。（和第二种方法参数为1时效果相同）\r\n\r\n提交Runnable任务到线程池中\r\nExecutor作为一个祖先接口，提供了一个也仅有一个提交线程的方法：\r\n\r\n       void execute(Runnable command)\r\n\r\n在Executor的子类中，有很多子类提供了具有返回值的提交方法，返回提交的结果。\r\n\r\n       public Future<?> submit(Runnable task)\r\n\r\n比如这种submit方法，提交一个 Runnable 任务用于执行，并返回一个表示该任务的 Future。该 Future 的 get 方法在成功 完成时将会返回 null。调用get方法就能得到提交的结果。\r\n\r\n关闭线程池\r\n在线程使用结束后，为了保证程序的安全，我们有必要手动调用关闭线程池的方法：\r\n\r\n       public void shutdown()\r\n\r\nThreadPool类：\r\n\r\n      package AllThread;\r\n\r\n      import java.util.concurrent.ExecutorService;\r\n      import java.util.concurrent.Executors;\r\n\r\n      /**\r\n       * \r\n       * @author QuinnNorris\r\n       * \r\n       *         创建线程池\r\n       */\r\n     public class ThreadPool {\r\n\r\n       /**\r\n        * @param args\r\n        */\r\n        public static void main(String[] args) {\r\n             // TODO Auto-generated method stub\r\n\r\n            ExecutorService es = Executors.newFixedThreadPool(5);\r\n            // 我们调用静态方法创建了包含五个线程的线程池\r\n\r\n            for (int i = 0; i < 5; i++)\r\n                 es.submit(new ImplRunnable());\r\n\r\n            es.shutdown();\r\n            // 在使用结束之后，一定要关闭线程池\r\n         }\r\n\r\n      }\r\n\r\nImplRunnable类：\r\n\r\n     package AllThread;\r\n\r\n     /**\r\n      * \r\n      * @author QuinnNorris\r\n      * \r\n      *         Runnable的一个实现类\r\n      */\r\n\r\n     public class ImplRunnable implements Runnable {\r\n\r\n        @Override\r\n        public void run() {\r\n             // TODO Auto-generated method stub\r\n            System.out.println(\"new thread\");\r\n        }\r\n\r\n     }\r\n\r\n4.使用Callable与Future创建线程并获取返回值\r\n我们使用Runnable封装了一个异步运行的任务，我们可以把它想象成一个没有参数和返回值的异步方法，Callable与Runnable相似，但是Callable具有返回值，可以从线程中返回数据。\r\n\r\nCallable\r\n我们从jdk中找到了Callable<V>的源代码，去掉一些无用的部分：\r\n\r\n     package java.util.concurrent;\r\n\r\n     public interface Callable<V> {\r\n\r\n              V call() throws Exception;\r\n     }\r\n可以看出Callable接口只是将run方法换成了call方法，其他并没有太多的改动。\r\n\r\nFuture\r\nFuture类负责保存异步计算的结果。可以启动一个计算，将Future对象交给某个线程，然后我们去做其他的事情，Future对象的所有者在结果计算好之后就可以调用get方法获得它。我们在上面线程池的submit方法中也提到过。\r\n\r\nV get() throws InterruptedException,ExecutionException\r\n如有必要，等待计算完成，然后通过get方法获取其结果。\r\n\r\nFutureTask包装器\r\n我们虽然有了Callable和Future类，但是我们仍然需要一种方法将他们结合起来使用。而且还存在的问题是，Callable的出现替代了Runnable。我们需要一种手段让Thread类能够接受Callable做参数。在这里我们使用非常好用的FutureTask包装器。它可以将Callable转换成Futrue和Runnable，因为他同时实现了Runnable和Future<V>两个接口。\r\n\r\nCallablePool类：\r\n\r\n     package AllThread;\r\n\r\n     import java.util.ArrayList;\r\n     import java.util.concurrent.ExecutionException;\r\n     import java.util.concurrent.ExecutorService;\r\n     import java.util.concurrent.Executors;\r\n     import java.util.concurrent.Future;\r\n     import java.util.concurrent.FutureTask;\r\n\r\n     /**\r\n      * \r\n      * @author QuinnNorris\r\n      * \r\n      *         用线程池实现Callable创建线程\r\n      */\r\n    public class CallablePool {\r\n\r\n         /**\r\n          * @param args\r\n          */\r\n         public static void main(String[] args) {\r\n             // TODO Auto-generated method stub\r\n\r\n            ExecutorService es = Executors.newFixedThreadPool(5);\r\n            // 创建一个5个线程大小的线程池\r\n\r\n           ArrayList<Future<Integer>> results = new ArrayList<Future<Integer>>(5);\r\n           // 创建一个Future<Integer>类型的数组\r\n\r\n           FutureTask<Integer> ft = null;\r\n\r\n           for (int i = 0; i < 5; i++) {\r\n               ft = new FutureTask<Integer>(new ImplCallable(i));\r\n               // 将Callable类型转化成FutureTask类型\r\n\r\n              es.submit(ft);\r\n              // 提交线程\r\n\r\n              results.add(ft);\r\n              // 将返回的结果提交，因为FutureTask同时也可变为Future类型，所以这里不需要其他类型转化\r\n\r\n           }\r\n           for (int i = 0; i < 5; i++)\r\n              try {\r\n                System.out.println(results.get(i).get());\r\n                // 打印结果，发现数组中为0到4五个数字，成功。\r\n\r\n               } catch (InterruptedException e) {\r\n                  // TODO Auto-generated catch block\r\n                  e.printStackTrace();\r\n               } catch (ExecutionException e) {\r\n                  // TODO Auto-generated catch block\r\n                  e.printStackTrace();\r\n              }\r\n           }\r\n\r\n        }\r\n\r\nImplCallable类：\r\n\r\n    package AllThread;\r\n\r\n    import java.util.concurrent.Callable;\r\n     /**\r\n      * \r\n      * @author QuinnNorris\r\n      * \r\n      *         Callable的实现类\r\n      */\r\n \r\n    public class ImplCallable implements Callable<Integer> {\r\n\r\n         private int index;\r\n\r\n         ImplCallable(int index) {\r\n               this.index = index;\r\n        }\r\n\r\n       @Override\r\n       public Integer call() throws Exception {\r\n           // TODO Auto-generated method stub\r\n           return index;\r\n\r\n       }\r\n\r\n    }\r\n上面采用了线程池的方法来表现Callable和Future的使用方法，如果是简单实用Thread道理也是相同的，我们需要把：\r\n\r\nExecutorService es = Executors.newFixedThreadPool(5);\r\nes.submit(ft);\r\n这两句去掉，在for循环中替换成下面两句。创建Thread实例，开启新的线程。\r\n\r\nThread th = new Thread(ft);\r\nth.start();', '1', 'post', 'publish', 'java', 'Java', '372', '0', '1', '1', '1');

-- ----------------------------
-- Table structure for t_fontusers
-- ----------------------------
DROP TABLE IF EXISTS `t_fontusers`;
CREATE TABLE `t_fontusers` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `head_photo` varchar(255) DEFAULT NULL,
  `home_url` varchar(200) DEFAULT NULL,
  `screen_name` varchar(32) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `activated` int(10) unsigned DEFAULT '0',
  `logged` int(10) unsigned DEFAULT '0',
  `group_name` varchar(16) DEFAULT 'visitor',
  `outDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `secretKey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`username`),
  UNIQUE KEY `mail` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_fontusers
-- ----------------------------
INSERT INTO `t_fontusers` VALUES ('13', 'suiyuan', '3201c4fa6fea5f0dfe98d8d017a55f57', '1091260466@qq.com', '/static/user/img/logo.jpg', null, 'suiyuan', '1524324244', '0', '0', 'visitor', '2018-04-23 12:01:36', '7ea39ce6-8623-4e56-8373-f173b278d02f');

-- ----------------------------
-- Table structure for t_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_logs`;
CREATE TABLE `t_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(100) DEFAULT NULL,
  `data` varchar(2000) DEFAULT NULL,
  `author_id` int(10) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `created` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=421 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_logs
-- ----------------------------
INSERT INTO `t_logs` VALUES ('1', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496815277');
INSERT INTO `t_logs` VALUES ('2', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496815280');
INSERT INTO `t_logs` VALUES ('3', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496815318');
INSERT INTO `t_logs` VALUES ('4', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496815398');
INSERT INTO `t_logs` VALUES ('5', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496815482');
INSERT INTO `t_logs` VALUES ('6', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496815492');
INSERT INTO `t_logs` VALUES ('7', '保存系统设置', '{\"site_keywords\":\"Blog\",\"site_description\":\"SpringBoot+Mybatis+thymeleaf 搭建的 Java 博客系统\",\"site_title\":\"Blog\",\"site_theme\":\"default\",\"allow_install\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1496815955');
INSERT INTO `t_logs` VALUES ('8', '保存系统设置', '{\"site_keywords\":\"Blog\",\"site_description\":\"SpringBoot+Mybatis+thymeleaf 搭建的 Java 博客系统\",\"site_title\":\"Blog\",\"site_theme\":\"default\",\"allow_install\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1496815964');
INSERT INTO `t_logs` VALUES ('9', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496989015');
INSERT INTO `t_logs` VALUES ('10', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1496989366');
INSERT INTO `t_logs` VALUES ('11', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497317863');
INSERT INTO `t_logs` VALUES ('12', '保存系统设置', '{\"social_zhihu\":\"https://www.zhihu.com/people/tian-zhisheng/activities\",\"social_github\":\"https://github.com/zhisheng17\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1497318696');
INSERT INTO `t_logs` VALUES ('13', '修改个人信息', '{\"uid\":1,\"email\":\"1041218129@qq.com\",\"screenName\":\"admin\"}', '1', '0:0:0:0:0:0:0:1', '1497319220');
INSERT INTO `t_logs` VALUES ('14', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497319856');
INSERT INTO `t_logs` VALUES ('15', '登录后台', null, '1', '127.0.0.1', '1497321561');
INSERT INTO `t_logs` VALUES ('16', '登录后台', null, '1', '127.0.0.1', '1497322738');
INSERT INTO `t_logs` VALUES ('17', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497323446');
INSERT INTO `t_logs` VALUES ('18', '删除文章', '2', '1', '0:0:0:0:0:0:0:1', '1497323495');
INSERT INTO `t_logs` VALUES ('19', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497427641');
INSERT INTO `t_logs` VALUES ('20', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497428250');
INSERT INTO `t_logs` VALUES ('21', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497428290');
INSERT INTO `t_logs` VALUES ('22', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497428556');
INSERT INTO `t_logs` VALUES ('23', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497674581');
INSERT INTO `t_logs` VALUES ('24', '修改个人信息', '{\"uid\":1,\"email\":\"1041218129@qq.com\",\"screenName\":\"admin\"}', '1', '0:0:0:0:0:0:0:1', '1497674690');
INSERT INTO `t_logs` VALUES ('25', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497676623');
INSERT INTO `t_logs` VALUES ('26', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497683817');
INSERT INTO `t_logs` VALUES ('27', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1497685128');
INSERT INTO `t_logs` VALUES ('28', '登录后台', null, '1', '127.0.0.1', '1497689032');
INSERT INTO `t_logs` VALUES ('29', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520482159');
INSERT INTO `t_logs` VALUES ('30', '删除文章', '/upload/2017/06/t93vgdj6o8irgo87ds56u0ou0s.jpeg', '1', '0:0:0:0:0:0:0:1', '1520482692');
INSERT INTO `t_logs` VALUES ('31', '删除文章', '/upload/2018/03/7qscfftiqag8lojplt3pqv6sid.xlsx', '1', '0:0:0:0:0:0:0:1', '1520482695');
INSERT INTO `t_logs` VALUES ('32', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520485483');
INSERT INTO `t_logs` VALUES ('33', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520508484');
INSERT INTO `t_logs` VALUES ('34', '保存系统设置', '{\"social_zhihu\":\"https://www.zhihu.com/people/tian-zhisheng/activities\",\"social_github\":\"https://github.com/zhisheng17\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520508500');
INSERT INTO `t_logs` VALUES ('35', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520525060');
INSERT INTO `t_logs` VALUES ('36', '删除页面', '7', '1', '0:0:0:0:0:0:0:1', '1520526463');
INSERT INTO `t_logs` VALUES ('37', '删除文章', '8', '1', '0:0:0:0:0:0:0:1', '1520526540');
INSERT INTO `t_logs` VALUES ('38', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520527658');
INSERT INTO `t_logs` VALUES ('39', '保存系统设置', '{\"social_zhihu\":\"https://www.zhihu.com/people/tian-zhisheng/activities\",\"social_github\":\"https://github.com/zhisheng17\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520527664');
INSERT INTO `t_logs` VALUES ('40', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/zhisheng17\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520527752');
INSERT INTO `t_logs` VALUES ('41', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520528778');
INSERT INTO `t_logs` VALUES ('42', '删除文章', '/upload/2018/03/690lbcaas6ji9obrd6a2cmu4gq.xlsx', '1', '0:0:0:0:0:0:0:1', '1520528985');
INSERT INTO `t_logs` VALUES ('43', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520563587');
INSERT INTO `t_logs` VALUES ('44', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520563602');
INSERT INTO `t_logs` VALUES ('45', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520564981');
INSERT INTO `t_logs` VALUES ('46', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520564985');
INSERT INTO `t_logs` VALUES ('47', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520565710');
INSERT INTO `t_logs` VALUES ('48', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520567028');
INSERT INTO `t_logs` VALUES ('49', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520599789');
INSERT INTO `t_logs` VALUES ('50', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1520599893');
INSERT INTO `t_logs` VALUES ('51', '保存系统设置', '{\"site_keywords\":\"Blog\",\"site_description\":\"SpringBoot+Mybatis+thymeleaf 搭建的 Java 博客系统\",\"site_title\":\"Blog\",\"site_theme\":\"default\",\"allow_install\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1520599897');
INSERT INTO `t_logs` VALUES ('52', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1520599899');
INSERT INTO `t_logs` VALUES ('53', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1520599920');
INSERT INTO `t_logs` VALUES ('54', '修改个人信息', '{\"uid\":1,\"email\":\"1025103647@qq.com\",\"screenName\":\"admin\"}', '1', '0:0:0:0:0:0:0:1', '1520601434');
INSERT INTO `t_logs` VALUES ('55', '修改个人信息', '{\"uid\":1,\"email\":\"1025103647@qq.com\",\"screenName\":\"潘炜桐\"}', '1', '0:0:0:0:0:0:0:1', '1520601448');
INSERT INTO `t_logs` VALUES ('56', '修改个人信息', '{\"uid\":1,\"email\":\"1025103647@qq.com\",\"screenName\":\"潘炜桐\"}', '1', '0:0:0:0:0:0:0:1', '1520601453');
INSERT INTO `t_logs` VALUES ('57', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520601899');
INSERT INTO `t_logs` VALUES ('58', '修改个人信息', '{\"uid\":1,\"email\":\"1025103647@qq.com\",\"screenName\":\"admin\"}', '1', '0:0:0:0:0:0:0:1', '1520601917');
INSERT INTO `t_logs` VALUES ('59', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792449');
INSERT INTO `t_logs` VALUES ('60', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792536');
INSERT INTO `t_logs` VALUES ('61', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792583');
INSERT INTO `t_logs` VALUES ('62', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792663');
INSERT INTO `t_logs` VALUES ('63', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792676');
INSERT INTO `t_logs` VALUES ('64', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792686');
INSERT INTO `t_logs` VALUES ('65', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520792755');
INSERT INTO `t_logs` VALUES ('66', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520860598');
INSERT INTO `t_logs` VALUES ('67', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520949629');
INSERT INTO `t_logs` VALUES ('68', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520949645');
INSERT INTO `t_logs` VALUES ('69', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520950376');
INSERT INTO `t_logs` VALUES ('70', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520950465');
INSERT INTO `t_logs` VALUES ('71', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520950612');
INSERT INTO `t_logs` VALUES ('72', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520950763');
INSERT INTO `t_logs` VALUES ('73', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520951197');
INSERT INTO `t_logs` VALUES ('74', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520959127');
INSERT INTO `t_logs` VALUES ('75', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520959751');
INSERT INTO `t_logs` VALUES ('76', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520995368');
INSERT INTO `t_logs` VALUES ('77', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520997470');
INSERT INTO `t_logs` VALUES ('78', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1520999702');
INSERT INTO `t_logs` VALUES ('79', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521000097');
INSERT INTO `t_logs` VALUES ('80', '删除文章', '/upload/2018/03/vd3d41tibkhsaqpr4bgmpj9fnj.cpp', '1', '0:0:0:0:0:0:0:1', '1521000149');
INSERT INTO `t_logs` VALUES ('81', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521000220');
INSERT INTO `t_logs` VALUES ('82', '删除文章', '/upload/2018/03/3et6odspf2hamptme1b0ogi5m1.cpp', '1', '0:0:0:0:0:0:0:1', '1521001154');
INSERT INTO `t_logs` VALUES ('83', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521002263');
INSERT INTO `t_logs` VALUES ('84', '删除文章', '/upload/2018/03/1j8nta113cg42piepshhp3auh2.cpp', '1', '0:0:0:0:0:0:0:1', '1521002333');
INSERT INTO `t_logs` VALUES ('85', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521002444');
INSERT INTO `t_logs` VALUES ('86', '删除文章', '/upload/2018/03/5cdppcmflij7arf8kdtsccpgv8.docx', '1', '0:0:0:0:0:0:0:1', '1521002485');
INSERT INTO `t_logs` VALUES ('87', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521004864');
INSERT INTO `t_logs` VALUES ('88', '删除文章', '/upload/2018/03/0aqbvd6dpagq2o4a5bfdbn7kh4.docx', '1', '0:0:0:0:0:0:0:1', '1521004905');
INSERT INTO `t_logs` VALUES ('89', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521005016');
INSERT INTO `t_logs` VALUES ('90', '删除文章', '/upload/2018/03/0h2d2gpnmcimhrp7tf8j87qnsq.docx', '1', '0:0:0:0:0:0:0:1', '1521005021');
INSERT INTO `t_logs` VALUES ('91', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521005622');
INSERT INTO `t_logs` VALUES ('92', '删除文章', '/upload/2018/03/ta2um33vcsgsaru70ijtghfbtl.docx', '1', '0:0:0:0:0:0:0:1', '1521005629');
INSERT INTO `t_logs` VALUES ('93', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521012733');
INSERT INTO `t_logs` VALUES ('94', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521013070');
INSERT INTO `t_logs` VALUES ('95', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521013170');
INSERT INTO `t_logs` VALUES ('96', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521013761');
INSERT INTO `t_logs` VALUES ('97', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521013942');
INSERT INTO `t_logs` VALUES ('98', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521020952');
INSERT INTO `t_logs` VALUES ('99', '删除文章', '/upload/2018/03/u70u10kj8kg0npfvpim29h5kba.docx', '1', '0:0:0:0:0:0:0:1', '1521021016');
INSERT INTO `t_logs` VALUES ('100', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521042422');
INSERT INTO `t_logs` VALUES ('101', '删除文章', '/upload/2018/03/o6o2uls24cirdpfcbmo59eeflb.docx', '1', '0:0:0:0:0:0:0:1', '1521042427');
INSERT INTO `t_logs` VALUES ('102', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521042755');
INSERT INTO `t_logs` VALUES ('103', '删除文章', '/upload/2018/03/rjo7q4hq88ik2otcdj5nf3mhih.docx', '1', '0:0:0:0:0:0:0:1', '1521042773');
INSERT INTO `t_logs` VALUES ('104', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521043164');
INSERT INTO `t_logs` VALUES ('105', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521043390');
INSERT INTO `t_logs` VALUES ('106', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521043448');
INSERT INTO `t_logs` VALUES ('107', '删除文章', '/upload/2018/03/4sg5nude2ujpvofhbtlmno2ods.docx', '1', '0:0:0:0:0:0:0:1', '1521043472');
INSERT INTO `t_logs` VALUES ('108', '删除文章', '2018/03/rmqhc5sltkj4gpqdn0fr1an8bj.docx', '1', '0:0:0:0:0:0:0:1', '1521043475');
INSERT INTO `t_logs` VALUES ('109', '删除文章', '/upload/2018/03/voni19s5ekj7hq9lhlebhl7gnp.docx', '1', '0:0:0:0:0:0:0:1', '1521043491');
INSERT INTO `t_logs` VALUES ('110', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521043533');
INSERT INTO `t_logs` VALUES ('111', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521043578');
INSERT INTO `t_logs` VALUES ('112', '删除文章', '/upload/2018/03/2524i32oaigq3rnhe5834mlkhb.docx', '1', '0:0:0:0:0:0:0:1', '1521043867');
INSERT INTO `t_logs` VALUES ('113', '删除文章', '/2018/03/qh3k6h8dvuipfosrrgeh3subth.docx', '1', '0:0:0:0:0:0:0:1', '1521043871');
INSERT INTO `t_logs` VALUES ('114', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521043937');
INSERT INTO `t_logs` VALUES ('115', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521045606');
INSERT INTO `t_logs` VALUES ('116', '删除文章', '/upload/2018/03/peknutd078ggtq46bu4e9jn0ch.docx', '1', '0:0:0:0:0:0:0:1', '1521045610');
INSERT INTO `t_logs` VALUES ('117', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521045719');
INSERT INTO `t_logs` VALUES ('118', '删除文章', '2018/03/0aipnt0veih1vqrloqbisas3h0.docx', '1', '0:0:0:0:0:0:0:1', '1521045730');
INSERT INTO `t_logs` VALUES ('119', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521045862');
INSERT INTO `t_logs` VALUES ('120', '删除文章', '2018/03/46km69cf0ei9pphakbvnd6omd0.docx', '1', '0:0:0:0:0:0:0:1', '1521045866');
INSERT INTO `t_logs` VALUES ('121', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521045960');
INSERT INTO `t_logs` VALUES ('122', '删除文章', '2018/03/qqnp3h5es6haorus92oq3eb42j.docx', '1', '0:0:0:0:0:0:0:1', '1521045965');
INSERT INTO `t_logs` VALUES ('123', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521046600');
INSERT INTO `t_logs` VALUES ('124', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521047112');
INSERT INTO `t_logs` VALUES ('125', '删除文章', '2018/03/s8hfpn4vniil1r7l2ag1t4qc4c.docx', '1', '0:0:0:0:0:0:0:1', '1521047116');
INSERT INTO `t_logs` VALUES ('126', '删除文章', '2018/03/rtaslqpj10g61ont532f0r5bsh.docx', '1', '0:0:0:0:0:0:0:1', '1521047120');
INSERT INTO `t_logs` VALUES ('127', '删除文章', '2018/03/sugbdrm9paj0jrgvg7mpktp7nd.docx', '1', '0:0:0:0:0:0:0:1', '1521047216');
INSERT INTO `t_logs` VALUES ('128', '删除文章', '2018/03/q81vtgqlj6hfuqtj4rg1a30eg1.docx', '1', '0:0:0:0:0:0:0:1', '1521047255');
INSERT INTO `t_logs` VALUES ('129', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521048772');
INSERT INTO `t_logs` VALUES ('130', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521048966');
INSERT INTO `t_logs` VALUES ('131', '删除文章', '2018/03/skq8ecb9v6ju5qscec36tf4ebo.docx', '1', '0:0:0:0:0:0:0:1', '1521049070');
INSERT INTO `t_logs` VALUES ('132', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521049128');
INSERT INTO `t_logs` VALUES ('133', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521049275');
INSERT INTO `t_logs` VALUES ('134', '删除文章', '2018/03/o27n7kcblkgjnpo50glvhf06up.docx', '1', '0:0:0:0:0:0:0:1', '1521049279');
INSERT INTO `t_logs` VALUES ('135', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521049624');
INSERT INTO `t_logs` VALUES ('136', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521102069');
INSERT INTO `t_logs` VALUES ('137', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521102465');
INSERT INTO `t_logs` VALUES ('138', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521103858');
INSERT INTO `t_logs` VALUES ('139', '删除文章', '2018/03/4s6n8v596ggulpcv367ksn35k2.docx', '1', '0:0:0:0:0:0:0:1', '1521103869');
INSERT INTO `t_logs` VALUES ('140', '删除文章', '2018/03/u4p7dbi0p0hcmrmr28rv8hrnhi.docx', '1', '0:0:0:0:0:0:0:1', '1521103983');
INSERT INTO `t_logs` VALUES ('141', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521104069');
INSERT INTO `t_logs` VALUES ('142', '删除文章', '2018/03/4mtuo275rch25ojcgb5d2eemgk.docx', '1', '0:0:0:0:0:0:0:1', '1521104073');
INSERT INTO `t_logs` VALUES ('143', '删除文章', '/2018/03/pttdo439lsg88q1u99s2n8stmk.docx', '1', '0:0:0:0:0:0:0:1', '1521104102');
INSERT INTO `t_logs` VALUES ('144', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521104277');
INSERT INTO `t_logs` VALUES ('145', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521104480');
INSERT INTO `t_logs` VALUES ('146', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521104837');
INSERT INTO `t_logs` VALUES ('147', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521105553');
INSERT INTO `t_logs` VALUES ('148', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521106138');
INSERT INTO `t_logs` VALUES ('149', '删除文章', '/s5t4ka1jqajanrjogoruvigif0.docx', '1', '0:0:0:0:0:0:0:1', '1521106181');
INSERT INTO `t_logs` VALUES ('150', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521107191');
INSERT INTO `t_logs` VALUES ('151', '删除文章', '/6vuob63a4shr3rboeqk47tgt9g.docx', '1', '0:0:0:0:0:0:0:1', '1521107206');
INSERT INTO `t_logs` VALUES ('152', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521107629');
INSERT INTO `t_logs` VALUES ('153', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521108038');
INSERT INTO `t_logs` VALUES ('154', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521108545');
INSERT INTO `t_logs` VALUES ('155', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521108621');
INSERT INTO `t_logs` VALUES ('156', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521108971');
INSERT INTO `t_logs` VALUES ('157', '删除文章', '/2kkadgtfoqi48rqfnrc3np5odv.docx', '1', '0:0:0:0:0:0:0:1', '1521109027');
INSERT INTO `t_logs` VALUES ('158', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521109143');
INSERT INTO `t_logs` VALUES ('159', '删除文章', '/0i64784gruh01qsv20d9lpa0lo.docx', '1', '0:0:0:0:0:0:0:1', '1521109172');
INSERT INTO `t_logs` VALUES ('160', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521109376');
INSERT INTO `t_logs` VALUES ('161', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521109497');
INSERT INTO `t_logs` VALUES ('162', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521109506');
INSERT INTO `t_logs` VALUES ('163', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521109539');
INSERT INTO `t_logs` VALUES ('164', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521114218');
INSERT INTO `t_logs` VALUES ('165', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521114648');
INSERT INTO `t_logs` VALUES ('166', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521116318');
INSERT INTO `t_logs` VALUES ('167', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521116416');
INSERT INTO `t_logs` VALUES ('168', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521116848');
INSERT INTO `t_logs` VALUES ('169', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521116983');
INSERT INTO `t_logs` VALUES ('170', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521117220');
INSERT INTO `t_logs` VALUES ('171', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521117656');
INSERT INTO `t_logs` VALUES ('172', '删除页面', '8', '1', '0:0:0:0:0:0:0:1', '1521117685');
INSERT INTO `t_logs` VALUES ('173', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521118481');
INSERT INTO `t_logs` VALUES ('174', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521128716');
INSERT INTO `t_logs` VALUES ('175', '删除文章', '18', '1', '0:0:0:0:0:0:0:1', '1521128731');
INSERT INTO `t_logs` VALUES ('176', '删除文章', '17', '1', '0:0:0:0:0:0:0:1', '1521128734');
INSERT INTO `t_logs` VALUES ('177', '删除文章', '16', '1', '0:0:0:0:0:0:0:1', '1521128736');
INSERT INTO `t_logs` VALUES ('178', '删除文章', '15', '1', '0:0:0:0:0:0:0:1', '1521128740');
INSERT INTO `t_logs` VALUES ('179', '删除文章', '14', '1', '0:0:0:0:0:0:0:1', '1521128742');
INSERT INTO `t_logs` VALUES ('180', '删除文章', '13', '1', '0:0:0:0:0:0:0:1', '1521128746');
INSERT INTO `t_logs` VALUES ('181', '删除文章', '12', '1', '0:0:0:0:0:0:0:1', '1521128750');
INSERT INTO `t_logs` VALUES ('182', '删除文章', '11', '1', '0:0:0:0:0:0:0:1', '1521128753');
INSERT INTO `t_logs` VALUES ('183', '删除文章', '10', '1', '0:0:0:0:0:0:0:1', '1521128757');
INSERT INTO `t_logs` VALUES ('184', '保存系统设置', '{\"site_keywords\":\"Blog\",\"site_description\":\"Spring+SpringMVC+MyBatis+thymeleaf 搭建的 Java 博客系统\",\"site_title\":\"Blog\",\"site_theme\":\"default\",\"allow_install\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1521128809');
INSERT INTO `t_logs` VALUES ('185', '保存系统设置', '{\"site_keywords\":\"Blog\",\"site_description\":\"Spring+SpringMVC+MyBatis+thymeleaf 搭建的 Java 博客系统\",\"site_title\":\"Blog\",\"site_theme\":\"default\",\"allow_install\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1521128830');
INSERT INTO `t_logs` VALUES ('186', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1521128835');
INSERT INTO `t_logs` VALUES ('187', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521128936');
INSERT INTO `t_logs` VALUES ('188', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521130336');
INSERT INTO `t_logs` VALUES ('189', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521205296');
INSERT INTO `t_logs` VALUES ('190', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521362655');
INSERT INTO `t_logs` VALUES ('191', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1521362660');
INSERT INTO `t_logs` VALUES ('192', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521363198');
INSERT INTO `t_logs` VALUES ('193', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1521363403');
INSERT INTO `t_logs` VALUES ('194', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521385891');
INSERT INTO `t_logs` VALUES ('195', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521386740');
INSERT INTO `t_logs` VALUES ('196', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521387101');
INSERT INTO `t_logs` VALUES ('197', '删除文章', '3', '1', '0:0:0:0:0:0:0:1', '1521387107');
INSERT INTO `t_logs` VALUES ('198', '删除文章', '6', '1', '0:0:0:0:0:0:0:1', '1521387200');
INSERT INTO `t_logs` VALUES ('199', '删除文章', '4', '1', '0:0:0:0:0:0:0:1', '1521387298');
INSERT INTO `t_logs` VALUES ('200', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521388333');
INSERT INTO `t_logs` VALUES ('201', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521416280');
INSERT INTO `t_logs` VALUES ('202', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521417290');
INSERT INTO `t_logs` VALUES ('203', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521423527');
INSERT INTO `t_logs` VALUES ('204', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521560241');
INSERT INTO `t_logs` VALUES ('205', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521562574');
INSERT INTO `t_logs` VALUES ('206', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521564640');
INSERT INTO `t_logs` VALUES ('207', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521565569');
INSERT INTO `t_logs` VALUES ('208', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521784457');
INSERT INTO `t_logs` VALUES ('209', '删除文章', '/4r9oe500nqhdaqt618d4bnikse.docx', '1', '0:0:0:0:0:0:0:1', '1521784497');
INSERT INTO `t_logs` VALUES ('210', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521791411');
INSERT INTO `t_logs` VALUES ('211', '删除文章', '/vbvaaeff1ojeqpcfjkd8g7doo6.doc', '1', '0:0:0:0:0:0:0:1', '1521792147');
INSERT INTO `t_logs` VALUES ('212', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521792303');
INSERT INTO `t_logs` VALUES ('213', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521794512');
INSERT INTO `t_logs` VALUES ('214', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521794791');
INSERT INTO `t_logs` VALUES ('215', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521795327');
INSERT INTO `t_logs` VALUES ('216', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521795492');
INSERT INTO `t_logs` VALUES ('217', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521795662');
INSERT INTO `t_logs` VALUES ('218', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521795783');
INSERT INTO `t_logs` VALUES ('219', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521795943');
INSERT INTO `t_logs` VALUES ('220', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521796183');
INSERT INTO `t_logs` VALUES ('221', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521796307');
INSERT INTO `t_logs` VALUES ('222', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521796396');
INSERT INTO `t_logs` VALUES ('223', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521796465');
INSERT INTO `t_logs` VALUES ('224', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521798656');
INSERT INTO `t_logs` VALUES ('225', '保存系统设置', '{\"site_keywords\":\"Blog\",\"site_description\":\"Spring+SpringMVC+MyBatis+thymeleaf 搭建的 Java 博客系统\",\"site_title\":\"Blog\",\"site_theme\":\"default\",\"allow_install\":\"\"}', '1', '0:0:0:0:0:0:0:1', '1521798716');
INSERT INTO `t_logs` VALUES ('226', '保存系统设置', '{\"social_zhihu\":\"\",\"social_github\":\"https://github.com/Panweitong\",\"social_twitter\":\"\",\"social_weibo\":\"https://weibo.com/u/2344829772?refer_flag\\u003d1001030201_\\u0026is_hot\\u003d1\"}', '1', '0:0:0:0:0:0:0:1', '1521798719');
INSERT INTO `t_logs` VALUES ('227', '删除文章', '/v9cddt7kkghr9pskrlr22oho1e.doc', '1', '0:0:0:0:0:0:0:1', '1521798745');
INSERT INTO `t_logs` VALUES ('228', '删除页面', '11', '1', '0:0:0:0:0:0:0:1', '1521798936');
INSERT INTO `t_logs` VALUES ('229', '删除文章', '12', '1', '0:0:0:0:0:0:0:1', '1521798989');
INSERT INTO `t_logs` VALUES ('230', '删除文章', '13', '1', '0:0:0:0:0:0:0:1', '1521799005');
INSERT INTO `t_logs` VALUES ('231', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521799495');
INSERT INTO `t_logs` VALUES ('232', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521799521');
INSERT INTO `t_logs` VALUES ('233', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521799650');
INSERT INTO `t_logs` VALUES ('234', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521799691');
INSERT INTO `t_logs` VALUES ('235', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521800041');
INSERT INTO `t_logs` VALUES ('236', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521801648');
INSERT INTO `t_logs` VALUES ('237', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521801952');
INSERT INTO `t_logs` VALUES ('238', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521802318');
INSERT INTO `t_logs` VALUES ('239', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521802573');
INSERT INTO `t_logs` VALUES ('240', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1521867662');
INSERT INTO `t_logs` VALUES ('241', '登录后台', null, '1', '192.168.1.102', '1521867842');
INSERT INTO `t_logs` VALUES ('242', '登录后台', null, '1', '192.168.1.102', '1521867846');
INSERT INTO `t_logs` VALUES ('243', '登录后台', null, '1', '192.168.1.102', '1521867852');
INSERT INTO `t_logs` VALUES ('244', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522684462');
INSERT INTO `t_logs` VALUES ('245', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522684809');
INSERT INTO `t_logs` VALUES ('246', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522685278');
INSERT INTO `t_logs` VALUES ('247', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522685355');
INSERT INTO `t_logs` VALUES ('248', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522685391');
INSERT INTO `t_logs` VALUES ('249', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522685532');
INSERT INTO `t_logs` VALUES ('250', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1522685578');
INSERT INTO `t_logs` VALUES ('251', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524044127');
INSERT INTO `t_logs` VALUES ('252', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524044176');
INSERT INTO `t_logs` VALUES ('253', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524058257');
INSERT INTO `t_logs` VALUES ('254', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524074322');
INSERT INTO `t_logs` VALUES ('255', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524074328');
INSERT INTO `t_logs` VALUES ('256', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524077747');
INSERT INTO `t_logs` VALUES ('257', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524084480');
INSERT INTO `t_logs` VALUES ('258', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524108479');
INSERT INTO `t_logs` VALUES ('259', '删除文章', '11', '1', '0:0:0:0:0:0:0:1', '1524109223');
INSERT INTO `t_logs` VALUES ('260', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524123488');
INSERT INTO `t_logs` VALUES ('261', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524123785');
INSERT INTO `t_logs` VALUES ('262', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524125842');
INSERT INTO `t_logs` VALUES ('263', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524126721');
INSERT INTO `t_logs` VALUES ('264', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524127150');
INSERT INTO `t_logs` VALUES ('265', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524127275');
INSERT INTO `t_logs` VALUES ('266', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524131683');
INSERT INTO `t_logs` VALUES ('267', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524133033');
INSERT INTO `t_logs` VALUES ('268', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524133304');
INSERT INTO `t_logs` VALUES ('269', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524133511');
INSERT INTO `t_logs` VALUES ('270', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524133635');
INSERT INTO `t_logs` VALUES ('271', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524133932');
INSERT INTO `t_logs` VALUES ('272', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524143503');
INSERT INTO `t_logs` VALUES ('273', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524143513');
INSERT INTO `t_logs` VALUES ('274', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524143527');
INSERT INTO `t_logs` VALUES ('275', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524143532');
INSERT INTO `t_logs` VALUES ('276', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524143736');
INSERT INTO `t_logs` VALUES ('277', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524143974');
INSERT INTO `t_logs` VALUES ('278', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524144041');
INSERT INTO `t_logs` VALUES ('279', '登录后台', null, '6', '0:0:0:0:0:0:0:1', '1524151738');
INSERT INTO `t_logs` VALUES ('280', '登录后台', null, '7', '0:0:0:0:0:0:0:1', '1524151828');
INSERT INTO `t_logs` VALUES ('281', '登录后台', null, '7', '0:0:0:0:0:0:0:1', '1524151848');
INSERT INTO `t_logs` VALUES ('282', '登录后台', null, '8', '0:0:0:0:0:0:0:1', '1524152582');
INSERT INTO `t_logs` VALUES ('283', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524155384');
INSERT INTO `t_logs` VALUES ('284', '登录后台', null, '9', '0:0:0:0:0:0:0:1', '1524156017');
INSERT INTO `t_logs` VALUES ('285', '登录后台', null, '10', '0:0:0:0:0:0:0:1', '1524156193');
INSERT INTO `t_logs` VALUES ('286', '登录后台', null, '2', '0:0:0:0:0:0:0:1', '1524156629');
INSERT INTO `t_logs` VALUES ('287', '登录后台', null, '11', '0:0:0:0:0:0:0:1', '1524158281');
INSERT INTO `t_logs` VALUES ('288', '登录后台', null, '11', '0:0:0:0:0:0:0:1', '1524158597');
INSERT INTO `t_logs` VALUES ('289', '登录后台', null, '11', '0:0:0:0:0:0:0:1', '1524159520');
INSERT INTO `t_logs` VALUES ('290', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524159877');
INSERT INTO `t_logs` VALUES ('291', '登录后台', null, '11', '0:0:0:0:0:0:0:1', '1524159895');
INSERT INTO `t_logs` VALUES ('292', '登录后台', null, '11', '0:0:0:0:0:0:0:1', '1524161221');
INSERT INTO `t_logs` VALUES ('293', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524161320');
INSERT INTO `t_logs` VALUES ('294', '登录后台', null, '11', '0:0:0:0:0:0:0:1', '1524161441');
INSERT INTO `t_logs` VALUES ('295', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524161455');
INSERT INTO `t_logs` VALUES ('296', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524161516');
INSERT INTO `t_logs` VALUES ('297', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524161584');
INSERT INTO `t_logs` VALUES ('298', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524161640');
INSERT INTO `t_logs` VALUES ('299', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524161737');
INSERT INTO `t_logs` VALUES ('300', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524198054');
INSERT INTO `t_logs` VALUES ('301', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524243281');
INSERT INTO `t_logs` VALUES ('302', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524243418');
INSERT INTO `t_logs` VALUES ('303', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524243484');
INSERT INTO `t_logs` VALUES ('304', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524245606');
INSERT INTO `t_logs` VALUES ('305', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524246972');
INSERT INTO `t_logs` VALUES ('306', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524247025');
INSERT INTO `t_logs` VALUES ('307', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524247532');
INSERT INTO `t_logs` VALUES ('308', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524282447');
INSERT INTO `t_logs` VALUES ('309', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524290081');
INSERT INTO `t_logs` VALUES ('310', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524290192');
INSERT INTO `t_logs` VALUES ('311', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524293300');
INSERT INTO `t_logs` VALUES ('312', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524307973');
INSERT INTO `t_logs` VALUES ('313', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524311297');
INSERT INTO `t_logs` VALUES ('314', '登录后台', null, '12', '0:0:0:0:0:0:0:1', '1524314519');
INSERT INTO `t_logs` VALUES ('315', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524496483');
INSERT INTO `t_logs` VALUES ('316', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524496732');
INSERT INTO `t_logs` VALUES ('317', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524497314');
INSERT INTO `t_logs` VALUES ('318', '删除文章', '11', '1', '0:0:0:0:0:0:0:1', '1524497319');
INSERT INTO `t_logs` VALUES ('319', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524497491');
INSERT INTO `t_logs` VALUES ('320', '删除文章', '12', '1', '0:0:0:0:0:0:0:1', '1524497593');
INSERT INTO `t_logs` VALUES ('321', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524499855');
INSERT INTO `t_logs` VALUES ('322', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524500037');
INSERT INTO `t_logs` VALUES ('323', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524500430');
INSERT INTO `t_logs` VALUES ('324', '删除文章', '13', '1', '0:0:0:0:0:0:0:1', '1524500441');
INSERT INTO `t_logs` VALUES ('325', '删除文章', '14', '1', '0:0:0:0:0:0:0:1', '1524500479');
INSERT INTO `t_logs` VALUES ('326', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524500936');
INSERT INTO `t_logs` VALUES ('327', '删除文章', '/rr454arhtchuqohentmvndp7jr.doc', '1', '0:0:0:0:0:0:0:1', '1524500993');
INSERT INTO `t_logs` VALUES ('328', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524501533');
INSERT INTO `t_logs` VALUES ('329', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524516084');
INSERT INTO `t_logs` VALUES ('330', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524517166');
INSERT INTO `t_logs` VALUES ('331', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524540653');
INSERT INTO `t_logs` VALUES ('332', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524540735');
INSERT INTO `t_logs` VALUES ('333', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524541213');
INSERT INTO `t_logs` VALUES ('334', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524541317');
INSERT INTO `t_logs` VALUES ('335', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524541475');
INSERT INTO `t_logs` VALUES ('336', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524541695');
INSERT INTO `t_logs` VALUES ('337', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524542011');
INSERT INTO `t_logs` VALUES ('338', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524542844');
INSERT INTO `t_logs` VALUES ('339', '删除文章', '15', '1', '0:0:0:0:0:0:0:1', '1524543236');
INSERT INTO `t_logs` VALUES ('340', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524543553');
INSERT INTO `t_logs` VALUES ('341', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524544191');
INSERT INTO `t_logs` VALUES ('342', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524544672');
INSERT INTO `t_logs` VALUES ('343', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524544796');
INSERT INTO `t_logs` VALUES ('344', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524545117');
INSERT INTO `t_logs` VALUES ('345', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524545413');
INSERT INTO `t_logs` VALUES ('346', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524545560');
INSERT INTO `t_logs` VALUES ('347', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524545839');
INSERT INTO `t_logs` VALUES ('348', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524546984');
INSERT INTO `t_logs` VALUES ('349', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524547117');
INSERT INTO `t_logs` VALUES ('350', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524547992');
INSERT INTO `t_logs` VALUES ('351', '删除页面', '16', '1', '0:0:0:0:0:0:0:1', '1524548084');
INSERT INTO `t_logs` VALUES ('352', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524548310');
INSERT INTO `t_logs` VALUES ('353', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524548323');
INSERT INTO `t_logs` VALUES ('354', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524548432');
INSERT INTO `t_logs` VALUES ('355', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524548527');
INSERT INTO `t_logs` VALUES ('356', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524548579');
INSERT INTO `t_logs` VALUES ('357', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549128');
INSERT INTO `t_logs` VALUES ('358', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524549194');
INSERT INTO `t_logs` VALUES ('359', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549202');
INSERT INTO `t_logs` VALUES ('360', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549209');
INSERT INTO `t_logs` VALUES ('361', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549377');
INSERT INTO `t_logs` VALUES ('362', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524549440');
INSERT INTO `t_logs` VALUES ('363', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549446');
INSERT INTO `t_logs` VALUES ('364', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549455');
INSERT INTO `t_logs` VALUES ('365', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549568');
INSERT INTO `t_logs` VALUES ('366', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549578');
INSERT INTO `t_logs` VALUES ('367', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549782');
INSERT INTO `t_logs` VALUES ('368', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524549802');
INSERT INTO `t_logs` VALUES ('369', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524550060');
INSERT INTO `t_logs` VALUES ('370', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524550441');
INSERT INTO `t_logs` VALUES ('371', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524550510');
INSERT INTO `t_logs` VALUES ('372', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524552100');
INSERT INTO `t_logs` VALUES ('373', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524552784');
INSERT INTO `t_logs` VALUES ('374', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524552787');
INSERT INTO `t_logs` VALUES ('375', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524552941');
INSERT INTO `t_logs` VALUES ('376', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524553104');
INSERT INTO `t_logs` VALUES ('377', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524553107');
INSERT INTO `t_logs` VALUES ('378', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524553189');
INSERT INTO `t_logs` VALUES ('379', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524553199');
INSERT INTO `t_logs` VALUES ('380', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524553292');
INSERT INTO `t_logs` VALUES ('381', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524554107');
INSERT INTO `t_logs` VALUES ('382', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524554109');
INSERT INTO `t_logs` VALUES ('383', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524554282');
INSERT INTO `t_logs` VALUES ('384', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524554324');
INSERT INTO `t_logs` VALUES ('385', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524554665');
INSERT INTO `t_logs` VALUES ('386', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524554697');
INSERT INTO `t_logs` VALUES ('387', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524554700');
INSERT INTO `t_logs` VALUES ('388', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524554770');
INSERT INTO `t_logs` VALUES ('389', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524554886');
INSERT INTO `t_logs` VALUES ('390', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524554916');
INSERT INTO `t_logs` VALUES ('391', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524554957');
INSERT INTO `t_logs` VALUES ('392', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524555170');
INSERT INTO `t_logs` VALUES ('393', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524555225');
INSERT INTO `t_logs` VALUES ('394', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524555265');
INSERT INTO `t_logs` VALUES ('395', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524555292');
INSERT INTO `t_logs` VALUES ('396', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524555611');
INSERT INTO `t_logs` VALUES ('397', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524555937');
INSERT INTO `t_logs` VALUES ('398', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524555940');
INSERT INTO `t_logs` VALUES ('399', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524556081');
INSERT INTO `t_logs` VALUES ('400', '系统备份', null, '1', '0:0:0:0:0:0:0:1', '1524556183');
INSERT INTO `t_logs` VALUES ('401', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524556751');
INSERT INTO `t_logs` VALUES ('402', '修改个人信息', '{\"uid\":1,\"email\":\"1025103647@qq.com\",\"screenName\":\"admin\"}', '1', '0:0:0:0:0:0:0:1', '1524556757');
INSERT INTO `t_logs` VALUES ('403', '修改密码', null, '1', '0:0:0:0:0:0:0:1', '1524556770');
INSERT INTO `t_logs` VALUES ('404', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524556819');
INSERT INTO `t_logs` VALUES ('405', '修改密码', null, '1', '0:0:0:0:0:0:0:1', '1524556834');
INSERT INTO `t_logs` VALUES ('406', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524556844');
INSERT INTO `t_logs` VALUES ('407', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524561428');
INSERT INTO `t_logs` VALUES ('408', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524561458');
INSERT INTO `t_logs` VALUES ('409', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524561549');
INSERT INTO `t_logs` VALUES ('410', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524562143');
INSERT INTO `t_logs` VALUES ('411', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524563409');
INSERT INTO `t_logs` VALUES ('412', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524586933');
INSERT INTO `t_logs` VALUES ('413', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524589254');
INSERT INTO `t_logs` VALUES ('414', '删除文章', '18', '1', '0:0:0:0:0:0:0:1', '1524595263');
INSERT INTO `t_logs` VALUES ('415', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524756484');
INSERT INTO `t_logs` VALUES ('416', '删除文章', '/spmbkuqooai26o0vl3ecm0p15e.jpg', '1', '0:0:0:0:0:0:0:1', '1524759054');
INSERT INTO `t_logs` VALUES ('417', '删除页面', '17', '1', '0:0:0:0:0:0:0:1', '1524759447');
INSERT INTO `t_logs` VALUES ('418', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1524801725');
INSERT INTO `t_logs` VALUES ('419', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1525595450');
INSERT INTO `t_logs` VALUES ('420', '登录后台', null, '1', '0:0:0:0:0:0:0:1', '1525603058');

-- ----------------------------
-- Table structure for t_metas
-- ----------------------------
DROP TABLE IF EXISTS `t_metas`;
CREATE TABLE `t_metas` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `type` varchar(32) NOT NULL DEFAULT '',
  `description` varchar(200) DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`mid`),
  KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_metas
-- ----------------------------
INSERT INTO `t_metas` VALUES ('1', 'default', null, 'category', null, '0', '0');
INSERT INTO `t_metas` VALUES ('6', 'my github', 'https://github.com/Panweitong', 'link', 'http://www.54tianzhisheng.cn/img/avatar.png', '1', '0');
INSERT INTO `t_metas` VALUES ('7', 'my website', 'https://743921382.mylightsite.com', 'link', 'http://www.54tianzhisheng.cn/img/avatar.png', '0', '0');
INSERT INTO `t_metas` VALUES ('9', 'Java', 'Java', 'tag', null, '0', '0');
INSERT INTO `t_metas` VALUES ('10', 'Java', 'Java', 'category', '有关Java的博客', '0', '0');
INSERT INTO `t_metas` VALUES ('15', 'Pyspider', 'Pyspider', 'tag', null, '0', '0');
INSERT INTO `t_metas` VALUES ('16', 'Python', 'Python', 'tag', null, '0', '0');
INSERT INTO `t_metas` VALUES ('17', '爬虫', '爬虫', 'tag', null, '0', '0');
INSERT INTO `t_metas` VALUES ('19', 'Python', 'Python', 'category', '有关Python的博客', '0', '0');
INSERT INTO `t_metas` VALUES ('20', '随笔', null, 'category', null, '0', '0');
INSERT INTO `t_metas` VALUES ('22', '爬虫', null, 'category', null, '0', '0');
INSERT INTO `t_metas` VALUES ('23', '默认分类', '默认分类', 'category', null, '0', '0');

-- ----------------------------
-- Table structure for t_options
-- ----------------------------
DROP TABLE IF EXISTS `t_options`;
CREATE TABLE `t_options` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `value` varchar(1000) DEFAULT '',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_options
-- ----------------------------
INSERT INTO `t_options` VALUES ('allow_install', '', '');
INSERT INTO `t_options` VALUES ('site_description', 'Spring+SpringMVC+MyBatis+thymeleaf 搭建的 Java 博客系统', null);
INSERT INTO `t_options` VALUES ('site_keywords', 'Blog', null);
INSERT INTO `t_options` VALUES ('site_theme', 'default', null);
INSERT INTO `t_options` VALUES ('site_title', 'Blog', '');
INSERT INTO `t_options` VALUES ('social_github', 'https://github.com/Panweitong', null);
INSERT INTO `t_options` VALUES ('social_twitter', '', null);
INSERT INTO `t_options` VALUES ('social_weibo', 'https://weibo.com/u/2344829772?refer_flag=1001030201_&is_hot=1', null);
INSERT INTO `t_options` VALUES ('social_zhihu', '', null);

-- ----------------------------
-- Table structure for t_relationships
-- ----------------------------
DROP TABLE IF EXISTS `t_relationships`;
CREATE TABLE `t_relationships` (
  `cid` int(10) unsigned NOT NULL,
  `mid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cid`,`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_relationships
-- ----------------------------
INSERT INTO `t_relationships` VALUES ('5', '15');
INSERT INTO `t_relationships` VALUES ('5', '16');
INSERT INTO `t_relationships` VALUES ('5', '17');
INSERT INTO `t_relationships` VALUES ('5', '19');
INSERT INTO `t_relationships` VALUES ('7', '16');
INSERT INTO `t_relationships` VALUES ('7', '17');
INSERT INTO `t_relationships` VALUES ('7', '19');
INSERT INTO `t_relationships` VALUES ('7', '22');
INSERT INTO `t_relationships` VALUES ('10', '9');
INSERT INTO `t_relationships` VALUES ('10', '10');

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `home_url` varchar(200) DEFAULT NULL,
  `screen_name` varchar(32) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `activated` int(10) unsigned DEFAULT '0',
  `logged` int(10) unsigned DEFAULT '0',
  `group_name` varchar(16) DEFAULT 'visitor',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`username`),
  UNIQUE KEY `mail` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'a66abb5684c45962d887564f08346e8d', '1025103647@qq.com', null, 'admin', '1490756162', '0', '0', 'visitor');
