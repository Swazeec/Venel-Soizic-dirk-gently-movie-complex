-- Dans le terminal de xampp, pour se connecter à la bdd :
-- mysql -h localhost -u root -p
-- password vide (dans mon cas, en local, pour l'exercice. Pour un vrai projet, j'aurais mis un mdp fort.)

-- ***** CREATION BDD *****

CREATE DATABASE IF NOT EXISTS movieTheatersComplex DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;

USE movieTheatersComplex;
SET default_storage_engine = InnoDB;

-- ***** CREATION TABLES *****

CREATE TABLE IF NOT EXISTS managers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(60) NOT NULL
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS movieTheaters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    postal_code INT(5) NOT NULL,
    manager_id INT UNIQUE,
    FOREIGN KEY (manager_id) REFERENCES managers(id)
    ) engine = InnoDB;

CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(60) NOT NULL
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS admin_theaters (
  admin_id INT NOT NULL,
  movieTheater_id INT NOT NULL,
  PRIMARY KEY (admin_id, movieTheater_id),
  FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE,
  FOREIGN KEY (movieTheater_id) REFERENCES movieTheaters(id) ON DELETE CASCADE
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    nb_places INT NOT NULL,
    movieTheater_id INT NOT NULL,
    FOREIGN KEY (movieTheater_id) REFERENCES movieTheaters(id)
    ) engine = InnoDB;

CREATE TABLE IF NOT EXISTS movies(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    genre VARCHAR(50),
    duration VARCHAR(6)
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS sessions(
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    hour TIME NOT NULL,
    reserved_places INT DEFAULT 0,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS paymentType(
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(20) NOT NULL
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS states(
    id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(40) NOT NULL
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS prices(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    price DECIMAL(4,2) NOT NULL
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS clients(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    email VARCHAR(60) NOT NULL,
    password VARCHAR(60) NOT NULL,
    place_price_id INT NOT NULL,
    FOREIGN KEY (place_price_id) REFERENCES prices(id)
) engine = InnoDB;

CREATE TABLE IF NOT EXISTS reservations(
    id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    payment_type_id INT NOT NULL,
    state_id INT NOT NULL,
    client_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    FOREIGN KEY (payment_type_id) REFERENCES paymentType(id),
    FOREIGN KEY (state_id) REFERENCES states(id)
) engine = InnoDB;

-- ***** AJOUT DONNEES *****

-- ajouter des managers
INSERT INTO managers (name, firstname, email, password) VALUES ('Tookey', 'Francine', 'ftookey0@so-net.ne.jp', '$2y$10$uND9DWnF10edGrWvULp.b.qMX0PaTvoYefCFviuRdqYvbTuE7./xO');
INSERT INTO managers (name, firstname, email, password) VALUES ('Goulder', 'Nerte', 'ngoulder1@sbwire.com', '$2y$10$eL4KTFwMK9psbY4aWegFFOqAt.pulAIDQ6fHrNdq5b.MICXXks8V6');
INSERT INTO managers (name, firstname, email, password) VALUES ('Grunwall', 'Della', 'dgrunwall2@walmart.com', '$2y$10$Od7ddUEIILM7Xzb259bNWeTzWHrVyHPQNuEHUgytdOzkrTiKLYc0i');
INSERT INTO managers (name, firstname, email, password) VALUES ('Luebbert', 'Paco', 'pluebbert3@google.fr', '$2y$10$xJCeWj/o943OkD5sFnUN/uvwVyE1z64EZYhyyv5DQgzS6qYnxIsFS');
INSERT INTO managers (name, firstname, email, password) VALUES ('Biddleston', 'Manya', 'mbiddleston4@spiegel.de', '$2y$10$itxm5nRpRQn3MfhjBnB7Duw67JaYeq0W9ldcyenMg02ljB.na6TjO');

-- ajouter des cinémas
INSERT INTO movieTheaters (name, city, address, postal_code, manager_id) VALUES ('Hermiston-Erdman', 'Paris', '7 Northland Road', 75004, 1);
INSERT INTO movieTheaters (name, city, address, postal_code, manager_id) VALUES ('Collier, Kiehn and Jacobs', 'Rennes', '60 Ridgeview Plaza', 35000, 2);
INSERT INTO movieTheaters (name, city, address, postal_code, manager_id) VALUES ('Fahey, Koelpin and Beier', 'Nantes', '88171 Rutledge Way', 44000, 3);
INSERT INTO movieTheaters (name, city, address, postal_code, manager_id) VALUES ('Windler and Sons', 'Lyon', '72423 Division Center', 69000, 4);
INSERT INTO movieTheaters (name, city, address, postal_code, manager_id) VALUES ('Fisher Group', 'Bordeaux', '20 Tennessee Circle', 33000, 5);

-- ajouter des admins

INSERT INTO admins (name, firstname, email, password) VALUES ('Tibbotts', 'Celestina', 'ctibbotts0@ftc.gov', '$2y$10$fxGqPejIKFI7PLJfpd9uB.c1/JtPo.JSyjlpoZ524Wz3iV97IKoc6');
INSERT INTO admins (name, firstname, email, password) VALUES ('Clines', 'Ingram', 'iclines1@buzzfeed.com', '$2y$10$XPOVCywuBc2baBItJH/Y4eiAH4KYaYbF6gKZHxS6./FS3x/aUsMcu');

-- lier les admins aux cinémas

INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (1, 1);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (1, 2);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (1, 3);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (1, 4);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (1, 5);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (2, 1);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (2, 2);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (2, 3);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (2, 4);
INSERT INTO admin_theaters (admin_id, movieTheater_id) VALUES (2, 5);

-- ajouter des salles

INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Rorke', 70, 1);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Alford', 30, 2);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Dannye', 100, 3);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Berke', 70, 4);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Michal', 100, 5);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Clarissa', 100, 1);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Blondy', 100, 2);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Powell', 100, 3);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Janean', 100, 4);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Petronilla', 100, 5);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Evy', 100, 1);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Luca', 80, 2);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Dal', 80, 3);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Ayn', 80, 4);
INSERT INTO rooms (name, nb_places, movieTheater_id) VALUES ('salle Nedda', 80, 5);

