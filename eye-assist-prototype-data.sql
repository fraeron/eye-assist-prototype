-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 03:59 AM
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
-- Table structure for table `api_tokens`
--

CREATE TABLE `api_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(28, 1, '858213', '2025-05-20 01:38:03', '2025-05-20 09:40:03');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mfa_tokens`
--
ALTER TABLE `mfa_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

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
