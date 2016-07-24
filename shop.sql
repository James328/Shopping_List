-- phpMyAdmin SQL Dump
-- version 4.4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Jul 24, 2016 at 09:56 AM
-- Server version: 5.5.42
-- PHP Version: 5.6.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_id` mediumint(8) unsigned NOT NULL,
  `list_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(4,2) DEFAULT NULL,
  `price_type` int(11) DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `list_id`, `user_id`, `name`, `created_at`, `status`, `quantity`, `price`, `price_type`, `notes`) VALUES
(15, 2, 0, 'Bread', '2016-07-24 03:55:11', 0, 1, '5.00', 0, ''),
(24, 3, 0, 'Hammer', '2016-06-29 05:00:00', 0, 1, '5.99', 0, ''),
(25, 2, 0, 'Oranges', '2016-06-29 05:00:00', 0, 4, '1.00', 2, ''),
(27, 2, 0, 'Beer', '2016-07-24 07:34:40', 0, 1, '6.99', 2, 'Fat tire pls'),
(31, 2, 0, 'Eggs', '2016-07-24 07:32:58', 0, 1, '5.99', NULL, 'Make sure to get the large size'),
(36, 0, 0, 'Prescriptions', '2016-07-24 07:32:13', 0, 1, NULL, NULL, 'Make sure to get generics');

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

CREATE TABLE `list` (
  `list_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`list_id`, `user_id`, `name`, `created_at`) VALUES
(1, 0, 'Show All', '2016-07-24 04:26:02'),
(2, 0, 'Grocery Store', '2016-07-24 04:26:03'),
(3, 0, 'Hardware Store', '2016-07-24 04:26:04'),
(4, 0, 'Other', '2016-07-24 04:26:05'),
(9, 0, 'Test', '2016-07-24 04:26:06');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `active_list` mediumint(8) unsigned NOT NULL,
  `first_name` varchar(20) NOT NULL DEFAULT '',
  `last_name` varchar(40) NOT NULL DEFAULT '',
  `email` varchar(60) NOT NULL DEFAULT '',
  `pass` char(40) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `active_list`, `first_name`, `last_name`, `email`, `pass`, `created_at`) VALUES
(1, 1, 'James', 'Hume', 'james@hume.com', '1234', '2016-07-24 07:34:38');

-- --------------------------------------------------------

--
-- Table structure for table `user_item_list`
--

CREATE TABLE `user_item_list` (
  `uil_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `item_id` mediumint(8) unsigned NOT NULL,
  `list_id` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `item_list` (`list_id`),
  ADD KEY `item_user` (`user_id`);

--
-- Indexes for table `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`list_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_active_list` (`active_list`);

--
-- Indexes for table `user_item_list`
--
ALTER TABLE `user_item_list`
  ADD PRIMARY KEY (`uil_id`),
  ADD KEY `user_item_user` (`user_id`),
  ADD KEY `user_item_item` (`item_id`),
  ADD KEY `user_item_list` (`list_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `list`
--
ALTER TABLE `list`
  MODIFY `list_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `user_item_list`
--
ALTER TABLE `user_item_list`
  MODIFY `uil_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_item_list`
--
ALTER TABLE `user_item_list`
  ADD CONSTRAINT `user_item_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  ADD CONSTRAINT `user_item_list` FOREIGN KEY (`list_id`) REFERENCES `list` (`list_id`),
  ADD CONSTRAINT `user_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
