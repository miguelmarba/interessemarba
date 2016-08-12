-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-08-2016 a las 02:21:23
-- Versión del servidor: 10.1.9-MariaDB
-- Versión de PHP: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `interesse_marba`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONTACTOS_GETLIST` ()  BEGIN
	SELECT * FROM contactos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONTACTOS_GETSINGLE` (IN `P_ID` INT)  BEGIN
	SELECT * FROM contactos WHERE id = P_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONTACTO_ADD` (IN `P_NOMBRE` VARCHAR(30), IN `P_APELLIDOS` VARCHAR(50), IN `P_DIRECCION` VARCHAR(100), IN `P_EMAIL` VARCHAR(100), INOUT `P_ID` INT(11))  BEGIN
	IF P_ID = 0 THEN
		INSERT INTO contactos (nombres, apellidos, direccion, email) VALUES (P_NOMBRE, P_APELLIDOS, P_DIRECCION,P_EMAIL);
    	SET P_ID = LAST_INSERT_ID();
    ELSE
    	UPDATE contactos SET nombres = P_NOMBRE, apellidos = P_APELLIDOS, direccion = P_DIRECCION, email = P_EMAIL WHERE id = P_ID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONTACTO_REMOVE` (IN `P_ID` INT)  BEGIN
	DELETE FROM contactos WHERE id = P_ID;
    
    DELETE FROM telefonos WHERE contacto_id = P_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ETIQUETAS_ADD` (IN `P_NOMBRE` VARCHAR(30), OUT `P_ID` INT(11))  BEGIN
	INSERT INTO etiquetas (nombre) VALUES (P_NOMBRE);
    SET P_ID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ETIQUETAS_GETID` (IN `P_ID` INT)  BEGIN
	SELECT * FROM etiquetas WHERE id = P_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ETIQUETAS_GETLIST` ()  BEGIN
SELECT * FROM etiquetas; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_ETIQUETAS_TEST` (OUT `total` INT)  BEGIN
SELECT COUNT(*) INTO total FROM etiquetas; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TELEFONOS_ADD` (IN `P_NUMERO` VARCHAR(30), IN `P_CONTACTO_ID` INT(11), IN `P_ETIQUETA_ID` INT(11), OUT `P_ID` INT(11))  BEGIN
	INSERT INTO telefonos (numero, contacto_id, etiqueta_id) VALUES (P_NUMERO, P_CONTACTO_ID, P_ETIQUETA_ID);
    SET P_ID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TELEFONOS_GETCONTACTO` (IN `P_CONTACTOID` INT)  BEGIN
	SELECT * FROM telefonos WHERE contacto_id = P_CONTACTOID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE `contactos` (
  `id` int(11) UNSIGNED NOT NULL,
  `nombres` varchar(30) CHARACTER SET latin1 NOT NULL,
  `apellidos` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `direccion` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `contactos`
--

INSERT INTO `contactos` (`id`, `nombres`, `apellidos`, `direccion`, `email`) VALUES
(1, 'Miguel A', 'Bautista', '1 de mayo', 'marba@gmail.com'),
(2, 'Daniela', 'Juarez', 'Adolfo Lopez 23', 'dani.j@hotmail.com'),
(3, 'Victor Samuel', 'Pineda', 'Av Morelos 400', 'vik.sam@hotmail.com'),
(4, 'Maria Fernando', 'Olivera', 'Orquidea', 'miguel_marba@hotmail.com'),
(5, 'Sheyla', 'Bautista', 'Orquidea', 'miguel_marba@hotmail.com'),
(6, 'Wendolyne', 'Barraza', 'Orquidea', 'miguel_marba@hotmail.com'),
(7, 'Raul', 'Gonzalez', 'Orquidea', 'miguel_marba@hotmail.com'),
(8, 'Barbara', 'Monjaras', 'Rio Nilo 23', 'barbie@miamigo.com'),
(9, 'Laura', 'Mendoza', 'Ajacuba 23', 'lautita@gmail.com'),
(10, 'luis', 'suarez', 'miguel ocaraza', ''),
(11, 'Sandra', 'Carmona', 'Centro historico 23', 'sandy@gmail.com'),
(12, 'Miguel', 'Martinez', 'Orquidea', 'miguel_marba@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE `etiquetas` (
  `id` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Descripción de los números de telefono';

--
-- Volcado de datos para la tabla `etiquetas`
--

INSERT INTO `etiquetas` (`id`, `nombre`) VALUES
(1, 'Casa'),
(2, 'Trabajo'),
(3, 'Celular'),
(4, 'Principal'),
(5, 'Fax de casa'),
(6, 'Fax de trabajo'),
(7, 'Otro'),
(8, 'test1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefonos`
--

CREATE TABLE `telefonos` (
  `id` int(11) NOT NULL,
  `numero` varchar(15) CHARACTER SET latin1 NOT NULL,
  `contacto_id` int(11) UNSIGNED NOT NULL,
  `etiqueta_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `telefonos`
--

INSERT INTO `telefonos` (`id`, `numero`, `contacto_id`, `etiqueta_id`) VALUES
(1, '23232323232', 11, 1),
(2, '323234343434', 11, 1),
(3, '434343434343', 11, 1),
(4, '122323232', 3, 1),
(5, '323232323223', 3, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `telefonos`
--
ALTER TABLE `telefonos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contacto_id` (`contacto_id`),
  ADD KEY `fk_etiqueta_id` (`etiqueta_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `telefonos`
--
ALTER TABLE `telefonos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `telefonos`
--
ALTER TABLE `telefonos`
  ADD CONSTRAINT `fk_contacto_id` FOREIGN KEY (`contacto_id`) REFERENCES `contactos` (`id`),
  ADD CONSTRAINT `fk_etiqueta_id` FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
