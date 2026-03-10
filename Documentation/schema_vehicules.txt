-- ===================================
-- CRÉATION DE LA BASE DE DONNÉES
-- ===================================
CREATE DATABASE IF NOT EXISTS vehicules CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE vehicules;

-- ===================================
-- TABLE 1: USERS (Utilisateurs)
-- ===================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    numero VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    ville VARCHAR(100),
    code_postal VARCHAR(10),
    role ENUM('admin', 'client') DEFAULT 'client',
    statut ENUM('actif', 'inactif', 'suspendu') DEFAULT 'actif',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_statut (statut)
);

-- Insérer l'administrateur
INSERT INTO users (nom, prenom, numero, email, mot_de_passe, adresse, ville, code_postal, role) 
VALUES ('admin', 'admin', '0000000000', 'admin@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '123 Rue Admin', 'Paris', '75000', 'admin');

-- ===================================
-- TABLE 2: MARQUES (Marques automobiles)
-- ===================================
CREATE TABLE IF NOT EXISTS marques (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(255),
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insérer les marques
INSERT INTO marques (nom, description, logo_url) VALUES
('BMW', 'Constructeur automobile allemand de luxe et de performance', 'image/bmw_logo.png'),
('Porsche', 'Manufacture de voitures de sport et de luxe allemande', 'image/porsche_logo.png'),
('Mercedes', 'Marque de prestige allemande, division de Daimler', 'image/mercedes_logo.png');

-- ===================================
-- TABLE 3: VOITURES (Catalogue des véhicules)
-- ===================================
CREATE TABLE IF NOT EXISTS voitures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marque_id INT NOT NULL,
    modele VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(12,2) NOT NULL,
    type VARCHAR(50) NOT NULL,
    puissance INT NOT NULL COMMENT 'en chevaux (ch)',
    vitesse_max INT NOT NULL COMMENT 'en km/h',
    acceleration FLOAT NOT NULL COMMENT '0-100 km/h en secondes',
    nitro FLOAT DEFAULT 0 COMMENT 'bonus de performance',
    image_url VARCHAR(255),
    couleur VARCHAR(50),
    annee INT,
    kilom INT DEFAULT 0,
    disponibilite ENUM('disponible', 'reserve', 'maintenance') DEFAULT 'disponible',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (marque_id) REFERENCES marques(id) ON DELETE RESTRICT,
    INDEX idx_marque_id (marque_id),
    INDEX idx_disponibilite (disponibilite),
    INDEX idx_type (type)
);

-- Insérer les véhicules
INSERT INTO voitures (marque_id, modele, description, prix, type, puissance, vitesse_max, acceleration, nitro, image_url, couleur, annee) VALUES
(1, 'BMW M4 Competition', 'Moteur 6 cylindres en ligne, 510 ch, Performance et design exceptionnels.', 85000.00, 'Sport', 510, 280, 3.9, 2.0, 'image/a.png', 'Noir', 2023),
(1, 'BMW 8 Series', 'Luxe et performance combinés avec 523 ch.', 100000.00, 'Coupé', 523, 300, 4.0, 2.1, 'image/b.png', 'Argent', 2023),
(1, 'BMW X5 M', 'SUV haut de gamme avec 617 ch.', 110000.00, 'SUV', 617, 250, 4.1, 2.2, 'image/c.png', 'Noir', 2023),
(1, 'BMW Z4', 'Roadster compact avec moteur 4 cylindres, 350 ch.', 60000.00, 'Cabriolet', 350, 250, 4.5, 2.0, 'image/d.png', 'Bleu', 2023),
(1, 'BMW X4 Sports', 'SUV sportif avec 425 ch.', 75000.00, 'SUV', 425, 240, 4.5, 2.0, 'image/e.png', 'Blanc', 2023),
(2, 'Porsche Taycan', 'Voiture électrique haut de gamme avec moteur de 600 ch.', 110000.00, 'Electric', 600, 250, 2.8, 2.5, 'image/f.png', 'Gris', 2023),
(2, 'Porsche 911 (992)', 'Le coupé légendaire avec moteur de 450 ch.', 120000.00, 'Coupé', 450, 300, 3.4, 2.7, 'image/g.png', 'Rouge', 2023),
(2, 'Porsche Cayenne', 'SUV luxueux avec moteur de 350 ch.', 95000.00, 'SUV', 350, 220, 6.0, 2.1, 'image/h.png', 'Noir', 2023),
(2, 'Porsche 911 Turbo', 'Porsche 911 avec moteur de 600 ch.', 150000.00, 'Coupé', 600, 320, 3.0, 2.8, 'image/i.png', 'Jaune', 2023),
(2, 'Porsche Macan Turbo', 'SUV sportif avec moteur de 400 ch.', 80000.00, 'SUV', 400, 250, 5.4, 2.4, 'image/j.png', 'Noir', 2023),
(3, 'Mercedes-AMG GLA 35', 'SUV compact de performance avec moteur 4 cylindres, 302 ch.', 55000.00, 'SUV', 302, 250, 5.1, 2.2, 'image/k.png', 'Blanc', 2023),
(3, 'Mercedes-AMG C-Class Estate', 'Break sportif avec moteur V8, 503 ch.', 70000.00, 'Break', 503, 270, 4.2, 2.3, 'image/l.png', 'Noir', 2023),
(3, 'Mercedes-AMG C-Class Coupe', 'Coupé sportif avec moteur V8, 503 ch.', 75000.00, 'Coupé', 503, 280, 4.0, 2.4, 'image/m.png', 'Argent', 2023),
(3, 'Mercedes-AMG A-Class', 'Compact de luxe avec moteur 4 cylindres, 302 ch.', 45000.00, 'Compact', 302, 250, 5.1, 2.2, 'image/n.png', 'Bleu', 2023),
(3, 'Mercedes-AMG G-Class', 'SUV emblématique avec moteur V8, 577 ch.', 135000.00, 'SUV', 577, 220, 4.0, 2.5, 'image/o.png', 'Noir', 2023);

-- ===================================
-- TABLE 4: SERVICES (Services disponibles)
-- ===================================
CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    duree_minutes INT DEFAULT 60 COMMENT 'Durée du service en minutes',
    image_url VARCHAR(255),
    statut ENUM('actif', 'inactif') DEFAULT 'actif',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_statut (statut)
);

