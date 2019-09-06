-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2019 at 05:45 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grivato`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `a_username` varchar(20) NOT NULL,
  `a_password` varchar(20) NOT NULL,
  `a_isAdmin` tinyint(1) NOT NULL,
  `a_c_id` int(11) DEFAULT NULL,
  `a_isVerified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`a_username`, `a_password`, `a_isAdmin`, `a_c_id`, `a_isVerified`) VALUES
('ad', 'ad', 0, 4, 1),
('admin', 'admin', 1, NULL, 1),
('anthony', 'bia2', 0, 12, 1),
('dmash', 'dmash1', 0, 1, 0),
('dmash2', 'dmash', 0, 8, 1),
('rami', '123123', 0, 11, 1),
('tofi', 'tofi1', 0, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `c_id` int(11) NOT NULL,
  `c_fname` varchar(30) NOT NULL,
  `c_lname` varchar(30) NOT NULL,
  `c_phone` int(15) NOT NULL,
  `c_email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`c_id`, `c_fname`, `c_lname`, `c_phone`, `c_email`) VALUES
(1, 'Mohammad', 'Dimashkieh', 76434589, 'm.dimashkieh13198@gmail.com'),
(2, 'Rabih', 'Kadi', 70655288, 'rabih.kadi@gmail.com'),
(4, 'ad', 'ad', 1273478293, 'ad@ad.ad'),
(5, 'Toufic', 'Shararah', 70822791, 'tofi@gmail.com'),
(8, 'dmash', 'music', 76434589, 'dmashbeats@gmail.com'),
(11, 'Rami', 'Debs', 81746815, 'corabica97@gmail.com'),
(12, 'bia', 'bia', 70655288, 'rabih_kadi@hotmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `p_id` int(11) NOT NULL,
  `p_r_id` int(11) NOT NULL,
  `p_details` varchar(1000) NOT NULL,
  `p_price` double NOT NULL,
  `p_from` date NOT NULL,
  `p_to` date NOT NULL,
  `p_img` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`p_id`, `p_r_id`, `p_details`, `p_price`, `p_from`, `p_to`, `p_img`) VALUES
(1, 1, 'Marmaris Park Hotel features a restaurant and free WiFi. The hotel has a spa centre and sauna, and guests can enjoy a meal at the restaurant or a drink at the bar. Free private parking is available on site.', 330, '2019-07-01', '2019-07-14', 'IMG/marmaris.jpg'),
(2, 4, 'Astra Suites offer a swimming pool and air-conditioned units with balconies overlooking the Aegean Sea and Santorini surroundings.', 500, '2018-06-10', '2018-06-17', 'IMG/asta.jpg'),
(3, 4, 'Test test test', 500, '2020-01-01', '2020-02-01', 'IMG/samabe.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `re_id` int(11) NOT NULL,
  `re_p_id` int(11) NOT NULL,
  `re_c_id` int(11) NOT NULL,
  `re_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`re_id`, `re_p_id`, `re_c_id`, `re_quantity`) VALUES
(10, 2, 1, 2),
(12, 1, 5, 4),
(13, 2, 12, 2),
(14, 3, 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `resort`
--

CREATE TABLE `resort` (
  `r_id` int(11) NOT NULL,
  `r_name` varchar(50) NOT NULL,
  `r_location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `resort`
--

INSERT INTO `resort` (`r_id`, `r_name`, `r_location`) VALUES
(1, 'Marmaris Park Hotel', 'Marmaris, Turkey'),
(2, 'Astra Suits', 'Santorini, Greece'),
(4, 'Samabe', 'Bali, Test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`a_username`),
  ADD KEY `a_c_id` (`a_c_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`c_id`),
  ADD UNIQUE KEY `c_email` (`c_email`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `p_r_id` (`p_r_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`re_id`),
  ADD KEY `reservation_ibfk_1` (`re_p_id`),
  ADD KEY `re_c_id` (`re_c_id`);

--
-- Indexes for table `resort`
--
ALTER TABLE `resort`
  ADD PRIMARY KEY (`r_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `re_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `resort`
--
ALTER TABLE `resort`
  MODIFY `r_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`a_c_id`) REFERENCES `client` (`c_id`);

--
-- Constraints for table `package`
--
ALTER TABLE `package`
  ADD CONSTRAINT `package_ibfk_1` FOREIGN KEY (`p_r_id`) REFERENCES `resort` (`r_id`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`re_p_id`) REFERENCES `package` (`p_id`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`re_c_id`) REFERENCES `client` (`c_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
