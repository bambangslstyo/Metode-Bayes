/*
 Navicat Premium Data Transfer

 Source Server         : Bambang
 Source Server Type    : MySQL
 Source Server Version : 100119
 Source Host           : localhost:3306
 Source Schema         : dbbayes

 Target Server Type    : MySQL
 Target Server Version : 100119
 File Encoding         : 65001

 Date: 18/02/2018 21:01:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbdiagnosa
-- ----------------------------
DROP TABLE IF EXISTS `tbdiagnosa`;
CREATE TABLE `tbdiagnosa`  (
  `kdPenyakit` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bobot` double NULL DEFAULT NULL,
  `kdGejala` int(5) NULL DEFAULT NULL,
  `bobotRule` double NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbgejala
-- ----------------------------
DROP TABLE IF EXISTS `tbgejala`;
CREATE TABLE `tbgejala`  (
  `kdGejala` int(5) NOT NULL AUTO_INCREMENT,
  `nmGejala` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kdGejala`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbgejala
-- ----------------------------
INSERT INTO `tbgejala` VALUES (1, 'Panas');
INSERT INTO `tbgejala` VALUES (2, 'Sakit Kepala');
INSERT INTO `tbgejala` VALUES (3, 'Bersin');
INSERT INTO `tbgejala` VALUES (4, 'Batuk');
INSERT INTO `tbgejala` VALUES (5, 'Pilek, Hidung Buntu');
INSERT INTO `tbgejala` VALUES (6, 'Badan Lemas');
INSERT INTO `tbgejala` VALUES (7, 'Kedinginan');

-- ----------------------------
-- Table structure for tbhasil
-- ----------------------------
DROP TABLE IF EXISTS `tbhasil`;
CREATE TABLE `tbhasil`  (
  `kdPenyakit` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perkalian` double(5, 4) NULL DEFAULT NULL,
  `hasil` double(5, 4) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tbpenyakit
-- ----------------------------
DROP TABLE IF EXISTS `tbpenyakit`;
CREATE TABLE `tbpenyakit`  (
  `kdPenyakit` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmPenyakit` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bobot` double NULL DEFAULT NULL,
  PRIMARY KEY (`kdPenyakit`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbpenyakit
-- ----------------------------
INSERT INTO `tbpenyakit` VALUES ('A', 'Anemia', 0.5);
INSERT INTO `tbpenyakit` VALUES ('B', 'Bronkhitis', 0.6);
INSERT INTO `tbpenyakit` VALUES ('D', 'Demam', 0.6);
INSERT INTO `tbpenyakit` VALUES ('F', 'Flu', 0.7);

-- ----------------------------
-- Table structure for tbrule
-- ----------------------------
DROP TABLE IF EXISTS `tbrule`;
CREATE TABLE `tbrule`  (
  `idRule` int(5) NOT NULL AUTO_INCREMENT,
  `kdPenyakit` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdGejala` int(5) NULL DEFAULT NULL,
  `bobotRule` double NOT NULL,
  PRIMARY KEY (`idRule`) USING BTREE,
  INDEX `fk_kdPenyakit`(`kdPenyakit`) USING BTREE,
  INDEX `fk_kdGejala`(`kdGejala`) USING BTREE,
  CONSTRAINT `fk_kdGejala` FOREIGN KEY (`kdGejala`) REFERENCES `tbgejala` (`kdGejala`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kdPenyakit` FOREIGN KEY (`kdPenyakit`) REFERENCES `tbpenyakit` (`kdPenyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tbrule
-- ----------------------------
INSERT INTO `tbrule` VALUES (1, 'A', 1, 0.2);
INSERT INTO `tbrule` VALUES (2, 'A', 2, 0.9);
INSERT INTO `tbrule` VALUES (3, 'A', 3, 0.2);
INSERT INTO `tbrule` VALUES (4, 'A', 4, 0.2);
INSERT INTO `tbrule` VALUES (5, 'A', 5, 0.2);
INSERT INTO `tbrule` VALUES (6, 'A', 6, 0.95);
INSERT INTO `tbrule` VALUES (7, 'A', 7, 0.2);
INSERT INTO `tbrule` VALUES (8, 'B', 1, 0.7);
INSERT INTO `tbrule` VALUES (9, 'B', 2, 0.1);
INSERT INTO `tbrule` VALUES (10, 'B', 3, 0.7);
INSERT INTO `tbrule` VALUES (11, 'B', 4, 0.9);
INSERT INTO `tbrule` VALUES (12, 'B', 5, 0.3);
INSERT INTO `tbrule` VALUES (13, 'B', 6, 0.3);
INSERT INTO `tbrule` VALUES (14, 'B', 7, 0.2);
INSERT INTO `tbrule` VALUES (15, 'D', 1, 0.7);
INSERT INTO `tbrule` VALUES (16, 'D', 2, 0.2);
INSERT INTO `tbrule` VALUES (17, 'D', 3, 0.2);
INSERT INTO `tbrule` VALUES (18, 'D', 4, 0.2);
INSERT INTO `tbrule` VALUES (19, 'D', 5, 0.2);
INSERT INTO `tbrule` VALUES (20, 'D', 6, 0.7);
INSERT INTO `tbrule` VALUES (21, 'D', 7, 0.9);
INSERT INTO `tbrule` VALUES (22, 'F', 1, 6);
INSERT INTO `tbrule` VALUES (23, 'F', 2, 0.5);
INSERT INTO `tbrule` VALUES (24, 'F', 3, 0.75);
INSERT INTO `tbrule` VALUES (25, 'F', 4, 0.2);
INSERT INTO `tbrule` VALUES (26, 'F', 5, 0.9);
INSERT INTO `tbrule` VALUES (27, 'F', 6, 0.3);
INSERT INTO `tbrule` VALUES (28, 'F', 7, 0.5);

SET FOREIGN_KEY_CHECKS = 1;