-- Insérer les services
INSERT INTO services (nom, description, prix, duree_minutes, image_url) VALUES
('Essai de voiture', 'Testez votre voiture de rêve sur notre circuit privé. Une expérience unique pour découvrir les performances de votre véhicule.', 3000.00, 60, 'image/3.png'),
('Entretien voiture', 'Service complet d''entretien de votre véhicule par nos experts certifiés. Nous prenons soin de votre voiture comme si c''était la nôtre.', 5000.00, 120, 'image/2.png'),
('Polissage carrosserie', 'Donnez un aspect neuf à votre voiture avec notre service de polissage professionnel. Protection et brillance garanties.', 10000.00, 180, 'image/4.png');

-- ===================================
-- TABLE 5: DEMANDES_ESSAI (Demandes d'essai)
-- ===================================
CREATE TABLE IF NOT EXISTS demandes_essai (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    voiture_id INT NOT NULL,
    date_essai DATE NOT NULL,
    heure_essai TIME NOT NULL,
    lieu_essai VARCHAR(100) NOT NULL,
    commentaire TEXT,
    statut ENUM('en_attente', 'confirmee', 'realisee', 'annulee', 'reportee') DEFAULT 'en_attente',
    date_demande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (voiture_id) REFERENCES voitures(id) ON DELETE RESTRICT,
    INDEX idx_user_id (user_id),
    INDEX idx_voiture_id (voiture_id),
    INDEX idx_statut (statut),
    INDEX idx_date_essai (date_essai)
);

-- ===================================
-- TABLE 6: RESERVATIONS_SERVICES (Réservations de services)
-- ===================================
CREATE TABLE IF NOT EXISTS reservations_services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    voiture_id INT,
    date_reservation DATE NOT NULL,
    heure_reservation TIME NOT NULL,
    date_fin_prevue DATETIME COMMENT 'Date et heure de fin prévue',
    statut ENUM('en_attente', 'confirmee', 'en_cours', 'completee', 'annulee') DEFAULT 'en_attente',
    prix_final DECIMAL(10,2),
    notes TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE RESTRICT,
    FOREIGN KEY (voiture_id) REFERENCES voitures(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_service_id (service_id),
    INDEX idx_voiture_id (voiture_id),
    INDEX idx_statut (statut),
    INDEX idx_date_reservation (date_reservation)
);

-- ===================================
-- TABLE 7: AVIS_CLIENTS (Avis et commentaires)
-- ===================================
CREATE TABLE IF NOT EXISTS avis_clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    voiture_id INT NOT NULL,
    note INT NOT NULL CHECK (note >= 1 AND note <= 5),
    titre VARCHAR(100),
    commentaire TEXT,
    date_avis TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (voiture_id) REFERENCES voitures(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_voiture_id (voiture_id),
    INDEX idx_note (note)
);

-- ===================================
-- TABLE 8: PAIEMENTS (Factures et paiements)
-- ===================================
CREATE TABLE IF NOT EXISTS paiements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    reservation_id INT,
    demande_essai_id INT,
    montant DECIMAL(12,2) NOT NULL,
    mode_paiement ENUM('carte_credit', 'virement', 'cheque', 'especes') NOT NULL,
    statut ENUM('en_attente', 'confirme', 'echoue', 'remboursee') DEFAULT 'en_attente',
    numero_transaction VARCHAR(100) UNIQUE,
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reservation_id) REFERENCES reservations_services(id) ON DELETE SET NULL,
    FOREIGN KEY (demande_essai_id) REFERENCES demandes_essai(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_statut (statut),
    INDEX idx_date_paiement (date_paiement)
);

