-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2024 at 03:05 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `contest`
--

CREATE TABLE `contest` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contest`
--

INSERT INTO `contest` (`id`, `title`) VALUES
(1, 'Match 01'),
(2, 'Match 01'),
(4, 'ind vs pak 3'),
(5, 'ind vs pak 3'),
(6, 'ind vs pak 4'),
(7, 'ind vs pak 4'),
(8, 'ind vs pak 4'),
(9, 'ipl 54');

-- --------------------------------------------------------

--
-- Table structure for table `participants`
--

CREATE TABLE `participants` (
  `id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `participant_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `participants`
--

INSERT INTO `participants` (`id`, `team_id`, `participant_name`) VALUES
(1, 1, 'raj'),
(2, 2, 'kiran'),
(3, 7, 'vivek'),
(4, 15, 'adarsh'),
(6, 137, 'vishnu'),
(7, 121, 'raj'),
(8, 122, 'kiran'),
(9, 126, 'vaibhav'),
(10, 139, 'adarsh'),
(11, 134, 'vijay'),
(12, 146, 'vivek'),
(13, 151, 'raj'),
(14, 149, 'kiran'),
(15, 152, 'vaibhav');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `contest_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `contest_id`, `name`) VALUES
(7, 2, 'kohli'),
(8, 2, 'sachin'),
(9, 2, 'raina'),
(10, 2, 'dhoni'),
(11, 2, 'gill'),
(12, 2, 'abhishek'),
(19, 4, 'Kohli'),
(20, 4, 'Rohit'),
(21, 4, 'Kartik'),
(22, 4, 'Babar'),
(23, 4, 'Huq'),
(24, 4, 'Rizwan'),
(25, 5, 'Kohli'),
(26, 5, 'Rohit'),
(27, 5, 'Kartik'),
(28, 5, 'Babar'),
(29, 5, 'Huq'),
(30, 5, 'Rizwan'),
(31, 6, 'Kohli'),
(32, 6, 'rohit'),
(33, 6, 'sachin'),
(34, 6, 'babar'),
(35, 6, 'rizwan'),
(36, 6, 'Huq'),
(37, 7, 'Kohli'),
(38, 7, 'rohit'),
(39, 7, 'sachin'),
(40, 7, 'babar'),
(41, 7, 'rizwan'),
(42, 7, 'Huq'),
(43, 8, 'Kohli'),
(44, 8, 'rohit'),
(45, 8, 'sachin'),
(46, 8, 'babar'),
(47, 8, 'rizwan'),
(48, 8, 'Huq'),
(49, 9, 'rohit'),
(50, 9, 'kohli'),
(51, 9, 'rinku'),
(52, 9, 'dhawan'),
(53, 9, 'dhoni'),
(54, 9, 'kartik');

-- --------------------------------------------------------

--
-- Table structure for table `run`
--

