-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-02-2026 a las 21:55:01
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

--
-- Volcado de datos para la tabla `candidatos`
--

INSERT INTO `candidatos` (`dni`, `nombre_candidato`, `siglas_partido`, `orden`) VALUES
('40001111A', 'Alberto Núñez Feijóo', 'PP', '1'),
('40001112B', 'Cuca Gamarra Ruiz-Clavijo', 'PP', '2'),
('40001113C', 'Juan Bravo Baena', 'PP', '3'),
('40001121D', 'Pedro Sánchez Pérez-Castejón', 'PSOE', '1'),
('40001122E', 'María Jesús Montero Cuadrado', 'PSOE', '2'),
('40001123F', 'Santos Cerdán León', 'PSOE', '3'),
('40001131G', 'Santiago Abascal Conde', 'VOX', '1'),
('40001132H', 'Javier Ortega Smith', 'VOX', '2'),
('40001133I', 'Macarena Olona Choclán', 'VOX', '3'),
('40001141J', 'Yolanda Díaz Pérez', 'Sumar', '1'),
('40001143L', 'Mónica García Gómez', 'Sumar', '2'),
('40001151M', 'Reg', 'FPJ', '2'),
('40001152N', 'Stan/Loretta', 'FPJ', '3'),
('40001153O', 'Brian', 'FPJ', '1');

--
-- Volcado de datos para la tabla `censo`
--

INSERT INTO `censo` (`dni`, `nombre_completo`, `fecha_nacimiento`, `direccion`, `id_localidad`) VALUES
('00000000A', 'Isidoro Pardo Martínez', '2000-01-19', 'Calle Falsa 123', 3),
('01234567J', 'Beatriz Ruiz Campos', '1991-04-27', 'Calle de la Paz 7', 3),
('04574822F', 'Isidoro P. Madrigal', '1964-10-22', 'Hermanos Quinero nº10', 3),
('04579539D', 'Pilar Martínez Martínez', '1968-07-24', 'Hermanos Quinero nº10', 3),
('10111213T', 'Sandra López García', '1987-09-09', 'Camino Verde 21', 5),
('11223344K', 'David Sánchez Pardo', '1986-06-10', 'Avenida Libertad 20', 4),
('12345678A', 'Carlos Gómez Pérez', '1985-03-14', 'Calle Mayor 12', 1),
('20223344A', 'Lucía García Romero', '2008-02-15', 'Calle Primavera 14', 3),
('21234455B', 'Daniel Pérez López', '2009-07-21', 'Avenida del Parque 6', 4),
('22334455L', 'Elena Herrera Ríos', '1994-08-16', 'Calle Los Olmos 5', 5),
('22345566C', 'Sofía Martínez Torres', '2010-10-03', 'Calle Jardines 18', 5),
('23456677D', 'Hugo Fernández Ruiz', '2011-01-12', 'Plaza Mayor 9', 6),
('23456789B', 'María López Sánchez', '1990-07-22', 'Avenida del Sol 8', 3),
('24567788E', 'Martina Sánchez Vega', '2012-06-27', 'Calle de la Estrella 11', 7),
('25678899F', 'Pablo Jiménez Ortiz', '2013-09-05', 'Camino de los Pinos 3', 8),
('26789900G', 'Valeria Navarro Díaz', '2014-11-19', 'Calle Trébol 20', 9),
('27890011H', 'Leo Ramírez Gil', '2015-04-09', 'Calle del Bosque 7', 1),
('28901122I', 'Carla Morales Santos', '2016-08-15', 'Avenida de Castilla 2', 3),
('29012233J', 'Alejandro Torres Martín', '2017-12-30', 'Calle del Río 16', 5),
('33445566M', 'Francisco Ortiz Marín', '1982-02-09', 'Calle del Río 18', 6),
('34567890C', 'Juan Martínez Ruiz', '1978-11-05', 'Plaza del Carmen 4', 4),
('40001111A', 'Alberto Núñez Feijóo', '1961-09-10', 'Calle Génova 13', 1),
('40001112B', 'Cuca Gamarra Ruiz-Clavijo', '1974-12-23', 'Avenida del Prado 8', 3),
('40001113C', 'Juan Bravo Baena', '1974-02-20', 'Calle Serrano 45', 4),
('40001121D', 'Pedro Sánchez Pérez-Castejón', '1972-02-29', 'Calle Ferraz 70', 5),
('40001122E', 'María Jesús Montero Cuadrado', '1966-02-04', 'Avenida de la Constitución 22', 6),
('40001123F', 'Santos Cerdán León', '1969-06-04', 'Calle del Sol 10', 7),
('40001131G', 'Santiago Abascal Conde', '1976-04-14', 'Calle Velázquez 10', 8),
('40001132H', 'Javier Ortega Smith', '1968-08-28', 'Avenida Castellana 55', 9),
('40001133I', 'Macarena Olona Choclán', '1979-05-14', 'Calle del Águila 9', 1),
('40001141J', 'Yolanda Díaz Pérez', '1971-05-06', 'Calle del Trabajo 3', 3),
('40001142K', 'Ernest Urtasun Domingo', '1983-12-14', 'Avenida Democracia 9', 4),
('40001143L', 'Mónica García Gómez', '1974-01-16', 'Calle Igualdad 27', 5),
('40001151M', 'Reg', '1945-03-01', 'Plaza del Coliseo 1', 6),
('40001152N', 'Stan/Loretta', '1947-07-19', 'Calle del Foro 7', 7),
('40001153O', 'Brian', '1948-11-25', 'Via Appia 3', 8),
('44556677N', 'Carmen Díaz Llorente', '1999-09-23', 'Camino Viejo 6', 7),
('45678901D', 'Laura Fernández Díaz', '1995-02-17', 'Calle Luna 22', 5),
('48253637Z', 'Guillermo Pardo Martínez', '2002-10-16', 'Hermanos Quinero nº10', 3),
('55667788O', 'Raúl Domínguez Peña', '1977-12-14', 'Calle del Prado 10', 8),
('56789012E', 'Pedro Ramírez Ortega', '1988-09-30', 'Camino Real 15', 6),
('66778899P', 'Isabel Gil Ramos', '1989-03-02', 'Calle de las Flores 3', 9),
('67890123F', 'Lucía Torres Gil', '1992-12-25', 'Calle Olivo 9', 7),
('77889900Q', 'Alberto Morales Castro', '1996-05-12', 'Calle Nueva 17', 1),
('78901234G', 'Jorge Navarro León', '1980-05-19', 'Avenida Andalucía 33', 8),
('88990011R', 'Patricia Vega Romero', '1984-11-28', 'Avenida Central 25', 3),
('89012345H', 'Ana Morales Vega', '1997-01-08', 'Calle Esperanza 11', 9),
('90123456I', 'Sergio Castro Molina', '1983-10-03', 'Calle Jardines 2', 1),
('99001122S', 'Diego Fernández León', '1993-07-04', 'Calle Colón 13', 4);