-- ajouter des films

INSERT INTO movies (name, description, genre, duration) VALUES ('Stroker Ace', 'In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 'Action|Comedy|Romance', '2:40');
INSERT INTO movies (name, description, genre, duration) VALUES ('Life Back Then (Antoki no inochi)', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 'Drama|Romance', '1:12');
INSERT INTO movies (name, description, genre, duration) VALUES ('Ender''s Game', 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Action|Adventure|Sci-Fi|IMAX', '1:41');
INSERT INTO movies (name, description, genre, duration) VALUES ('Dominion: Prequel to the Exorcist', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', 'Horror|Thriller', '1:28');
INSERT INTO movies (name, description, genre, duration) VALUES ('My Baby''s Daddy', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 'Comedy', '1:55');

-- ajouter des séances

INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-06', '14:00', 0, 2, 3);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-02', '13:50', 0, 2, 3);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-27', '18:50', 0, 2, 5);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-22', '18:40', 0, 3, 1);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-19', '22:00', 0, 1, 2);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-03', '12:00', 0, 2, 4);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-25', '13:30', 0, 2, 5);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-21', '13:15', 0, 1, 2);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-28', '14:20', 0, 5, 1);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-28', '22:00', 0, 3, 5);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-05', '17:00', 0, 5, 4);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-13', '15:30', 0, 4, 3);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-20', '16:00', 0, 1, 3);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-02', '22:00', 0, 5, 4);
INSERT INTO sessions (date, hour, reserved_places, movie_id, room_id) VALUES ('2022-03-09', '20:00', 0, 4, 5);

