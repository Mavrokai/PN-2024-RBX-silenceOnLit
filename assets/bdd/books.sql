/* se connecter en root*/

sudo mysql

/* sortir */

exit

/* liste des bdd*/

SHOW DATABASES;

/*Créer une base de données */

CREATE DATABASE books;

/*Utiliser la base de données */

USE books

/*Créer utilisateur et lui donner les droit sur la base de données books, à faire quand on est connecté en root*/

CREATE USER 'book_admin'@'localhost' IDENTIFIED BY 'Hm723Hq4MShm289PfFhm';
GRANT ALL PRIVILEGES ON books.* TO 'book_admin'@'localhost';

/*se connecter en tant qu'utilisateur */

mysql -h localhost -u book_admin -p 

/*commandes diverses */

SHOW TABLES;
DESCRIBE Users;


/*créer le tableau utilisateur*/



CREATE TABLE IF NOT EXISTS Users (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    date_of_birth DATETIME NOT NULL,
    site_E2C VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
)ENGINE=InnoDB;

/* Insérer des données dans un tableau */

INSERT INTO Users (email, password, firstname, lastname, date_of_birth, site_E2C)
    VALUES ('o.burcker@e2c-grandlille.fr', 'motdepasse', 'Olivier', 'Burcker', '1976-06-21', 'Multisite');

INSERT INTO Users (email, password, firstname, lastname, date_of_birth, site_E2C)
    VALUES ('n.derebreu@gmail.com', 'motdepasse', 'Nell', 'Derebreu', '2004-09-24', 'Roubaix'),
            ('k.nempon', 'bidule', 'Kevin', 'Nempon', '2004-09-24', 'Roubaix'),
            ('m.hermant', 'cestmoi', 'Maxence', 'Hermant', '2003-11-01', 'Saint-Omer');

/* Comment on affiche les données d'un tableau */

SELECT * FROM Users;
SELECT site_E2C, firstname, lastname FROM Users;

SELECT password FROM Users WHERE email = "k.nempon";

SELECT * FROM Users WHERE site_E2C = "roubaix" OR site_E2C="multisite";

/*Modifie un tableau*/

ALTER TABLE Users
ADD COLUMN is_admin BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE Users
DROP COLUMN email;

ALTER TABLE Users
MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE Users
CHANGE COLUMN surname lastname VARCHAR(255) NOT NULL;

/*Site*/

CREATE TABLE IF NOT EXISTS Sites (
    id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(255) NOT NULL UNIQUE
)ENGINE=InnoDB;

INSERT INTO Sites (city)
    VALUES ('Multisite'),
            ('Armentières'),
            ('Lille'),
            ('Roubaix'),
            ('Saint-Omer');

/*Créer une relation */

ALTER TABLE Users
ADD COLUMN site_id TINYINT UNSIGNED NOT NULL;

/* on change toutes les valeurs */

UPDATE Users
SET site_id = 2;

/* Créer une clés étrangère */

ALTER TABLE Users
ADD CONSTRAINT fk_sites FOREIGN KEY (site_id) REFERENCES Sites(id);

UPDATE Users
SET site_id = 1
WHERE site_E2C = 'Multisite';

UPDATE Users
SET site_id = 4
WHERE site_E2C = 'Roubaix';

UPDATE Users
SET site_id = 5
WHERE site_E2C = 'Saint-Omer';

ALTER TABLE Users
DROP COLUMN site_E2C;

/*Première jointure */

SELECT Users.firstname AS Prénom, Users.lastname AS Nom, Sites.city AS Ville, Users.email As Email
FROM Users INNER JOIN Sites ON Users.site_id = Sites.id
WHERE Users.site_id = 4
ORDER BY Prénom ASC;

/* tableau des genres */

CREATE TABLE IF NOT EXISTS Genres (
    id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
)ENGINE=InnoDB;

INSERT INTO Genres (name)
    VALUES ('Roman'), ('Policier'), ('Biographie'), ('BD'), ('Manga'), ('Sciences-Fiction'), ('Education'), ('Histoire'), ('Fantastique/horreur'), ('Dictionnaire'), ('Philosophie'), ('Droit'), ('Politique');

INSERT INTO Genres (name)
VALUE ('Poèsie'), ('Nouvelle'), ('Théâtres');

/*Ajout du tableau auteur*/

CREATE TABLE IF NOT EXISTS Authors (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    picture VARCHAR(255)
)ENGINE=InnoDB;

