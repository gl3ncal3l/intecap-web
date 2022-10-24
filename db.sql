CREATE DATABASE db_hotel_intecap;
GO


USE db_hotel_intecap;
GO


CREATE TABLE estados_clientes(
	id_estado_cliente INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion VARCHAR(10) NOT NULL
);


CREATE TABLE clientes(
	id_cliente INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	telefono VARCHAR(11) NOT NULL,
	email VARCHAR(100) NOT NULL,
	contrasenia VARCHAR(256) NOT NULL,
	id_estado_cliente INT NOT NULL FOREIGN KEY REFERENCES estados_clientes(id_estado_cliente)
);


CREATE TABLE sedes(
	id_sede INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	direccion VARCHAR(256) NOT NULL,
	telefono VARCHAR(11) NOT NULL
);


CREATE TABLE roles(
	id_rol INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion VARCHAR(100) NOT NULL
);


CREATE TABLE usuarios(
	id_usuario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cui VARCHAR(14) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,	
	telefono VARCHAR(11) NOT NULL,
	email VARCHAR(100) NOT NULL,
	contrasenia VARCHAR(256) NOT NULL,
	id_rol INT NOT NULL FOREIGN KEY REFERENCES roles(id_rol),
	id_sede INT NOT NULL FOREIGN KEY REFERENCES sedes(id_sede)
);


CREATE TABLE estados(
	id_estado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion VARCHAR(20) NOT NULL
);


CREATE TABLE tipos(
	id_tipo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	descripcion VARCHAR(1024) NOT NULL
);


CREATE TABLE habitaciones(
	id_habitacion INT NOT NULL PRIMARY KEY,
	capacidad INT NOT NULL,
	cantidad_camas INT NOT NULL,
	costo DECIMAL(18,2) NOT NULL,
	id_tipo INT NOT NULL FOREIGN KEY REFERENCES tipos(id_tipo),
	id_estado INT NOT NULL FOREIGN KEY REFERENCES estados(id_estado),
	id_sede INT NOT NULL FOREIGN KEY REFERENCES sedes(id_sede)
);


CREATE TABLE estados_reservacion(
	id_estado_reservacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion VARCHAR(20) NOT NULL
);


CREATE TABLE reservaciones(
	id_reservacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_cliente INT NOT NULL FOREIGN KEY REFERENCES clientes(id_cliente),
	total DECIMAL(18,2) NOT NULL,
	fecha DATE NOT NULL,
	id_estado_reservacion INT NOT NULL FOREIGN KEY REFERENCES estados_reservacion(id_estado_reservacion)
);


CREATE TABLE detalle_reservacion(
	id_detalle_reservacion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_habitacion INT NOT NULL FOREIGN KEY REFERENCES habitaciones(id_habitacion),
	total DECIMAL(18,2) NOT NULL,
	id_reservacion INT NOT NULL FOREIGN KEY REFERENCES reservaciones(id_reservacion)
);


CREATE TABLE pagos(
	id_pago INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion VARCHAR(20) NOT NULL
);


CREATE TABLE facturas(
	id_factura INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_cliente INT NOT NULL FOREIGN KEY REFERENCES clientes(id_cliente),
	total DECIMAL(18,2) NOT NULL,
	fecha DATE NOT NULL,
	id_pago INT NOT NULL FOREIGN KEY REFERENCES pagos(id_pago)
);


CREATE TABLE detalle_factura(
	id_detalle_factura INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_habitacion INT NOT NULL FOREIGN KEY REFERENCES habitaciones(id_habitacion),
	total DECIMAL(18,2) NOT NULL,
	id_factura INT NOT NULL FOREIGN KEY REFERENCES facturas(id_factura)
);


-- INSERCIONES
INSERT INTO estados_clientes(descripcion) VALUES ('Pendiente'), ('Aprobado'), ('Denegado');


