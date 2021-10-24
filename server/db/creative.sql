-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.21-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para creative
CREATE DATABASE IF NOT EXISTS `creative` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `creative`;

-- Copiando estrutura para tabela creative.cloakroom_custom
CREATE TABLE IF NOT EXISTS `cloakroom_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `id_roupa` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `roupa` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela creative.cloakroom_custom: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cloakroom_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `cloakroom_custom` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela creative.phone_app_chat: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Meu número',
  `num` varchar(10) NOT NULL COMMENT 'Número do contato',
  `incoming` int(11) NOT NULL COMMENT 'Origem da chamada',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Chamada aceita ou não',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela creative.phone_calls: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela creative.phone_messages: 0 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela creative.phone_users_contacts: 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_barbershop
CREATE TABLE IF NOT EXISTS `vrp_barbershop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `fathers` int(11) NOT NULL DEFAULT 0,
  `kinship` int(11) NOT NULL DEFAULT 0,
  `eyecolor` int(11) NOT NULL DEFAULT 0,
  `skincolor` int(11) NOT NULL DEFAULT 0,
  `acne` int(11) NOT NULL DEFAULT 0,
  `stains` int(11) NOT NULL DEFAULT 0,
  `freckles` int(11) NOT NULL DEFAULT 0,
  `aging` int(11) NOT NULL DEFAULT 15,
  `hair` int(11) NOT NULL DEFAULT 0,
  `haircolor` int(11) NOT NULL DEFAULT 0,
  `haircolor2` int(11) NOT NULL DEFAULT 0,
  `makeup` int(11) NOT NULL DEFAULT 0,
  `makeupintensity` int(11) NOT NULL DEFAULT 0,
  `makeupcolor` int(11) NOT NULL DEFAULT 0,
  `lipstick` int(11) NOT NULL DEFAULT 0,
  `lipstickintensity` int(11) NOT NULL DEFAULT 0,
  `lipstickcolor` int(11) NOT NULL DEFAULT 0,
  `eyebrow` int(11) NOT NULL DEFAULT 0,
  `eyebrowintensity` int(11) NOT NULL DEFAULT 10,
  `eyebrowcolor` int(11) NOT NULL DEFAULT 0,
  `beard` int(11) NOT NULL DEFAULT 0,
  `beardintentisy` int(11) NOT NULL DEFAULT 10,
  `beardcolor` int(11) NOT NULL DEFAULT 0,
  `blush` int(11) NOT NULL DEFAULT 0,
  `blushintentisy` int(11) NOT NULL DEFAULT 0,
  `blushcolor` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_barbershop: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_barbershop` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_barbershop` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_benefactor
CREATE TABLE IF NOT EXISTS `vrp_benefactor` (
  `vehicle` varchar(50) NOT NULL,
  `estoque` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Sobre: Tabela aonde é definido o estoque dos veiculos\r\nColunas: \r\n• vehicle = Nome de Spawn do Veiculo;\r\n• estoque = Quantidade disponivel em estoque (-1 para estoque infinito);\r\n';

-- Copiando dados para a tabela creative.vrp_benefactor: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_benefactor` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_benefactor` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_chests
CREATE TABLE IF NOT EXISTS `vrp_chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permiss` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `x` text NOT NULL,
  `y` text NOT NULL,
  `z` text NOT NULL,
  `grid` int(11) NOT NULL DEFAULT 0,
  `weight` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela creative.vrp_chests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_chests` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_chests` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_fines
CREATE TABLE IF NOT EXISTS `vrp_fines` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) NOT NULL DEFAULT '0.0.0',
  `price` int(11) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `nuser_id` (`nuser_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_fines: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_fines` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_fines` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_homes
CREATE TABLE IF NOT EXISTS `vrp_homes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `home` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `owner` int(1) NOT NULL DEFAULT 0,
  `vault` int(5) NOT NULL DEFAULT 0,
  `fridge` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`home`,`user_id`) USING BTREE,
  KEY `home` (`home`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_homes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_homes` DISABLE KEYS */;
INSERT INTO `vrp_homes` (`id`, `home`, `user_id`, `owner`, `vault`, `fridge`) VALUES
	(1, 'MiddlePremium064', 1, 1, 250, 0),
	(2, 'MiddlePremium063', 1, 1, 250, 0);
/*!40000 ALTER TABLE `vrp_homes` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_houses
CREATE TABLE IF NOT EXISTS `vrp_houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT 0,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1;

-- Copiando dados para a tabela creative.vrp_houses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_houses` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_infos
CREATE TABLE IF NOT EXISTS `vrp_infos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) NOT NULL,
  `whitelist` tinyint(1) DEFAULT 0,
  `banned` tinyint(1) DEFAULT 0,
  `gems` int(11) NOT NULL DEFAULT 0,
  `premium` int(12) NOT NULL DEFAULT 0,
  `predays` int(2) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `chars` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_infos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_infos` DISABLE KEYS */;
INSERT INTO `vrp_infos` (`id`, `steam`, `whitelist`, `banned`, `gems`, `premium`, `predays`, `priority`, `chars`) VALUES
	(1, 'steam:11000013c79c1da', 1, 0, 0, 0, 0, 0, 1);
/*!40000 ALTER TABLE `vrp_infos` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_invoice
CREATE TABLE IF NOT EXISTS `vrp_invoice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) NOT NULL DEFAULT '0.0.0',
  `price` int(11) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nuser_id` (`nuser_id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_invoice: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_invoice` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_permissions
CREATE TABLE IF NOT EXISTS `vrp_permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 1,
  `permiss` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_permissions: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_permissions` DISABLE KEYS */;
INSERT INTO `vrp_permissions` (`id`, `user_id`, `permiss`) VALUES
	(1, 1, 'Owner'),
	(2, 1, 'Admin'),
	(3, 1, 'waitPolice');
/*!40000 ALTER TABLE `vrp_permissions` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_player_houses
CREATE TABLE IF NOT EXISTS `vrp_player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 CHECKSUM=1;

