-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-lorryc.alwaysdata.net
-- Generation Time: Apr 24, 2026 at 08:57 AM
-- Server version: 10.11.15-MariaDB
-- PHP Version: 8.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lorryc_vehicules`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`lorryc_user`@`%` PROCEDURE `sp_insert_demande_essai` (IN `p_user_id` INT, IN `p_marque` VARCHAR(100), IN `p_modele` VARCHAR(100), IN `p_date_essai` DATE, IN `p_heure_essai` TIME, IN `p_lieu_essai` VARCHAR(100), IN `p_commentaire` TEXT)   BEGIN
    IF EXISTS (
        SELECT 1 FROM demandes_essai
        WHERE date_essai = p_date_essai
          AND heure_essai = p_heure_essai
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Créneau déjà réservé : date et heure occupées.';
    ELSE
        INSERT INTO demandes_essai (user_id, marque, modele, date_essai, heure_essai, lieu_essai, commentaire)
        VALUES (p_user_id, p_marque, p_modele, p_date_essai, p_heure_essai, p_lieu_essai, p_commentaire);
    END IF;
END$$

CREATE DEFINER=`lorryc_user`@`%` PROCEDURE `sp_update_reservation_status` (IN `p_id` INT, IN `p_status` ENUM('en_attente','confirmee','annulee'))   BEGIN
    IF p_status NOT IN ('en_attente','confirmee','annulee') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Statut invalide.';
    ELSE
        UPDATE reservations_services
        SET statut = p_status
        WHERE id = p_id;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `demandes_essai`
--

CREATE TABLE `demandes_essai` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `marque` varchar(100) DEFAULT NULL,
  `modele` varchar(100) DEFAULT NULL,
  `date_essai` date DEFAULT NULL,
  `heure_essai` time DEFAULT NULL,
  `lieu_essai` varchar(100) DEFAULT NULL,
  `commentaire` text DEFAULT NULL,
  `date_demande` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `demandes_essai`
--

INSERT INTO `demandes_essai` (`id`, `user_id`, `marque`, `modele`, `date_essai`, `heure_essai`, `lieu_essai`, `commentaire`, `date_demande`) VALUES
(6, 4, 'bmw', 'BMW BMW M4 Competition', '2025-11-18', '07:00:00', 'Port Louis', '', '2025-11-18 14:02:57'),
(7, 1, 'Mercedes', 'Mercedes-AMG C-Class Estate', '2026-04-02', '10:11:00', 'Beau bassin', 'full option please', '2026-04-08 06:12:01'),
(8, 1, 'Peugeot', '208', '2024-01-15', '10:00:00', 'Paris', 'Test 1', '2026-04-09 09:32:55');

--
-- Triggers `demandes_essai`
--
DELIMITER $$
CREATE TRIGGER `trg_demandes_essai_before_insert` BEFORE INSERT ON `demandes_essai` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1 FROM demandes_essai
        WHERE date_essai = NEW.date_essai
          AND heure_essai = NEW.heure_essai
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Créneau déjà réservé : date et heure occupées.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservations_services`
--

CREATE TABLE `reservations_services` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `date_reservation` date NOT NULL,
  `heure_reservation` time NOT NULL,
  `statut` enum('en_attente','confirmee','annulee') DEFAULT 'en_attente',
  `date_creation` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reservations_services`
--

INSERT INTO `reservations_services` (`id`, `user_id`, `service_id`, `date_reservation`, `heure_reservation`, `statut`, `date_creation`) VALUES
(1, 3, 2, '2025-10-18', '09:00:00', 'en_attente', '2025-10-17 07:03:21'),
(2, 1, 1, '2026-04-09', '09:00:00', 'en_attente', '2026-04-08 06:10:41');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `nom`, `description`, `prix`, `image_url`, `date_creation`) VALUES
(1, 'Essai de voiture', 'Testez votre voiture de rêve sur notre circuit privé. Une expérience unique pour découvrir les performances de votre véhicule.', 3000.00, 'image/3.png', '2025-10-13 11:23:58'),
(2, 'Entretien voiture', 'Service complet d\'entretien de votre véhicule par nos experts certifiés. Nous prenons soin de votre voiture comme si c\'était la nôtre.', 5000.00, 'image/2.png', '2025-10-13 11:23:58'),
(3, 'Polissage carrosserie', 'Donnez un aspect neuf à votre voiture avec notre service de polissage professionnel. Protection et brillance garanties.', 10000.00, 'image/4.png', '2025-10-13 11:23:58');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `numero` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('admin','client') DEFAULT 'client',
  `date_creation` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nom`, `prenom`, `numero`, `email`, `mot_de_passe`, `role`, `date_creation`) VALUES