INSERT INTO clientes(nombre, apellido, telefono, email, contrasenia, id_estado_cliente)
VALUES('Fernanda','Cazorla','12345678','fcarzola@gmail.com','123fc',1),
('Antonio','Catalan','12345678','acatalan@gmail.com','1234ac',1),
('Manuel ','Hern�ndez','12345678','mhernandez@gmail.com','1234mh',1),
('Cintia','Mendez','12345678','cmendez@gmail.com','1234cm',1),
('Antonio','Alarcon','12345678','aalarcon@gmail.com','12345678aa',1);


INSERT INTO sedes(nombre,direccion,telefono)
VALUES('Costa Azul', 'Puerto San Jos�, Escuintla | Km 102 de la autopista.','+5022240022');


INSERT INTO roles(descripcion) VALUES ('Administrador'),('Empleado');


INSERT INTO usuarios(cui,nombre,apellido,telefono,email,contrasenia,id_rol,id_sede)
VALUES('6212393161','Juan','Palau','12345678','jpalau@gmail.com','1234jp',1,1),
('4257426233','Jose','Linares','12345678','jlinares@gmail.com','1234jl',2,1),
('6764515180','Aaron','Bonilla','12345678','abonilla@gmail.com','1234ab',2,1),
('1977997713','Julia','Perez','12345678','jperez@gmail.com','1234jp',2,1),
('2025834893','Bibiana','Guerra','12345678','bguerra@gmail.com','1234bg',2,1);


INSERT INTO estados(descripcion) 
VALUES('Disponible'), ('Ocupada'), ('Reservada');


INSERT INTO tipos(nombre,descripcion) 
VALUES('Deluxe Dos Camas Matrimoniales', 'Habitaci�n de Lujo con dos camas twin (individuales), cuenta con aire acondicionado, control remoto para TV con cable, bar ejecutivo, cajilla de seguridad, telefono con discado internacional directo, ba�o privado. Adicionalmente radio y secadora.'), 
('Deluxe King', 'Nuestra habitaci�n Deluxe King tiene 297 pies cuadrados (27.59 metros cuadrados) con vistas espectaculares a la ciudad o a los volcanes, dise�adas por completo para brindar confort. Para satisfacer las necesidades del viajero de negocios, el Hotel Grand Tikal Futura ofrece en sus remodeladas habitaciones todas.'), 
('Royale King', 'Habitaci�n de lujo con alojamiento exclusivo e impresionantes vistas panor�micas. Ofrece Desayuno Continental cada ma�ana, caf� y t� todo el d�a y por la noche c�cteles y canap�s. Adem�s cuenta con servicio de concierge las 24 horas, revistas y peri�dicos. Estos cuartos incluyen sistema individual de aire acondicionado, televisor plasma, control remoto, servicio de cable para TV, bar ejecutivo, tel�fono con discado internacional directo, contestador autom�tico y ba�o privado. Adem�s, en el cuarto podr� encontrar un reloj despertador, secadora de cabello y una cajilla de seguridad. Las habitaciones que est�n en el noveno piso cuentan con duchas de vidrio en los ba�os privados.'), 
('Royale Dos Camas Matrimoniales','Habitacion de lujo para dos personas con alojamiento exclusivo e impresionantes vistas panor�micas. Ofrece Desayuno Continental cada ma�ana, caf� y t� todo el d�a y por la noche c�cteles y canap�s. Adem�s cuenta con servicio de concierge las 24 horas, revistas y peri�dicos. Estos cuartos incluyen sistema individual de aire acondicionado, televisor plasma, control remoto, servicio de cable para TV, bar ejecutivo, tel�fono con discado internacional directo, contestador autom�tico y ba�o privado. Adem�s, en el cuarto podr� encontrar un reloj despertador, secadora de cabello y una cajilla de seguridad. Las habitaciones que est�n en el noveno piso cuentan con duchas de vidrio en los ba�os privados.'),
('Suite Ejecutiva', 'Esta suite ofrece una sala separada del dormitorio, especial para aquellos que desean recibir visitas o llevar a cabo reuniones de negocios. El �rea de la suite est� amueblada con c�modos sof�s, televisor con control remoto, gabinete con un bar ejecutivo y un escritorio ejecutivo. Los ba�os tienen secadores de pelo, batas para salida de ba�o y amenidades de lujo. Tambi�n cuenta con personal multiling�e de turno para atender las necesidades de los hu�spedes.'), 
('Master Suite', 'Estas Suites incluyen sistema individual de aire acondicionado, televisor plasma, control remoto, servicio de cable para TV, bar ejecutivo, tel�fono con discado internacional directo, contestador autom�tico y ba�o privado. Adem�s, en el cuarto podr� encontrar un reloj despertador, secadora de cabello y una cajilla de seguridad. Las habitaciones que est�n en el noveno piso cuentan con duchas de vidrio en los ba�os privados.'), 
('Presidential Suite', 'Ubicado en el und�cimo piso, cuenta con vista panor�mica a la ciudad; re�ne varios ambientes, servicios y amenidades extraordinarias dentro de sus 240 metros cuadrados. Cuenta con un dormitorio, un amplio comedor, una acogedora sala de estar, una estaci�n de trabajo con escritorio ejecutivo, cocineta y ba�o de visitas.');


