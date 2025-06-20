-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2025 at 05:54 AM
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
-- Table structure for table `admin_mfa_tokens`
--

CREATE TABLE `admin_mfa_tokens` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `token` varchar(6) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_mfa_tokens`
--

INSERT INTO `admin_mfa_tokens` (`id`, `admin_id`, `token`, `created_at`, `expires_at`) VALUES
(1, 1, '115015', '2025-06-20 02:40:25', '2025-06-20 10:42:25'),
(2, 1, '310661', '2025-06-20 03:15:38', '2025-06-20 11:17:38'),
(3, 1, '675911', '2025-06-20 03:17:22', '2025-06-20 11:19:22'),
(4, 1, '270318', '2025-06-20 03:17:52', '2025-06-20 11:19:52'),
(5, 1, '599757', '2025-06-20 03:17:56', '2025-06-20 11:19:56'),
(6, 1, '842375', '2025-06-20 03:18:45', '2025-06-20 11:20:45'),
(7, 1, '395201', '2025-06-20 03:18:53', '2025-06-20 11:20:53'),
(8, 1, '274797', '2025-06-20 03:23:36', '2025-06-20 11:25:36'),
(9, 1, '858628', '2025-06-20 03:36:12', '2025-06-20 11:38:12');

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
(': :1'),
('192.168.1.6');

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
(10, 1, '5f35eea2e0c5e947ef72cdef9ed9a1fde36e98d2911f816fd61ce969161425ef', '2025-06-12 09:41:19', '2025-06-12 11:41:19'),
(11, 1, 'e0f0351385a0c3787d0fc981defe783a480811807227ea78707ebc16893f3610', '2025-06-18 01:43:05', '2025-06-18 01:44:05'),
(12, 1, '20525fd17ba38716b831c7a8a89cf765866d677fa2fec5dfa449d7977fd987ba', '2025-06-19 00:49:16', '2025-06-19 00:50:16'),
(13, 1, 'a84e27d3e995ef19cc15366abee26067eb9310c4ac8d3d3782922942f53d4d8d', '2025-06-19 01:19:24', '2025-06-19 01:20:24'),
(14, 1, 'e13a582da672bd3e18cf6ce464004fbd7ae032a0c15c33ac6952f8f1559fd8b7', '2025-06-19 01:28:37', '2025-06-19 01:29:37'),
(15, 1, 'e5dc0cf982336b2f25177548b153efe9443ddb617d8c7f92cbeecc1a9f1e5134', '2025-06-19 02:01:54', '2025-06-19 02:02:54'),
(16, 1, '3c00d3eb8302056241903619ef97be95cd2ca268934e1d154eadfa68e9be6e5c', '2025-06-19 02:06:58', '2025-06-19 02:07:58'),
(17, 1, '26ff363a39cca9820187055c7b064267dfa882a3a13e8d4e7aa7999740019fc4', '2025-06-19 02:10:38', '2025-06-19 02:11:38'),
(18, 1, '6999f97f9166cbd375573719c819319245f819c16bfb4535ae280ac46da46be4', '2025-06-19 02:11:02', '2025-06-19 02:12:02'),
(19, 1, '66064b76b93157a2b125c79a81d6b9117f25237b12f269912bb80d74cb03285f', '2025-06-19 02:12:42', '2025-06-19 02:13:42'),
(20, 1, 'c62a714cded292800769c7e60a6a55907a56abf0ba01d67f312d326c330e428a', '2025-06-19 02:13:45', '2025-06-19 02:14:45'),
(21, 1, '28c8315edf969200e7499b64ebdc5e52f1ef83997611fe5c38cbec59b80141dd', '2025-06-19 16:31:33', '2025-06-19 16:32:33'),
(22, 1, '2a1287746a670ef0a7d2d8d668db55853419580eb95ddc72149a33164dae397f', '2025-06-19 20:43:04', '2025-06-19 20:44:04'),
(23, 1, 'd682f4fd4dcdebe162ece0130e51ffdd2618e0c7283aed2e47cc5c17892f0f2b', '2025-06-19 20:55:23', '2025-06-19 20:56:23'),
(24, 1, 'ce9f1b3be40d5add49123d6a86ac6798b36a0b4268bb26dde41cb711b64e0210', '2025-06-19 20:59:23', '2025-06-19 21:00:23'),
(25, 1, 'dd8b981702f5e853b484740c2b355617763969d9b7d3111c19665d2eaddddf4c', '2025-06-19 21:31:13', '2025-06-19 21:32:13');

-- --------------------------------------------------------

--
-- Table structure for table `mfa_tokens`
--

CREATE TABLE `mfa_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(6) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mfa_tokens`
--

INSERT INTO `mfa_tokens` (`id`, `user_id`, `token`, `created_at`, `expires_at`) VALUES
(126, 1, '748044', '2025-06-20 02:39:59', '2025-06-20 10:41:59'),
(127, 1, '933680', '2025-06-20 02:42:08', '2025-06-20 10:44:08'),
(128, 1, '124937', '2025-06-20 02:43:13', '2025-06-20 10:45:13'),
(129, 1, '930228', '2025-06-20 02:53:18', '2025-06-20 10:55:18'),
(130, 1, '943860', '2025-06-20 02:55:08', '2025-06-20 10:57:08'),
(131, 1, '348290', '2025-06-20 02:59:03', '2025-06-20 11:01:03'),
(132, 1, '145087', '2025-06-20 03:26:28', '2025-06-20 11:28:28'),
(133, 1, '288809', '2025-06-20 03:30:06', '2025-06-20 11:32:06');

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
  `id` varchar(255) NOT NULL,
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

INSERT INTO `users` (`id`, `username`, `password`, `email`, `last_login`, `failed_attempts`, `lock_until`) VALUES
('1', 'john', '$2y$10$VkfHAp.T5XrFNn/XFCxlIulaLnakcgdGsiX6T8ZwQmPAHKM1dgoFG', 'imagine@gmail.com', '2025-06-20 03:30:06', 0, NULL);

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
  `encrypted_page_name` varchar(100) NOT NULL,
  `iv` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_navigational_activity`
