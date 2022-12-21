-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_digitalbooking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_digitalbooking
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_digitalbooking`;
CREATE SCHEMA `db_digitalbooking` DEFAULT CHARACTER SET utf8mb3 ;
USE `db_digitalbooking` ;

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`categories` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `title` VARCHAR(255) NOT NULL,
  `url_image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`cities` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `latitude` VARCHAR(255) NOT NULL,
  `longitude` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`features` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
   `icon_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`products` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` TEXT NULL,
  `title` VARCHAR(255) NOT NULL,
  `categories_id` BIGINT NOT NULL,
  `cities_id` BIGINT NOT NULL,
  `stars` INT NULL DEFAULT NULL,
  `rate` INT NULL DEFAULT NULL,
  `address` VARCHAR(255) NOT NULL,
  `latitude` VARCHAR(255) NULL ,
  `longitude` VARCHAR(255) NULL ,
  `near_location` VARCHAR(255) NULL,
  `slogan` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_categories1_idx` (`categories_id` ASC) VISIBLE,
  INDEX `fk_products_cities1_idx` (`cities_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `db_digitalbooking`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `db_digitalbooking`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`images` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `products_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `images_products_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `images_products`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
    ON DELETE CASCADE
    )
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`products_has_features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`products_has_features` (
  `products_id` BIGINT NOT NULL,
  `features_id` BIGINT NOT NULL,
  PRIMARY KEY (`products_id`, `features_id`),
  INDEX `fk_products_has_features_features1_idx` (`features_id` ASC) VISIBLE,
  INDEX `fk_products_has_features_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_has_features_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `db_digitalbooking`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_features_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`rules` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `products_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rules_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_rules_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`health_security`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`health_security` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `products_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_health_security_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_health_security_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