INSERT INTO habitaciones(id_habitacion, capacidad, cantidad_camas, costo, id_tipo, id_estado, id_sede)
VALUES (101, 4, 2, 750.0, 1, 1, 1), 
(102, 3, 2, 750.0, 1, 1, 1), 
(103, 3, 2, 750.0, 1, 1, 1), 
(104, 3, 2, 750.0, 1, 1, 1),
(105, 3, 2, 750.0, 1, 1, 1),

(106, 3, 2, 800.0, 2, 1, 1),
(107, 3, 2, 800.0, 2, 1, 1),
(108, 3, 2, 800.0, 2, 1, 1),
(109, 3, 2, 800.0, 2, 1, 1),
(110, 3, 2, 800.0, 2, 1, 1),

(111, 3, 2, 850.0, 3, 1, 1),
(112, 3, 2, 850.0, 3, 1, 1),
(113, 3, 2, 850.0, 3, 1, 1),
(114, 3, 2, 850.0, 3, 1, 1),
(115, 3, 2, 850.0, 3, 1, 1),

(116, 3, 2, 850.0, 4, 1, 1),
(117, 3, 2, 850.0, 4, 1, 1),
(118, 3, 2, 850.0, 4, 1, 1),
(119, 3, 2, 850.0, 4, 1, 1),
(120, 3, 2, 850.0, 4, 1, 1),

(121, 3, 2, 900.0, 5, 1, 1),
(122, 3, 2, 900.0, 5, 1, 1),
(123, 3, 2, 900.0, 5, 1, 1),
(124, 3, 2, 900.0, 5, 1, 1),
(125, 3, 2, 900.0, 5, 1, 1),

(126, 3, 2, 1000.0, 6, 1, 1),
(127, 3, 2, 1000.0, 6, 1, 1),
(128, 3, 2, 1000.0, 6, 1, 1),
(129, 3, 2, 1000.0, 6, 1, 1),
(130, 3, 2, 1000.0, 6, 1, 1),

(131, 4, 2, 1200.0, 7, 1, 1),
(132, 4, 2, 1200.0, 7, 1, 1),
(133, 4, 2, 1200.0, 7, 1, 1),
(134, 4, 2, 1200.0, 7, 1, 1),
(135, 4, 2, 1200.0, 7, 1, 1);


INSERT INTO estados_reservacion (descripcion)
VALUES ('Confirmada'), ('Por Confirmar'), ('Anulada');


INSERT INTO pagos (descripcion)
VALUES('Efectivo'), ('Tarjeta');

--PROCEDIMIENTOS ALMACENADOS




