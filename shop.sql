-- phpMyAdmin SQL Dump
-- version 4.4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Jul 24, 2016 at 07:18 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `list_id`, `user_id`, `name`, `created_at`, `status`, `quantity`, `price`, `price_type`, `notes`) VALUES
(15, 2, 0, 'Bread', '2016-07-24 03:55:11', 0, 1, '5.00', 0, ''),
(24, 3, 0, 'Hammer', '2016-06-29 05:00:00', 0, 1, '5.99', 0, ''),
(25, 2, 0, 'Oranges', '2016-06-29 05:00:00', 0, 4, '1.00', 2, ''),
(26, 3, 0, 'Nails', '2016-06-29 05:00:00', 0, 3, '0.89', 2, ''),
(27, 2, 0, 'Beer', '2016-07-24 04:09:37', 0, 4, '6.99', 2, 'Fat tire pls'),
(30, 4, 0, 'Prescriptions', '2016-07-24 04:08:03', 0, 1, '0.00', NULL, 'Make sure to get generic'),
(31, 2, 0, 'Eggs', '2016-07-24 04:10:56', 0, 1, '1.00', NULL, 'Make sure to get the large size');

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

CREATE TABLE `list` (
  `list_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`list_id`, `user_id`, `name`, `created_at`, `status`) VALUES
(1, 1, 'Show All', '2016-07-24 04:26:02', 0),
(2, 1, 'Grocery Store', '2016-07-24 04:26:03', 0),
(3, 1, 'Hardware Store', '2016-07-24 04:26:04', 0),
(4, 1, 'Other', '2016-07-24 04:26:05', 0),
(9, 1, 'Test', '2016-07-24 04:26:06', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `active_list` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL DEFAULT '',
  `last_name` varchar(40) NOT NULL DEFAULT '',
  `email` varchar(60) NOT NULL DEFAULT '',
  `pass` char(40) NOT NULL DEFAULT '',
  `registration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `active_list`, `first_name`, `last_name`, `email`, `pass`, `registration_date`) VALUES
(1, 1, 'James', 'Hume', 'james@hume.com', '1234', '2016-07-24 05:05:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `item_list` (`list_id`);

--
-- Indexes for table `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`list_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
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
-- Constraints for dumped tables
--

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_list` FOREIGN KEY (`list_id`) REFERENCES `list` (`list_id`);

--
-- Constraints for table `list`
--
ALTER TABLE `list`
  ADD CONSTRAINT `list_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