--
-- Volcado de datos para la tabla `comunidades`
--

INSERT INTO `comunidades` (`id_comunidad`, `nombre_comunidad`) VALUES
(1, 'Castilla-La Mancha'),
(2, 'Región de Murcia'),
(3, 'Comunidad Valenciana');

--
-- Volcado de datos para la tabla `elecciones`
--

INSERT INTO `elecciones` (`id_elecciones`, `descripcion`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
(4, 'Elecciones generales 2030', '2026-06-12', '2026-06-14', 'finalizada');

--
-- Volcado de datos para la tabla `escrutinio`
--

INSERT INTO `escrutinio` (`id_escritinio`, `id_elecciones`, `partido`, `localidad`, `comunidad`) VALUES
(12, 4, 'FPJ', 3, '1'),
(13, 4, 'FPJ', 1, '1'),
(14, 4, 'FPJ', 3, '1'),
(15, 4, 'FPJ', 4, '1'),
(16, 4, 'FPJ', 5, '2'),
(17, 4, 'FPJ', 6, '2'),
(18, 4, 'FPJ', 7, '3'),
(19, 4, 'FPJ', 8, '3'),
(20, 4, 'FPJ', 9, '3'),
(21, 4, 'PP', 1, '1'),
(22, 4, 'PP', 5, '2'),
(23, 4, 'PP', 7, '3'),
(24, 4, 'PSOE', 3, '1'),
(25, 4, 'PSOE', 6, '2'),
(26, 4, 'Sumar', 4, '1'),
(27, 4, 'Sumar', 8, '3'),
(28, 4, 'Vox', 1, '1'),
(29, 4, 'Vox', 9, '3');

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`id_localidad`, `nombre_localidad`, `id_comunidad`) VALUES
(1, 'Cuenca', 1),
(3, 'Albacete', 1),
(4, 'Toledo', 1),
(5, 'Murcia', 2),
(6, 'Cartagena', 2),
(7, 'Valencia', 3),
(8, 'Alicante', 3),
(9, 'Castellón', 3);

--
-- Volcado de datos para la tabla `participacion`
--

INSERT INTO `participacion` (`id_localidad`, `numero_censados`, `total_votos`) VALUES
(3, 8, 3),
(4, 6, 2);

--
-- Volcado de datos para la tabla `partidos`
--

INSERT INTO `partidos` (`Siglas`, `Descripcion`, `Rutas`) VALUES
('FPJ', 'Frente Popular de Judea', '../imagenes/fpj.png'),
('PP', 'Partido Popular', '../imagenes/pp.png'),
('PSOE', 'Partido Socialista Obrero Español', '../imagenes/psoe.png'),
('Sumar', 'Sumar', '../imagenes/sumar.png'),
('Vox', 'Vox', '../imagenes/vox.png');

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`dni`, `contra`, `rol`, `votado`) VALUES
('00000000A', '82d06846a93f5449dbd5c7eb6a6a6bbe', 'admin', 1),
('01234567J', '0343c536f2e86806866b699652993a1d', 'user', 0),
('11223344K', '32c6cc1f8b934ff705d27f30abb4d52c', 'user', 0),
('12345678A', '81dc9bdb52d04dc20036dbd8313ed055', 'user', 0),
('22334455L', '037c51ada773555405e9656d6465277a', 'analista', 0),
('23456789B', '32c6cc1f8b934ff705d27f30abb4d52c', 'user', 0),
('44556677N', '0343c536f2e86806866b699652993a1d', 'user', 0),
('99001122S', '32c6cc1f8b934ff705d27f30abb4d52c', 'user', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