INSERT INTO Authors (name) 
VALUES ('inconnu');

/* Le tableau Books... */

CREATE TABLE IF NOT EXISTS Books (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre_id TINYINT UNSIGNED NOT NULL DEFAULT 1,
    publishing_house VARCHAR(255) NOT NULL DEFAULT "Inconnue",
    published_at DATETIME,
    format VARCHAR(255) NOT NULL DEFAULT 'Livre de poche',
    pages SMALLINT NOT NULL,
    synopsis TEXT,
    picture VARCHAR(255),
    borrower_id INT UNSIGNED,
    site_id TINYINT UNSIGNED NOT NULL,
    CONSTRAINT fk_genres
        FOREIGN KEY (genre_id)
        REFERENCES Genres(id),
    CONSTRAINT fk_borrower
        FOREIGN KEY (borrower_id)
        REFERENCES Users(id),
    CONSTRAINT fk_book_sites
        FOREIGN KEY(site_id)
        REFERENCES Sites(id)
)ENGINE=InnoDB;


DESCRIBE Books;

/* Relation plusieurs à plusieurs auteur-livre */

CREATE TABLE IF NOT EXISTS Books_authors (
    book_id INT UNSIGNED NOT NULL,
    author_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_link_book
        FOREIGN KEY (book_id)
        REFERENCES Books(id),
    CONSTRAINT fk_link_author
        FOREIGN KEY (author_id)
        REFERENCES Authors(id)
)ENGINE=InnoDB;

/* Ajout d'un livre */

INSERT INTO Authors (name)
VALUES ('Jean-Paul Dubois');

INSERT INTO Books (title, genre_id, site_id, publishing_house, published_at, format, pages)
VALUES ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183);

INSERT INTO Books_authors (book_id, author_id)
VALUES (1, 2);

/*Replissage de la base*/

INSERT INTO Authors (name)
VALUES ('Stephen King'), ('J.R.R. Tolkien'),('Greg Egan'),('Isaac Asmimov'),('Paul Auster'),('J.K. Rowling'),('Hannah Arendt'),('Platon'),('Agatha Christie'),('Michael Connely'),('Collectif'),('Hergé');

INSERT INTO Books (title, genre_id, site_id, publishing_house, published_at, format, pages)
VALUES  ('Le fléau', 9, 4, 'J''ai Lu', '1998-01-01', 'Livre de poche', 650),
        ('Duma Key', 9, 3, 'J''ai Lu', '2022-01-01', 'Livre de poche', 578),
        ('La communauté de l''anneau', 9, 4, 'Flamarion', '1950-05-01', 'Grand format', 478),
        ('Silmarilion', 9, 2, 'La pagode', '1957-01-01', 'Grand format', 574),
        ('Diaspora', 6, 4, 'Livre de poche', '2007-01-01', 'Livre de poche', 354),
        ('Fondation', 6, 4, 'Livre de poche', '1968-05-01', 'Livre de poche', 224),
        ('Les robots', 6, 5, 'Livre de poche', '1961-05-01', 'Livre de poche', 302),
        ('Leviathan', 1, 4, 'Points', '1997-01-01', 'Livre de poche', 245),
        ('Harry Potter et le pot de chambre enchanté', 9, 4, 'Points', '1998-01-01', 'Livre de poche', 311),
        ('Du mensonge à la violence', 11, 4, 'J''ai lu', '1973-01-01', 'Livre de poche', 179),
        ('Critias', 11, 2, 'Philo Dodo', '1988-05-01', 'Grand format', 259),
        ('Le crime de l''orient express', 2, 4, 'Livre de poche', '1958-05-01', 'Livre de poche', 251),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183),
        ('Hommes entre eux', 1, 4, 'Points', '2012-05-01', 'Livre de poche', 183);
INSERT INTO Books_authors (book_id, author_id)
VALUES (2, 3),
        (3, 3),
        (4, 4),
        (5, 4),
        (6, 5),
        (7, 6),
        (8, 6),
        (9, 7),
        (10, 8),
        (11, 9),
        (12, 10),
        (13, 11),
        (14, 2),
        (15, 2),
        (16, 2),
        (17, 2),
        (18, 2),
        (19, 2),
        (20, 2),
        (21, 2),
        (22, 2),
        (23, 2),
        (24, 2),
        (25, 2),
        (26, 2);