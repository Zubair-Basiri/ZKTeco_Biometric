-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2026 at 01:52 PM
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
-- Database: `zkteco_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendancerecord`
--

CREATE TABLE `attendancerecord` (
  `id` varchar(191) NOT NULL,
  `employeeId` varchar(191) DEFAULT NULL,
  `deviceId` varchar(191) DEFAULT NULL,
  `employeeCode` varchar(191) NOT NULL,
  `occurredAt` datetime(3) NOT NULL,
  `type` enum('CHECK_IN','CHECK_OUT','BREAK_IN','BREAK_OUT','UNKNOWN') NOT NULL DEFAULT 'UNKNOWN',
  `source` enum('MANUAL','DEVICE') NOT NULL DEFAULT 'MANUAL',
  `verificationType` varchar(191) DEFAULT NULL,
  `externalId` varchar(191) NOT NULL,
  `notes` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendancerecord`
--

INSERT INTO `attendancerecord` (`id`, `employeeId`, `deviceId`, `employeeCode`, `occurredAt`, `type`, `source`, `verificationType`, `externalId`, `notes`, `createdAt`, `updatedAt`) VALUES
('cmov3xkgo0005w1b0gar2jjzl', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:16:09.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:16:09.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.600', '2026-07-16 09:35:21.034'),
('cmov3xkhb0007w1b0yzyjcuzp', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:18:39.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:18:39.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.671', '2026-07-16 09:35:21.052'),
('cmov3xkin0009w1b0tccwab7f', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:21:46.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:21:46.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.719', '2026-07-16 09:35:21.062'),
('cmov3xkiz000bw1b0mlvwvxzv', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:24:21.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:24:21.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.731', '2026-07-16 09:35:21.073'),
('cmov3xkjd000dw1b0qv0h2c4y', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:25:48.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:25:48.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.746', '2026-07-16 09:35:21.085'),
('cmov3xkjs000fw1b0we1rus9v', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:28:05.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:28:05.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.761', '2026-07-16 09:35:21.093'),
('cmov3xkk8000hw1b0meuu2pav', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:34:58.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:34:58.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.776', '2026-07-16 09:35:21.101'),
('cmov3xkkm000jw1b0lrsvcuxm', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:37:21.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:37:21.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.790', '2026-07-16 09:35:21.109'),
('cmov3xkkz000lw1b0ih11psm1', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:45:46.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:45:46.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.802', '2026-07-16 09:35:21.121'),
('cmov3xkl8000nw1b0y63sslkr', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:50:38.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:50:38.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.812', '2026-07-16 09:35:21.136'),
('cmov3xklj000pw1b0xmi7urqd', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:52:10.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:52:10.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.823', '2026-07-16 09:35:21.155'),
('cmov3xklw000rw1b02slaet39', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 08:53:46.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T08:53:46.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.836', '2026-07-16 09:35:21.163'),
('cmov3xkm9000tw1b02dordlur', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-04 09:02:22.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-04T09:02:22.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.849', '2026-07-16 09:35:21.177'),
('cmov3xkmn000vw1b0sgc8l2c6', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-05 07:54:46.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-05T07:54:46.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.863', '2026-07-16 09:35:21.197'),
('cmov3xkn4000xw1b06qirmheo', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-05 07:55:58.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-05T07:55:58.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.880', '2026-07-16 09:35:21.208'),
('cmov3xkng000zw1b0cczpspad', 'cmov3xk8v0002w1b0f3zneesx', 'cmov3xcuq0000w1b0sncrbpp1', '2', '2026-05-05 07:57:51.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:2:2026-05-05T07:57:51.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.892', '2026-07-16 09:35:21.219'),
('cmov3xknr0011w1b0m24y45js', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-05 07:58:08.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-05T07:58:08.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.903', '2026-07-16 09:35:21.230'),
('cmov3xknz0013w1b0cobcnnog', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-05 08:11:42.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-05T08:11:42.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.912', '2026-07-16 09:35:21.240'),
('cmov3xkoa0015w1b0m9p2ea1t', 'cmov3xk8v0002w1b0f3zneesx', 'cmov3xcuq0000w1b0sncrbpp1', '2', '2026-05-05 08:12:31.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:2:2026-05-05T08:12:31.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.922', '2026-07-16 09:35:21.247'),
('cmov3xkoo0017w1b0vjq5p87y', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-05 08:13:09.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-05T08:13:09.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.936', '2026-07-16 09:35:21.254'),
('cmov3xkoy0019w1b07n2v4j8d', 'cmov3xk8h0001w1b0dlpw6923', 'cmov3xcuq0000w1b0sncrbpp1', '1', '2026-05-05 08:14:13.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:1:2026-05-05T08:14:13.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.947', '2026-07-16 09:35:21.264'),
('cmov3xkpa001bw1b0wc48ap8x', 'cmov3xk8v0002w1b0f3zneesx', 'cmov3xcuq0000w1b0sncrbpp1', '2', '2026-05-05 08:14:29.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:2:2026-05-05T08:14:29.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.958', '2026-07-16 09:35:21.274'),
('cmov3xkpk001dw1b0scbklfqx', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-05-05 08:14:39.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-05-05T08:14:39.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:30:42.969', '2026-07-16 09:35:21.283'),
('cmov43izm00xfw1b0oi0pbw7t', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 06:32:32.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T06:32:32.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:35:20.674', '2026-07-16 09:35:21.291'),
('cmov49amz01pkw1b0ml12zdim', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 06:36:51.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T06:36:51.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:39:49.787', '2026-07-16 09:35:21.297'),
('cmov49khi01tsw1b0fuwkl5x4', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 06:37:14.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T06:37:14.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:40:02.550', '2026-07-16 09:35:21.307'),
('cmov4m4xc01vaw1b0fuhryp39', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 06:49:42.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T06:49:42.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 06:49:48.913', '2026-07-16 09:35:21.317'),
('cmov555az02gcw1b0n3suavx0', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 07:04:32.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T07:04:32.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 07:04:35.867', '2026-07-16 09:35:21.325'),
('cmovbsi3d007tw10c3yof5dku', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 10:10:40.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T10:10:40.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 10:10:43.225', '2026-07-16 09:35:21.333'),
('cmovf1j0y0039w1os2mgxe8nx', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 11:41:25.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T11:41:25.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 11:41:43.186', '2026-07-16 09:35:21.342'),
('cmovf2x15006nw1osj5w9e1zs', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 11:41:55.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T11:41:55.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 11:42:47.993', '2026-07-16 09:35:21.351'),
('cmovf3dac00a5w1ossn1615uz', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 11:43:01.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T11:43:01.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 11:43:09.060', '2026-07-16 09:35:21.361'),
('cmovfbnj0001tw1u48qrpt1fk', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 11:46:04.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T11:46:04.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 11:49:35.580', '2026-07-16 09:35:21.371'),
('cmovgajkx001vw1lki79z135w', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 11:49:38.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T11:49:38.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:16:43.425', '2026-07-16 09:35:21.382'),
('cmovgfmie001xw1uk8phjzbgz', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 12:17:06.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T12:17:06.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:20:40.503', '2026-07-16 09:35:21.391'),
('cmovgg1oc003xw1ukx5ksxbap', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 12:20:40.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T12:20:40.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:21:00.156', '2026-07-16 09:35:21.401'),
('cmovggw1y00bzw1ukuwf02d1h', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 12:21:18.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T12:21:18.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:21:39.527', '2026-07-16 09:35:21.413'),
('cmovghe1k00shw1ukfo5tslx4', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 12:21:58.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T12:21:58.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:22:02.840', '2026-07-16 09:35:21.424'),
('cmovgnq9g02fyw1ukapcyor0y', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-05-07 12:26:52.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-05-07T12:26:52.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:26:58.612', '2026-07-16 09:35:21.433'),
('cmovgotym02oow1ukov0cxrzc', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 12:27:41.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T12:27:41.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:27:50.063', '2026-07-16 09:35:21.443'),
('cmovgq2p202t6w1uk5h0f7wqs', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-05-07 12:28:31.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-05-07T12:28:31.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:28:48.038', '2026-07-16 09:35:21.454'),
('cmovgwhpy00fzw1doo6ydoiq0', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-05-07 12:33:44.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-05-07T12:33:44.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:33:47.446', '2026-07-16 09:35:21.463'),
('cmovgzgzr009dw1as4l3v2uf4', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 12:36:01.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T12:36:01.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:36:06.472', '2026-07-16 09:35:21.473'),
('cmovgztef00ldw1asix3qkwq9', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 12:36:19.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T12:36:19.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:36:22.552', '2026-07-16 09:35:21.484'),
('cmovh2uww004xw14oqevjx4it', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-05-07 12:38:30.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-05-07T12:38:30.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:38:44.480', '2026-07-16 09:35:21.493'),
('cmovhpxs200rhw14o652u8f0h', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-05-07 12:56:31.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-05-07T12:56:31.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:56:41.282', '2026-07-16 09:35:21.502'),
('cmovhu0u600plw1bcijk6l13i', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 12:59:48.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T12:59:48.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 12:59:51.871', '2026-07-16 09:35:21.509'),
('cmovhvxdh0059w1ogvib9b4bm', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-05-07 13:01:16.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-05-07T13:01:16.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 13:01:20.693', '2026-07-16 09:35:21.516'),
('cmovi01qh002pw1ekeiubn166', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-05-07 13:04:30.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-05-07T13:04:30.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 13:04:32.970', '2026-07-16 09:35:21.524'),
('cmovkn35o002rw1kouwhozoa7', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 14:17:27.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T14:17:27.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 14:18:27.133', '2026-07-16 09:35:21.535'),
('cmovknwyj0105w1kozklvv5oq', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 14:19:02.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T14:19:02.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 14:19:05.755', '2026-07-16 09:35:21.547'),
('cmovl79n501bjw1kojrkth7vq', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 14:33:31.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T14:33:31.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 14:34:08.658', '2026-07-16 09:35:21.558'),
('cmovlhs0g01hdw1koq1zfntmz', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 14:39:45.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T14:39:45.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 14:42:19.024', '2026-07-16 09:35:21.567'),
('cmovlmpe101nbw1ko1ab1eqzs', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 14:45:50.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T14:45:50.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 14:46:08.905', '2026-07-16 09:35:21.575'),
('cmovlsrjy04tdw1kooizhwa3v', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 14:50:43.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T14:50:43.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 14:50:51.646', '2026-07-16 09:35:21.582'),
('cmovmo7gm09bdw1kowdquikwb', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 15:15:15.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T15:15:15.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 15:15:18.599', '2026-07-16 09:35:21.589'),
('cmovmw14g0bh7w1kooqlmoqea', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-05-07 15:21:21.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-05-07T15:21:21.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 15:21:23.633', '2026-07-16 09:35:21.596'),
('cmovmz03n0e7fw1ko6uxfuuvk', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-05-07 15:23:26.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-05-07T15:23:26.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 15:23:42.275', '2026-07-16 09:35:21.606'),
('cmovn11cn0gj9w1ko7h5lnfsb', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 15:24:58.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T15:24:58.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 15:25:17.207', '2026-07-16 09:35:21.616'),
('cmovn1wwb0hpxw1ko36zyc4ps', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-05-07 15:25:53.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-05-07T15:25:53.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 15:25:58.091', '2026-07-16 09:35:21.627'),
('cmovn23y00hzzw1ko4fnplyfp', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-07 15:26:04.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-07T15:26:04.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-07 15:26:07.224', '2026-07-16 09:35:21.636'),
('cmoy2m1r60e7uw1pw53tt6683', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-09 08:16:56.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-09T08:16:56.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-09 08:17:04.099', '2026-07-16 09:35:21.645'),
('cmoy2sz600oggw1pw357fy4cm', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-09 08:22:23.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-09T08:22:23.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-09 08:22:27.337', '2026-07-16 09:35:21.653'),
('cmoy2txut0px0w1pwtf7ka0vw', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-05-09 08:23:09.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-05-09T08:23:09.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-09 08:23:12.294', '2026-07-16 09:35:21.662'),
('cmoy2xzr30w52w1pwadwncvx8', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-05-09 08:26:18.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-05-09T08:26:18.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-09 08:26:21.375', '2026-07-16 09:35:21.673'),
('cmoy2zk3k0yjsw1pwuim1otca', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-09 08:27:32.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-09T08:27:32.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-09 08:27:34.400', '2026-07-16 09:35:21.685'),
('cmoy8iw9l28hiw1pwbjg8mm18', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-05-09 11:02:32.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-05-09T11:02:32.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-05-09 11:02:34.713', '2026-07-16 09:35:21.697'),
('cmrkmljmk03inw1bo9gn01310', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-14 12:26:42.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-14T12:26:42.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:26:53.468', '2026-07-16 09:35:21.709'),
('cmrkmob5l01d7w1vc6mxynnvh', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-14 12:28:52.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-14T12:28:52.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:29:02.457', '2026-07-16 09:35:21.720'),
('cmrkmrp7m05qfw1vclg5m7eur', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-14 12:31:29.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-14T12:31:29.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:31:40.642', '2026-07-16 09:35:21.730'),
('cmrkmuemn09u9w1vclsl662l3', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-07-14 12:33:34.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-07-14T12:33:34.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:33:46.896', '2026-07-16 09:35:21.740'),
('cmrkmuj3w0a27w1vcx77nvajk', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-14 12:33:40.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-14T12:33:40.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:33:52.700', '2026-07-16 09:35:21.755'),
('cmrkmule10a69w1vcidd6w6g7', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-14 12:33:45.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-14T12:33:45.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:33:55.657', '2026-07-16 09:35:21.766'),
('cmrkn2gkr01p3w1twik3ew1bs', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-14 12:39:24.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-14T12:39:24.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:40:02.668', '2026-07-16 09:35:21.778'),
('cmrkn2gm001p5w1twjhvptu24', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-14 12:39:32.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-14T12:39:32.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-14 12:40:02.712', '2026-07-16 09:35:21.789'),
('cmrn9tvxd01yww1u0q51nk57d', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 08:52:37.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T08:52:37.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 08:52:46.177', '2026-07-16 09:35:21.804'),
('cmrn9uo0x03dmw1u0vsf8za5u', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 08:53:11.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T08:53:11.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 08:53:22.594', '2026-07-16 09:35:21.813'),
('cmrn9vp4w05a4w1u06sgz0h2q', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 08:54:01.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T08:54:01.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 08:54:10.688', '2026-07-16 09:35:21.825'),
('cmrna1m1q0fzuw1u0uvqmfpcc', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 08:58:36.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T08:58:36.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 08:58:46.622', '2026-07-16 09:35:21.840'),
('cmrna1od30g4aw1u0y6qrkcvs', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 08:58:40.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T08:58:40.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 08:58:49.624', '2026-07-16 09:35:21.853'),
('cmrnab5s60qdaw1u0vfh6mv56', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:03:34.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:03:34.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:06:12.103', '2026-07-16 09:35:21.867'),
('cmrnab5sw0qdcw1u0w73dp4yk', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 09:03:36.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T09:03:36.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:06:12.128', '2026-07-16 09:35:21.878'),
('cmrnac2th0s5aw1u0fli3kpza', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 09:06:44.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T09:06:44.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:06:54.918', '2026-07-16 09:35:21.887'),
('cmrnafrnx0ukyw1u0fkpf9a42', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:09:36.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:09:36.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:09:47.086', '2026-07-16 09:35:21.898'),
('cmrnaserp1bycw1u06uxe389z', 'cmov48pf001k6w1b0z75qo9c4', 'cmov3xcuq0000w1b0sncrbpp1', '5', '2026-07-16 09:19:26.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:5:2026-07-16T09:19:26.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:19:36.901', '2026-07-16 09:35:21.909'),
('cmrnash541c34w1u05kk2jbgg', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-16 09:19:30.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-16T09:19:30.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:19:39.976', '2026-07-16 09:35:21.924'),
('cmrnautqy1g7cw1u02gwveaxc', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-16 09:21:18.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-16T09:21:18.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:21:29.626', '2026-07-16 09:35:21.933'),
('cmrnay5bm1n6qw1u0x1smypii', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:23:55.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:23:55.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:24:04.595', '2026-07-16 09:35:21.942'),
('cmrnazamq1phww1u03wh4b6ih', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-16 09:24:47.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-16T09:24:47.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:24:58.130', '2026-07-16 09:35:21.952'),
('cmrnb4kex1xlow1u0sp1yndi3', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 09:28:55.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T09:28:55.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:29:04.089', '2026-07-16 09:35:22.000'),
('cmrnb6g4621msw1u05aiqsnwi', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-16 09:30:20.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-16T09:30:20.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:30:31.830', '2026-07-16 09:35:22.009'),
('cmrnb6i8021rww1u00118ayp7', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:30:24.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:30:24.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:30:34.561', '2026-07-16 09:35:22.020'),
('cmrnb8hmg266ew1u0dg7igscc', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:31:57.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:31:57.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:32:07.096', '2026-07-16 09:35:22.031'),
('cmrnb9inb28h4w1u0v8z0sxr5', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-16 09:32:46.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-16T09:32:46.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:32:55.079', '2026-07-16 09:35:22.044'),
('cmrnb9l4q28mew1u087orm6tl', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 09:32:49.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T09:32:49.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:32:58.298', '2026-07-16 09:35:22.057'),
('cmrnba5ui29xyw1u01w7d2ccr', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:33:16.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:33:16.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:33:25.146', '2026-07-16 09:35:22.065'),
('cmrnbaxk42bq0w1u0jg3cfvb3', 'cmov3xk910003w1b0yn6yk5ii', 'cmov3xcuq0000w1b0sncrbpp1', '3', '2026-07-16 09:33:51.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:3:2026-07-16T09:33:51.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:34:01.060', '2026-07-16 09:35:22.075'),
('cmrnbb4ol2c68w1u0cmvp13bw', 'cmovgn9kg027gw1uk4tlg9b0b', 'cmov3xcuq0000w1b0sncrbpp1', '6', '2026-07-16 09:33:59.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:6:2026-07-16T09:33:59.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:34:10.293', '2026-07-16 09:35:22.112'),
('cmrnbbwfa2doqw1u0vo86ia0v', 'cmov42of100jaw1b0j46zwvbm', 'cmov3xcuq0000w1b0sncrbpp1', '4', '2026-07-16 09:34:32.000', 'UNKNOWN', 'DEVICE', 'fingerprint', 'DEVICE:cmov3xcuq0000w1b0sncrbpp1:4:2026-07-16T09:34:32.000Z', 'Live fingerprint punch from Main Entrance ZKTeco', '2026-07-16 09:34:46.246', '2026-07-16 09:35:22.121');

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE `device` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `ipAddress` varchar(191) NOT NULL,
  `port` int(11) NOT NULL DEFAULT 4370,
  `commKey` int(11) NOT NULL DEFAULT 0,
  `status` enum('UNKNOWN','ONLINE','OFFLINE','ERROR') NOT NULL DEFAULT 'UNKNOWN',
  `location` varchar(191) DEFAULT NULL,
  `serialNumber` varchar(191) DEFAULT NULL,
  `firmwareVersion` varchar(191) DEFAULT NULL,
  `platform` varchar(191) DEFAULT NULL,
  `lastSeenAt` datetime(3) DEFAULT NULL,
  `lastSyncAt` datetime(3) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`id`, `name`, `ipAddress`, `port`, `commKey`, `status`, `location`, `serialNumber`, `firmwareVersion`, `platform`, `lastSeenAt`, `lastSyncAt`, `notes`, `createdAt`, `updatedAt`) VALUES
('cmov3xcuq0000w1b0sncrbpp1', 'Main Entrance ZKTeco', '192.168.1.201', 4370, 0, 'OFFLINE', NULL, NULL, NULL, NULL, '2026-07-16 09:35:22.127', '2026-07-16 11:51:53.362', NULL, '2026-05-07 06:30:32.707', '2026-07-16 11:51:53.363');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` varchar(191) NOT NULL,
  `employeeCode` varchar(191) NOT NULL,
  `firstName` varchar(191) NOT NULL,
  `lastName` varchar(191) NOT NULL,
  `deviceUid` int(11) DEFAULT NULL,
  `deviceRole` int(11) DEFAULT NULL,
  `deviceCardNo` int(11) DEFAULT NULL,
  `department` varchar(191) DEFAULT NULL,
  `designation` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `biometricUid` varchar(191) DEFAULT NULL,
  `hireDate` datetime(3) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `employeeCode`, `firstName`, `lastName`, `deviceUid`, `deviceRole`, `deviceCardNo`, `department`, `designation`, `email`, `phone`, `biometricUid`, `hireDate`, `isActive`, `notes`, `createdAt`, `updatedAt`) VALUES