-- Copiando dados para a tabela creative.vrp_player_houses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_player_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_player_houses` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_prison
CREATE TABLE IF NOT EXISTS `vrp_prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `prison` int(11) NOT NULL DEFAULT 0,
  `date2` varchar(50) NOT NULL DEFAULT '0',
  `multa` int(11) NOT NULL DEFAULT 0,
  `text` varchar(200) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela creative.vrp_prison: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_prison` DISABLE KEYS */;
INSERT INTO `vrp_prison` (`id`, `user_id`, `name`, `prison`, `date2`, `multa`, `text`, `date`) VALUES
	(158, 1, 'Ruan Ribeiro', 1, '13:04', 1, 'a', '22.10.2021');
/*!40000 ALTER TABLE `vrp_prison` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_races
CREATE TABLE IF NOT EXISTS `vrp_races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raceid` int(11) NOT NULL DEFAULT 0,
  `user_id` int(9) NOT NULL DEFAULT 0,
  `vehicle` varchar(100) NOT NULL DEFAULT '0',
  `points` int(20) NOT NULL DEFAULT 0,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela creative.vrp_races: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_races` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_races` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_salary
CREATE TABLE IF NOT EXISTS `vrp_salary` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_salary: ~16 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_salary` DISABLE KEYS */;
INSERT INTO `vrp_salary` (`id`, `user_id`, `date`, `price`) VALUES
	(1, 1, '21.10.2021', 1655),
	(2, 1, '21.10.2021', 1655),
	(3, 1, '21.10.2021', 1655),
	(4, 1, '22.10.2021', 1655),
	(5, 1, '22.10.2021', 1655),
	(6, 1, '24.10.2021', 1655),
	(7, 1, '24.10.2021', 1655),
	(8, 1, '24.10.2021', 1655),
	(9, 1, '24.10.2021', 1655),
	(10, 1, '24.10.2021', 1655),
	(11, 1, '24.10.2021', 1655),
	(12, 1, '24.10.2021', 1655),
	(13, 1, '24.10.2021', 1655),
	(14, 1, '24.10.2021', 1655),
	(15, 1, '24.10.2021', 1655),
	(16, 1, '24.10.2021', 1655);
/*!40000 ALTER TABLE `vrp_salary` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_srv_data: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_srv_data` DISABLE KEYS */;
INSERT INTO `vrp_srv_data` (`dkey`, `dvalue`) VALUES
	('custom:1:adder', '{"tint":-1,"dashColour":0,"neon":{"1":false,"2":false,"3":false,"0":false},"mods":{"1":-1,"2":-1,"3":-1,"4":-1,"5":-1,"6":-1,"7":-1,"8":-1,"9":-1,"10":-1,"11":3,"12":-1,"13":2,"14":-1,"15":3,"16":-1,"17":false,"18":1,"19":false,"20":false,"21":false,"22":false,"23":-1,"24":-1,"25":-1,"26":-1,"27":-1,"28":-1,"29":-1,"30":-1,"31":-1,"32":-1,"33":-1,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":-1,"43":-1,"44":-1,"45":-1,"46":-1,"47":-1,"48":-1,"0":-1},"liverys":-1,"smokecolor":[255,255,255],"xenonColor":255,"var":{"24":false,"23":false},"interColour":0,"platestyle":0,"extracolors":[7,156],"wheeltype":7,"lights":[255,0,255],"colors":[112,0],"extras":[1,0,0,0,0,0,0,0,0,1,0,0],"plateIndex":0}'),
	('saveClothes:1', '{"arms":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"mask":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"accessory":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"bracelet":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"hat":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"watch":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"vest":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"ear":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"shoes":{"texture":0,"defaultItem":1,"defaultTexture":0,"item":1},"glass":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"t-shirt":{"texture":0,"defaultItem":1,"defaultTexture":0,"item":15},"pants":{"texture":2,"defaultItem":0,"defaultTexture":0,"item":5},"torso2":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":22},"bag":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"decals":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0}}'),
	('tattoosClothes:1', '{"t-shirt":{"texture":0,"defaultItem":1,"defaultTexture":0,"item":1},"vest":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"watch":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"arms":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"glass":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"shoes":{"texture":0,"defaultItem":1,"defaultTexture":0,"item":0},"bag":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"torso2":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"mask":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"pants":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"bracelet":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"hat":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"ear":{"texture":0,"defaultItem":-1,"defaultTexture":0,"item":-1},"decals":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0},"accessory":{"texture":0,"defaultItem":0,"defaultTexture":0,"item":0}}');
