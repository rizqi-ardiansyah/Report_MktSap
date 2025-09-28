-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.27-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.4.0.6670
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
CREATE DATABASE IF NOT EXISTS `budget_hmmi` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
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
  `n0_amountSales` int(11) DEFAULT NULL,
  `difference` decimal(10,3) DEFAULT NULL,
  `n_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n_amountSales` int(11) DEFAULT NULL,
  `n1_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n1_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n1_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n1_amountSales` int(11) DEFAULT NULL,
  `n2_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n2_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n2_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n2_amountSales` int(11) DEFAULT NULL,
  `n3_pcs_forecast` decimal(15,3) DEFAULT NULL,
  `n3_kg_forecast` decimal(15,3) DEFAULT NULL,
  `n3_amount_forecast` decimal(18,3) DEFAULT NULL,
  `n3_amountSales` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table budget_hmmi.budget_mat: ~12 rows (approximately)
DELETE FROM `budget_mat`;
INSERT INTO `budget_mat` (`id`, `month`, `nokol`, `model`, `tipe`, `name`, `total_item`, `n0_pcs_forecast`, `n0_kg_forecast`, `n0_amount_forecast`, `n0_pcs_act`, `n0_kg_act`, `n0_amount_act`, `n0_amountSales`, `difference`, `n_pcs_forecast`, `n_kg_forecast`, `n_amount_forecast`, `n_amountSales`, `n1_pcs_forecast`, `n1_kg_forecast`, `n1_amount_forecast`, `n1_amountSales`, `n2_pcs_forecast`, `n2_kg_forecast`, `n2_amount_forecast`, `n2_amountSales`, `n3_pcs_forecast`, `n3_kg_forecast`, `n3_amount_forecast`, `n3_amountSales`) VALUES
	(1, 'Aug-25', 1, 'SU2ID', 1, 'Material', 19, 113861.000, 178246.000, 2671528.390, 111681.000, 176173.000, 2639241.000, 3139510, -0.010, 75332.000, 119241.000, 1783300.000, 4033389, 84044.000, 132689.000, 1989042.000, 2954814, 79721.000, 125711.000, 1884794.000, 2800776, 48716.000, 78732.000, 1176528.000, 1746865),
	(2, 'Aug-25', 1, 'SU2ID', 2, 'CKD PCS', 0, 223176.000, 0.000, 59868.000, 221803.000, 0.000, 57326.000, 0, -0.040, 151320.000, 0.000, 37836.000, 0, 163791.000, 0.000, 44503.000, 0, 155119.000, 0.000, 42462.000, 0, 91827.000, 0.000, 26031.000, 0),
	(3, 'Aug-25', 1, 'SU2ID', 3, 'CKD Transport', 0, 0.000, 0.000, 2244.000, 0.000, 0.000, 2141.000, 0, -0.050, 0.000, 0.000, 1361.000, 0, 0.000, 0.000, 1709.000, 0, 0.000, 0.000, 1635.000, 0, 0.000, 0.000, 1031.000, 0),
	(4, 'Aug-25', 2, 'KS', 1, 'Material', 7, 45234.000, 34049.000, 520791.000, 43309.000, 32605.000, 498131.000, 774501, -0.050, 20847.000, 15625.000, 245138.000, 373867, 28747.000, 21577.000, 337689.000, 514633, 26658.000, 19932.000, 312285.000, 475906, 30265.000, 22686.000, 355937.000, 542434),
	(5, 'Aug-25', 2, 'KS', 2, 'CKD PCS', 0, 40652.000, 0.000, 15850.000, 38811.000, 0.000, 15258.000, 0, -0.040, 20217.000, 0.000, 5797.000, 0, 26959.000, 0.000, 9009.000, 0, 25192.000, 0.000, 8032.000, 0, 29139.000, 0.000, 8698.000, 0),
	(6, 'Aug-25', 2, 'KS', 3, 'CKD Transport', 0, 0.000, 0.000, 824.000, 0.000, 0.000, 795.000, 0, -0.040, 0.000, 0.000, 265.000, 0, 0.000, 0.000, 443.000, 0, 0.000, 0.000, 387.000, 0, 0.000, 0.000, 406.000, 0),
	(7, 'Aug-25', 3, 'SU2ID FL', 1, 'Material', 7, 303855.000, 163275.000, 2698021.000, 301815.000, 160432.000, 2649879.000, 3771268, -0.020, 196305.000, 103902.000, 1715348.000, 4837471, 231473.000, 121963.000, 2019989.000, 3575133, 219770.000, 116007.000, 1921194.000, 3395894, 135848.000, 68481.000, 1145944.000, 2053143),
	(8, 'Aug-25', 3, 'SU2ID FL', 2, 'CKD PCS', 0, 195875.000, 0.000, 169661.000, 195191.000, 0.000, 168777.000, 0, -0.010, 130278.000, 0.000, 108134.000, 0, 150508.000, 0.000, 129073.000, 0, 141840.000, 0.000, 122414.000, 0, 91525.000, 0.000, 77489.000, 0),
	(9, 'Aug-25', 3, 'SU2ID FL', 3, 'CKD Transport', 0, 0.000, 0.000, 6766.000, 0.000, 0.000, 6746.000, 0, 0.000, 0.000, 0.000, 4384.000, 0, 0.000, 0.000, 5119.000, 0, 0.000, 0.000, 4840.000, 0, 0.000, 0.000, 3050.000, 0),
	(10, 'Aug-25', 4, 'KS-FL', 1, 'Material', 5, 23694.000, 17575.000, 274799.000, 23052.000, 17064.000, 266858.000, 428046, -0.030, 18828.000, 13926.000, 196148.000, 317358, 20190.000, 14970.000, 211083.000, 341335, 20010.000, 14837.000, 209202.000, 338292, 24900.000, 18463.000, 260326.000, 420963),
	(11, 'Aug-25', 4, 'KS-FL', 2, 'CKD PCS', 0, 20474.000, 0.000, 17732.000, 19828.000, 0.000, 17286.000, 0, -0.030, 16228.000, 0.000, 14117.000, 0, 17498.000, 0.000, 15101.000, 0, 17342.000, 0.000, 14966.000, 0, 21580.000, 0.000, 18624.000, 0),
	(12, 'Aug-25', 4, 'KS-FL', 3, 'CKD Transport', 0, 0.000, 0.000, 988.000, 0.000, 0.000, 968.000, 0, -0.020, 0.000, 0.000, 792.000, 0, 0.000, 0.000, 843.000, 0, 0.000, 0.000, 835.000, 0, 0.000, 0.000, 1039.000, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