CREATE TABLE `run` (
  `id` int(11) NOT NULL,
  `contest_id` int(11) DEFAULT NULL,
  `player_id` int(11) DEFAULT NULL,
  `runs` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `run`
--

INSERT INTO `run` (`id`, `contest_id`, `player_id`, `runs`) VALUES
(1, 2, 7, 24),
(2, 2, 8, 11),
(3, 2, 9, 30),
(4, 2, 10, 7),
(5, 2, 11, 44),
(6, 2, 12, 17),
(7, 8, 43, 37),
(8, 8, 44, 11),
(9, 8, 45, 17),
(10, 8, 46, 3),
(11, 8, 47, 33),
(12, 8, 48, 7),
(13, 8, 43, 17),
(14, 8, 44, 7),
(15, 8, 45, 3),
(16, 9, 49, 17),
(17, 9, 50, 13),
(18, 9, 51, 27),
(19, 9, 52, 3),
(20, 9, 53, 0),
(21, 9, 54, 23);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `contest_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `player1` varchar(255) NOT NULL,
  `player2` varchar(255) NOT NULL,
  `player3` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `contest_id`, `team_id`, `player1`, `player2`, `player3`) VALUES
(1, 2, 1, 'raina', 'dhoni', 'gill'),
(2, 2, 2, 'sachin', 'raina', 'abhishek'),
(3, 2, 3, 'raina', 'dhoni', 'abhishek'),
(4, 2, 4, 'kohli', 'gill', 'abhishek'),
(5, 2, 5, 'sachin', 'raina', 'gill'),
(6, 2, 6, 'kohli', 'sachin', 'dhoni'),
(7, 2, 7, 'kohli', 'raina', 'abhishek'),
(8, 2, 8, 'kohli', 'dhoni', 'gill'),
(9, 2, 9, 'kohli', 'sachin', 'raina'),
(10, 2, 10, 'kohli', 'dhoni', 'abhishek'),
(11, 2, 11, 'kohli', 'raina', 'dhoni'),
(12, 2, 12, 'sachin', 'dhoni', 'abhishek'),
(13, 2, 13, 'sachin', 'raina', 'dhoni'),
(14, 2, 14, 'sachin', 'gill', 'abhishek'),
(15, 2, 15, 'dhoni', 'gill', 'abhishek'),
(16, 2, 16, 'kohli', 'sachin', 'gill'),
(17, 2, 17, 'sachin', 'dhoni', 'gill'),
(18, 2, 18, 'kohli', 'sachin', 'abhishek'),
(19, 2, 19, 'raina', 'gill', 'abhishek'),
(20, 2, 20, 'kohli', 'raina', 'gill'),
(41, 4, 1, '22', '23', '24'),
(42, 4, 2, '20', '22', '24'),
(43, 4, 3, '20', '22', '23'),
(44, 4, 4, '19', '20', '23'),
(45, 4, 5, '20', '21', '24'),
(46, 4, 6, '21', '23', '24'),
(47, 4, 7, '21', '22', '24'),
(48, 4, 8, '19', '21', '22'),
(49, 4, 9, '19', '20', '21'),
(50, 4, 10, '19', '20', '24'),
(51, 4, 11, '20', '21', '23'),
(52, 4, 12, '19', '21', '23'),
(53, 4, 13, '20', '23', '24'),
(54, 4, 14, '19', '20', '22'),
(55, 4, 15, '19', '21', '24'),
(56, 4, 16, '19', '22', '24'),
(57, 4, 17, '21', '22', '23'),
(58, 4, 18, '20', '21', '22'),
(59, 4, 19, '19', '22', '23'),
(60, 4, 20, '19', '23', '24'),
(61, 5, 1, '0', '0', '0'),
(62, 5, 2, '0', '0', '0'),
(63, 5, 3, '0', '0', '0'),
(64, 5, 4, '0', '0', '0'),
(65, 5, 5, '0', '0', '0'),
(66, 5, 6, '0', '0', '0'),
(67, 5, 7, '0', '0', '0'),
(68, 5, 8, '0', '0', '0'),
(69, 5, 9, '0', '0', '0'),
(70, 5, 10, '0', '0', '0'),
(71, 5, 11, '0', '0', '0'),
(72, 5, 12, '0', '0', '0'),
(73, 5, 13, '0', '0', '0'),
(74, 5, 14, '0', '0', '0'),
(75, 5, 15, '0', '0', '0'),
(76, 5, 16, '0', '0', '0'),
(77, 5, 17, '0', '0', '0'),
(78, 5, 18, '0', '0', '0'),
(79, 5, 19, '0', '0', '0'),
(80, 5, 20, '0', '0', '0'),
(81, 6, 1, '0', '0', '0'),
(82, 6, 2, '0', '0', '0'),
(83, 6, 3, '0', '0', '0'),
(84, 6, 4, '0', '0', '0'),
(85, 6, 5, '0', '0', '0'),
(86, 6, 6, '0', '0', '0'),
(87, 6, 7, '0', '0', '0'),
(88, 6, 8, '0', '0', '0'),
(89, 6, 9, '0', '0', '0'),
(90, 6, 10, '0', '0', '0'),
(91, 6, 11, '0', '0', '0'),
(92, 6, 12, '0', '0', '0'),
(93, 6, 13, '0', '0', '0'),
(94, 6, 14, '0', '0', '0'),
(95, 6, 15, '0', '0', '0'),
(96, 6, 16, '0', '0', '0'),
(97, 6, 17, '0', '0', '0'),
(98, 6, 18, '0', '0', '0'),
(99, 6, 19, '0', '0', '0'),
(100, 6, 20, '0', '0', '0'),
(101, 7, 1, 'rohit', 'rizwan', 'Huq'),
(102, 7, 2, 'Kohli', 'sachin', 'rizwan'),
(103, 7, 3, 'Kohli', 'sachin', 'babar'),
(104, 7, 4, 'rohit', 'sachin', 'Huq'),
(105, 7, 5, 'rohit', 'sachin', 'rizwan'),
(106, 7, 6, 'Kohli', 'rohit', 'babar'),
(107, 7, 7, 'rohit', 'babar', 'rizwan'),
(108, 7, 8, 'Kohli', 'babar', 'rizwan'),
(109, 7, 9, 'Kohli', 'rohit', 'rizwan'),
(110, 7, 10, 'sachin', 'rizwan', 'Huq'),
(111, 7, 11, 'sachin', 'babar', 'Huq'),
(112, 7, 12, 'babar', 'rizwan', 'Huq'),
(113, 7, 13, 'Kohli', 'rohit', 'sachin'),
(114, 7, 14, 'Kohli', 'rohit', 'Huq'),
(115, 7, 15, 'Kohli', 'babar', 'Huq'),
(116, 7, 16, 'Kohli', 'sachin', 'Huq'),
(117, 7, 17, 'sachin', 'babar', 'rizwan'),
(118, 7, 18, 'rohit', 'babar', 'Huq'),
(119, 7, 19, 'rohit', 'sachin', 'babar'),
(120, 7, 20, 'Kohli', 'rizwan', 'Huq'),
(121, 8, 1, '43', '46', '47'),
(122, 8, 2, '45', '46', '48'),
(123, 8, 3, '43', '44', '45'),
(124, 8, 4, '43', '44', '46'),
(125, 8, 5, '44', '46', '47'),
(126, 8, 6, '44', '45', '46'),
(127, 8, 7, '44', '47', '48'),
(128, 8, 8, '43', '46', '48'),
(129, 8, 9, '44', '45', '48'),
(130, 8, 10, '43', '45', '48'),
(131, 8, 11, '45', '46', '47'),
(132, 8, 12, '43', '45', '46'),
(133, 8, 13, '43', '45', '47'),
(134, 8, 14, '46', '47', '48'),
(135, 8, 15, '44', '45', '47'),
(136, 8, 16, '43', '47', '48'),
(137, 8, 17, '44', '46', '48'),
(138, 8, 18, '43', '44', '48'),
(139, 8, 19, '45', '47', '48'),
(140, 8, 20, '43', '44', '47'),
(141, 9, 1, '49', '51', '54'),
(142, 9, 2, '50', '51', '53'),
(143, 9, 3, '49', '50', '52'),
(144, 9, 4, '49', '51', '52'),
(145, 9, 5, '50', '52', '53'),
(146, 9, 6, '50', '52', '54'),
(147, 9, 7, '51', '53', '54'),
(148, 9, 8, '49', '53', '54'),
(149, 9, 9, '49', '50', '53'),
(150, 9, 10, '50', '51', '52'),
(151, 9, 11, '49', '50', '51'),
(152, 9, 12, '49', '51', '53'),
(153, 9, 13, '49', '50', '54'),
(154, 9, 14, '51', '52', '54'),
(155, 9, 15, '49', '52', '54'),
(156, 9, 16, '51', '52', '53'),
(157, 9, 17, '50', '53', '54'),
(158, 9, 18, '52', '53', '54'),
(159, 9, 19, '49', '52', '53'),
(160, 9, 20, '50', '51', '54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contest`
--
ALTER TABLE `contest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_id` (`contest_id`);

--
-- Indexes for table `run`
--
ALTER TABLE `run`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_id` (`contest_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contest_id` (`contest_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contest`
--
ALTER TABLE `contest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `run`
--
ALTER TABLE `run`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `participants`
--
ALTER TABLE `participants`
  ADD CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`);

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`);

--
-- Constraints for table `run`
--
ALTER TABLE `run`
  ADD CONSTRAINT `run_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`),
  ADD CONSTRAINT `run_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`);

--
-- Constraints for table `teams`
--
ALTER TABLE `teams`
  ADD CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`contest_id`) REFERENCES `contest` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