-- ajouter les tarifs
INSERT INTO prices (name, price) VALUES ('Plein tarif', 9.20);
INSERT INTO prices (name, price) VALUES ('Tarif étudiant', 7.60);
INSERT INTO prices (name, price) VALUES ('Moins de 14 ans', 5.90);

-- ajouter les états de commandes
INSERT INTO states (state) VALUE ('Réservation validée');
INSERT INTO states (state) VALUE ('Réservation en attente de paiement');
INSERT INTO states (state) VALUE ('Réservation annulée');

-- ajouter les types de paiement
INSERT INTO paymentType (type) VALUE ('au guichet');
-- évolution possible :
-- INSERT INTO paymentType (type) VALUE ('en ligne');

-- ajouter un client
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('De Carolis', 'Crosby', 'cdecarolis0@seesaa.net', '$2y$10$f.jSo3EUkSgm1hP77qWxSeOv67TZC1xEFNlrpYgQ1Dt4Kw/D/KduK', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Eusden', 'Katleen', 'keusden1@rambler.ru', '$2y$10$FhT4uouf4jgo6pL4l30vuudC2DyJClZ.NawOdZ6lMG40RKYSHHQDa', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Slate', 'Goldina', 'gslate2@nbcnews.com', '$2y$10$l2qnmnHpjk0b7rofpkANGOImx7YzobsOn.8wEd4PyAp.NlYsrSuJG', 2);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('McIsaac', 'Chiquia', 'cmcisaac3@state.tx.us', '$2y$10$3Es1zsSCdKsFHXtTcuVPiOhUMiSkYZmz28G83ZuzN3NOMZRSsisEO', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Petticrow', 'Susann', 'spetticrow4@spiegel.de', '$2y$10$Gjathwuf5NZXQvWtB3g7y.DLd/CcNcxvLpShfmf/pJNJMBszNq.ie', 2);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Wintour', 'Carroll', 'cwintour5@yelp.com', '$2y$10$Q9UNe0edXsPc64sE1ObBluYJtLRk.zXZ6s03iMj/204791xCAuGtG', 3);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Antowski', 'Jephthah', 'jantowski6@cbslocal.com', '$2y$10$WEBKyjZVIbP1Ww9Eq6E01eCn.WTqLuXC1V4F/uf7ZoC5UxNPZLt82', 2);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Beardsell', 'Ddene', 'dbeardsell7@icq.com', '$2y$10$RsRFjfCRTYMlOSRQbO6h.uMAcotHLecUMgLisw9sdE055Dz5agr42', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Gaber', 'Dorris', 'dgaber8@ocn.ne.jp', '$2y$10$q7nUrp95m2Hz8nWH6WxtleR5wy3wmnFOzzvaRZ2okUUeglAd5fLAe', 2);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Peddersen', 'Sosanna', 'speddersen9@youtu.be', '$2y$10$bcF/NVfznri83AcpEJML5u4MkmUDhUfOnhgbseEqq.4NLCu78z7di', 3);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Shinfield', 'Jerrome', 'jshinfielda@bluehost.com', '$2y$10$rXyUYBggVeTbBPDHBjQafe6atAKyKnRedtWloBKdMgfB4O/FlThCe', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Olorenshaw', 'Chandal', 'colorenshawb@51.la', '$2y$10$LvL6dm1qqxRkWjkTRKZT3.pA8RqMFYz6GFFfa0rt6Zo7lG6H8kp6C', 3);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Charrisson', 'Lexis', 'lcharrissonc@blogger.com', '$2y$10$6GeZdohei55csD7rN1T88.O2k1UTlq0m8IGX5CpkMH3ASj807ck4W', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Songist', 'Guendolen', 'gsongistd@phoca.cz', '$2y$10$RiI2F8qBJBaqGRFa7nlo5OumB9.ufB0HdiHs19.k8ttXcjFKxZKRa', 1);
INSERT INTO clients (name, firstname, email, password, place_price_id) VALUES ('Greystock', 'Marina', 'mgreystocke@berkeley.edu', '$2y$10$zvHXZoiwfwdX9nnpdaQOVeEfOZjJd5trW1khNO18dttJ/mGCbltfq', 1);

