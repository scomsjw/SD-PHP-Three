-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2018 at 04:30 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.0.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `films-multiple-tables`
--

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `certificates`
--

INSERT INTO `certificates` (`id`, `name`, `description`, `image`) VALUES
(1, 'U', 'Suitable for all', 'u-cert.png'),
(2, 'PG', 'Some scenes may be unsuitable for young children', 'pg-cert.png'),
(3, '12', 'Suitable for people aged 12 and over.', '12-cert.png'),
(4, '15', 'Suitable for people aged 15 and over.', '15-cert.png'),
(5, '18', 'Suitable for people aged 18 and over.', '18-cert.png');

-- --------------------------------------------------------

--
-- Table structure for table `films`
--

CREATE TABLE `films` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `year` smallint(6) NOT NULL,
  `duration` smallint(6) NOT NULL,
  `certificate_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `films`
--

INSERT INTO `films` (`id`, `title`, `year`, `duration`, `certificate_id`) VALUES
(1, 'Jaws', 1975, 124, 4),
(2, 'Winter\'s Bone', 2010, 100, 4),
(3, 'Do The Right Thing', 1989, 120, 4),
(4, 'The Incredibles', 2004, 115, 1),
(5, 'The Godfather', 1972, 177, 5),
(6, 'Dangerous Minds', 1995, 99, 4),
(7, 'Spirited Away', 2001, 124, 2),
(8, 'Moonlight', 2016, 111, 5),
(9, 'Life of PI', 2012, 127, 2),
(10, 'Gravity', 2013, 91, 3),
(11, 'Arrival', 2016, 116, 3),
(12, 'Wonder Woman', 2017, 141, 3),
(13, 'Mean Girls', 2004, 97, 4),
(14, 'Inception', 2010, 108, 3),
(15, 'Donnie Darko', 2001, 113, 4),
(16, 'Get Out', 2017, 103, 4);

-- --------------------------------------------------------

--
-- Table structure for table `film_genre`
--

CREATE TABLE `film_genre` (
  `film_id` int(10) UNSIGNED NOT NULL,
  `genre_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `film_genre`
--

INSERT INTO `film_genre` (`film_id`, `genre_id`) VALUES
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 1),
(4, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 4),
(8, 1),
(9, 1),
(10, 7),
(11, 7),
(12, 4),
(13, 1),
(13, 3),
(14, 2),
(14, 7),
(15, 1),
(16, 6);

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`, `description`) VALUES
(1, 'Drama', 'Drama is a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone, focusing on in-depth development of realistic characters who must deal with realistic emotional struggles.'),
(2, 'Thriller', 'A Thriller is a story that is usually a mix of fear and excitement. It has traits from the suspense genre and often from the action, adventure or mystery genres, but the level of terror makes it borderline horror fiction at times as well. '),
(3, 'Comedy', 'Comedy is a story that tells about a series of funny or comical events, intended to make the audience laugh.'),
(4, 'Fantasy', 'A fantasy story is about magic or supernatural forces, rather than technology, though it often is made to include elements of other genres, such as science fiction elements, if it happens to take place in a modern or future era.'),
(5, 'Crime', 'A crime story is about a crime that is being committed or was committed. It can also be an account of a criminal\'s life. It often falls into the action or adventure genres.'),
(6, 'Horror', 'A horror story is told to deliberately scare or frighten the audience, through suspense, violence or shock.'),
(7, 'Science Fiction', 'Science fiction (often shortened to Sci-Fi or SF) is a genre of speculative fiction, typically dealing with imaginative concepts such as advanced science and technology, spaceflight, time travel, and extraterrestrial life. ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_films_certificates_certificate_id` (`certificate_id`);

--
-- Indexes for table `film_genre`
--
ALTER TABLE `film_genre`
  ADD PRIMARY KEY (`film_id`,`genre_id`),
  ADD KEY `fk_film_genre_films_genre_id` (`genre_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `films`
--
ALTER TABLE `films`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `films`
--
ALTER TABLE `films`
  ADD CONSTRAINT `fk_films_certificates_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `certificates` (`id`);

--
-- Constraints for table `film_genre`
--
ALTER TABLE `film_genre`
  ADD CONSTRAINT `fk_film_genre_films_film_id` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`),
  ADD CONSTRAINT `fk_film_genre_films_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