(1, 'admin', 'admin', '0000000000', 'admin@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', '2025-10-13 11:23:58'),
(2, 'RAZAFIMAHEFA', 'LORRYC IRINAH FAHENDRENA', '0348835571', 'l@gmail.com', '$2y$10$JefmwTogo3pPWfbNssz8Fui5Tte7U9tOOw7/HASlog/Cb6DuKfEea', 'client', '2025-10-17 06:53:14'),
(3, 'RAZAFIMAHEFA', 'LORRYC IRINAH FAHENDRENA', '0348835571', 'gk@gmail.com', '$2y$10$L1m8x336dWRV/jBjlxFOw.bZg0UZjkYJOPw1la7T5s/GOfVsKPPIW', 'client', '2025-10-17 07:01:20'),
(4, 'RAZAFINDRALAMBO', 'Miangaly', '000', 'miangalyaude@icloud.com', '$2y$10$aCW3Y/DU3T8Z0maxhjxAO.rI6.ml/DIvnhPeW2UJEQgB9tCj3plvy', 'client', '2025-11-18 11:15:06'),
(5, 'Client', 'sérieux', '55235678', 'client@gmail.com', '$2y$10$VgJETG1u8J5rCP3oCJkg8enrJXCHvSzZewAUciuzTIE/3buwhkx.m', 'client', '2026-04-08 06:43:47');

-- --------------------------------------------------------

--
-- Table structure for table `voitures`
--

CREATE TABLE `voitures` (
  `id` int(11) NOT NULL,
  `marque` varchar(50) NOT NULL,
  `modele` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `prix` decimal(10,2) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `puissance` int(11) DEFAULT NULL,
  `vitesse_max` int(11) DEFAULT NULL,
  `acceleration` float DEFAULT NULL,
  `nitro` float DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `voitures`
--

INSERT INTO `voitures` (`id`, `marque`, `modele`, `description`, `prix`, `type`, `puissance`, `vitesse_max`, `acceleration`, `nitro`, `image_url`) VALUES
(1, 'BMW', 'BMW M4 Competition', 'Moteur 6 cylindres en ligne, 510 ch, Performance et design exceptionnels.', 80000.00, 'Sport', 510, 280, 3, 2, 'image/a.png'),
(2, 'BMW', 'BMW 8 Series', 'Luxe et performance combinés avec 523 ch.', 130000.00, 'Coupé', 523, 300, 4, 2.1, 'image/b.png'),
(3, 'BMW', 'BMW X5 M', 'SUV haut de gamme avec 617 ch.', 129999.99, 'SUV', 617, 250, 4, 2.2, 'image/c.png'),
(4, 'BMW', 'BMW Z4', 'Roadster compact avec moteur 4 cylindres, 350 ch.', 80000.00, 'Cabriolet', 350, 250, 4, 2, 'image/d.png'),
(5, 'BMW', 'BMW X4 Sports', 'SUV sportif avec 425 ch.', 79999.98, 'SUV', 425, 240, 4, 2, 'image/e.png'),
(6, 'Porsche', 'Porsche Taycan', 'Voiture électrique haut de gamme avec moteur de 600 ch.', 115000.00, 'Electric', 600, 250, 2, 2.5, 'image/f.png'),
(7, 'Porsche', 'Porsche 911 (992)', 'Le coupé légendaire avec moteur de 450 ch.', 120000.00, 'Coupé', 450, 300, 3.4, 2.7, 'image/g.png'),
(8, 'Porsche', 'Porsche Cayenne', 'SUV luxueux avec moteur de 350 ch.', 99999.00, 'SUV', 350, 220, 6, 2.1, 'image/h.png'),
(9, 'Porsche', 'Porsche 911 Turbo', 'Porsche 911 avec moteur de 600 ch.', 160000.00, 'Coupé', 600, 320, 3, 2.8, 'image/i.png'),
(10, 'Porsche', 'Porsche Macan Turbo', 'SUV sportif avec moteur de 400 ch.', 84999.00, 'SUV', 400, 250, 5, 2.4, 'image/j.png'),
(11, 'Mercedes', 'Mercedes-AMG GLA 35', 'SUV compact de performance avec moteur 4 cylindres, 302 ch.', 60000.00, 'SUV', 302, 250, 5, 2.2, 'image/k.png'),
(12, 'Mercedes', 'Mercedes-AMG C-Class Estate', 'Break sportif avec moteur V8, 503 ch.', 75000.00, 'Break', 503, 270, 4, 2.3, 'image/l.png'),
(13, 'Mercedes', 'Mercedes-AMG C-Class Coupe', 'Coupé sportif avec moteur V8, 503 ch.', 75000.00, 'Coupé', 503, 280, 4, 2.4, 'image/m.png'),
(14, 'Mercedes', 'Mercedes-AMG A-Class', 'Compact de luxe avec moteur 4 cylindres, 302 ch.', 49999.00, 'Compact', 302, 250, 6, 3, 'image/n.png'),
(15, 'Mercedes', 'Mercedes-AMG G-Class', 'SUV emblématique avec moteur V8, 577 ch.', 135000.00, 'SUV', 577, 220, 4, 2.5, 'image/o.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `demandes_essai`
--
ALTER TABLE `demandes_essai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reservations_services`
--
ALTER TABLE `reservations_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `voitures`
--
ALTER TABLE `voitures`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `demandes_essai`
--
ALTER TABLE `demandes_essai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reservations_services`
--
ALTER TABLE `reservations_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `voitures`
--
ALTER TABLE `voitures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `demandes_essai`
--
ALTER TABLE `demandes_essai`
  ADD CONSTRAINT `demandes_essai_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `reservations_services`
--
ALTER TABLE `reservations_services`
  ADD CONSTRAINT `reservations_services_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
