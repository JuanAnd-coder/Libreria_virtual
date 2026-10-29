-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 29-10-2026 a las 13:47:40
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `librarydata`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores`
--

DROP TABLE IF EXISTS `autores`;
CREATE TABLE IF NOT EXISTS `autores` (
  `AutorID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Nacionalidad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AutorID`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `autores`
--

INSERT INTO `autores` (`AutorID`, `Nombre`, `Nacionalidad`) VALUES
(1, 'Luis Hernández', 'Mexicana'),
(2, 'Ana Torres', 'Española'),
(3, 'Marco Silva', 'Argentina'),
(4, 'Elena Ruiz', 'Colombiana'),
(5, 'Carlos Gómez', 'Chilena'),
(6, 'Laura Pérez', 'Peruana'),
(7, 'Fernando Díaz', 'Uruguaya'),
(8, 'María Fernández', 'Venezolana'),
(9, 'Jorge Romero', 'Cubana'),
(10, 'Patricia Ortega', 'Boliviana'),
(11, 'Hugo Navarro', 'Guatemalteca'),
(12, 'Silvia Carrillo', 'Hondureña'),
(13, 'Andrés Medina', 'Salvadoreña'),
(14, 'Lucía Castillo', 'Nicaragüense'),
(15, 'Ramiro Soto', 'Costarricense'),
(16, 'Clara Aguilar', 'Panameña'),
(17, 'Óscar Vargas', 'Ecuatoriana'),
(18, 'Marta Peña', 'Paraguaya'),
(19, 'Pablo Reyes', 'Dominicana'),
(20, 'Sofía Cabrera', 'Portuguesa'),
(21, 'Iván Márquez', 'Brasileña'),
(22, 'Daniela Ríos', 'Canadiense'),
(23, 'Miguel Paredes', 'Estadounidense'),
(24, 'Isabel Fuentes', 'Italiana'),
(25, 'Tomás Duarte', 'Francesa'),
(26, 'Rocío Ramos', 'Alemana'),
(27, 'Cristian Cordero', 'Británica'),
(28, 'Paula Salinas', 'Irlandesa'),
(29, 'Rodrigo Arias', 'Sueca'),
(30, 'Ángela Lozano', 'Noruega'),
(31, 'Vicente Molina', 'Danesa'),
(32, 'Julia Rivas', 'Finlandesa'),
(33, 'Ernesto Campos', 'Australiana'),
(34, 'Natalia Vargas', 'Neozelandesa'),
(35, 'Alonso Ibáñez', 'Japonesa'),
(36, 'Verónica Zamora', 'China'),
(37, 'Guillermo León', 'India'),
(38, 'Gabriela Solís', 'Coreana'),
(39, 'Raúl Sandoval', 'Filipina'),
(40, 'Adriana Bravo', 'Tailandesa'),
(41, 'Sebastián Chávez', 'Sudafricana'),
(42, 'Carmen Valdés', 'Egipcia'),
(43, 'Francisco Acosta', 'Turca'),
(44, 'Sara Molina', 'Griega'),
(45, 'Bruno Tapia', 'Rumana'),
(46, 'Florencia Vidal', 'Polaca'),
(47, 'Matías Peña', 'Rusa'),
(48, 'Patricia Domínguez', 'Checa'),
(49, 'Leonardo Paz', 'Húngara'),
(50, 'Antonia Herrera', 'Austríaca'),
(51, 'Héctor Muñoz', 'Suiza'),
(52, 'Camila Espinoza', 'Holandesa'),
(53, 'Ricardo Andrade', 'Belga'),
(54, 'Diana Montes', 'Israelí'),
(55, 'Alberto Mora', 'Palestina'),
(56, 'Lorena Delgado', 'Argentina'),
(57, 'Oscar Pino', 'Colombiana'),
(58, 'Beatriz Ayala', 'Mexicana'),
(59, 'Ramón Calderón', 'Peruana'),
(60, 'Irene Padilla', 'Chilena'),
(61, 'Santiago Zambrano', 'Venezolana'),
(62, 'Daniela Quintero', 'Costarricense'),
(63, 'Esteban Cáceres', 'Salvadoreña'),
(64, 'Alejandra Benítez', 'Nicaragüense'),
(65, 'Fabián Mármol', 'Guatemalteca'),
(66, 'Valeria Domínguez', 'Hondureña'),
(67, 'Mauricio Guerra', 'Ecuatoriana'),
(68, 'Renata Varela', 'Panameña'),
(69, 'Julio Salazar', 'Paraguaya'),
(70, 'Teresa Mendoza', 'Dominicana'),
(71, 'Arturo Pastor', 'Portuguesa'),
(72, 'Catalina Vidal', 'Francesa'),
(73, 'Manuel Rojas', 'Italiana'),
(74, 'Carolina Cortés', 'Alemana'),
(75, 'Ignacio Cabrera', 'Británica'),
(76, 'Rafael Medina', 'Irlandesa'),
(77, 'Viviana Rivera', 'Sueca'),
(78, 'Kevin Serrano', 'Noruega'),
(79, 'Cristina Cuesta', 'Danesa'),
(80, 'Julián Méndez', 'Finlandesa'),
(81, 'Lorena Figueroa', 'Australiana'),
(82, 'Martín Esquivel', 'Neozelandesa'),
(83, 'Natalie Torres', 'Japonesa'),
(84, 'Roberto Valverde', 'China'),
(85, 'Susana Lara', 'India'),
(86, 'Eduardo Sanz', 'Coreana'),
(87, 'Pamela Prieto', 'Filipina'),
(88, 'Félix Navarro', 'Tailandesa'),
(89, 'Álvaro Peña', 'Sudafricana'),
(90, 'Melisa Rojas', 'Egipcia'),
(91, 'Guadalupe Vega', 'Turca'),
(92, 'Marcos Barrera', 'Griega'),
(93, 'Jimena Pizarro', 'Rumana'),
(94, 'Víctor Carvajal', 'Polaca'),
(95, 'Emilia Arce', 'Rusa'),
(96, 'Pedro Palacios', 'Checa'),
(97, 'Agustina Bermúdez', 'Húngara'),
(98, 'Jorge Bravo', 'Austríaca'),
(99, 'Antonia Orozco', 'Suiza'),
(100, 'Benjamín Acuña', 'Holandesa'),
(101, 'Juan Rulfo', 'Mexicano'),
(102, 'Gabriel Garcia Marquez', 'Colombiano');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

DROP TABLE IF EXISTS `libros`;
CREATE TABLE IF NOT EXISTS `libros` (
  `LibroID` int NOT NULL AUTO_INCREMENT,
  `Titulo` varchar(150) NOT NULL,
  `AutorID` int NOT NULL,
  `Categoria` varchar(50) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Estado` enum('Disponible','Prestado','Reservado') DEFAULT 'Disponible',
  PRIMARY KEY (`LibroID`),
  UNIQUE KEY `ISBN` (`ISBN`),
  KEY `AutorID` (`AutorID`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`LibroID`, `Titulo`, `AutorID`, `Categoria`, `ISBN`, `Estado`) VALUES
