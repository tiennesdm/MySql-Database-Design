-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2019 at 03:48 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `studentlive`
--

-- --------------------------------------------------------

--
-- Table structure for table `chaptersubtopic`
--

CREATE TABLE `chaptersubtopic` (
  `idchapterSubTopic` int(11) NOT NULL,
  `subtopicName` varchar(45) NOT NULL,
  `startTime` int(11) NOT NULL,
  `stopTime` int(11) NOT NULL,
  `gameId` int(11) NOT NULL,
  `videoId` int(11) NOT NULL,
  `chapterTopicId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `chaptertopic`
--

CREATE TABLE `chaptertopic` (
  `idchapterTopic` int(11) NOT NULL,
  `topicName` varchar(45) NOT NULL,
  `chapterId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `classchapter`
--

CREATE TABLE `classchapter` (
  `idchapter` int(11) NOT NULL,
  `chapterName` varchar(45) NOT NULL,
  `classId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `classdetail`
--

CREATE TABLE `classdetail` (
  `idclassDetail` int(11) NOT NULL,
  `className` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `classenrollments`
--

CREATE TABLE `classenrollments` (
  `idclassEnrollments` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `classId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `classtiming`
--

CREATE TABLE `classtiming` (
  `idclassTiming` int(11) NOT NULL,
  `startTime` timestamp NULL DEFAULT NULL,
  `endTime` timestamp NULL DEFAULT NULL,
  `classEnrollMent` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gameinfo`
--

CREATE TABLE `gameinfo` (
  `idgameInfo` int(11) NOT NULL,
  `gameUrl` varchar(45) NOT NULL,
  `gameName` varchar(200) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gamescore`
--

CREATE TABLE `gamescore` (
  `idgameScore` int(11) NOT NULL,
  `gameid` int(11) NOT NULL,
  `studentId` int(11) NOT NULL,
  `studentScore` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `classId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `studentenrollinclass`
--

CREATE TABLE `studentenrollinclass` (
  `idstudentEnrollinClass` int(11) NOT NULL,
  `studentLicId` int(11) NOT NULL,
  `classTimingId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `studentenrollinclass`
--
DELIMITER $$
CREATE TRIGGER `studentenrollinclass_BEFORE_INSERT` BEFORE INSERT ON `studentenrollinclass` FOR EACH ROW BEGIN


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `studentlicense`
--

CREATE TABLE `studentlicense` (
  `idstudentLicense` int(11) NOT NULL,
  `licenseId` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `studentId` int(11) NOT NULL,
  `creatAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `userauth`
--

CREATE TABLE `userauth` (
  `iduserAuth` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `logincount` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `blockStatus` enum('block','unblock') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `userauth`
--
DELIMITER $$
CREATE TRIGGER `userauth_BEFORE_INSERT` BEFORE INSERT ON `userauth` FOR EACH ROW BEGIN
IF NEW.`email` NOT LIKE '%_@%_.__%' THEN
		SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = '[table:userauth] - `email` column is not valid';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `userdetail`
--

CREATE TABLE `userdetail` (
  `iduserDetail` int(11) NOT NULL,
  `userName` varchar(45) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `dob` datetime NOT NULL,
  `acedemicYear` int(11) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `createdat` timestamp NOT NULL DEFAULT current_timestamp(),
  `roleName` enum('Teacher','Student','Admin','SuperAdmin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `videoinfo`
--

CREATE TABLE `videoinfo` (
  `idvideoInfo` int(11) NOT NULL,
  `videoName` varchar(200) NOT NULL,
  `videoPath` varchar(200) NOT NULL,
  `playerName` varchar(200) NOT NULL,
  `playerPath` varchar(200) NOT NULL,
  `videoLength` varchar(200) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chaptersubtopic`
--
ALTER TABLE `chaptersubtopic`
  ADD PRIMARY KEY (`idchapterSubTopic`),
  ADD KEY `idchapterTopic_idx` (`chapterTopicId`),
  ADD KEY `idvideoInfo_idx` (`videoId`),
  ADD KEY `idgameInfo_idx` (`gameId`),
  ADD KEY `subtopic_idx` (`subtopicName`);

--
-- Indexes for table `chaptertopic`
--
ALTER TABLE `chaptertopic`
  ADD PRIMARY KEY (`idchapterTopic`),
  ADD KEY `idchapter_idx` (`chapterId`),
  ADD KEY `topicName_idx` (`topicName`);

--
-- Indexes for table `classchapter`
--
ALTER TABLE `classchapter`
  ADD PRIMARY KEY (`idchapter`),
  ADD KEY `idclassDetail_idx` (`classId`);

--
-- Indexes for table `classdetail`
--
ALTER TABLE `classdetail`
  ADD PRIMARY KEY (`idclassDetail`),
  ADD KEY `className_idx` (`className`);

--
-- Indexes for table `classenrollments`
--
ALTER TABLE `classenrollments`
  ADD PRIMARY KEY (`idclassEnrollments`),
  ADD KEY `iduserAuth_idx` (`userId`),
  ADD KEY `idclassDetail_idx` (`classId`);

--
-- Indexes for table `classtiming`
--
ALTER TABLE `classtiming`
  ADD PRIMARY KEY (`idclassTiming`),
  ADD KEY `idclassEnrollments_idx` (`classEnrollMent`);

--
-- Indexes for table `gameinfo`
--
ALTER TABLE `gameinfo`
  ADD PRIMARY KEY (`idgameInfo`),
  ADD KEY `gameName_idx` (`gameName`),
  ADD KEY `gameUrl_idx` (`gameUrl`);

--
-- Indexes for table `gamescore`
--
ALTER TABLE `gamescore`
  ADD PRIMARY KEY (`idgameScore`),
  ADD KEY `studentplayGame_idx` (`gameid`),
  ADD KEY `studentId _idx` (`studentId`),
  ADD KEY `studentclassId_idx` (`classId`);

--
-- Indexes for table `studentenrollinclass`
--
ALTER TABLE `studentenrollinclass`
  ADD PRIMARY KEY (`idstudentEnrollinClass`),
  ADD KEY `idclassTiming_idx` (`classTimingId`),
  ADD KEY `idstudentLicense_idx` (`studentLicId`);

--
-- Indexes for table `studentlicense`
--
ALTER TABLE `studentlicense`
  ADD PRIMARY KEY (`idstudentLicense`),
  ADD UNIQUE KEY `licenseId_UNIQUE` (`licenseId`),
  ADD KEY `iduserAuth_idx` (`studentId`);

--
-- Indexes for table `userauth`
--
ALTER TABLE `userauth`
  ADD PRIMARY KEY (`iduserAuth`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `userdetail`
--
ALTER TABLE `userdetail`
  ADD PRIMARY KEY (`iduserDetail`),
  ADD UNIQUE KEY `userName_UNIQUE` (`userName`),
  ADD KEY `firstName` (`firstName`),
  ADD KEY `mobile_idx` (`mobile`);

--
-- Indexes for table `videoinfo`
--
ALTER TABLE `videoinfo`
  ADD PRIMARY KEY (`idvideoInfo`),
  ADD KEY `videoName_idx` (`videoName`),
  ADD KEY `videoPath_idx` (`videoPath`),
  ADD KEY `playerName_idx` (`playerName`),
  ADD KEY `playerPath_idx` (`playerPath`),
  ADD KEY `videoLength_idx` (`videoLength`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chaptersubtopic`
--
ALTER TABLE `chaptersubtopic`
  MODIFY `idchapterSubTopic` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chaptertopic`
--
ALTER TABLE `chaptertopic`
  MODIFY `idchapterTopic` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classchapter`
--
ALTER TABLE `classchapter`
  MODIFY `idchapter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classdetail`
--
ALTER TABLE `classdetail`
  MODIFY `idclassDetail` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classenrollments`
--
ALTER TABLE `classenrollments`
  MODIFY `idclassEnrollments` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classtiming`
--
ALTER TABLE `classtiming`
  MODIFY `idclassTiming` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gameinfo`
--
ALTER TABLE `gameinfo`
  MODIFY `idgameInfo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentlicense`
--
ALTER TABLE `studentlicense`
  MODIFY `idstudentLicense` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userauth`
--
ALTER TABLE `userauth`
  MODIFY `iduserAuth` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userdetail`
--
ALTER TABLE `userdetail`
  MODIFY `iduserDetail` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `videoinfo`
--
ALTER TABLE `videoinfo`
  MODIFY `idvideoInfo` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chaptersubtopic`
--
ALTER TABLE `chaptersubtopic`
  ADD CONSTRAINT `idchapterTopic` FOREIGN KEY (`chapterTopicId`) REFERENCES `chaptertopic` (`idchapterTopic`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idgameInfo` FOREIGN KEY (`gameId`) REFERENCES `gameinfo` (`idgameInfo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idvideoInfo` FOREIGN KEY (`videoId`) REFERENCES `videoinfo` (`idvideoInfo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `chaptertopic`
--
ALTER TABLE `chaptertopic`
  ADD CONSTRAINT `idchapter` FOREIGN KEY (`chapterId`) REFERENCES `classchapter` (`idchapter`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `classchapter`
--
ALTER TABLE `classchapter`
  ADD CONSTRAINT `idclassDetail` FOREIGN KEY (`classId`) REFERENCES `classdetail` (`idclassDetail`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `classenrollments`
--
ALTER TABLE `classenrollments`
  ADD CONSTRAINT `authUserId` FOREIGN KEY (`userId`) REFERENCES `userauth` (`iduserAuth`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `classUserId` FOREIGN KEY (`classId`) REFERENCES `classdetail` (`idclassDetail`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `classtiming`
--
ALTER TABLE `classtiming`
  ADD CONSTRAINT `idclassEnrollments` FOREIGN KEY (`classEnrollMent`) REFERENCES `classenrollments` (`idclassEnrollments`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `gamescore`
--
ALTER TABLE `gamescore`
  ADD CONSTRAINT `studentId ` FOREIGN KEY (`studentId`) REFERENCES `userauth` (`iduserAuth`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `studentclassId` FOREIGN KEY (`classId`) REFERENCES `classdetail` (`idclassDetail`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `studentplayGame` FOREIGN KEY (`gameid`) REFERENCES `gameinfo` (`idgameInfo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `studentenrollinclass`
--
ALTER TABLE `studentenrollinclass`
  ADD CONSTRAINT `idclassTiming` FOREIGN KEY (`classTimingId`) REFERENCES `classtiming` (`idclassTiming`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `studentLicenseId` FOREIGN KEY (`studentLicId`) REFERENCES `studentlicense` (`idstudentLicense`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `studentlicense`
--
ALTER TABLE `studentlicense`
  ADD CONSTRAINT `studentUserAuthId` FOREIGN KEY (`studentId`) REFERENCES `userauth` (`iduserAuth`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userdetail`
--
ALTER TABLE `userdetail`
  ADD CONSTRAINT `iduserAuth` FOREIGN KEY (`iduserDetail`) REFERENCES `userauth` (`iduserAuth`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