-- ===================================
-- TABLE 9: MAINTENANCE (Entretien des véhicules)
-- ===================================
CREATE TABLE IF NOT EXISTS maintenance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voiture_id INT NOT NULL,
    type_maintenance ENUM('revision', 'reparation', 'inspection', 'nettoyage') NOT NULL,
    description TEXT,
    date_debut DATE NOT NULL,
    date_fin DATE,
    cout DECIMAL(10,2),
    statut ENUM('programmee', 'en_cours', 'completee', 'annulee') DEFAULT 'programmee',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voiture_id) REFERENCES voitures(id) ON DELETE CASCADE,
    INDEX idx_voiture_id (voiture_id),
    INDEX idx_statut (statut),
    INDEX idx_type (type_maintenance)
);

-- ===================================
-- TABLE 10: HISTORIQUE_ACTIONS (Audit trail)
-- ===================================
CREATE TABLE IF NOT EXISTS historique_actions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action VARCHAR(100) NOT NULL,
    description TEXT,
    table_name VARCHAR(50),
    record_id INT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_date_action (date_action)
);

-- ===================================
-- VUES SQL UTILES
-- ===================================

-- Vue: Voitures disponibles
CREATE OR REPLACE VIEW voitures_disponibles AS
SELECT 
    v.id,
    m.nom as marque,
    v.modele,
    v.prix,
    v.type,
    v.puissance,
    v.vitesse_max,
    v.image_url,
    v.disponibilite
FROM voitures v
JOIN marques m ON v.marque_id = m.id
WHERE v.disponibilite = 'disponible'
ORDER BY v.prix DESC;

-- Vue: Statistiques des réservations
CREATE OR REPLACE VIEW stats_reservations AS
SELECT 
    DATE(r.date_reservation) as date_reservation,
    COUNT(*) as total_reservations,
    SUM(CASE WHEN r.statut = 'confirmee' THEN 1 ELSE 0 END) as confirmees,
    SUM(CASE WHEN r.statut = 'completee' THEN 1 ELSE 0 END) as completees,
    SUM(r.prix_final) as revenue_total
FROM reservations_services r
GROUP BY DATE(r.date_reservation)
ORDER BY date_reservation DESC;

-- Vue: Demandes essai en attente
CREATE OR REPLACE VIEW demandes_essai_attente AS
SELECT 
    d.id,
    u.nom,
    u.prenom,
    u.email,
    m.nom as marque,
    v.modele,
    d.date_essai,
    d.heure_essai,
    d.lieu_essai
FROM demandes_essai d
JOIN users u ON d.user_id = u.id
JOIN voitures v ON d.voiture_id = v.id
JOIN marques m ON v.marque_id = m.id
WHERE d.statut = 'en_attente'
ORDER BY d.date_essai ASC;

-- ===================================
-- FIN DU SCRIPT
-- ===================================