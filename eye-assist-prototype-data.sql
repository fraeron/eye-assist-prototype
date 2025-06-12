-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2025 at 05:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `prototype`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp(),
  `failed_attempts` int(11) DEFAULT 0,
  `lock_until` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `email`, `last_login`, `failed_attempts`, `lock_until`) VALUES
(1, 'michael', '$2y$10$D9nhIOgEGidavYNZdMKnFe8JQsWjYhp0RJq1qcNalk87uN/Z3V.Z2', 'michael@test_iswear.com', '2025-05-19 05:06:39', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `allowed_ip`
--

CREATE TABLE `allowed_ip` (
  `allowed` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `allowed_ip`
--

INSERT INTO `allowed_ip` (`allowed`) VALUES
('192.168.18.21'),
('127.0.0.1'),
('::1'),
(': :1');

-- --------------------------------------------------------

--
-- Table structure for table `api_tokens`
--

CREATE TABLE `api_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_tokens`
--

INSERT INTO `api_tokens` (`id`, `user_id`, `token`, `created_at`, `expires_at`) VALUES
(1, 1, '23ac4cb86144a0b981a5ac757e35ee1c28d1c5ccf4b7b359c86b16169bd3fecb', '2025-06-12 08:41:02', '2025-06-12 10:41:02'),
(2, 1, '348f8129cb46cfcb619f323a542b810dd74dab6e189e1d8b9c595d9cde5a0c1e', '2025-06-12 08:53:39', '2025-06-12 10:53:39'),
(3, 1, '6cb4eb8d187f0ae7cad487d9b3a331cb590a319251d333107081e0a0acf23563', '2025-06-12 09:13:21', '2025-06-12 11:13:21'),
(4, 1, '8dfa7ac17910d648aaf3f46d03299bbb5a690c68f807a18c06a69b3c8beb3df4', '2025-06-12 09:17:34', '2025-06-12 11:17:34'),
(5, 1, '973f70cb27e39d9326af103bcfa65b8de889c329a3239794b0cb56dc68561b96', '2025-06-12 09:23:25', '2025-06-12 11:23:25'),
(6, 1, '7edf52324d828578f759849e2aee897a1a4cd473ce672a6e16f5cfdce4dedc72', '2025-06-12 09:25:40', '2025-06-12 11:25:40'),
(7, 1, '6f7546b9ffb7e8b93d38fd2e61289562c6e2c16bd2a867411e0e5a94db0e9ee9', '2025-06-12 09:31:29', '2025-06-12 11:31:29'),
(8, 1, '1d9937103d88dcd79b517e1617e96d64b8eb66abc2c9c2123e22ef6fb83d6e6a', '2025-06-12 09:32:31', '2025-06-12 11:32:31'),
(9, 1, '56623d3b2fcca74c9f5afc208d01914fd4447276d37f20f327eb4bf3055322a3', '2025-06-12 09:37:54', '2025-06-12 11:37:54'),
(10, 1, '5f35eea2e0c5e947ef72cdef9ed9a1fde36e98d2911f816fd61ce969161425ef', '2025-06-12 09:41:19', '2025-06-12 11:41:19');

-- --------------------------------------------------------

--
-- Table structure for table `mfa_tokens`
--

CREATE TABLE `mfa_tokens` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `token` varchar(6) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mfa_tokens`
--

INSERT INTO `mfa_tokens` (`id`, `admin_id`, `token`, `created_at`, `expires_at`) VALUES
(1, 1, '336111', '2025-05-19 05:21:17', '2025-05-19 07:31:17'),
(2, 1, '884674', '2025-05-19 06:36:53', '2025-05-19 08:46:53'),
(3, 1, '918880', '2025-05-19 07:11:30', '2025-05-19 09:21:30'),
(4, 1, '656196', '2025-05-19 07:24:23', '2025-05-19 09:34:23'),
(5, 1, '649513', '2025-05-19 07:25:31', '2025-05-19 09:35:31'),
(6, 1, '506528', '2025-05-19 07:25:46', '2025-05-19 09:35:46'),
(7, 1, '722400', '2025-05-19 07:26:35', '2025-05-19 09:36:35'),
(8, 1, '890708', '2025-05-19 07:28:23', '2025-05-19 09:38:23'),
(9, 1, '141096', '2025-05-19 07:29:10', '2025-05-19 09:39:10'),
(10, 1, '262121', '2025-05-19 07:29:57', '2025-05-19 09:39:57'),
(11, 1, '799165', '2025-05-19 07:30:24', '2025-05-19 09:40:24'),
(12, 1, '648980', '2025-05-19 07:33:18', '2025-05-19 09:43:18'),
(13, 1, '940152', '2025-05-19 08:38:35', '2025-05-19 10:48:35'),
(14, 1, '652216', '2025-05-19 08:45:35', '2025-05-19 10:55:35'),
(15, 1, '662039', '2025-05-19 08:46:53', '2025-05-19 10:56:53'),
(16, 1, '166141', '2025-05-19 08:51:07', '2025-05-19 11:01:07'),
(17, 1, '145855', '2025-05-19 09:02:54', '2025-05-19 11:12:54'),
(18, 1, '764550', '2025-05-19 09:06:36', '2011-11-17 05:10:00'),
(19, 1, '667323', '2025-05-19 09:07:05', '2025-05-19 11:12:00'),
(20, 1, '394769', '2025-05-19 09:09:04', '2025-05-19 11:11:04'),
(21, 1, '755228', '2025-05-19 09:10:18', '2025-05-19 11:12:18'),
(22, 1, '345850', '2025-05-19 09:10:57', '2025-05-19 11:12:57'),
(23, 1, '247406', '2025-05-19 09:11:18', '0000-00-00 00:00:00'),
(24, 1, '114604', '2025-05-19 09:12:12', '2025-05-19 11:14:12'),
(25, 1, '472514', '2025-05-19 09:13:41', '2025-05-19 17:15:41'),
(26, 1, '203624', '2025-05-20 01:24:57', '2025-05-20 09:26:57'),
(27, 1, '939399', '2025-05-20 01:35:51', '2025-05-20 09:37:51'),
(28, 1, '858213', '2025-05-20 01:38:03', '2025-05-20 09:40:03'),
(29, 1, '811302', '2025-06-11 07:33:26', '2025-06-11 15:35:26'),
(30, 1, '772103', '2025-06-11 13:03:04', '2025-06-11 21:05:04'),
(31, 1, '912390', '2025-06-11 13:03:13', '2025-06-11 21:05:13'),
(32, 1, '812226', '2025-06-11 13:05:37', '2025-06-11 21:07:37'),
(33, 1, '821977', '2025-06-12 06:12:23', '2025-06-12 14:14:23'),
(34, 1, '621461', '2025-06-12 06:15:35', '2025-06-12 14:17:35'),
(35, 1, '963377', '2025-06-12 06:15:37', '2025-06-12 14:17:37'),
(36, 1, '515935', '2025-06-12 06:15:38', '2025-06-12 14:17:38'),
(37, 1, '598839', '2025-06-12 06:15:38', '2025-06-12 14:17:38'),
(38, 1, '953437', '2025-06-12 06:15:38', '2025-06-12 14:17:38'),
(39, 1, '503722', '2025-06-12 06:15:38', '2025-06-12 14:17:38'),
(40, 1, '205191', '2025-06-12 06:15:38', '2025-06-12 14:17:38'),
(41, 1, '510610', '2025-06-12 06:15:38', '2025-06-12 14:17:38'),
(42, 1, '334197', '2025-06-12 06:15:39', '2025-06-12 14:17:39'),
(43, 1, '249176', '2025-06-12 06:15:39', '2025-06-12 14:17:39'),
(44, 1, '824592', '2025-06-12 06:15:39', '2025-06-12 14:17:39'),
(45, 1, '679501', '2025-06-12 06:15:57', '2025-06-12 14:17:57'),
(46, 1, '620080', '2025-06-12 06:16:00', '2025-06-12 14:18:00'),
(47, 1, '715874', '2025-06-12 06:16:00', '2025-06-12 14:18:00'),
(48, 1, '705057', '2025-06-12 06:16:00', '2025-06-12 14:18:00'),
(49, 1, '581652', '2025-06-12 06:16:01', '2025-06-12 14:18:01'),
(50, 1, '131314', '2025-06-12 06:19:05', '2025-06-12 14:21:05'),
(51, 1, '862848', '2025-06-12 06:20:16', '2025-06-12 14:22:16'),
(52, 1, '604434', '2025-06-12 06:20:22', '2025-06-12 14:22:22'),
(53, 1, '157416', '2025-06-12 06:23:59', '2025-06-12 14:25:59'),
(54, 1, '150497', '2025-06-12 06:24:11', '2025-06-12 14:26:11'),
(55, 1, '826516', '2025-06-12 06:30:37', '2025-06-12 14:32:37'),
(56, 1, '281616', '2025-06-12 06:32:43', '2025-06-12 14:34:43'),
(57, 1, '433619', '2025-06-12 06:33:41', '2025-06-12 14:35:41'),
(58, 1, '201325', '2025-06-12 06:40:37', '2025-06-12 14:42:37'),
(59, 1, '482612', '2025-06-12 06:49:10', '2025-06-12 14:51:10'),
(60, 1, '525236', '2025-06-12 06:49:12', '2025-06-12 14:51:12'),
(61, 1, '850058', '2025-06-12 06:52:36', '2025-06-12 14:54:36'),
(62, 1, '468986', '2025-06-12 06:54:13', '2025-06-12 14:56:13'),
(63, 1, '663802', '2025-06-12 06:54:14', '2025-06-12 14:56:14'),
(64, 1, '631861', '2025-06-12 06:54:15', '2025-06-12 14:56:15'),
(65, 1, '305527', '2025-06-12 06:54:15', '2025-06-12 14:56:15'),
(66, 1, '110416', '2025-06-12 06:54:15', '2025-06-12 14:56:15'),
(67, 1, '608170', '2025-06-12 06:54:15', '2025-06-12 14:56:15'),
(68, 1, '712477', '2025-06-12 06:54:16', '2025-06-12 14:56:16'),
(69, 1, '108078', '2025-06-12 06:57:28', '2025-06-12 14:59:28'),
(70, 1, '897410', '2025-06-12 07:07:24', '2025-06-12 15:09:24'),
(71, 1, '898015', '2025-06-12 07:14:13', '2025-06-12 15:16:13'),
(72, 1, '491916', '2025-06-12 07:20:05', '2025-06-12 15:22:05'),
(73, 1, '707376', '2025-06-12 07:24:05', '2025-06-12 15:26:05'),
(74, 1, '514521', '2025-06-12 07:27:40', '2025-06-12 15:29:40'),
(75, 1, '401403', '2025-06-12 07:29:50', '2025-06-12 15:31:50'),
(76, 1, '264223', '2025-06-12 07:31:53', '2025-06-12 15:33:53'),
(77, 1, '494544', '2025-06-12 07:34:00', '2025-06-12 15:36:00'),
(78, 1, '643584', '2025-06-12 07:38:12', '2025-06-12 15:40:12'),
(79, 1, '520661', '2025-06-12 07:56:13', '2025-06-12 15:58:13'),
(80, 1, '876285', '2025-06-12 07:57:48', '2025-06-12 15:59:48'),
(81, 1, '654169', '2025-06-12 07:57:51', '2025-06-12 15:59:51'),
(82, 1, '872677', '2025-06-12 07:59:19', '2025-06-12 16:01:19'),
(83, 1, '231250', '2025-06-12 08:00:46', '2025-06-12 16:02:46'),
(84, 1, '769102', '2025-06-12 12:44:50', '2025-06-12 20:46:50'),
(85, 1, '656160', '2025-06-12 12:44:50', '2025-06-12 20:46:50'),
(86, 1, '612810', '2025-06-12 12:44:50', '2025-06-12 20:46:50'),
(87, 1, '728887', '2025-06-12 12:45:19', '2025-06-12 20:47:19'),
(88, 1, '342825', '2025-06-12 12:46:52', '2025-06-12 20:48:52'),
(89, 1, '622535', '2025-06-12 13:03:41', '2025-06-12 21:05:41'),
(90, 1, '866668', '2025-06-12 13:23:51', '2025-06-12 21:25:51'),
(91, 1, '701659', '2025-06-12 13:29:53', '2025-06-12 21:31:53'),
(92, 1, '138828', '2025-06-12 13:34:37', '2025-06-12 21:36:37'),
(93, 1, '458648', '2025-06-12 13:41:15', '2025-06-12 21:43:15'),
(94, 1, '594313', '2025-06-12 14:01:56', '2025-06-12 22:03:56'),
(95, 1, '955420', '2025-06-12 14:38:38', '2025-06-12 22:40:38'),
(96, 1, '248987', '2025-06-12 14:40:51', '2025-06-12 22:42:51'),
(97, 1, '934889', '2025-06-12 14:53:16', '2025-06-12 22:55:16'),
(98, 1, '865024', '2025-06-12 15:13:06', '2025-06-12 23:15:06'),
(99, 1, '777246', '2025-06-12 15:17:21', '2025-06-12 23:19:21'),
(100, 1, '199145', '2025-06-12 15:23:14', '2025-06-12 23:25:14'),
(101, 1, '664537', '2025-06-12 15:25:25', '2025-06-12 23:27:25'),
(102, 1, '745159', '2025-06-12 15:31:13', '2025-06-12 23:33:13'),
(103, 1, '820275', '2025-06-12 15:32:18', '2025-06-12 23:34:18'),
(104, 1, '687274', '2025-06-12 15:37:39', '2025-06-12 23:39:39'),
(105, 1, '403794', '2025-06-12 15:41:05', '2025-06-12 23:43:05');

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensor_data`
--

INSERT INTO `sensor_data` (`user_id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(150) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `failed_attempts` int(11) NOT NULL DEFAULT 0,
  `lock_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `last_login`, `failed_attempts`, `lock_until`) VALUES
('1', 'john', 'yokoOnoisaBitch', 'imagine@gmail.com', '2025-06-05 13:57:27', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE `user_log` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `activity_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`activity_details`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_navigational_activity`
--

CREATE TABLE `user_navigational_activity` (
  `user_id` int(11) NOT NULL,
  `last_latitude` decimal(9,6) NOT NULL,
  `last_longitude` decimal(9,6) NOT NULL,
  `time` datetime NOT NULL,
  `encrypted_page_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_navigational_activity`
--

INSERT INTO `user_navigational_activity` (`user_id`, `last_latitude`, `last_longitude`, `time`, `encrypted_page_name`) VALUES
(1, 0.000000, 0.000000, '0000-00-00 00:00:00', 'jfE8apx5FRkHXaYgkUQWVuhRscRlht/Hl/rFFisJICE='),
(1, 0.000000, 0.000000, '0000-00-00 00:00:00', 'jfE8apx5FRkHXaYgkUQWVuhRscRlht/Hl/rFFisJICE='),
(1, 0.000000, 0.000000, '0000-00-00 00:00:00', 'jfE8apx5FRkHXaYgkUQWVuhRscRlht/Hl/rFFisJICE='),
(1, 0.000000, 0.000000, '0000-00-00 00:00:00', 'jfE8apx5FRkHXaYgkUQWVuhRscRlht/Hl/rFFisJICE='),
(1, 0.000000, 0.000000, '0000-00-00 00:00:00', 'jfE8apx5FRkHXaYgkUQWVuhRscRlht/Hl/rFFisJICE=');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indexes for table `mfa_tokens`
--
ALTER TABLE `mfa_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `sensor_data`
--
ALTER TABLE `sensor_data`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`log_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_tokens`
--
ALTER TABLE `api_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `mfa_tokens`
--
ALTER TABLE `mfa_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_log`
--
ALTER TABLE `user_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mfa_tokens`
--
ALTER TABLE `mfa_tokens`
  ADD CONSTRAINT `mfa_tokens_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
