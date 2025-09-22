-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.33 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for budget_hmmi
DROP DATABASE IF EXISTS `budget_hmmi`;
CREATE DATABASE IF NOT EXISTS `budget_hmmi` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `budget_hmmi`;

-- Dumping structure for table budget_hmmi.budget_mat
DROP TABLE IF EXISTS `budget_mat`;
CREATE TABLE IF NOT EXISTS `budget_mat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` varchar(10) NOT NULL,
  `nokol` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `tipe` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `total_item` int(11) NOT NULL,
  `n0_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n0_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n0_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n0_pcs_act` decimal(15,3) DEFAULT NULL,
  `n0_kg_act` decimal(15,3) DEFAULT NULL,
  `n0_amount_act` decimal(18,3) DEFAULT NULL,
  `difference` decimal(10,3) DEFAULT NULL,
  `n_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n1_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n1_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n1_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n2_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n2_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n2_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n3_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n3_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n3_amount_forecast` decimal(18,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table budget_hmmi.budget_mat: ~12 rows (approximately)
INSERT INTO `budget_mat` (`id`, `month`, `nokol`, `model`, `tipe`, `name`, `total_item`, `n0_pcs_forecast`, `n0_kg_forecast`, `n0_amount_forecast`, `n0_pcs_act`, `n0_kg_act`, `n0_amount_act`, `difference`, `n_pcs_forecast`, `n_kg_forecast`, `n_amount_forecast`, `n1_pcs_forecast`, `n1_kg_forecast`, `n1_amount_forecast`, `n2_pcs_forecast`, `n2_kg_forecast`, `n2_amount_forecast`, `n3_pcs_forecast`, `n3_kg_forecast`, `n3_amount_forecast`) VALUES
	(1, 'Aug-25', 1, 'KS', 1, 'Material', 7, 43465.000, 32855.934, 508664.398, 46260.000, 34972.377, 541174.348, 0.060, 45964.000, 34514.090, 539475.327, 22772.000, 17068.822, 267978.498, 28747.000, 21576.759, 337689.318, 26568.000, 19932.352, 312285.161),
	(2, 'Aug-25', 1, 'KS', 2, 'CKD PCS', 7, 35923.000, 0.000, 17800.991, 38028.000, 0.000, 19153.168, 0.071, 42538.000, 0.000, 15021.914, 22058.000, 0.000, 6389.799, 26959.000, 0.000, 9009.327, 25192.000, 0.000, 8031.576),
	(3, 'Aug-25', 1, 'KS', 3, 'CKD Transport', 7, 35923.000, 0.000, 1049.748, 38028.000, 0.000, 1134.220, 0.074, 42538.000, 0.000, 754.688, 22058.000, 0.000, 293.831, 26959.000, 0.000, 442.696, 25192.000, 0.000, 386.704),
	(4, 'Aug-25', 2, 'KS-FL', 1, 'Material', 5, 7446.000, 5514.362, 86421.777, 6762.000, 5031.812, 79054.839, -0.093, 29490.000, 21865.918, 342081.394, 19470.000, 14436.397, 225850.277, 20190.000, 14970.254, 234202.216, 20010.000, 14836.793, 232114.231),
	(5, 'Aug-25', 2, 'KS-FL', 2, 'CKD PCS', 5, 6514.000, 0.000, 5278.442, 6102.000, 0.000, 4737.638, -0.114, 25558.000, 0.000, 22056.554, 16874.000, 0.000, 14562.262, 17498.000, 0.000, 15100.774, 17342.000, 0.000, 14966.146),
	(6, 'Aug-25', 2, 'KS-FL', 3, 'CKD Transport', 5, 6514.000, 0.000, 311.348, 6102.000, 0.000, 277.144, -0.123, 25558.000, 0.000, 1230.716, 16874.000, 0.000, 812.548, 17498.000, 0.000, 842.596, 17342.000, 0.000, 835.084),
	(7, 'Aug-25', 3, 'SU2ID', 1, 'Material', 19, 124532.000, 187574.153, 2813448.615, 112589.000, 175627.198, 2628931.853, -0.070, 91340.000, 143236.355, 2145226.530, 104753.000, 164436.769, 2461784.499, 83984.000, 132662.111, 1988576.061, 79721.000, 125710.971, 1884794.278),
	(8, 'Aug-25', 3, 'SU2ID', 2, 'CKD PCS', 19, 232623.000, 0.000, 64511.808, 217903.000, 0.000, 60719.539, -0.062, 178924.000, 0.000, 47903.362, 206249.000, 0.000, 54667.803, 163745.000, 0.000, 44490.583, 155119.000, 0.000, 42461.771),
	(9, 'Aug-25', 3, 'SU2ID', 3, 'CKD Transport', 19, 232623.000, 0.000, 2342.919, 217903.000, 0.000, 2210.001, -0.060, 178924.000, 0.000, 1781.736, 206249.000, 0.000, 2005.767, 163745.000, 0.000, 1708.971, 155119.000, 0.000, 1634.709),
	(10, 'Aug-25', 4, 'SU2ID FL', 1, 'Material', 7, 303855.000, 161025.399, 2665620.423, 286994.000, 152313.753, 2521018.608, -0.057, 240650.000, 128602.010, 2126718.801, 272878.000, 145892.634, 2411265.129, 231473.000, 123274.476, 2042147.577, 219770.000, 117259.265, 1942332.079),
	(11, 'Aug-25', 4, 'SU2ID FL', 2, 'CKD PCS', 7, 159228.000, 0.000, 163278.777, 150430.000, 0.000, 152382.142, -0.072, 123950.000, 0.000, 127682.033, 141687.000, 0.000, 144414.067, 117461.000, 0.000, 123760.496, 110776.000, 0.000, 117484.996),
	(12, 'Aug-25', 4, 'SU2ID FL', 3, 'CKD Transport', 7, 159228.000, 0.000, 6733.008, 150430.000, 0.000, 6292.122, -0.070, 123950.000, 0.000, 5303.247, 141687.000, 0.000, 6023.733, 117461.000, 0.000, 5089.818, 110776.000, 0.000, 4821.126);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
