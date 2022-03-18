DROP DATABASE IF EXISTS dbLog_in;
CREATE DATABASE IF NOT EXISTS dbLog_in;
USE dbLog_in;


-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-03-2022 a las 15:44:45
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dblog_in`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `proNewUser` (IN `nombre` VARCHAR(30), IN `apellidos` VARCHAR(60), IN `fNacimiento` DATE, IN `telefono` VARCHAR(20), IN `email` VARCHAR(50), IN `idTipo` INT, IN `usuario` VARCHAR(10), IN `contra` VARCHAR(50))  BEGIN
     
	INSERT INTO `catpersonas`(`txtNombreP`, `txtApellidos`, `feNacimiento`, `txtTelefono`, `txtEmail`, `bActivo`) VALUES (nombre,apellidos,fNacimiento,telefono,email,1);
   SELECT MAX(nIdPersona) INTO @idP FROM catpersonas;
	INSERT INTO `catusers`(`fkIdPersona`, `fkidTipoP`, `txtUser`, `txtPass`, `bActivo`) VALUES (@idP,idTipo,usuario,md5(contra),1);
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catpersonas`
--

CREATE TABLE `catpersonas` (
  `nIdPersona` int(11) NOT NULL,
  `txtNombreP` varchar(30) NOT NULL,
  `txtApellidos` varchar(60) DEFAULT NULL,
  `feNacimiento` date DEFAULT NULL,
  `txtTelefono` varchar(20) NOT NULL,
  `txtEmail` varchar(50) NOT NULL,
  `bActivo` tinyint(1) DEFAULT 0,
  `fhCreatedAt` datetime DEFAULT current_timestamp(),
  `fhUpdatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `catpersonas`
--

INSERT INTO `catpersonas` (`nIdPersona`, `txtNombreP`, `txtApellidos`, `feNacimiento`, `txtTelefono`, `txtEmail`, `bActivo`, `fhCreatedAt`, `fhUpdatedAt`) VALUES
(1, 'Juan Manuel', 'Fernández Alvarez', '0000-00-00', '3122100436', 'admin@prueba.com', 1, '2022-03-17 08:56:21', '2022-03-17 08:56:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cattipop`
--

CREATE TABLE `cattipop` (
  `nIdTipoP` int(11) NOT NULL,
  `txtTipoP` varchar(10) NOT NULL,
  `txtDescripcion` varchar(50) NOT NULL,
  `bActivo` tinyint(1) DEFAULT 0,
  `fhCreatedAt` datetime DEFAULT current_timestamp(),
  `fhUpdatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cattipop`
--

INSERT INTO `cattipop` (`nIdTipoP`, `txtTipoP`, `txtDescripcion`, `bActivo`, `fhCreatedAt`, `fhUpdatedAt`) VALUES
(1, 'Admin', '', 1, '2022-03-17 08:53:12', '2022-03-17 08:53:12'),
(2, 'Docente', '', 1, '2022-03-17 08:53:12', '2022-03-17 08:53:12'),
(3, 'Alumno', '', 1, '2022-03-17 08:53:12', '2022-03-17 08:53:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catusers`
--

CREATE TABLE `catusers` (
  `nIdUser` int(11) NOT NULL,
  `fkIdPersona` int(11) NOT NULL,
  `fkidTipoP` int(11) NOT NULL,
  `txtUser` varchar(10) NOT NULL,
  `txtPass` varchar(50) NOT NULL,
  `bActivo` tinyint(1) DEFAULT 0,
  `fhCreatedAt` datetime DEFAULT current_timestamp(),
  `fhUpdatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `catusers`
--

INSERT INTO `catusers` (`nIdUser`, `fkIdPersona`, `fkidTipoP`, `txtUser`, `txtPass`, `bActivo`, `fhCreatedAt`, `fhUpdatedAt`) VALUES
(1, 1, 1, 'admin', '0192023a7bbd73250516f069df18b500', 1, '2022-03-17 08:56:21', '2022-03-17 08:56:21'),
(2, 1, 2, 'docente', '8be2efedf58bc5ca5ef33aec86a7a217', 0, '2022-03-17 11:17:18', '2022-03-17 11:17:18'),
(3, 1, 3, 'alumno', '0c82ca5b1092a0c21dcfe3200688046e', 0, '2022-03-17 11:17:18', '2022-03-17 11:17:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `sessionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `txtIP` varchar(20) NOT NULL,
  `bTipo` tinyint(1) NOT NULL,
  `fhCreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ci_sessions`
--

INSERT INTO `ci_sessions` (`sessionId`, `userId`, `txtIP`, `bTipo`, `fhCreatedAt`) VALUES
(1, 1, 'Admin', 0, '2022-03-17 11:59:56'),
(2, 1, 'Admin', 0, '2022-03-17 12:07:29');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwsessions`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwsessions` (
`sessionId` int(11)
,`txtNombreCompleto` varchar(91)
,`nickName` varchar(10)
,`userType` varchar(10)
,`IP` varchar(20)
,`tipoSesion` tinyint(1)
,`fechaSesion` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwuserdata`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwuserdata` (
`nIdUser` int(11)
,`txtNombreCompleto` varchar(91)
,`nombre` varchar(30)
,`apellidos` varchar(60)
,`telefono` varchar(20)
,`mail` varchar(50)
,`nickName` varchar(10)
,`userType` varchar(10)
,`nIdTipoP` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vwusers`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vwusers` (
`userId` int(11)
,`usuario` varchar(10)
,`contra` varchar(50)
,`bActivo` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vwsessions`
--
DROP TABLE IF EXISTS `vwsessions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwsessions`  AS SELECT `s`.`sessionId` AS `sessionId`, `ud`.`txtNombreCompleto` AS `txtNombreCompleto`, `ud`.`nickName` AS `nickName`, `ud`.`userType` AS `userType`, `s`.`txtIP` AS `IP`, `s`.`bTipo` AS `tipoSesion`, `s`.`fhCreatedAt` AS `fechaSesion` FROM (`vwuserdata` `ud` join `ci_sessions` `s` on(`s`.`userId` = `ud`.`nIdUser`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwuserdata`
--
DROP TABLE IF EXISTS `vwuserdata`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwuserdata`  AS SELECT `u`.`nIdUser` AS `nIdUser`, concat(`p`.`txtNombreP`,' ',`p`.`txtApellidos`) AS `txtNombreCompleto`, `p`.`txtNombreP` AS `nombre`, `p`.`txtApellidos` AS `apellidos`, `p`.`txtTelefono` AS `telefono`, `p`.`txtEmail` AS `mail`, `u`.`txtUser` AS `nickName`, `t`.`txtTipoP` AS `userType`, `t`.`nIdTipoP` AS `nIdTipoP` FROM (`cattipop` `t` join (`catusers` `u` join `catpersonas` `p` on(`u`.`fkIdPersona` = `p`.`nIdPersona`)) on(`u`.`fkidTipoP` = `t`.`nIdTipoP`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vwusers`
--
DROP TABLE IF EXISTS `vwusers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwusers`  AS SELECT `catusers`.`nIdUser` AS `userId`, `catusers`.`txtUser` AS `usuario`, `catusers`.`txtPass` AS `contra`, `catusers`.`bActivo` AS `bActivo` FROM `catusers` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `catpersonas`
--
ALTER TABLE `catpersonas`
  ADD PRIMARY KEY (`nIdPersona`);

--
-- Indices de la tabla `cattipop`
--
ALTER TABLE `cattipop`
  ADD PRIMARY KEY (`nIdTipoP`);

--
-- Indices de la tabla `catusers`
--
ALTER TABLE `catusers`
  ADD PRIMARY KEY (`nIdUser`),
  ADD KEY `fkIdPersona` (`fkIdPersona`,`fkidTipoP`),
  ADD KEY `fkidTipoP` (`fkidTipoP`);

--
-- Indices de la tabla `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`sessionId`),
  ADD KEY `userId` (`userId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `catpersonas`
--
ALTER TABLE `catpersonas`
  MODIFY `nIdPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cattipop`
--
ALTER TABLE `cattipop`
  MODIFY `nIdTipoP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `catusers`
--
ALTER TABLE `catusers`
  MODIFY `nIdUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ci_sessions`
--
ALTER TABLE `ci_sessions`
  MODIFY `sessionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `catusers`
--
ALTER TABLE `catusers`
  ADD CONSTRAINT `catusers_ibfk_1` FOREIGN KEY (`fkIdPersona`) REFERENCES `catpersonas` (`nIdPersona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `catusers_ibfk_2` FOREIGN KEY (`fkidTipoP`) REFERENCES `cattipop` (`nIdTipoP`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD CONSTRAINT `ci_sessions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `catusers` (`nIdUser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
