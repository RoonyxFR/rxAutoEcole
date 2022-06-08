CREATE TABLE `licenses` (
	`type` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`type`)
);

CREATE TABLE `user_licenses` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`type` varchar(60) NOT NULL,
	`owner` varchar(60) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `licenses` (`type`, `label`) VALUES
('boat', 'Boat License'),
('dmv', 'Code de la route'),
('drive', 'Permis de conduire'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('weapon', 'Permis de port d\'arme');