ON DELETE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`roles` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`users` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NULL,
  `roles_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_roles1_idx` (`roles_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `db_digitalbooking`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`bookings` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `start_time` VARCHAR(255) NOT NULL,
  `check_in` DATE NOT NULL,
  `check_out` DATE NOT NULL,
  `users_id` BIGINT NOT NULL,
  `products_id` BIGINT NOT NULL,
  `covid_vaccinated` TINYINT(1) NULL,
  `others_comments` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bookings_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_bookings_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `db_digitalbooking`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`favourites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`favourites` (
  `id` BIGINT NOT NULL auto_increment,
  `users_id` BIGINT NOT NULL,
  `products_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `users_id`, `products_id`),
  INDEX `fk_users_has_products_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_users_has_products_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_products_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `db_digitalbooking`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_products_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`policies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_digitalbooking`.`policies` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NULL,
  `products_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_policies_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_policies_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `db_digitalbooking`.`products` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------
-- Added default values to db_digitalbooking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`categories`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.categories (id, title, description, url_image)
VALUES 
(DEFAULT,"Hoteles", "Descripción hoteles", "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(DEFAULT,"Hostels", "Descripción hostels", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80"),
(DEFAULT,"Departamentos", "Descripción departamentos", "https://images.unsplash.com/photo-1543589365-3cc63c87243f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
(DEFAULT,"Bed and breakfast", "Descripción bed and breakfast", "https://images.unsplash.com/photo-1520179432903-03d08e6ef07a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80");

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`cities`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.cities (id, name, country, latitude, longitude)
VALUES 
(DEFAULT, "Buenos Aires","Argentina", "-34.6075682", "-58.4370894"),
(DEFAULT, "Córdoba","Argentina", "-31.4173391", "-64.183319"),
(DEFAULT, "Mendoza","Argentina", "-32.8894155", "-68.8446177"),
(DEFAULT, "Florianópolis","Brasil", "-27.5973002", "-48.5496098"),
(DEFAULT, "Natal","Brasil", "-5.805398", "-35.2080905"),
(DEFAULT, "Medellín","Colombia", "6.2443382", "-75.573553"),
(DEFAULT, "Bogotá","Colombia", "4.6534649", "-74.0836453");

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`features`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.features (id, name,icon_id)
VALUES 
(DEFAULT,"kitchen",9),
(DEFAULT,"tv",10),
(DEFAULT,"air-conditioning",5),
(DEFAULT,"parking",3),
(DEFAULT,"swimming",1),
(DEFAULT,"wifi",2),
(DEFAULT,"pets",8),
(DEFAULT,"elevator",11),
(DEFAULT,"restaurant",6),
(DEFAULT,"gym",4),
(DEFAULT,"bar",7);

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`products`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.products (id, title, description, cities_id, categories_id, stars, rate, address, latitude, longitude, near_location,slogan)
VALUES 
(DEFAULT,"Hermitage Hotel", "El Hermitage Hotel ocupa un edificio impresionante ubicado frente a la playa de Mar del Plata y ofrece alojamiento de lujo, casino, spa, centro de fitness y terraza con pileta. Alberga un restaurante.
Las habitaciones del Hermitage Hotel son amplias y luminosas. Presentan una decoración con mobiliario elegante y ventanales. Todas tienen zona de estar. Algunas ofrecen vistas al mar.
Se sirve un desayuno continental a diario. El restaurante Luis Alberto propone platos internacionales inspirados en la cocina mediterránea. El bar del vestíbulo ofrece cócteles y aperitivos que pueden tomarse en una terraza con vistas al mar.", 1, 1, 5, 8, "Colon 1643","-38.0081004", "-57.5404444","A 940m del centro", "Alojate en el corazón de Buenos Aires"),
(DEFAULT, "Villaggio Hotel Boutique","El Villaggio Hotel Boutique está ubicado en Mendoza, a solo 1 calle del casino de Mendoza y de la plaza Independencia. Cuenta con pileta, bañera de hidromasaje y centro de spa con gimnasio en la 5ª planta. El estacionamiento privado conlleva un adicional.", 3, 1, 3, 9, "25 de Mayo 1010", "-32.8900616", "-68.8474445","A 940m del centro", "Alojate en el corazón de Mendoza"),
(DEFAULT, "Hotel Charlott Suite 26","El Hotel Charlott Suite 26 se encuentra en Bogotá, a 6 km de la plaza Bolívar y de la biblioteca Luis Ángel Arango. El alojamiento está a unos 2,2 km del centro internacional de exposiciones Corferias, a 2,5 km del estadio El Campín y a 6 km de la Zona T. El hotel está a 9 km del centro comercial Unicentro y a 200 metros del centro comercial Gran Estación.

Todas las habitaciones incluyen TV de pantalla plana. Las habitaciones del Hotel Charlott Suite 26 incluyen ropa de cama y toallas.

El alojamiento sirve un desayuno continental.", 7, 1, 4, 7, "385 Avenida Calle 26, Teusaquillo", "4.6326714", "-74.0858353","A 940m del centro", "Alojate en el corazón de Bogotá"),
(DEFAULT, "Sheraton Mendoza Hotel","El Sheraton es un hotel nuevo de 5 estrellas situado a pocos pasos de la Avenida San Martín. Ofrece un restaurante con vistas de 360 grados al centro de Mendoza y la cordillera de Los Andes. También cuenta con pileta cubierta y wifi gratis. Las habitaciones del Sheraton son amplias y presentan un estilo moderno y elegante. Todas ellas tienen vistas a la ciudad e incluyen zona de estar y TV LCD con canales por cable. El Sheraton Mendoza Hotel alberga el restaurante más alto de la ciudad de Mendoza, que prepara cocina internacional de calidad. Todas las mañanas se sirve un desayuno, por un adicional.", 3, 1, 5, 9, "Primitivo De La Reta 989", "-32.8920829", "-68.8379971","A 940m del centro", "Alojate en el corazón de Mendoza"),
(DEFAULT, "Jaque Mate Hostel","El Jaque Mate Hostel, situado en Mendoza, ofrece recepción, wifi gratis, juegos de mesa y una elegante zona de salón compartida. El alojamiento está a solo 30 metros de la avenida Villanueva, con sus bares, restaurantes y tiendas. Las habitaciones son sencillas y modernas, y tienen toques de color. Todas incluyen baño privado o compartido con secador de pelo, calefacción y ropa de cama. Se facilitan toallas por un adicional. Todas las habitaciones tienen lockers. El Jaque Mate Hostel ofrece jardín, zona de parrilla, bar y cocina compartida. También hay consigna de equipaje y una zona de fumadores.", 3, 2, 3, 7, "Olascoaga 780", "-32.8914313", "-68.8546491","A 940m del centro","Alojate en el corazón de Mendoza"),
(DEFAULT, "Apartment City Heart III","El Apartment City Heart III está situado en el centro de Mendoza, a menos de 1 km del Museo del Pasado Cuyano y a 13 minutos a pie de la plaza de la Independencia, y ofrece conexión wifi gratis y aire acondicionado. Este departamento se encuentra a 2,2 km del centro de convenciones Emilio Civit y a 2,7 km de la clínica Zaldivar. Este departamento cuenta con 1 dormitorio, cocina con heladera y horno, TV de pantalla plana, zona de estar y baño con ducha.", 3, 3, 3, 9, "Lavalle 35 Torre Sur, Piso 3 Departamento 11", "-32.8914313", "-68.8546491","A 940m del centro","Alojate en el corazón de Mendoza"),
(DEFAULT, "Innsenso Suites","El Innsenso B&B está situado en Natal, a 200 metros de la playa de Ponta Negra y a 9 km de Arena das Dunas, y ofrece alojamiento con wifi gratis, aire acondicionado, jardín y terraza. 
El baño privado está totalmente equipado con bidet y artículos de aseo gratuitos. Este bed and breakfast sirve un desayuno continental o a la carta. El Innsenso B&B se encuentra a 13 km del Forte dos Reis Magos y a 32 km de la playa de Genipabu. El aeropuerto internacional São Gonçalo do Amarante es el más cercano y queda a 24 km.", 5, 4, 4, 9, "Rua Hélio Galvão 8960, Ponta Negra", "-5.8704392", "-35.1802190","A 940m  del centro","Alojate en el corazón de Natal"),

(DEFAULT,"Principado Downtown","El Principado Downtown se encuentra en el centro de Buenos Aires, a 150 metros del centro comercial Galerías Pacífico y a 300 metros de la plaza San Martín, y ofrece wifi gratis. Hay una terraza solárium con tumbonas y muebles de exterior. Además, el alojamiento está a 400 metros de Puerto Madero y a 500 metros de la Dársena Norte y la terminal de ferris Buquebus. Las habitaciones del Principado Downtown son cómodas y cuentan con aire acondicionado, Smart TV de 40 o 30 pulgadas, puerto USB, escritorio, caja fuerte y minibar. También incluyen baño completo con artículos de aseo gratuitos y secador de pelo. El Principado Downtown sirve un desayuno buffet a diario en su bar exclusivo. El alojamiento también ofrece servicios de estacionamiento por un adicional adicional fuera de las instalaciones y servicios de lavandería y planchado. El hotel alberga un gimnasio de uso gratuito.", 1,1,4,8, "Paraguay 481", "-34,597049", "-58,37374", "A 1km del centro", "Alojate en el corazón de Buenos Aires"),
(DEFAULT,"Hotel Regis","El HOTEL REGIS está bien situado en el centro de Buenos Aires, a 800 metros del Obelisco de Buenos Aires, a menos de 1 km del teatro Colón y a 13 minutos a pie de la basílica del Santísimo Sacramento. El alojamiento cuenta con recepción 24 horas, servicio de conserjería y wifi gratis en todas las instalaciones. El hotel dispone de habitaciones familiares. El Palacio Barolo se encuentra a 1,7 km del hotel, mientras que el Centro Cultural Kirchner está a 2,1 km.",1,1,2,8,"813 Lavalle, 1047","-34,602109","-58,3782851","Cerca del subte","Alojate en el corazón de Buenos Aires"),
(DEFAULT,"Novotel Buenos Aires","El Novotel Buenos Aires está situado en la avenida Corrientes y ofrece habitaciones amplias con TV LCD. Las instalaciones incluyen pileta exterior, baño turco y centro de fitness. El Obelisco se encuentra a solo 2 calles. Todas las habitaciones del Novotel Buenos Aires cuentan con minibar y escritorio. El Novotel Buenos Aires también dispone de solárium. El restaurante del hotel, el Patio #378, sirve platos mediterráneos sencillos y modernos. Es posible comer al aire libre en el patio.",1,1,4,8,"Av Corrientes 1334","-34,603915","-58,3856203","Cerca del subte","Alojate en el corazón de Buenos Aires"),
(DEFAULT,"Imperial Park Hotel","El Imperial Park Hotel ofrece habitaciones con aire acondicionado y TV por cable en el distrito Monserrat de Buenos Aires. El alojamiento cuenta con restaurante, recepción 24 horas, room service y wifi gratis. El alojamiento cuenta con servicio de conserjería, mostrador de información turística y consigna de equipaje. Las habitaciones disponen de baño privado con ducha, secador de pelo y artículos de aseo gratuitos. odas las mañanas se sirve un desayuno buffet en el hotel.",1,1,4,7,"Lima, 101, Monserrat","-34,6095092","-58,3820460","Cerca del subte","Alojate en el corazón de Buenos Aires"),
(DEFAULT,"Vilaut Smart Flat","El Vilaut Smart Flat se encuentra en el centro comercial y financiero de Córdoba y cuenta con pileta al aire libre, centro de negocios y wifi gratis. Las habitaciones del Vilaut Smart Flat tienen zona de cocina, zona de comedor, baño privado y wifi gratis. La plaza San Martín y la terminal de micros están a 400 metros, mientras que el aeropuerto Ingeniero Taravella queda a 8 km.",2,1,3,9,"Corrientes 207","-31,4200126","-64,1826335","A 400m  del centro","Alojate en el corazón de Córdoba"),
(DEFAULT,"AT Suites","El AT Suites ofrece alojamientos independientes con wifi gratis en Córdoba, a 150 metros del centro comercial Olmos y a 500 metros de la plaza San Martín. Cuenta con pileta al aire libre. os alojamientos disponen de cocina totalmente equipada, TV de pantalla plana y aire acondicionado. El AT Suites alberga una terraza. También ofrece consigna de equipaje y servicio de camarera de pisos diario. Se proporciona ropa de cama.",2,3,4,8,"Boulevard Iliia 50","-31,4209806","-64,1854051","A 0,5km  del centro","Alojate en el corazón de Córdoba"),
(DEFAULT,"Apart Hotel Magali","El Apart Hotel Magali dispone de wifi gratis en todo el alojamiento, admite animales domésticos y se encuentra en Córdoba. Hay bar en las instalaciones. Los departamentos del Apart Hotel Magali tienen aire acondicionado y TV por cable. La recepción está abierta las 24 horas. El Apart Hotel Magali se halla a 300 metros del centro comercial Patio Olmos y a 600 metros de la Plaza Jesuita. El aeropuerto Ambrosio L. V. Taravella es el más cercano y está a 12 km del Apart Hotel Magali.",2,1,3,7,"Montevideo 408","-31,4200781","-64,1919711","Ubicación ideal","Alojate en el corazón de Córdoba"),
(DEFAULT,"Hotel Mallorca","El Hotel Mallorca está situado en Mendoza. Ofrece conexión wifi gratis y baño privado con ducha, bidet y artículos de aseo gratuitos. El Hotel Mallorca dispone de un hermoso patio y una biblioteca y está situado a solo 1 calle del Parque San Martín, en Mendoza. Este hotel dispone de conexión wifi gratis en todas las áreas. Las habitaciones del Hotel Mallorca están amuebladas de manera sencilla. Disponen de ventilador, calefacción y baño privado. La ropa de cama, las toallas y el servicio diario de limpieza están incluidos. Este hotel cuenta con terraza en la azotea, recepción las 24 horas, consigna de equipaje e información turística. También hay zona de comedor común y se puede pedir el desayuno cada mañana.",3,1,2,8,"Julio A. Roca 719","-32,887543","-68,8602200","Ubicación ideal","Alojate en el corazón de Mendoza"),
(DEFAULT,"Park Hyatt Mendoza Hotel, Casino & Spa","El Park Hyatt Mendoza Hotel, Casino & Spa, situado en un impresionante edificio frente a la Plaza Independencia, ofrece alojamiento de lujo en el centro de Mendoza. El alojamiento alberga spa, centro de fitness, casino, pileta y varios restaurantes. Las habitaciones del Park Hyatt Mendoza son amplias y luminosas y presentan una decoración de estilo contemporáneo. Además, todas incluyen TV por cable, reproductor de DVD y escritorio. Algunas disponen de zona de estar. Todos los días se sirve un desayuno buffet. Para las comidas, los huéspedes pueden disfrutar del restaurante asador argentino o del Bistro M, que ofrece platos internacionales. Las instalaciones del spa incluyen bañera de hidromasaje, sauna y baño de vapor. Además, los huéspedes pueden hacer uso del centro de fitness, la pileta y el casino. También hay un servicio de masajes a pedido.",3,1,5,8,"Chile 1124","-32,888904","-68,8460489","Ubicación ideal","Alojate en el corazón de Mendoza"),
(DEFAULT,"Hotel Don Zepe","El Hotel Don Zepe proporciona TV LCD por cable y conexión gratuita a internet en Florianópolis, cerca del lago Conceição. También se encuentra a poca distancia a pie de bares, restaurantes y tiendas. Las habitaciones del Don Zepe Hotel incluyen baño, zona de estar y aire acondicionado. La sala de desayunos del alojamiento ofrece vistas al lago Conceição y se puede usar para albergar eventos. El Don Zepe dispone de recepción 24 horas y servicio de alquiler de autos. Además, está a 3 km de las playas da Joaquina y Mole.",4,1,3,8,"Avenida Afonso Delambert Neto, 740","-27,6055701","-48,4680521","A 3km  de la playa","Alojate en el corazón de Florianópolis");

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`products_has_features`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.products_has_features (products_id, features_id)
VALUES 
(1,1),(1,2),(1,4),(1,6),(1,10),
(2,1),(2,2),(2,3),(2,4),(2,9),(2,10),
(3,1),(3,2),(3,4),(3,7),(3,8),(3,9),
(4,3),(4,5),(4,8),(4,9),(4,10),
(5,1),(5,2),(5,6),(5,9),
(6,1),(6,2),(6,3),(6,6),(6,9),
(7,1),(7,2),(7,4),(7,6),(7,9),(7,11),
(8,1),(8,2),(8,3),(8,4),(8,9),(8,10),
(9,1),(9,2),(9,3),(9,4),(9,9),(9,10),
(10,1),(10,2),(10,4),(10,7),(10,8),(10,9),
(11,1),(11,2),(11,6),(11,9),
(12,1),(12,2),(12,3),(12,6),(12,9),
(14,3),(14,5),(14,8),(14,9),(14,10),
(15,1),(15,2),(15,6),(15,9),
(16,1),(16,2),(16,3),(16,6),(16,9),
(17,1),(17,2),(17,4),(17,6),(17,9),(17,11);

-- -----------------------------------------------------
-- Table `db_digitalbooking`.`images`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.images (id, title, url, products_id)
VALUES 
(DEFAULT,"Hermitage Frente", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/5923624.jpg?k=323f2b7086d47096fda0d6aec2bff102d9029e05dbce297db7ff61476ab2bfb4&o=&hp=1",1),
(DEFAULT,"Hermitage salón", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/5930618.jpg?k=4699ae44d22abcedfd1ca34ca2738cf9238cb52e261bab6fcaff860743cf8c00&o=&hp=1",1),
(DEFAULT,"Hermitage dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/284812436.jpg?k=c66fd69a1353baba67ba7e075824edd86c9fd6901d087ea9459b93a60cefdf59&o=&hp=1",1),
(DEFAULT,"Hermitage pileta", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/5923721.jpg?k=953196ed39a4dabe9def6073296b3176110d1110eee5b5e916c093fd8049e6ab&o=&hp=1",1),
(DEFAULT,"Hermitage habitación doble", "https://t-cf.bstatic.com/xdata/images/hotel/max1024x768/284814146.jpg?k=b30c49eb92cf006f35ffefd1613fdf718b07821893ac37944c36bbaf99687e39&o=",1),

(DEFAULT,"Villaggio Desayuno", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/126774017.jpg?k=71f15dbb8c0c5d5f96f90248082d99c0bce76e1f416c054e18634dac23fa4962&o=&hp=1",2),
(DEFAULT,"Villaggio patio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/151205119.jpg?k=8feb383950c6fd01d8c2964f5de0e4a7056f628d59b3aea6b3f8bf3675da7dc7&o=&hp=1",2),
(DEFAULT,"Villaggio domitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/15653303.jpg?k=ed092c8190410e21bc3881d1a4f4aace2b2f5df039c3be24066257dd4b9a77c2&o=&hp=1",2),
(DEFAULT,"Villaggio recepción", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/15652904.jpg?k=82f3da85614bb864ea1543959d3d97fb395a4ecf3395d08f2a69e8c6eab6ae53&o=&hp=1",2),

(DEFAULT,"Hotel Charlott Suite 26 dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/384450231.jpg?k=4638ffb1f1d6f5347c7a7e9482b9a67a6df3b3984469d928277088d18f739937&o=&hp=1",3),
(DEFAULT,"Hotel Charlott Suite 26 terraza", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/384450728.jpg?k=ae1bd51ff3ea44a828073a0f606d0262039f15b253c6195e498cc871d9eafc51&o=&hp=1",3),
(DEFAULT,"Hotel Charlott Suite 26 dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/384450229.jpg?k=d434951dfe438251845891ef6e64913dc19dbbed7a52b7702025f0671d888833&o=&hp=1",3),
(DEFAULT,"Hotel Charlott Suite 26 salón", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/384450741.jpg?k=d258d2dbc4d3d49c6e813d01211820d57fadbc34d3be5691172b7b961c03ae11&o=&hp=1",3),

(DEFAULT,"Sheraton Mendoza Hotel dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1024x768/177080264.jpg?k=a72b8d458d3a3a167c461a717bc36c527e28d7697bfc86df2e44d209afc82fa3&o=",4),
(DEFAULT,"Sheraton Mendoza Hotel terraza", "https://t-cf.bstatic.com/xdata/images/hotel/max1024x768/177080117.jpg?k=1b0f26790a29a846a9aa4c599c3dc29cde9cd6027df13179d0ad239cf9529b97&o=",4),
(DEFAULT,"Sheraton Mendoza Hotel dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1024x768/177080170.jpg?k=f4618b4747083539ae3908435ee712ebaf0b881b53a963a2c94d316b04d47644&o=",4),
(DEFAULT,"Sheraton Mendoza Hotel frente", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/327385688.jpg?k=c8532ab48e065656fefbee78b082bb3f881e36e23ba10ca2b3793310f11e768f&o=&hp=1",4),

(DEFAULT,"Jaque Mate Hostel sala", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/25413698.jpg?k=b447933faf59a92175eb8b296f190d14983226f5c588a249a8a75295890ddf8b&o=&hp=1",5),
(DEFAULT,"Jaque Mate Hostel comedor", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/301501073.jpg?k=803cbbd00afc64af17a234bb71849923ab67a6cf49e9f4b3c158cae521d9380a&o=&hp=1",5),
(DEFAULT,"Jaque Mate Hostell dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/369640136.jpg?k=d122ddc272328527bfb7702e3231456750d9301ab68e8e0afc2a47413278cce1&o=&hp=1",5),
(DEFAULT,"Jaque Mate Hostel dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/369638232.jpg?k=859d096be46b6f0b5e200a90941c1bbf790d45110ac54e1dc53b2b98a84f7661&o=&hp=1",5),

(DEFAULT,"Apartment City Heart III dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/242544143.jpg?k=bc323165fdde24c1921d34045cb4f7ab59213bfe9538f1c119ef31921eb5c5ad&o=&hp=1",6),
(DEFAULT,"Apartment City Heart III salón", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/242543989.jpg?k=68bda27aa3d9281ba4b3655c97c28d0472f11771c2ad6df172b598102fdea0e1&o=&hp=1",6),
(DEFAULT,"Apartment City Heart III deco", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/242544088.jpg?k=9d6d851b0f00c3d6ba3ee655f58de2a7602b5192c769a2acda477c0110b2b69e&o=&hp=1",6),
(DEFAULT,"Apartment City Heart III comedor", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/242544111.jpg?k=a5b59387b9efa870c9e6d193a8797d04c91569a6d3a005ab688f5289342e78f4&o=&hp=1",6),

(DEFAULT,"Innsenso Suites frente", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/232782672.jpg?k=72533c4901f6c372dd199cd521808b0445b13fa56620fef6aadbdb364d7d07be&o=&hp=1",7),
(DEFAULT,"Innsenso Suites dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/268475380.jpg?k=8ad62954f8143de91cf1e4a244c72b3a2636b38a5a11702aa95bbb78927aa7dd&o=&hp=1",7),
(DEFAULT,"Innsenso Suites dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/268474964.jpg?k=e71c6a1196d01ed2df6f8c7d5e12e7d9389f5941c04198fc4a9732ff60c2eff4&o=&hp=1",7),
(DEFAULT,"Innsenso Suites pileta", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/240830355.jpg?k=ec15f71b351b14a38934cf5a527a391d1da29ed8c48e09d71855b0e5fea60c64&o=&hp=1",7),

(DEFAULT,"Principado Downtown salon", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979892.jpg?k=e34ded5762432dee948f60bf8ce266966c313dbb2ca0d42064be0296db1fafae&o=&hp=1",8),
(DEFAULT,"Principado Downtown salon", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979867.jpg?k=a25e794684d68ede130374c2f2c7770f9b289d537b3da1407e1fe07a43499abb&o=&hp=1",8),
(DEFAULT,"Principado Downtown gym", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979876.jpg?k=c9ce813bf8a9a816cd10727577596365fd09d52f1102818b91d4f348566c210e&o=&hp=1",8),
(DEFAULT,"Principado Downtown dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979865.jpg?k=3a13df8c5fc08b0419e7912392e50fb6dcb539a714b423bd1b3379e3c68fbed4&o=&hp=1",8),

(DEFAULT,"Hotel Regis dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/352739050.jpg?k=c92d9395aff42fb77254232e038213aa35aa0bc68106a775ee534b202b6c9b99&o=&hp=1",9),
(DEFAULT,"Hotel Regis entrada", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/352454795.jpg?k=564490d94d3bba02aca385c17e2c1f53d685c0dcb9ad28b328d22823d0e06622&o=&hp=1",9),
(DEFAULT,"Hotel Regis dormitorio", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/352454808.jpg?k=0b4f93b9f4ef25806e69ea62ebeb1a1cebfd8ed5885ffef97eec0c1fdfe809f1&o=&hp=1",9),
(DEFAULT,"Hotel Regis Obelisco", "https://t-cf.bstatic.com/xdata/images/landmark/max1024/184908.webp?k=d2204154f7cd332cef7cc5471fe1a9a8d2815722dc28359aaeb5e8dd3d065280&o=",9),



(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979871.jpg?k=734be4d819306d6be7f7aaf30c841ff524d55efeed1aa542dfeef018efb9c62a&o=&hp=1",10),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979874.jpg?k=358ff5804794904f4c01611fb82753d0bbf54efa6fcfd956e377d0b82159e37d&o=&hp=1",11),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/400979879.jpg?k=4d761d3841cd3ec55091bb4b77a6ed1ab339e95d9689015e595e575b5e7b947b&o=&hp=1",12),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/160446865.jpg?k=654104115ba4c5c188ae133e9ddc1fe33120ac89f24aafe150dec8a6ccbe91fb&o=&hp=1",13),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/160446863.jpg?k=d8c59877755a3f6db7894b3ef4cb9ef93452c2ef813570b3eda126d29b4de800&o=&hp=1",14),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/89321568.jpg?k=299b4a7d312f69feb40ead296e3c0e1d3d0fdab8791b7fe6d7932700f767fcd7&o=&hp=1",15),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/90607371.jpg?k=2d6fb67f5ef3df15de732175b04da151b4f288e84aaf2c8540cc90309df28101&o=&hp=1",16),
(DEFAULT,"dormitorio ", "https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/79792580.jpg?k=a33451222c8edb3f7f540df7d80a5b028b43d284cc4cae0fcbe26e8b597b300a&o=&hp=1",17);


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`rules`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.rules (id, description, products_id)
VALUES 
(DEFAULT,"Check-in: 15:00 - 23:00", 1),
(DEFAULT,"No se permite fumar", 1),
(DEFAULT,"No se permiten fiestas", 1),
(DEFAULT,"Check-in: 13:00 - 22:00", 2),
(DEFAULT,"No se permiten mascotas", 2),
(DEFAULT,"Check-in: 15:00 - 23:00", 3),
(DEFAULT,"No se permite fumar", 3),
(DEFAULT,"No se permiten fiestas", 3),
(DEFAULT,"Check-in: 12:00 - 23:00", 4),
(DEFAULT,"No se permiten fiestas", 4),
(DEFAULT,"Check-in: 15:00 - 23:00", 5),
(DEFAULT,"No se permite fumar", 5),
(DEFAULT,"No se permiten fiestas", 5),
(DEFAULT,"Check-in: 15:00 - 23:00", 6),
(DEFAULT,"No se permiten fiestas", 6),
(DEFAULT,"Check-in: 15:00 - 23:00", 7),
(DEFAULT,"No se permite fumar", 7),
(DEFAULT,"No se permiten fiestas", 8),
(DEFAULT,"Check-in: 13:00 - 22:00", 8),
(DEFAULT,"No se permiten mascotas", 8),
(DEFAULT,"Check-in: 15:00 - 23:00", 9),
(DEFAULT,"No se permite fumar", 9),
(DEFAULT,"No se permiten fiestas", 9),
(DEFAULT,"Check-in: 12:00 - 23:00", 9),
(DEFAULT,"No se permiten fiestas", 10),
(DEFAULT,"Check-in: 15:00 - 23:00", 11),
(DEFAULT,"No se permite fumar", 11),
(DEFAULT,"No se permiten fiestas", 11),
(DEFAULT,"Check-in: 15:00 - 23:00", 12),
(DEFAULT,"No se permiten fiestas", 13),
(DEFAULT,"Check-in: 12:00 - 23:00", 14),
(DEFAULT,"No se permiten fiestas", 14),
(DEFAULT,"Check-in: 15:00 - 23:00", 15),
(DEFAULT,"No se permite fumar", 15),
(DEFAULT,"No se permiten fiestas", 15),
(DEFAULT,"Check-in: 15:00 - 23:00", 16),
(DEFAULT,"No se permiten fiestas", 16),
(DEFAULT,"Check-in: 15:00 - 23:00", 17),
(DEFAULT,"No se permite fumar", 17);



-- -----------------------------------------------------
-- Table `db_digitalbooking`.`health_security`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.health_security (id, description, products_id)
VALUES 
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 1),
(DEFAULT,"Detector de humo", 1),
(DEFAULT,"Depósito de seguridad", 1),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 2),
(DEFAULT,"Detector de humo", 2),
(DEFAULT,"Depósito de seguridad", 2),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 3),
(DEFAULT,"Detector de humo", 3),
(DEFAULT,"Depósito de seguridad", 3),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 4),
(DEFAULT,"Detector de humo", 4),
(DEFAULT,"Depósito de seguridad", 4),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 5),
(DEFAULT,"Detector de humo", 5),
(DEFAULT,"Depósito de seguridad", 5),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 6),
(DEFAULT,"Detector de humo", 6),
(DEFAULT,"Depósito de seguridad", 6),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 7),
(DEFAULT,"Detector de humo", 7),
(DEFAULT,"Depósito de seguridad", 7),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 8),
(DEFAULT,"Depósito de seguridad", 8),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 9),
(DEFAULT,"Detector de humo", 9),
(DEFAULT,"Detector de humo", 10),
(DEFAULT,"Depósito de seguridad", 10),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 11),
(DEFAULT,"Detector de humo", 11),
(DEFAULT,"Depósito de seguridad", 11),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 12),
(DEFAULT,"Detector de humo", 12),
(DEFAULT,"Depósito de seguridad", 12),
(DEFAULT,"Detector de humo", 13),
(DEFAULT,"Depósito de seguridad", 13),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 14),
(DEFAULT,"Detector de humo", 14),
(DEFAULT,"Depósito de seguridad", 14),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 15),
(DEFAULT,"Detector de humo", 15),
(DEFAULT,"Depósito de seguridad", 15),
(DEFAULT,"Detector de humo", 16),
(DEFAULT,"Depósito de seguridad", 16),
(DEFAULT,"Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus", 17),
(DEFAULT,"Depósito de seguridad", 17);


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`roles`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.roles (id, name)
VALUES 
(DEFAULT,"CLIENT"),
(DEFAULT,"ADMIN");


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`users`
-- -----------------------------------------------------
-- user y user 2 password: 1234567
INSERT INTO `db_digitalbooking`.`users` (id, name, last_name, email, password, city, roles_id)
VALUES 
(DEFAULT,'user', 'user', 'user@booking.com', '$2a$10$kfiLgjJJNq4cjMm8G.rvROXyzZix36HM5g41sntCSXUDg/uWN6oRW', 'cba', '1'),
(DEFAULT,'user2', 'user2', 'user2@booking.com','$2a$10$RvZOSlE586dVEyQ7zlPOEeDNodvVVH35rQXVK.x5JYuFtkNi4wvgu', 'cba', '1'),
(DEFAULT,'user3', 'user3', 'user3@booking.com','$2a$10$VQHr95WFxyRsV3VRqxIzDehR2QguTzkZ9Bz2K5BGBhyG/KX7w3ArG', 'cba', '2');




-- -----------------------------------------------------
-- Table `db_digitalbooking`.`bookings`
-- -----------------------------------------------------

INSERT INTO `db_digitalbooking`.`bookings` (id, start_time, check_in, check_out, users_id, products_id, covid_vaccinated, others_comments) 
VALUES 
(DEFAULT,'10:00', '2022-12-16', '2022-12-20', '1', '1', '1', 'other comments'),
(DEFAULT,'12:00', '2022-12-23', '2022-12-26', '1', '1', '1', 'other comments'),
(DEFAULT,'14:00', '2022-12-23', '2022-12-26', '2', '3', '1', 'other comments'),
(DEFAULT,'12:00', '2022-12-27', '2022-12-29', '1', '4', '1', 'other comments'),
(DEFAULT,'9:00', '2023-01-02', '2023-01-07', '2', '5', '1', 'other comments'),
(DEFAULT,'19:00', '2023-01-02', '2023-01-07', '2', '2', '1', 'other comments'),
(DEFAULT,'8:00','2023-03-16','2023-03-20','1','6', '1','other comments'),
(DEFAULT,'12:00','2023-01-21','2023-01-24','1','7', '1','other comments'),
(DEFAULT,'14:00','2022-12-23','2022-12-26','2','8', '1','other comments'),
(DEFAULT,'12:00', '2023-02-17', '2023-02-19', '1', '9', '1', 'other comments'),
(DEFAULT,'9:00', '2023-01-02', '2023-01-07', '2', '10', '1', 'other comments'),
(DEFAULT,'10:00', '2022-12-16', '2022-12-20', '1', '11', '1', 'other comments'),
(DEFAULT,'10:00', '2022-12-16', '2022-12-20', '1', '12', '1', 'other comments'),
(DEFAULT,'12:00', '2022-12-23', '2022-12-26', '1', '13', '1', 'other comments'),
(DEFAULT,'14:00', '2022-12-23', '2022-12-26', '2', '14', '1', 'other comments'),
(DEFAULT,'12:00', '2022-12-27', '2022-12-29', '1', '15', '1', 'other comments'),
(DEFAULT,'9:00', '2023-01-02', '2023-01-07', '2', '14', '1', 'other comments'),
(DEFAULT,'19:00', '2023-01-02', '2023-01-07', '2', '16', '1', 'other comments'),
(DEFAULT,'8:00', '2023-02-16', '2023-02-20', '1', '17', '1', 'other comments');


-- -----------------------------------------------------
-- Table `db_digitalbooking`.`policies`
-- -----------------------------------------------------

INSERT INTO db_digitalbooking.policies (id, description, products_id)
VALUES 
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 1),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 2),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 3),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 4),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 5),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 6),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 7),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 8),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 9),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 10),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 11),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 12),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 13),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 14),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 15),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 16),
(DEFAULT,"Agregá las fechas de tu viaje para obtener los detalles de la cancelación de esta estadia", 17);