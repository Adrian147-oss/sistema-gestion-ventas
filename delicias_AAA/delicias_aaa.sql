-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-10-2025 a las 02:44:18
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
-- Base de datos: `delicias_aaa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `combos`
--

CREATE TABLE `combos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio_usd` decimal(10,2) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `combos`
--

INSERT INTO `combos` (`id`, `nombre`, `descripcion`, `precio_usd`, `activo`, `fecha_creacion`) VALUES
(1, 'Combo Hamburguesa mini', '11 Hamburguesas', 10.00, 1, '2025-10-21 12:32:09'),
(2, 'Combo Perro Caliente', '9 Perro Caliente + Refresco 2Ltr', 10.00, 1, '2025-10-21 12:32:09'),
(3, 'Combo Hamburguesa grande', '4 Hamburguesas + Refresco 2Ltr', 8.00, 1, '2025-10-21 12:32:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `combo_productos`
--

CREATE TABLE `combo_productos` (
  `id` int(11) NOT NULL,
  `combo_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `combo_productos`
--

INSERT INTO `combo_productos` (`id`, `combo_id`, `producto_id`, `cantidad`) VALUES
(2, 1, 4, 11),
(3, 3, 5, 4),
(4, 2, 1, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio_bs` decimal(10,2) NOT NULL,
  `precio_usd` decimal(10,2) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `precio_bs`, `precio_usd`, `activo`) VALUES
(1, 'Perro Caliente (Gr)', 260.00, 1.00, 1),
(2, 'Perro Caliente (Especial)', 650.00, 2.50, 1),
(3, 'PerriPollo', 750.00, 3.00, 1),
(4, 'Hamburguesa (mini)', 260.00, 1.00, 1),
(5, 'hamburguesa (Grande)', 520.00, 2.00, 1),
(6, 'Hamburguesa (Especial)', 750.00, 3.00, 1),
(7, 'Hamburguesa (Mixta)', 970.00, 4.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `total_bs` decimal(10,2) NOT NULL,
  `total_usd` decimal(10,2) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `metodo_pago` enum('efectivo_bs','pago_movil','punto','dolares') NOT NULL,
  `monto_pagado_bs` decimal(10,2) DEFAULT NULL,
  `monto_pagado_usd` decimal(10,2) DEFAULT NULL,
  `nota` text DEFAULT NULL,
  `combo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `producto_id`, `cantidad`, `total_bs`, `total_usd`, `fecha`, `metodo_pago`, `monto_pagado_bs`, `monto_pagado_usd`, `nota`, `combo_id`) VALUES
(1, 1, 5, 1300.00, 5.00, '2025-10-21 14:16:30', 'punto', 2080.00, NULL, NULL, NULL),
(2, 4, 3, 780.00, 3.00, '2025-10-21 14:16:30', 'punto', 2080.00, NULL, NULL, NULL),
(5, NULL, 1, 0.00, 10.00, '2025-10-21 18:00:06', 'dolares', NULL, 10.00, NULL, 1),
(6, 5, 1, 520.00, 2.00, '2025-10-21 18:36:12', 'pago_movil', 520.00, NULL, NULL, NULL),
(7, 3, 2, 1500.00, 6.00, '2025-10-21 18:36:25', 'dolares', NULL, 6.00, NULL, NULL),
(8, 6, 1, 750.00, 3.00, '2025-10-21 20:05:38', 'pago_movil', 750.00, NULL, NULL, NULL),
(9, NULL, 1, 0.00, 10.00, '2025-10-21 20:05:38', 'dolares', NULL, 10.00, NULL, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `combos`
--
ALTER TABLE `combos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `combo_productos`
--
ALTER TABLE `combo_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `combo_id` (`combo_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ventas_combo` (`combo_id`),
  ADD KEY `fk_ventas_producto` (`producto_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `combos`
--
ALTER TABLE `combos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `combo_productos`
--
ALTER TABLE `combo_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `combo_productos`
--
ALTER TABLE `combo_productos`
  ADD CONSTRAINT `combo_productos_ibfk_1` FOREIGN KEY (`combo_id`) REFERENCES `combos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `combo_productos_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_ventas_combo` FOREIGN KEY (`combo_id`) REFERENCES `combos` (`id`),
  ADD CONSTRAINT `fk_ventas_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