('cmov3xk8h0001w1b0dlpw6923', '1', 'Jan', 'Employee', 1, 0, 0, NULL, NULL, NULL, NULL, '1', NULL, 1, 'Imported from device Main Entrance ZKTeco (192.168.1.201)', '2026-05-07 06:30:42.353', '2026-07-16 09:20:41.843'),
('cmov3xk8v0002w1b0f3zneesx', '2', 'P', 'Employee', 2, 0, 0, NULL, NULL, NULL, NULL, '2', NULL, 1, 'Imported from device Main Entrance ZKTeco (192.168.1.201)', '2026-05-07 06:30:42.367', '2026-07-16 09:20:41.862'),
('cmov3xk910003w1b0yn6yk5ii', '3', 'W', 'Employee', 3, 0, 0, NULL, NULL, NULL, NULL, '3', NULL, 1, 'Imported from device Main Entrance ZKTeco (192.168.1.201)', '2026-05-07 06:30:42.373', '2026-07-16 09:20:41.874'),
('cmov42of100jaw1b0j46zwvbm', '4', 'Z', 'Employee', 4, 0, 0, NULL, NULL, NULL, NULL, '4', NULL, 1, 'Imported from device Main Entrance ZKTeco (192.168.1.201)', '2026-05-07 06:34:41.053', '2026-07-16 09:20:41.885'),
('cmov48pf001k6w1b0z75qo9c4', '5', 'A', 'Employee', 5, 0, 0, NULL, NULL, NULL, NULL, '5', NULL, 1, 'Imported from device Main Entrance ZKTeco (192.168.1.201)', '2026-05-07 06:39:22.285', '2026-07-16 09:20:41.901'),
('cmovgn9kg027gw1uk4tlg9b0b', '6', 'Test', 'Employee', 6, 0, 0, NULL, NULL, NULL, NULL, '6', NULL, 1, 'Imported from device Main Entrance ZKTeco (192.168.1.201)', '2026-05-07 12:26:36.976', '2026-07-16 09:20:41.926');

