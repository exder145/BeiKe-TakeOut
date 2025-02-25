SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = utf8mb4_unicode_ci;
SET collation_database = utf8mb4_unicode_ci;
SET collation_server = utf8mb4_unicode_ci;
SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_database = utf8mb4;
SET character_set_results = utf8mb4;
SET character_set_server = utf8mb4;
DROP DATABASE IF EXISTS appDB;
CREATE DATABASE appDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE appDB;
CREATE TABLE `ADMIN_USER`(
    `username` CHAR(15) PRIMARY KEY,
    `password` CHAR(12) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
INSERT INTO `ADMIN_USER`
VALUES ('root', '12345678');
SELECT *
FROM ADMIN_USER;
CREATE TABLE `CUSTOMER`(
    `username` CHAR(15) PRIMARY KEY,
    `password` CHAR(12) NOT NULL,
    `address` VARCHAR(30) NOT NULL,
    `phone` CHAR(15) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
INSERT INTO `CUSTOMER`
VALUES ('用户', '1111123', '贝壳学生宿舍', '12365478966'),
    ('用户2', '1111222', '贝壳居民区', '4586248596');
SELECT *
FROM CUSTOMER;
CREATE TABLE `RESTAURANT`(
    `username` CHAR(15) PRIMARY KEY,
    `password` CHAR(12) NOT NULL,
    `address` VARCHAR(30) NOT NULL,
    `phone` CHAR(15) NOT NULL,
    `img_res` VARCHAR(50)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
INSERT INTO `RESTAURANT`
VALUES (
        '老北京炸酱面',
        '77777777',
        '北京市东城区簋街东口胡同11号',
        '1314074',
        '/static/images/restaurant/beijing_noodle.jpg'
    ),
    (
        '四季民福烤鸭',
        '88888888',
        '北京市西城区前门大街甲2号',
        '1884801',
        '/static/images/restaurant/duck.jpg'
    );
SELECT *
FROM RESTAURANT;
CREATE TABLE `DISHES`(
    `dishname` CHAR(15) PRIMARY KEY,
    `restaurant` CHAR(15) NOT NULL,
    `dishinfo` VARCHAR(50),
    `nutriention` VARCHAR(30),
    `price` DECIMAL(5, 2) NOT NULL,
    `sales` INT(5) NOT NULL,
    `imgsrc` VARCHAR(50),
    `isSpecialty` BOOLEAN,
    FOREIGN KEY (restaurant) REFERENCES RESTAURANT(username)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
INSERT INTO DISHES
VALUES (
        '老北京炸酱面',
        '老北京炸酱面',
        '正宗北京风味，黄豆酱炸制，搭配新鲜面条',
        '碳水化合物，蛋白质',
        16.00,
        0,
        '/static/images/dishes/zhajiang.jpg',
        1
    ),
    (
        '茄子炖土豆',
        '老北京炸酱面',
        '地道老北京家常菜，软烂入味',
        '膳食纤维，维生素',
        22.00,
        0,
        '/static/images/dishes/eggplant.jpg',
        0
    ),
    (
        '京酱肉丝',
        '老北京炸酱面',
        '甜咸适中，配上新鲜韭黄，口感一流',
        '蛋白质，维生素',
        28.00,
        0,
        '/static/images/dishes/shredpork.jpg',
        1
    ),
    (
        '烤鸭全鸭',
        '四季民福烤鸭',
        '果木炭火烤制，皮酥肉嫩，配送专用甜面酱',
        '蛋白质，维生素',
        168.00,
        0,
        '/static/images/dishes/roastduck.jpg',
        1
    ),
    (
        '白灼菜心',
        '四季民福烤鸭',
        '新鲜时蔬，清淡爽口，开胃解腻',
        '膳食纤维，维生素',
        26.00,
        0,
        '/static/images/dishes/vegetables.jpg',
        0
    ),
    (
        '鸭骨汤',
        '四季民福烤鸭',
        '原汤原味，浓郁鲜美，配送葱花香菜',
        '钙质，胶原蛋白',
        18.00,
        0,
        '/static/images/dishes/ducksoup.jpg',
        0
    );
SELECT *
FROM DISHES;
CREATE TABLE `SHOPPINGCART`(
    `username` CHAR(15),
    `restaurant` CHAR(15),
    `dishname` CHAR(15),
    `price` DECIMAL(5, 2) NOT NULL,
    `img_res` VARCHAR(50),
    FOREIGN KEY (username) REFERENCES CUSTOMER(username),
    FOREIGN KEY (restaurant) REFERENCES RESTAURANT(username),
    FOREIGN KEY (dishname) REFERENCES DISHES(dishname),
    PRIMARY KEY (username, restaurant, dishname)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
INSERT INTO `SHOPPINGCART`
VALUES (
        'lonelyprince7',
        '四季民福烤鸭',
        '烤鸭全鸭',
        168.00,
        '/static/images/dishes/roastduck.jpg'
    );
SELECT *
FROM SHOPPINGCART;
CREATE TABLE `ORDER_COMMENT`(
    `orderID` CHAR(15) PRIMARY KEY,
    `username` CHAR(15) NOT NULL,
    `restaurant` VARCHAR(15) NOT NULL,
    `isFinished` BOOLEAN,
    CHECK(
        isFinished = 1
        or isFinished = 0
    ),
    `cost` DECIMAL(5, 2) NOT NULL,
    `c_rank` TINYINT(1),
    CHECK(
        c_rank BETWEEN 1 AND 5
    ),
    `text` VARCHAR(50),
    `transactiontime` TIMESTAMP(0) NOT NULL,
    CHECK(
        transactiontime BETWEEN '1970-01-01 00:00:01' AND '2038-01-19 03:14:07'
    ),
    FOREIGN KEY (username) REFERENCES CUSTOMER(username),
    FOREIGN KEY (restaurant) REFERENCES RESTAURANT(username)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
INSERT INTO ORDER_COMMENT
VALUES (
        '1444000',
        'lonelyprince7',
        '老北京炸酱面',
        1,
        16.00,
        5,
        '炸酱面非常正宗，面条劲道，炸酱香浓',
        '2020-11-7 13:14:07'
    ),
    (
        '1445000',
        'lonelyprince7',
        '四季民福烤鸭',
        1,
        168.00,
        4,
        '烤鸭皮酥肉嫩，配菜新鲜，就是价格稍贵',
        '2020-10-13 20:29:13'
    ),
    (
        '1446000',
        '小张',
        '老北京炸酱面',
        0,
        28.00,
        5,
        '京酱肉丝做得地道，搭配韭黄很香',
        '2020-10-27 15:45:21'
    );
SELECT *
FROM ORDER_COMMENT;
CREATE TABLE `USER_FEEDBACK` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` CHAR(15),
    `dish_name` VARCHAR(50),
    `restaurant` VARCHAR(50),
    `action` ENUM('like', 'dislike'),
    `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;