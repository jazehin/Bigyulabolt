DROP TABLE IF EXISTS `b_user`;
DROP TABLE IF EXISTS `b_forgalom`;
DROP TABLE IF EXISTS `b_termekek`;
DROP TABLE IF EXISTS `b_termekcsoport`;

CREATE TABLE IF NOT EXISTS `b_user` (
    b_kod INT PRIMARY KEY AUTO_INCREMENT,
  	b_nev VARCHAR(30) NOT NULL,
    b_tipus TINYINT NOT NULL,
    b_jelszo VARCHAR(50) NOT NULL
);

INSERT INTO `b_user` (`b_nev`, `b_tipus`, `b_jelszo`) VALUES
('Erdei_Geri', 1, 'Hajra'),
('Nagy_Edmond_Ede', 0, '123');

CREATE TABLE IF NOT EXISTS `b_termekcsoport` (
    b_Tcskod INT PRIMARY KEY AUTO_INCREMENT,
  	b_Tcsnev VARCHAR(30) NOT NULL
);

INSERT INTO `b_termekcsoport` 
(`b_Tcskod`, `b_Tcsnev`) VALUES
(1, 'szamitogepes_jatekok'),
(2, 'szamitogepes_kiegeszíto'),
(3, 'edessegek'),
(4, 'gyerek_jatekok'),
(5, 'Taiwan_tema');

CREATE TABLE IF NOT EXISTS `b_termekek` (
    b_tazon INT PRIMARY KEY AUTO_INCREMENT,
  	b_tleiras VARCHAR(45) NOT NULL,
    b_tcsop INT NOT NULL,
    b_tar INT,
    FOREIGN KEY (b_tcsop) REFERENCES b_termekcsoport(b_Tcskod)
);

INSERT INTO `b_termekek` 
(`b_tazon`, `b_tleiras`, `b_tcsop`, `b_tar`) VALUES
(1, 'C_16 game bigyulabolt', 1, 999),
(2, 'C_64 game Wizzard of wor', 1, 999),
(3, 'Quickshot2', 2, 10000),
(4, 'Drive 1541', 2, 20000),
(5, 'Negro', 3, 399),
(6, 'Szerencsi tejcsoki', 3, 555),
(7, 'Darth Vader Star Wars figura', 4, 9999),
(8, 'Obi van Kenobi Star Wars figura', 4, 9999),
(9, 'Oolon tea', 5, 16999),
(10, 'Winter Melon Tea', 5, 3499);

CREATE TABLE IF NOT EXISTS `b_forgalom` (
    b_szamlaszam INT NOT NULL,
  	b_termekazon INT NOT NULL,
    b_eladdb INT NOT NULL,
    b_datum TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (b_szamlaszam, b_termekazon, b_eladdb, b_datum),
    FOREIGN KEY (b_termekazon) REFERENCES b_termekek(b_tazon)
);

INSERT INTO `b_forgalom` 
(`b_szamlaszam`, `b_termekazon`, `b_eladdb`, `b_datum`) VALUES
(1, 1, 1, '2022-04-07 15:38:07'),
(1, 2, 1, '2022-04-07 15:38:08'),
(2, 7, 2, '2022-04-08 15:39:25'),
(3, 6, 10, '2022-04-08 15:39:25'),
(3, 10, 4, '2022-04-08 15:39:27'),
(4, 7, 1, '2022-04-08 15:44:06'),
(4, 5, 1, '2022-04-08 15:44:09'),
(4, 6, 4, '2022-04-08 15:44:12'),
(5, 6, 3, '2022-04-08 15:50:06'),
(6, 5, 3, '2022-04-10 15:31:06'),
(6, 7, 3, '2022-04-10 15:44:06'),
(7, 6, 20, '2022-04-11 15:44:06'),
(7, 7, 3, '2022-04-11 15:44:07'),
(7, 1, 1, '2022-04-11 15:44:08'),
(8, 6, 1, '2022-04-11 15:44:10'),
(9, 7, 1, '2022-04-11 15:44:59'),
(10, 7, 11, '2022-04-11 15:14:06'),
(10, 1, 11, '2022-04-11 15:14:16'),
(10, 2, 11, '2022-04-11 15:14:26'),
(10, 6, 11, '2022-04-11 15:14:36'),
(11, 1, 3, '2022-04-11 15:44:06'),
(11, 2, 2, '2022-04-11 15:44:07'),
(11, 6, 8, '2022-04-11 15:44:56');

CREATE VIEW kimutatas AS
SELECT 
	b_termekcsoport.b_Tcsnev AS 'tcsnev',
	b_termekek.b_tar * SUM(b_forgalom.b_eladdb) AS 'eladas'
FROM b_termekek 
	INNER JOIN b_forgalom ON b_termekek.b_tazon = b_forgalom.b_termekazon
	INNER JOIN b_termekcsoport ON b_termekek.b_tcsop = b_termekcsoport.b_Tcskod
GROUP BY b_termekcsoport.b_Tcsnev;