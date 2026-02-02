-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-02-2026 a las 21:54:27
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bbdd_ipm_elecciones`
--
CREATE DATABASE IF NOT EXISTS `bbdd_ipm_elecciones` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE `bbdd_ipm_elecciones`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `candidatos`
--

CREATE TABLE IF NOT EXISTS `candidatos` (
  `dni` varchar(9) NOT NULL,
  `nombre_candidato` varchar(100) NOT NULL,
  `siglas_partido` varchar(10) NOT NULL,
  `orden` enum('1','2','3') NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `siglas_partido` (`siglas_partido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `censo`
--

CREATE TABLE IF NOT EXISTS `censo` (
  `dni` varchar(9) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `fecha_nacimiento` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `id_localidad` int(11) NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `id_localidad` (`id_localidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunidades`
--

CREATE TABLE IF NOT EXISTS `comunidades` (
  `id_comunidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_comunidad` varchar(100) NOT NULL,
  PRIMARY KEY (`id_comunidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elecciones`
--

CREATE TABLE IF NOT EXISTS `elecciones` (
  `id_elecciones` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_inicio` varchar(20) NOT NULL,
  `fecha_fin` varchar(20) NOT NULL,
  `estado` enum('cerrada','abierta','finalizada') NOT NULL,
  PRIMARY KEY (`id_elecciones`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escrutinio`
--

CREATE TABLE IF NOT EXISTS `escrutinio` (
  `id_escritinio` int(11) NOT NULL AUTO_INCREMENT,
  `id_elecciones` int(11) NOT NULL,
  `partido` varchar(10) NOT NULL,
  `localidad` int(11) NOT NULL,
  `comunidad` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_escritinio`),
  KEY `id_elecciones` (`id_elecciones`),
  KEY `partido` (`partido`),
  KEY `localidad` (`localidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE IF NOT EXISTS `localidades` (
  `id_localidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_localidad` varchar(100) NOT NULL,
  `id_comunidad` int(11) NOT NULL,
  PRIMARY KEY (`id_localidad`),
  KEY `id_comunidad` (`id_comunidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participacion`
--

CREATE TABLE IF NOT EXISTS `participacion` (
  `id_localidad` int(11) DEFAULT NULL,
  `numero_censados` int(11) DEFAULT NULL,
  `total_votos` int(11) DEFAULT NULL,
  KEY `id_localidad` (`id_localidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partidos`
--

CREATE TABLE IF NOT EXISTS `partidos` (
  `Siglas` varchar(10) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `Rutas` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Siglas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `dni` varchar(9) NOT NULL,
  `contra` varchar(255) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `votado` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `candidatos`
--
ALTER TABLE `candidatos`
  ADD CONSTRAINT `candidatos_ibfk_1` FOREIGN KEY (`dni`) REFERENCES `censo` (`dni`),
  ADD CONSTRAINT `candidatos_ibfk_2` FOREIGN KEY (`siglas_partido`) REFERENCES `partidos` (`Siglas`);

--
-- Filtros para la tabla `censo`
--
ALTER TABLE `censo`
  ADD CONSTRAINT `censo_ibfk_1` FOREIGN KEY (`id_localidad`) REFERENCES `localidades` (`id_localidad`);

--
-- Filtros para la tabla `escrutinio`
--
ALTER TABLE `escrutinio`
  ADD CONSTRAINT `escrutinio_ibfk_1` FOREIGN KEY (`id_elecciones`) REFERENCES `elecciones` (`id_elecciones`),
  ADD CONSTRAINT `escrutinio_ibfk_2` FOREIGN KEY (`partido`) REFERENCES `partidos` (`Siglas`),
  ADD CONSTRAINT `escrutinio_ibfk_3` FOREIGN KEY (`localidad`) REFERENCES `localidades` (`id_localidad`);

--
-- Filtros para la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD CONSTRAINT `localidades_ibfk_1` FOREIGN KEY (`id_comunidad`) REFERENCES `comunidades` (`id_comunidad`);

--
-- Filtros para la tabla `participacion`
--
ALTER TABLE `participacion`
  ADD CONSTRAINT `participacion_ibfk_1` FOREIGN KEY (`id_localidad`) REFERENCES `localidades` (`id_localidad`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`dni`) REFERENCES `censo` (`dni`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
