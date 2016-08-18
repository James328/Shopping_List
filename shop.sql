-- phpMyAdmin SQL Dump
-- version 4.4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Aug 18, 2016 at 03:54 AM
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
  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(4,2) DEFAULT NULL,
  `price_type` int(11) DEFAULT NULL,
  `notes` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `list_id`, `user_id`, `name`, `created_at`, `status`, `quantity`, `price`, `price_type`, `notes`) VALUES
(1, 2, 'auth0|579d87ab9ad76e1663946aae', 'Oranges', '2016-08-08 00:59:41', 0, 4, '1.00', 2, ''),
(2, 2, 'auth0|579d87ab9ad76e1663946aae', 'Beer', '2016-08-18 01:40:06', 0, 2, '6.99', 2, 'Fat tire pls'),
(3, 2, 'auth0|579d87ab9ad76e1663946aae', 'Eggs', '2016-08-18 01:40:04', 0, 1, '5.99', NULL, 'Get the large size'),
(4, 4, 'auth0|579d87ab9ad76e1663946aae', 'Prescriptions', '2016-08-08 00:59:44', 0, 3, NULL, NULL, 'Make sure to get generics'),
(5, 2, 'auth0|579d87ab9ad76e1663946aae', 'Bread', '2016-08-08 00:59:45', 0, 1, NULL, NULL, ''),
(6, 3, 'auth0|579d87ab9ad76e1663946aae', 'Hammer', '2016-08-08 00:59:46', 0, 1, NULL, NULL, ''),
(7, 3, 'auth0|579d87ab9ad76e1663946aae', 'Screw driver', '2016-08-08 00:59:45', 0, 1, NULL, NULL, 'Phillips head only'),
(8, 3, 'auth0|579d87ab9ad76e1663946aae', 'Nails', '2016-08-08 00:59:47', 0, 1, NULL, NULL, 'Box of at least 100'),
(9, 4, 'auth0|579d87ab9ad76e1663946aae', 'Tshirts', '2016-08-08 00:59:48', 0, 3, NULL, NULL, 'Plain white tee'),
(10, 4, 'auth0|579d87ab9ad76e1663946aae', 'Dog food', '2016-08-08 00:59:49', 0, 1, NULL, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

CREATE TABLE `list` (
  `list_id` mediumint(8) unsigned NOT NULL,
  `user_id` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`list_id`, `user_id`, `name`, `created_at`) VALUES
(2, 'auth0|579d87ab9ad76e1663946aae', 'Grocery Store', '2016-08-08 01:42:23'),
(3, 'auth0|579d87ab9ad76e1663946aae', 'Hardware Store', '2016-08-08 01:42:25'),
(4, 'auth0|579d87ab9ad76e1663946aae', 'Other', '2016-08-08 01:42:25');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `auth_id` varchar(30) NOT NULL,
  `active_list` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `auth_id`, `active_list`, `created_at`) VALUES
(1, 'auth0|579d87ab9ad76e1663946aae', 1, '2016-08-18 01:44:06');

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
  MODIFY `item_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `list`
--
ALTER TABLE `list`
  MODIFY `list_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;