-- ajouter des réservations

INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (11, 1, 1, 8);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (3, 1, 1, 14);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (6, 1, 1, 13);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (1, 1, 1, 1);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (13, 1, 1, 5);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (8, 1, 1, 6);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (4, 1, 2, 15);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (2, 1, 1, 14);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (11, 1, 1, 14);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (14, 1, 1, 8);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (11, 1, 1, 3);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (7, 1, 1, 14);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (15, 1, 1, 1);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (14, 1, 1, 8);
INSERT INTO reservations (session_id, payment_type_id, state_id, client_id) VALUES (9, 1, 1, 12);



-- ***** AFFICHAGE *****

-- Afficher la liste des cinémas existants et leur ville
SELECT movieTheaters.name, movieTheaters.city
FROM movieTheaters;

-- Afficher tous les films à l'affiche dans un cinéma donné 
SELECT DISTINCT movies.name
FROM movies
    JOIN sessions ON movies.id = sessions.movie_id
    JOIN rooms ON sessions.room_id = rooms.id
    JOIN movieTheaters ON movieTheaters.id = rooms.movieTheater_id
WHERE movieTheater_id = 1;

-- Afficher la liste des films disponibles à une date donnée, avec infos de date, heure, salle, cinéma et ville

SELECT sessions.date, sessions.hour, movies.name AS movie, rooms.name AS room, movieTheaters.name AS movieTheater, movieTheaters.city AS city
FROM movies
    JOIN sessions ON sessions.movie_id = movies.id
    JOIN rooms ON sessions.room_id = rooms.id
    JOIN movieTheaters ON movieTheaters.id = rooms.movieTheater_id
WHERE sessions.date = '2022-03-28';

-- Afficher le nombre de places réservées pour une séance VS le nombre de place total
SELECT sessions.date AS date, sessions.hour AS hour, movies.name AS movie, sessions.reserved_places AS resas, rooms.nb_places
FROM sessions
    JOIN rooms ON rooms.id = sessions.room_id
    JOIN movies ON movies.id = sessions.movie_id
ORDER BY date, hour;


-- Mettre à jour le nombre de réservations pour une session

UPDATE sessions
SET sessions.reserved_places = (SELECT COUNT(*) FROM reservations WHERE session_id = 11)
WHERE sessions.id = 11;

-- Valider une réservation en attente

UPDATE reservations
SET reservations.state_id = 1
WHERE reservations.state_id = 2 AND client_id = 15;

-- Annuler une réservation
UPDATE reservations
SET state_id = 3
WHERE id = 7 AND client_id = 15;

-- supprimer une réservation

DELETE FROM reservations
WHERE id = 7 AND client_id = 15 ;

-- ***** GESTION DES PRIVILEGES *****

-- Créer un compte admin

CREATE USER 'coffeeAllMighty'@'localhost' IDENTIFIED BY 'TeaIsEvil@666';
GRANT ALL PRIVILEGES ON movieTheatersComplex.* TO 'coffeeAllMighty'@'localhost';

-- Créer un compte manager

CREATE USER 'buzz'@'localhost' IDENTIFIED BY 'light@35year';
GRANT INSERT, UPDATE, DELETE ON movieTheatersComplex.sessions TO 'buzz'@'localhost';
GRANT INSERT, UPDATE ON movieTheatersComplex.clients TO 'buzz'@'localhost';
GRANT SELECT ON movieTheatersComplex.* TO 'buzz'@'localhost';




-- ***** SAUVEGARDE *****

-- dans le shell de xampp :
## exit
## mysqldump -u coffeeAllMighty -p movieTheatersComplex > movieTheatersComplex-export.sql