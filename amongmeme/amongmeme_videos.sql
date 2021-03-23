/*Creando Tabla de Videos*/

DROP TABLE IF EXISTS videos;

CREATE TABLE videos(
	id_video INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	video VARCHAR(255) NOT NULL,
	views INT UNSIGNED DEFAULT 0
);

INSERT INTO videos (video)
VALUES
	('Rats Fighting for a Cheese Burguer with Linkin Park music playing at the background');
