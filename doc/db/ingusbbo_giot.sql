-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 12-09-2019 a las 16:58:19
-- Versión del servidor: 5.7.23-log
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ingusbbo_giot`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gateway`
--

CREATE TABLE `gateway` (
  `id` int(11) NOT NULL,
  `clave` varchar(256) NOT NULL,
  `protocolo` varchar(45) NOT NULL,
  `sis_opt` varchar(46) NOT NULL,
  `contacto` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` varchar(45) NOT NULL,
  `sensor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nodo`
--

CREATE TABLE `nodo` (
  `id` int(11) NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  `protocolo` varchar(80) NOT NULL,
  `gateway` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sensor`
--

CREATE TABLE `sensor` (
  `id` int(11) NOT NULL,
  `marca` varchar(45) NOT NULL,
  `frecuencia_min` int(3) NOT NULL,
  `nodo` int(11) NOT NULL,
  `tipo_sensor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_sensor`
--

CREATE TABLE `tipo_sensor` (
  `id` int(11) NOT NULL,
  `nombre` int(11) NOT NULL,
  `magnitud` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `username` varchar(45) NOT NULL,
  `clave` varchar(256) NOT NULL,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `tipo_usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `gateway`
--
ALTER TABLE `gateway`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mensaje_sensor_idx` (`sensor`);

--
-- Indices de la tabla `nodo`
--
ALTER TABLE `nodo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nodo_gateway_idx` (`gateway`);

--
-- Indices de la tabla `sensor`
--
ALTER TABLE `sensor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sensor_nodo_idx` (`nodo`),
  ADD KEY `fk_sensor_tipo_sensor_idx` (`tipo_sensor`);

--
-- Indices de la tabla `tipo_sensor`
--
ALTER TABLE `tipo_sensor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`nombre`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `correo_UNIQUE` (`correo`),
  ADD KEY `fk_usuario_tipo_usuario_idx` (`tipo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nodo`
--
ALTER TABLE `nodo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_sensor`
--
ALTER TABLE `tipo_sensor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD CONSTRAINT `fk_mensaje_sensor` FOREIGN KEY (`sensor`) REFERENCES `sensor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `nodo`
--
ALTER TABLE `nodo`
  ADD CONSTRAINT `fk_nodo_gateway` FOREIGN KEY (`gateway`) REFERENCES `gateway` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sensor`
--
ALTER TABLE `sensor`
  ADD CONSTRAINT `fk_sensor_nodo` FOREIGN KEY (`nodo`) REFERENCES `nodo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sensor_tipo_sensor` FOREIGN KEY (`tipo_sensor`) REFERENCES `tipo_sensor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_tipo_usuario` FOREIGN KEY (`tipo_usuario`) REFERENCES `tipo_usuario` (`nombre`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