/*!40000 ALTER TABLE `vrp_srv_data` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) DEFAULT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Ruan',
  `name2` varchar(50) DEFAULT 'Foda',
  `bank` int(12) NOT NULL DEFAULT 4500,
  `garage` int(3) NOT NULL DEFAULT 2,
  `prison` int(6) NOT NULL DEFAULT 0,
  `locate` int(1) NOT NULL DEFAULT 1,
  `deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_users` DISABLE KEYS */;
INSERT INTO `vrp_users` (`id`, `steam`, `registration`, `phone`, `name`, `name2`, `bank`, `garage`, `prison`, `locate`, `deleted`) VALUES
	(1, 'steam:11000013c79c1da', '80HZB005', '567-330', 'Ruan', 'Ribeiro', 9085749, 2, 0, 1, 0);
/*!40000 ALTER TABLE `vrp_users` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_user_data: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_data` DISABLE KEYS */;
INSERT INTO `vrp_user_data` (`user_id`, `dkey`, `dvalue`) VALUES
	(1, 'Clothings', '{"bag":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"shoes":{"defaultTexture":0,"texture":0,"defaultItem":1,"item":1},"decals":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"vest":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"t-shirt":{"defaultTexture":0,"texture":0,"defaultItem":1,"item":15},"bracelet":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"mask":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"ear":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"watch":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"pants":{"defaultTexture":0,"texture":2,"defaultItem":0,"item":5},"accessory":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"hat":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"torso2":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":22},"glass":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"arms":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0}}'),
	(1, 'currentCharacterMode', '[0,100,0,0,0,0,0,0,21,0,0,0,0,0,0,0,0,12,10,0,3,10,0,0,0,0,-2,-3,-3,0,0,0,0,0,0,-5,0,0,0,0,21]'),
	(1, 'Datatable', '{"weaps":{"WEAPON_PISTOL_MK2":{"ammo":148}},"stress":0,"skin":1885233650,"health":200,"position":{"x":-70.65,"z":326.18,"y":-820.74},"hunger":95,"inventorys":{"9":{"item":"tablet","amount":1},"8":{"item":"husky","amount":1},"7":{"amount":1,"item":"coptablet"},"6":{"amount":1,"item":"watch"},"5":{"amount":9,"item":"cocaine"},"4":{"amount":2,"item":"bread"},"3":{"amount":29,"item":"dollars2"},"2":{"amount":82,"item":"dollars2"},"1":{"amount":1,"item":"identity"},"10":{"item":"cat","amount":1}},"backpack":50,"armour":100,"thirst":90}'),
	(1, 'Tattoos', '{"LR_M_Hair_006":["mplowrider2_overlays"]}');
/*!40000 ALTER TABLE `vrp_user_data` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_vehicles
CREATE TABLE IF NOT EXISTS `vrp_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `plate` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `arrest` int(1) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `premiumtime` int(11) NOT NULL DEFAULT 0,
  `rentaltime` int(11) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `work` varchar(10) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  PRIMARY KEY (`id`,`user_id`,`vehicle`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_vehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_vehicles` DISABLE KEYS */;
INSERT INTO `vrp_vehicles` (`id`, `user_id`, `vehicle`, `plate`, `phone`, `arrest`, `time`, `premiumtime`, `rentaltime`, `engine`, `body`, `fuel`, `work`, `doors`, `windows`, `tyres`) VALUES
	(1, 1, 'adder', '50ZLM242', '567-330', 0, 0, 0, 0, 998, 998, 64, 'false', '{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false}', '{"1":1,"2":false,"3":false,"4":false,"5":false,"6":false,"7":false,"0":1}', '{"1":2,"2":2,"3":2,"4":2,"5":2,"6":2,"7":2,"0":2}');
/*!40000 ALTER TABLE `vrp_vehicles` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.vrp_weapons
CREATE TABLE IF NOT EXISTS `vrp_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `weapon` text NOT NULL,
  `ammo` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela creative.vrp_weapons: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_weapons` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_weapons` ENABLE KEYS */;

-- Copiando estrutura para tabela creative.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `properties` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela creative.weed_plants: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `weed_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed_plants` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