-- --------------------------------------------------------

--
-- Table structure for table `synclog`
--

CREATE TABLE `synclog` (
  `id` varchar(191) NOT NULL,
  `deviceId` varchar(191) NOT NULL,
  `kind` enum('STATUS','ATTENDANCE','USER_IMPORT') NOT NULL,
  `status` enum('RUNNING','SUCCESS','FAILED') NOT NULL DEFAULT 'RUNNING',
  `message` text DEFAULT NULL,
  `recordsProcessed` int(11) NOT NULL DEFAULT 0,
  `startedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `finishedAt` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `synclog`
--

INSERT INTO `synclog` (`id`, `deviceId`, `kind`, `status`, `message`, `recordsProcessed`, `startedAt`, `finishedAt`) VALUES
('cmov48od301itw1b0s2e09no8', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 5 device users.', 5, '2026-05-07 06:39:20.919', '2026-05-07 06:39:22.295'),
('cmovghsa8010zw1ukmvqnzf2h', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 38 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-05-07 12:22:21.297', '2026-05-07 12:22:21.654'),
('cmovghy2y017dw1ukedpsl6t9', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 5 device users.', 5, '2026-05-07 12:22:28.810', '2026-05-07 12:22:30.090'),
('cmovglend01qfw1ukqah1435w', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 5 device users.', 5, '2026-05-07 12:25:10.249', '2026-05-07 12:25:11.566'),
('cmovgljkn01upw1uk7a0uyjhl', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 38 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-05-07 12:25:16.631', '2026-05-07 12:25:16.826'),
('cmovgn82t025bw1ukappby9bf', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-05-07 12:26:35.046', '2026-05-07 12:26:37.004'),
('cmrkmj2yf01g5w1bohybb022a', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-14 12:24:58.552', '2026-07-14 12:24:59.990'),
('cmrkmnjpk00bdw1vcsrwh4ecv', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-14 12:28:26.888', '2026-07-14 12:28:28.807'),
('cmrkmvrv70c7bw1vc2moy7v69', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-14 12:34:50.708', '2026-07-14 12:34:52.839'),
('cmrkmvxmz0cjjw1vcangcgl4t', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 73 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-07-14 12:34:58.187', '2026-07-14 12:34:58.412'),
('cmrkmy7sb0001w1twcrgd0qi1', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'FAILED', 'Unexpected error', 0, '2026-07-14 12:36:44.651', '2026-07-14 12:36:47.529'),
('cmrkmydzz0003w1twngqcvqdn', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'FAILED', 'Unexpected error', 0, '2026-07-14 12:36:52.703', '2026-07-14 12:36:55.525'),
('cmrkn0lx7005dw1twjpv40dyi', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-14 12:38:36.283', '2026-07-14 12:38:38.466'),
('cmrkn157a0183w1twb8lmemv0', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 73 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-07-14 12:39:01.270', '2026-07-14 12:39:01.639'),
('cmrkn3v440051w188s443vnkj', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 75 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-07-14 12:41:08.164', '2026-07-14 12:41:09.267'),
('cmrknhz950023w1nwahrp2ec7', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-14 12:52:06.713', '2026-07-14 12:52:09.520'),
('cmrknihl400xfw1nw5ec2ip8e', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 75 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-07-14 12:52:30.472', '2026-07-14 12:52:31.469'),
('cmrna8pse0q8sw1u0k6nao3mn', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'FAILED', 'Unexpected error', 0, '2026-07-16 09:04:18.040', '2026-07-16 09:04:30.888'),
('cmrnabgj60qvsw1u0c08nc3ot', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 82 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-07-16 09:06:26.034', '2026-07-16 09:06:27.264'),
('cmrnabo6m0rayw1u04guogq9m', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-16 09:06:35.950', '2026-07-16 09:06:38.743'),
('cmrnatqtb1dy8w1u0p1li3rb7', 'cmov3xcuq0000w1b0sncrbpp1', 'USER_IMPORT', 'SUCCESS', 'Imported or refreshed 6 device users.', 6, '2026-07-16 09:20:39.168', '2026-07-16 09:20:41.957'),
('cmrnb656o20uow1u0ktmkga1j', 'cmov3xcuq0000w1b0sncrbpp1', 'STATUS', 'SUCCESS', 'Connected successfully. The device responded with 90 attendance logs, but the published node-zklib wrapper does not expose device time.', 0, '2026-07-16 09:30:17.664', '2026-07-16 09:30:17.913');

-- --------------------------------------------------------

--
-- Table structure for table `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('240711bd-550d-43d7-abb7-d9bc406d05a3', '420ad4b7b4931058efbdc8235785c6a4607ddbcd163cef2a0473ef17e104b92a', '2026-05-06 19:01:17.922', '20260506190115_init', NULL, NULL, '2026-05-06 19:01:15.793', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendancerecord`
--
ALTER TABLE `attendancerecord`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `AttendanceRecord_externalId_key` (`externalId`),
  ADD KEY `AttendanceRecord_employeeCode_occurredAt_idx` (`employeeCode`,`occurredAt`),
  ADD KEY `AttendanceRecord_deviceId_occurredAt_idx` (`deviceId`,`occurredAt`),
  ADD KEY `AttendanceRecord_employeeId_fkey` (`employeeId`);

--
-- Indexes for table `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Device_ipAddress_key` (`ipAddress`),
  ADD KEY `Device_status_updatedAt_idx` (`status`,`updatedAt`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Employee_employeeCode_key` (`employeeCode`),
  ADD UNIQUE KEY `Employee_email_key` (`email`),
  ADD UNIQUE KEY `Employee_biometricUid_key` (`biometricUid`),
  ADD KEY `Employee_lastName_firstName_idx` (`lastName`,`firstName`);

--
-- Indexes for table `synclog`
--
ALTER TABLE `synclog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SyncLog_deviceId_startedAt_idx` (`deviceId`,`startedAt`);

--
-- Indexes for table `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendancerecord`
--
ALTER TABLE `attendancerecord`
  ADD CONSTRAINT `AttendanceRecord_deviceId_fkey` FOREIGN KEY (`deviceId`) REFERENCES `device` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `AttendanceRecord_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `synclog`
--
ALTER TABLE `synclog`
  ADD CONSTRAINT `SyncLog_deviceId_fkey` FOREIGN KEY (`deviceId`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
