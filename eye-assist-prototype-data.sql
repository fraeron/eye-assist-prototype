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

create database if not exists prototype;
use prototype;

CREATE TABLE if not exists `admins` (
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

CREATE TABLE if not exists `allowed_ip` (
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

CREATE TABLE if not exists `api_tokens` (
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

CREATE TABLE if not exists `mfa_tokens` (
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
(10, 1, '262121', '2025-05-19 07:29:57', '2025-05-19 09:39:57');

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE if not exists `sensor_data` (
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

CREATE TABLE if not exists `users` (
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

CREATE TABLE if not exists `user_log` (
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

CREATE TABLE if not exists `user_navigational_activity` (
  `user_id` int(11) NOT NULL,
  `last_latitude` decimal(9,6) NOT NULL,
  `last_longitude` decimal(9,6) NOT NULL,
  `time` datetime NOT NULL,
  `encrypted_page_name` varchar(100) NOT NULL,
  `iv` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
