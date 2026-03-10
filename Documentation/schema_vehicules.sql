-- Création de la base de données
CREATE DATABASE IF NOT EXISTS vehicules CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE vehicules;

-- Table des utilisateurs
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    numero VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    role ENUM('admin', 'client') DEFAULT 'client',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
insert into users (nom, prenom, numero, email, mot_de_passe, role) values ('admin', 'admin', '0000000000', 'admin@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- Table des véhicules
CREATE TABLE IF NOT EXISTS voitures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2),
    type VARCHAR(50),
    puissance INT,
    vitesse_max INT,
    acceleration FLOAT,
    nitro FLOAT,
    image_url VARCHAR(255)
);

-- Table des demandes d'essai
CREATE TABLE IF NOT EXISTS demandes_essai (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    marque VARCHAR(100),
    modele VARCHAR(100),
    date_essai DATE,
    heure_essai TIME,
    lieu_essai VARCHAR(100),
    commentaire TEXT,
    date_demande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS reservations_services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    date_reservation DATE NOT NULL,
    heure_reservation TIME NOT NULL,
    statut ENUM('en_attente', 'confirmee', 'annulee') DEFAULT 'en_attente',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE
);

-- Création de la table services
CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertion des données dans la table services
INSERT INTO services (nom, description, prix, image_url) VALUES
('Essai de voiture', 'Testez votre voiture de rêve sur notre circuit privé. Une expérience unique pour découvrir les performances de votre véhicule.', 3000.00, 'image/3.png'),
('Entretien voiture', 'Service complet d''entretien de votre véhicule par nos experts certifiés. Nous prenons soin de votre voiture comme si c''était la nôtre.', 5000.00, 'image/2.png'),
('Polissage carrosserie', 'Donnez un aspect neuf à votre voiture avec notre service de polissage professionnel. Protection et brillance garanties.', 10000.00, 'image/4.png');

-- Insérer les véhicules dans la table 'voitures'
INSERT INTO voitures (marque, modele, description, prix, type, puissance, vitesse_max, acceleration, nitro, image_url) VALUES
('BMW', 'BMW M4 Competition', 'Moteur 6 cylindres en ligne, 510 ch, Performance et design exceptionnels.', 85000, 'Sport', 510, 280, 3.9, 2.0, 'image/a.png'),
('BMW', 'BMW 8 Series', 'Luxe et performance combinés avec 523 ch.', 100000, 'Coupé', 523, 300, 4.0, 2.1, 'image/b.png'),
('BMW', 'BMW X5 M', 'SUV haut de gamme avec 617 ch.', 110000, 'SUV', 617, 250, 4.1, 2.2, 'image/c.png'),
('BMW', 'BMW Z4', 'Roadster compact avec moteur 4 cylindres, 350 ch.', 60000, 'Cabriolet', 350, 250, 4.5, 2.0, 'image/d.png'),
('BMW', 'BMW X4 Sports', 'SUV sportif avec 425 ch.', 75000, 'SUV', 425, 240, 4.5, 2.0, 'image/e.png'),
('Porsche', 'Porsche Taycan', 'Voiture électrique haut de gamme avec moteur de 600 ch.', 110000, 'Electric', 600, 250, 2.8, 2.5, 'image/f.png'),
('Porsche', 'Porsche 911 (992)', 'Le coupé légendaire avec moteur de 450 ch.', 120000, 'Coupé', 450, 300, 3.4, 2.7, 'image/g.png'),
('Porsche', 'Porsche Cayenne', 'SUV luxueux avec moteur de 350 ch.', 95000, 'SUV', 350, 220, 6.0, 2.1, 'image/h.png'),
('Porsche', 'Porsche 911 Turbo', 'Porsche 911 avec moteur de 600 ch.', 150000, 'Coupé', 600, 320, 3.0, 2.8, 'image/i.png'),
('Porsche', 'Porsche Macan Turbo', 'SUV sportif avec moteur de 400 ch.', 80000, 'SUV', 400, 250, 5.4, 2.4, 'image/j.png'),
('Mercedes', 'Mercedes-AMG GLA 35', 'SUV compact de performance avec moteur 4 cylindres, 302 ch.', 55000, 'SUV', 302, 250, 5.1, 2.2, 'image/k.png'),
('Mercedes', 'Mercedes-AMG C-Class Estate', 'Break sportif avec moteur V8, 503 ch.', 70000, 'Break', 503, 270, 4.2, 2.3, 'image/l.png'),
('Mercedes', 'Mercedes-AMG C-Class Coupe', 'Coupé sportif avec moteur V8, 503 ch.', 75000, 'Coupé', 503, 280, 4.0, 2.4, 'image/m.png'),
('Mercedes', 'Mercedes-AMG A-Class', 'Compact de luxe avec moteur 4 cylindres, 302 ch.', 45000, 'Compact', 302, 250, 5.1, 2.2, 'image/n.png'),
('Mercedes', 'Mercedes-AMG G-Class', 'SUV emblématique avec moteur V8, 577 ch.', 135000, 'SUV', 577, 220, 4.0, 2.5, 'image/o.png');

-- Création de la table reservations_services