(1, 'El Jardín Olvidado', 1, 'Novela', '978-1-56619-909-4', 'Disponible'),
(2, 'Sombras del Pasado', 2, 'Misterio', '978-0-596-52068-7', 'Prestado'),
(3, 'La Última Estrella', 3, 'Ciencia Ficción', '978-1-4028-9462-6', 'Disponible'),
(4, 'Sueños de Libertad', 4, 'Romance', '978-0-553-38018-2', 'Disponible'),
(5, 'Crónicas del Tiempo', 5, 'Fantasía', '978-0-7432-7356-5', 'Disponible'),
(6, 'El Eco de los Ecos', 6, 'Drama', '978-1-60309-057-5', 'Disponible'),
(7, 'Secretos de Medianoche', 7, 'Thriller', '978-0-14-044913-6', 'Disponible'),
(8, 'Ríos de Sangre', 8, 'Terror', '978-0-345-39180-3', 'Disponible'),
(9, 'La Isla del Olvido', 9, 'Aventura', '978-0-312-86123-6', 'Disponible'),
(10, 'Nubes Errantes', 10, 'Poesía', '978-0-679-78322-3', 'Disponible'),
(11, 'Campos de Ceniza', 11, 'Histórica', '978-0-399-14304-2', 'Disponible'),
(12, 'Corazones de Hierro', 12, 'Acción', '978-0-06-202403-9', 'Disponible'),
(13, 'El Mar en Llamas', 13, 'Fantasía', '978-0-307-88577-5', 'Disponible'),
(14, 'Sombras del Norte', 14, 'Misterio', '978-0-375-50420-8', 'Disponible'),
(15, 'Las Puertas de la Mente', 15, 'Psicológica', '978-1-84195-889-8', 'Disponible'),
(16, 'Bajo el Sol de Medianoche', 16, 'Drama', '978-1-250-30561-3', 'Disponible'),
(17, 'El Viento en los Sauces', 17, 'Aventura', '978-0-439-02348-1', 'Disponible'),
(18, 'La Llama Inmortal', 18, 'Romance', '978-0-06-112008-4', 'Disponible'),
(19, 'Más Allá del Horizonte', 19, 'Ciencia Ficción', '978-0-06-112241-5', 'Disponible'),
(20, 'Fragmentos de Esperanza', 20, 'Histórica', '978-0-14-118257-5', 'Disponible'),
(21, 'La Sombra del Viento', 21, 'Misterio', '978-0-06-112009-1', 'Disponible'),
(22, 'Los Días del Venado', 22, 'Fantasía', '978-0-06-112010-7', 'Disponible'),
(23, 'Pasaje a la Libertad', 23, 'Histórica', '978-0-06-112011-4', 'Disponible'),
(24, 'El Arte de Respirar', 24, 'Psicología', '978-0-06-112012-1', 'Disponible'),
(25, 'Caminos de Fuego', 25, 'Aventura', '978-0-06-112013-8', 'Disponible'),
(26, 'Ecos en la Oscuridad', 26, 'Thriller', '978-0-06-112014-5', 'Disponible'),
(27, 'El Último Susurro', 27, 'Terror', '978-0-06-112015-2', 'Disponible'),
(28, 'Cielos de Acero', 28, 'Ciencia Ficción', '978-0-06-112016-9', 'Disponible'),
(29, 'Entre Sombras y Luz', 29, 'Drama', '978-0-06-112017-6', 'Disponible'),
(30, 'El Juego de la Memoria', 30, 'Psicológica', '978-0-06-112018-3', 'Disponible'),
(31, 'Rosas de Otoño', 31, 'Romance', '978-0-06-112019-0', 'Disponible'),
(32, 'La Danza de los Espíritus', 32, 'Fantasía', '978-0-06-112020-6', 'Disponible'),
(33, 'Tierras Olvidadas', 33, 'Aventura', '978-0-06-112021-3', 'Disponible'),
(34, 'Ciudad de Cristal', 34, 'Misterio', '978-0-06-112022-0', 'Disponible'),
(35, 'Travesía de los Sueños', 35, 'Drama', '978-0-06-112023-7', 'Disponible'),
(36, 'Tiempos de Guerra', 36, 'Histórica', '978-0-06-112024-4', 'Disponible'),
(37, 'Noche de Invierno', 37, 'Terror', '978-0-06-112025-1', 'Disponible'),
(38, 'Laberintos del Alma', 38, 'Psicológica', '978-0-06-112026-8', 'Disponible'),
(39, 'Sombras Errantes', 39, 'Thriller', '978-0-06-112027-5', 'Disponible'),
(40, 'Reflejos de Luna', 40, 'Poesía', '978-0-06-112028-2', 'Disponible'),
(41, 'Ríos de Esperanza', 41, 'Drama', '978-0-06-112029-9', 'Disponible'),
(42, 'Secretos de Arena', 42, 'Aventura', '978-0-06-112030-5', 'Disponible'),
(43, 'El Guardián de los Sueños', 43, 'Fantasía', '978-0-06-112031-2', 'Disponible'),
(44, 'El Velo de las Sombras', 44, 'Misterio', '978-0-06-112032-9', 'Disponible'),
(45, 'Tiempos Rotos', 45, 'Histórica', '978-0-06-112033-6', 'Disponible'),
(46, 'Latidos del Silencio', 46, 'Psicológica', '978-0-06-112034-3', 'Disponible'),
(47, 'Brumas de Otoño', 47, 'Romance', '978-0-06-112035-0', 'Disponible'),
(48, 'El Horizonte Perdido', 48, 'Aventura', '978-0-06-112036-7', 'Disponible'),
(49, 'El Legado Prohibido', 49, 'Thriller', '978-0-06-112037-4', 'Disponible'),
(50, 'Llamas de Medianoche', 50, 'Terror', '978-0-06-112038-1', 'Disponible'),
(51, 'Entre Dos Mundos', 51, 'Fantasía', '978-0-06-112039-8', 'Disponible'),
(52, 'El Último Héroe', 52, 'Aventura', '978-0-06-112040-4', 'Disponible'),
(53, 'El Alquimista de Almas', 53, 'Misterio', '978-0-06-112041-1', 'Disponible'),
(54, 'Noches de Cristal', 54, 'Drama', '978-0-06-112042-8', 'Disponible'),
(55, 'Crónicas del Despertar', 55, 'Ciencia Ficción', '978-0-06-112043-5', 'Disponible'),
(56, 'Silencio Roto', 56, 'Psicológica', '978-0-06-112044-2', 'Disponible'),
(57, 'Sombras del Ayer', 57, 'Histórica', '978-0-06-112045-9', 'Disponible'),
(58, 'Colores de la Mente', 58, 'Poesía', '978-0-06-112046-6', 'Disponible'),
(59, 'Reflejo de un Sueño', 59, 'Drama', '978-0-06-112047-3', 'Disponible'),
(60, 'Los Ecos del Mañana', 60, 'Fantasía', '978-0-06-112048-0', 'Disponible'),
(61, 'Cruzando el Vacío', 61, 'Ciencia Ficción', '978-0-06-112049-7', 'Disponible'),
(62, 'El Viaje Imposible', 62, 'Aventura', '978-0-06-112050-3', 'Disponible'),
(63, 'Líneas de Sangre', 63, 'Thriller', '978-0-06-112051-0', 'Disponible'),
(64, 'Susurros del Desierto', 64, 'Romance', '978-0-06-112052-7', 'Disponible'),
(65, 'La Última Sonrisa', 65, 'Terror', '978-0-06-112053-4', 'Disponible'),
(66, 'La Sinfonía del Tiempo', 66, 'Fantasía', '978-0-06-112054-1', 'Disponible'),
(67, 'Vestigios del Pasado', 67, 'Histórica', '978-0-06-112055-8', 'Disponible'),
(68, 'Alas de Libertad', 68, 'Drama', '978-0-06-112056-5', 'Disponible'),
(69, 'El Eco del Silencio', 69, 'Psicológica', '978-0-06-112057-2', 'Disponible'),
(70, 'Luces de Invierno', 70, 'Poesía', '978-0-06-112058-9', 'Disponible'),
(71, 'Caminos Olvidados', 71, 'Aventura', '978-0-06-112059-6', 'Disponible'),
(72, 'Sombras del Corazón', 72, 'Romance', '978-0-06-112060-2', 'Disponible'),
(73, 'Más Allá del Miedo', 73, 'Terror', '978-0-06-112061-9', 'Disponible'),
(74, 'La Memoria del Agua', 74, 'Fantasía', '978-0-06-112062-6', 'Disponible'),
(75, 'Tierra de Nadie', 75, 'Ciencia Ficción', '978-0-06-112063-3', 'Disponible'),
(76, 'El Rostro de la Verdad', 76, 'Thriller', '978-0-06-112064-0', 'Disponible'),
(77, 'Voces en el Viento', 77, 'Poesía', '978-0-06-112065-7', 'Disponible'),
(78, 'Las Cenizas del Alba', 78, 'Drama', '978-0-06-112066-4', 'Disponible'),
(79, 'El Último Reino', 79, 'Histórica', '978-0-06-112067-1', 'Disponible'),
(80, 'El Pacto de las Sombras', 80, 'Misterio', '978-0-06-112068-8', 'Disponible'),
(81, 'Melodías de la Eternidad', 81, 'Romance', '978-0-06-112069-5', 'Disponible'),
(82, 'La Tormenta Eterna', 82, 'Fantasía', '978-0-06-112070-1', 'Disponible'),
(83, 'Trazos de Realidad', 83, 'Psicológica', '978-0-06-112071-8', 'Disponible'),
(84, 'Vidas Paralelas', 84, 'Drama', '978-0-06-112072-5', 'Disponible'),
(85, 'Sombras de Hierro', 85, 'Thriller', '978-0-06-112073-2', 'Disponible'),
(86, 'Los Últimos Guardianes', 86, 'Ciencia Ficción', '978-0-06-112074-9', 'Disponible'),
(87, 'El Vals de los Recuerdos', 87, 'Poesía', '978-0-06-112075-6', 'Disponible'),
(88, 'Brumas del Norte', 88, 'Aventura', '978-0-06-112076-3', 'Disponible'),
(89, 'Secretos en la Niebla', 89, 'Misterio', '978-0-06-112077-0', 'Disponible'),
(90, 'Las Huellas del Olvido', 90, 'Histórica', '978-0-06-112078-7', 'Disponible'),
(91, 'Más Allá de los Sueños', 91, 'Fantasía', '978-0-06-112079-4', 'Disponible'),
(92, 'Cantos de Medianoche', 92, 'Drama', '978-0-06-112080-0', 'Disponible'),
(93, 'El Reino Prohibido', 93, 'Ciencia Ficción', '978-0-06-112081-7', 'Disponible'),
(94, 'Ojos de Sombra', 94, 'Thriller', '978-0-06-112082-4', 'Disponible'),
(95, 'Espíritus del Amanecer', 95, 'Fantasía', '978-0-06-112083-1', 'Disponible'),
(96, 'Los Rostros del Tiempo', 96, 'Drama', '978-0-06-112084-8', 'Disponible'),
(97, 'Reflejos del Pasado', 97, 'Psicológica', '978-0-06-112085-5', 'Disponible'),
(98, 'Camino de Sombras', 98, 'Misterio', '978-0-06-112086-2', 'Disponible'),
(99, 'El Guardián del Silencio', 99, 'Romance', '978-0-06-112087-9', 'Disponible'),
(100, 'El Ciclo Infinito', 100, 'Ciencia Ficción', '978-0-06-112088-6', 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE IF NOT EXISTS `prestamos` (
  `PrestamoID` int NOT NULL AUTO_INCREMENT,
  `UsuarioID` int NOT NULL,
  `LibroID` int NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaVencimiento` date NOT NULL,
  `FechaDevolucion` date DEFAULT NULL,
  `Multa` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`PrestamoID`),
  KEY `UsuarioID` (`UsuarioID`),
  KEY `LibroID` (`LibroID`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`PrestamoID`, `UsuarioID`, `LibroID`, `FechaInicio`, `FechaVencimiento`, `FechaDevolucion`, `Multa`) VALUES
(1, 3, 1, '2025-04-30', '2025-05-15', '2025-04-30', 0.00),
(2, 1, 1, '2025-04-30', '2025-05-15', '2025-04-30', 0.00),
(3, 1, 2, '2025-04-30', '2025-05-15', '2025-04-30', 0.00),
(4, 1, 3, '2025-04-30', '2025-05-15', '2025-04-30', 0.00),
(5, 1, 4, '2025-04-30', '2025-05-15', '2025-04-30', 0.00),
(6, 1, 5, '2025-04-30', '2025-05-15', '2025-04-30', 0.00),
(7, 2, 1, '2025-05-01', '2025-05-16', '2025-05-05', 0.00),
(8, 2, 2, '2025-05-01', '2025-05-16', '2025-05-05', 0.00),
(9, 4, 2, '2025-10-04', '2025-10-19', NULL, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE IF NOT EXISTS `reservas` (
  `ReservaID` int NOT NULL AUTO_INCREMENT,
  `UsuarioID` int NOT NULL,
  `LibroID` int NOT NULL,
  `FechaReserva` date NOT NULL,
  `Estado` enum('Activa','Caducada','Cancelada') DEFAULT 'Activa',
  PRIMARY KEY (`ReservaID`),
  KEY `UsuarioID` (`UsuarioID`),
  KEY `LibroID` (`LibroID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`ReservaID`, `UsuarioID`, `LibroID`, `FechaReserva`, `Estado`) VALUES
(1, 3, 1, '2025-10-04', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `UsuarioID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `Identificacion` varchar(20) NOT NULL,
  `Rol` enum('Usuario','Bibliotecario','Administrador') DEFAULT 'Usuario',
  PRIMARY KEY (`UsuarioID`),
  UNIQUE KEY `Correo` (`Correo`),
  UNIQUE KEY `Identificacion` (`Identificacion`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`UsuarioID`, `Nombre`, `Correo`, `Identificacion`, `Rol`) VALUES
(1, 'Juan Andres Cardenas Alvarez', 'andres.cardenas@utp.edu.co', '12121234', 'Usuario'),
(2, 'Isabella Pelaez Duque', 'isa.pelaez@gmail.com', '987654321', 'Usuario'),
(3, 'David Fernando Benavides', 'david.benavides@gmail.com', '12345234789', 'Usuario'),
(4, 'Groot', 'Groot@123.com', '123456788', 'Usuario');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
