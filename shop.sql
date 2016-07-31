-- phpMyAdmin SQL Dump
-- version 4.4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Jul 31, 2016 at 05:00 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `list_id`, `user_id`, `name`, `created_at`, `status`, `quantity`, `price`, `price_type`, `notes`) VALUES
(1, 2, 1, 'Oranges', '2016-07-31 02:50:28', 0, 4, '1.00', 2, ''),
(2, 2, 1, 'Beer', '2016-07-31 02:50:30', 0, 1, '6.99', 2, 'Fat tire pls'),
(3, 2, 1, 'Eggs', '2016-07-31 02:53:20', 0, 1, '5.99', NULL, 'Get the large size'),
(4, 4, 1, 'Prescriptions', '2016-07-31 02:52:09', 0, 3, NULL, NULL, 'Make sure to get generics'),
(5, 2, 1, 'Bread', '2016-07-31 02:51:58', 0, 1, NULL, NULL, ''),
(6, 3, 1, 'Hammer', '2016-07-31 02:52:22', 0, 1, NULL, NULL, ''),
(7, 3, 1, 'Screw driver', '2016-07-31 02:53:06', 0, 1, NULL, NULL, 'Phillips head only'),
(8, 3, 1, 'Nails', '2016-07-31 02:53:46', 0, 1, NULL, NULL, 'Box of at least 100'),
(9, 4, 1, 'Tshirts', '2016-07-31 02:54:49', 0, 3, NULL, NULL, 'Plain white tee'),
(10, 4, 1, 'Dog food', '2016-07-31 02:55:17', 0, 1, NULL, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

CREATE TABLE `list` (
  `list_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`list_id`, `user_id`, `name`, `created_at`) VALUES
(1, 1, 'Show All', '2016-07-30 18:28:49'),
(2, 1, 'Grocery Store', '2016-07-30 18:28:50'),
(3, 1, 'Hardware Store', '2016-07-31 02:51:12'),
(4, 1, 'Other', '2016-07-30 18:28:51');

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
(1, 1, 'James', 'Hume', 'james@hume.com', '1234', '2016-07-31 02:55:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`list_id`);

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
  MODIFY `item_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `list`
--
ALTER TABLE `list`
  MODIFY `list_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;