--

INSERT INTO `user_navigational_activity` (`user_id`, `last_latitude`, `last_longitude`, `time`, `encrypted_page_name`, `iv`) VALUES
(1, 37.421998, -122.084000, '2025-06-18 07:43:04', 'QmlNNEN1L3M4RXNxbllYdzEvZUh2OFVXR3dJWEFmNkhKUHhwM05ZaTkyb09uRGRTS09iamt2L1NpUG54S2JFSEhxL0pVUGRKaXZx', 'dtaS9fISGCAdmjlWVCWsxw=='),
(1, 0.000000, 0.000000, '2025-06-19 06:49:17', 'OTlUa0FabW9ZZnBJSTM5Q1ZhOUtFZmZTS2IxTmczOVQyWnRSbXM2d2lHYTAvUUtEVnVHSktsMkU0Q3MvZm0xVTFnT0c5WVUvM1h3', '/IRYmoXpxf3lBjENjxG07w=='),
(1, 0.000000, 0.000000, '2025-06-19 07:19:23', 'aXNKL1pnMUptc2g1dlRmcXpqUklyTFl0SHNucFpIY2QzaUlrQ1dmdEo3VjRGbS9CWkpGVmswUDBwTkpmams0TXU3bGNqZ0lpRTIz', 'NAnEF40rsX1c1rPJRYelfQ=='),
(1, 0.000000, 0.000000, '2025-06-19 07:28:36', 'YlR0Wmk5aElmQ0tueCttRWtOWXFjYUI4WjgwdTM2aGdxd1gycGVIdU1DaXNjbG5ocWxtZUQzWUhSSUJOamFuOGF1QThVQ1Q1M0Jo', 'TVeCzQzI/5rdStk4+xQ86g=='),
(1, 0.000000, 0.000000, '2025-06-19 08:10:38', 'ZkRFa0dRYllWaDJLbmM2eDlzWmF2OWxIMURZZjB3QnM5eDNoSGIzZkxUSEsyeHpKRUdLWjZTbGhzeGV5QnlIN1RKUC82NzIvcGZV', '9AQHL2k8O4TdufKwLG4yiQ=='),
(1, 0.000000, 0.000000, '2025-06-19 08:11:01', 'UGVNNGtUZGtYOEFrMFVVVnVkYitjRnV0SWVnZWJTMzhPV0Z4UFBRQmxLUUZHYjdXMDZXMWs3OUNBeWoxRW5iNFNrWEFNeE5kK1lq', '2MGYM0id6wNlCYGUVAPUeQ=='),
(1, 0.000000, 0.000000, '2025-06-19 08:12:41', 'UUtjeWNlYk9KcCtTMDQ4RFA3SWJkWmZTRlREdXVKSGJZQkVwQWc3M0FBQTBLV3BzMmF2WGVsRGJJcyt3Vjd4WThVVG1pQ09sY29J', 'C8/6rek55kJ1LmBErfAl/Q=='),
(1, 0.000000, 0.000000, '2025-06-19 08:13:44', 'aFAxRXFkanZuZ0hTRDBoSlczS3l0RzEvd3NZY2ZXQ05CQzVTcFQrdVFCYVROSWNXV1h3M2paNUJPbFA1Q2J0VVl1NVdXblBQbWIz', 'Spo0lYzL6SUIB6E3NdPFhw=='),
(1, 0.000000, 0.000000, '2025-06-19 22:31:33', 'RWZydDRWSTR0MlB5eUUrSE9kQTlyMFVxS3lBUXdkeThvQVZSZ2ZOVmFoY0t4WnY3STFTMXRoVnY3T1dETGJPYnkxZk1vN00xcHhq', 'vAEfGWjUL+n6BB1RMC+asQ=='),
(1, 0.000000, 0.000000, '2025-06-20 02:43:04', 'LzIvckdaZ2ZVbnh3MVBJNnRwNlVCejFQcER1RjNVa2MzU2hlNHRhNHA1cFJtcmpaeTB3T3ZubUNZWENmQXZ3YXJIK3ZjSHN1RTFs', 'vLUBbroWj4ZJMsogS/LzHA=='),
(1, 0.000000, 0.000000, '2025-06-20 02:59:23', 'cVlEeHF3TWtZb2tyaTgwR2FlN0p0Tkt4M0pEdFZPNHpwN0cwTFN4TklEOHdyZnVOMGxhdk0xMnVuYjhWdnFiUU8xYlc2ZTFzQjF4', 'a3Zf/bUqjcQ7fmkR/x2pHg=='),
(1, 0.000000, 0.000000, '2025-06-20 03:31:13', 'amVOem8rWExBR1EyYSsxTkp5a3ZVY2l0dlV3Ti96cUZJcGZVcmU1b2VhaGw3Yk1sUWxuRExENkxkTUQzdVFReXpXZ3pvbFEvQ2xw', 'Z4PM74P9bD17wduQEr+luA==');

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
-- Indexes for table `admin_mfa_tokens`
--
ALTER TABLE `admin_mfa_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`admin_id`) USING BTREE;

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
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `sensor_data`
--
ALTER TABLE `sensor_data`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `admin_mfa_tokens`
--
ALTER TABLE `admin_mfa_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `api_tokens`
--
ALTER TABLE `api_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `mfa_tokens`
--
ALTER TABLE `mfa_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

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
  ADD CONSTRAINT `mfa_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `admins` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
