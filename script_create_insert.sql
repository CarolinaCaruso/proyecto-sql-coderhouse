CREATE DATABASE IF NOT EXISTS pizzeria;

USE pizzeria;

-- #1 
CREATE TABLE IF NOT EXISTS CLIENTES(
	id_cliente INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(120) NOT NULL,
    telefono VARCHAR (20) NOT NULL
);

-- #2
CREATE TABLE IF NOT EXISTS INSUMOS(
	id_insumo INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	unidad VARCHAR(30) NOT NULL,
    tipo VARCHAR(15) NOT NULL,
    costo DECIMAL
);

-- #3
CREATE TABLE IF NOT EXISTS PROVEEDORES(
	id_proveedor INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(60) UNIQUE,
    telefono VARCHAR(20) UNIQUE
);

-- #4
CREATE TABLE IF NOT EXISTS COMPRAS(
	id_compra INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha DATETIME NOT NULL,
    monto_total DECIMAL(9,2),
	FOREIGN KEY (id_proveedor)
		REFERENCES proveedores(id_proveedor)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #5
CREATE TABLE IF NOT EXISTS COMPRAS_INSUMOS(
	id_unique INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	id_compra INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad DECIMAL(9,2) NOT NULL,
    precio_x_unidad DECIMAL(9,2) NOT NULL,
    CONSTRAINT UNIQUE(id_compra , id_insumo),
	FOREIGN KEY (id_compra)
		REFERENCES compras(id_compra)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
	FOREIGN KEY (id_insumo)
		REFERENCES insumos(id_insumo)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #6
CREATE TABLE IF NOT EXISTS TIPOS_PREPIZZAS(
	id_tipo_prepizza INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	nombre_tipo VARCHAR(30) NOT NULL
);


-- #7
CREATE TABLE IF NOT EXISTS TIPOS_PREPIZZAS_INSUMOS(
	id_unique INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	id_tipo_prepizza INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad DECIMAL(9,5) NOT NULL,
    CONSTRAINT UNIQUE(id_tipo_prepizza , id_insumo),
    FOREIGN KEY (id_tipo_prepizza)
		REFERENCES tipos_prepizzas(id_tipo_prepizza)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
	FOREIGN KEY (id_insumo)
		REFERENCES insumos(id_insumo)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #8
CREATE TABLE IF NOT EXISTS SABORES(
	id_sabor INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- #9
CREATE TABLE IF NOT EXISTS SABORES_INSUMOS(
	id_unique INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	id_sabor INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad DECIMAL(9,2) NOT NULL,
	CONSTRAINT UNIQUE(id_sabor , id_insumo),
    FOREIGN KEY (id_sabor)
		REFERENCES sabores(id_sabor)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
	FOREIGN KEY (id_insumo)
		REFERENCES insumos(id_insumo)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #10
CREATE TABLE IF NOT EXISTS PRODUCTOS(
	id_producto INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,	
    id_tipo_prepizza INT NOT NULL,
	id_sabor INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    precio INT,
	FOREIGN KEY (id_tipo_prepizza)
	REFERENCES tipos_prepizzas(id_tipo_prepizza)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
    FOREIGN KEY (id_sabor)
		REFERENCES sabores(id_sabor)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #11
CREATE TABLE IF NOT EXISTS ACCESORIOS_CANTIDAD(
	id_unique INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_insumo INT NOT NULL,
    cantidad DECIMAL(9,5),
    FOREIGN KEY (id_insumo)
		REFERENCES insumos(id_insumo)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #12
CREATE TABLE IF NOT EXISTS ACTUALIZACIONES_PRECIOS_PRODUCTOS(
	id_unique INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	fecha DATE NOT NULL,
	id_producto INT NOT NULL,
    nuevo_precio DECIMAL(9,2) NOT NULL,
    es_precio_actual TINYINT NOT NULL DEFAULT 1,

	FOREIGN KEY (id_producto)
		REFERENCES productos(id_producto)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #13
CREATE TABLE IF NOT EXISTS PEDIDOS(
	id_pedido INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
	fecha DATETIME NOT NULL,
    sub_total DECIMAL(9,2),
    descuento DECIMAL(9,2) DEFAULT 0,
    monto_final DECIMAL(9,2),
	estado TINYINT NOT NULL DEFAULT 0,
	FOREIGN KEY (id_cliente)
		REFERENCES clientes(id_cliente)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #14
CREATE TABLE IF NOT EXISTS PEDIDOS_PRODUCTOS(
	id_unique INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
	CONSTRAINT UNIQUE(id_pedido , id_producto),
    FOREIGN KEY (id_pedido)
		REFERENCES pedidos(id_pedido)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
	FOREIGN KEY (id_producto)
		REFERENCES productos(id_producto)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #15
CREATE TABLE IF NOT EXISTS DELIVERYS(
	id_delivery INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL UNIQUE
    
);

-- #16
CREATE TABLE IF NOT EXISTS VEHICULOS(
	id_vehiculo INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    clase VARCHAR(20) NOT NULL,
    descripcion VARCHAR(60) NOT NULL,
	patente VARCHAR(20) UNIQUE
);

-- #17
CREATE TABLE IF NOT EXISTS ENTREGAS(
	id_entrega INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	id_delivery INT NOT NULL,
	id_vehiculo INT NOT NULL,
    fecha DATETIME NOT NULL,
    horario_salida TIME NOT NULL,
    
	FOREIGN KEY (id_vehiculo)
		REFERENCES vehiculos(id_vehiculo)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
	FOREIGN KEY (id_delivery)
		REFERENCES deliverys(id_delivery)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- #18
CREATE TABLE IF NOT EXISTS ENTREGAS_PEDIDOS(
	id_unique INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	id_entrega INT NOT NULL,
	id_pedido INT NOT NULL,
    	CONSTRAINT UNIQUE(id_unique, id_pedido),
	FOREIGN KEY (id_entrega)
		REFERENCES entregas(id_entrega)
			ON DELETE CASCADE
            ON UPDATE CASCADE,
	FOREIGN KEY (id_pedido)
		REFERENCES pedidos(id_pedido)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);


#   -----------------            INSERCION DE DATOS            ------------------------

-- (1) CLIENTES

insert into clientes (id_cliente, nombre, direccion, telefono) values (1, 'Elizabet Karpe', '50 Kropf Street', '5375141827');
insert into clientes (id_cliente, nombre, direccion, telefono) values (2, 'Eward Hutcheon', '8 Dapin Trail', '6327596657');
insert into clientes (id_cliente, nombre, direccion, telefono) values (3, 'Alejandrina Luna', '5 Bashford Circle', '6311760244');
insert into clientes (id_cliente, nombre, direccion, telefono) values (4, 'Lilla Morde', '61 Darwin Pass', '1854785047');
insert into clientes (id_cliente, nombre, direccion, telefono) values (5, 'Darrick Charley', '03625 Fisk Avenue', '5814863799');
insert into clientes (id_cliente, nombre, direccion, telefono) values (6, 'Dawna Hampson', '29598 Stoughton Court', '1026384010');
insert into clientes (id_cliente, nombre, direccion, telefono) values (7, 'Franky Puve', '7 Lindbergh Terrace', '9001631552');
insert into clientes (id_cliente, nombre, direccion, telefono) values (8, 'Calvin Stirrip', '9 Havey Crossing', '3148147493');
insert into clientes (id_cliente, nombre, direccion, telefono) values (9, 'Floria Andries', '2 Texas Court', '7209972582');
insert into clientes (id_cliente, nombre, direccion, telefono) values (10, 'Aimil Arthan', '3783 Bay Alley', '8951147863');
insert into clientes (id_cliente, nombre, direccion, telefono) values (11, 'Sonnie Best', '9 Onsgard Court', '8626803843');
insert into clientes (id_cliente, nombre, direccion, telefono) values (12, 'Sophi Couroy', '21 Sachs Lane', '7988014812');
insert into clientes (id_cliente, nombre, direccion, telefono) values (13, 'Leila Pflieger', '02355 Sugar Point', '6898451076');
insert into clientes (id_cliente, nombre, direccion, telefono) values (14, 'Piper Diver', '3 Gina Circle', '9938738282');
insert into clientes (id_cliente, nombre, direccion, telefono) values (15, 'Bonita Crooks', '1391 Maryland Circle', '4968079115');
insert into clientes (id_cliente, nombre, direccion, telefono) values (16, 'Winfred O''Carran', '08 Waubesa Trail', '2136463617');
insert into clientes (id_cliente, nombre, direccion, telefono) values (17, 'Henderson Russam', '85345 Rowland Center', '2694997965');
insert into clientes (id_cliente, nombre, direccion, telefono) values (18, 'Garrott Yakovl', '35221 Merchant Pass', '2273308464');
insert into clientes (id_cliente, nombre, direccion, telefono) values (19, 'Orelia Gillio', '31 Red Cloud Plaza', '4618448591');
insert into clientes (id_cliente, nombre, direccion, telefono) values (20, 'Alica Scrivenor', '49187 Oxford Trail', '2025470108');
insert into clientes (id_cliente, nombre, direccion, telefono) values (21, 'Kyrstin Durand', '3229 Chive Court', '3966985409');
insert into clientes (id_cliente, nombre, direccion, telefono) values (22, 'Lazar Legg', '2684 Sunfield Parkway', '4521483880');
insert into clientes (id_cliente, nombre, direccion, telefono) values (23, 'Gabriellia Breukelman', '0614 Shopko Street', '9232028666');
insert into clientes (id_cliente, nombre, direccion, telefono) values (24, 'Lise Guslon', '02311 Dakota Place', '2473890349');
insert into clientes (id_cliente, nombre, direccion, telefono) values (25, 'Trula Petrik', '76 Clemons Parkway', '4927947511');
insert into clientes (id_cliente, nombre, direccion, telefono) values (26, 'Bar Mikalski', '29742 Fairview Plaza', '9508212043');
insert into clientes (id_cliente, nombre, direccion, telefono) values (27, 'Jackqueline Shaxby', '0702 Weeping Birch Way', '4848446564');
insert into clientes (id_cliente, nombre, direccion, telefono) values (28, 'Allegra Ivantsov', '51443 Steensland Trail', '4652601313');
insert into clientes (id_cliente, nombre, direccion, telefono) values (29, 'Wang Glazebrook', '59517 Holy Cross Street', '9415672301');
insert into clientes (id_cliente, nombre, direccion, telefono) values (30, 'Colby Gogarty', '6 Pankratz Court', '3062084069');
insert into clientes (id_cliente, nombre, direccion, telefono) values (31, 'Wes Beauchop', '0530 Beilfuss Terrace', '7932142364');
insert into clientes (id_cliente, nombre, direccion, telefono) values (32, 'Farly Physic', '05942 Elka Street', '5566675283');
insert into clientes (id_cliente, nombre, direccion, telefono) values (33, 'Danny Laverack', '59 Ohio Circle', '4458861957');
insert into clientes (id_cliente, nombre, direccion, telefono) values (34, 'Trix Ratlee', '4508 Moland Trail', '3995172156');
insert into clientes (id_cliente, nombre, direccion, telefono) values (35, 'Joaquin Tapp', '798 Waywood Hill', '1965460125');
insert into clientes (id_cliente, nombre, direccion, telefono) values (36, 'Quinta Pavy', '8 Hoard Circle', '9842128086');
insert into clientes (id_cliente, nombre, direccion, telefono) values (37, 'Katleen Plait', '770 Stuart Trail', '1887990646');
insert into clientes (id_cliente, nombre, direccion, telefono) values (38, 'Nanci Simmon', '4043 Rieder Park', '2773080454');
insert into clientes (id_cliente, nombre, direccion, telefono) values (39, 'Cristionna Shillum', '5754 Golf Course Street', '1746708351');
insert into clientes (id_cliente, nombre, direccion, telefono) values (40, 'Maible Angless', '8 Moland Circle', '3353756686');
insert into clientes (id_cliente, nombre, direccion, telefono) values (41, 'Wells McKeady', '500 Cambrid_clientege Trail', '1072373332');
insert into clientes (id_cliente, nombre, direccion, telefono) values (42, 'Tera Tichelaar', '5 Rusk Avenue', '7021770091');
insert into clientes (id_cliente, nombre, direccion, telefono) values (43, 'Helenelizabeth Jannaway', '07924 Susan Circle', '3826153522');
insert into clientes (id_cliente, nombre, direccion, telefono) values (44, 'Abner Martel', '5 Calypso Park', '6884272210');
insert into clientes (id_cliente, nombre, direccion, telefono) values (45, 'Windy Sedman', '125 Mcbrid_clientee Point', '1262849995');
insert into clientes (id_cliente, nombre, direccion, telefono) values (46, 'Christyna Rothery', '42 6th Junction', '8199069411');
insert into clientes (id_cliente, nombre, direccion, telefono) values (47, 'Kahaleel Chimienti', '3 School Alley', '7212144711');
insert into clientes (id_cliente, nombre, direccion, telefono) values (48, 'Kassandra Plail', '91907 East Place', '1857298694');
insert into clientes (id_cliente, nombre, direccion, telefono) values (49, 'Jasen Orrid_clientege', '4076 Becker Street', '2012669683');
insert into clientes (id_cliente, nombre, direccion, telefono) values (50, 'Shauna Cheal', '0 Village Junction', '9115158079');
insert into clientes (id_cliente, nombre, direccion, telefono) values (51, 'Ozzy Sneaker', '1889 Loftsgordon Court', '1465266127');
insert into clientes (id_cliente, nombre, direccion, telefono) values (52, 'Mabelle Trillo', '47 Springs Pass', '4544370404');
insert into clientes (id_cliente, nombre, direccion, telefono) values (53, 'Devlen Colliber', '38480 Center Crossing', '9125768736');
insert into clientes (id_cliente, nombre, direccion, telefono) values (54, 'Nisse Mann', '63 Fieldstone Alley', '5854914958');
insert into clientes (id_cliente, nombre, direccion, telefono) values (55, 'Hettie Rockcliffe', '0007 Ohio Place', '4157458909');
insert into clientes (id_cliente, nombre, direccion, telefono) values (56, 'Christalle Roose', '6391 Nobel Street', '1711741008');
insert into clientes (id_cliente, nombre, direccion, telefono) values (57, 'Cynthia Tonge', '76850 Sutherland Pass', '9218604343');
insert into clientes (id_cliente, nombre, direccion, telefono) values (58, 'Berrie Alwood', '5393 6th Pass', '8281672728');
insert into clientes (id_cliente, nombre, direccion, telefono) values (59, 'Kippie Helin', '274 Artisan Center', '3811421688');
insert into clientes (id_cliente, nombre, direccion, telefono) values (60, 'Ned Jauncey', '272 Lakeland Point', '8315113142');
insert into clientes (id_cliente, nombre, direccion, telefono) values (61, 'Caleb Humes', '76665 Golf Course Junction', '9853473159');
insert into clientes (id_cliente, nombre, direccion, telefono) values (62, 'Donna Plover', '4804 Golf Course Place', '5813231363');
insert into clientes (id_cliente, nombre, direccion, telefono) values (63, 'Duke De Cristofalo', '149 Coleman Place', '1682369025');
insert into clientes (id_cliente, nombre, direccion, telefono) values (64, 'Nanine Halford', '98994 Coleman Terrace', '9892778915');
insert into clientes (id_cliente, nombre, direccion, telefono) values (65, 'Bartholomeus Opy', '847 Starling Circle', '2201894835');
insert into clientes (id_cliente, nombre, direccion, telefono) values (66, 'Renate Heinemann', '9055 Grover Park', '9967071065');
insert into clientes (id_cliente, nombre, direccion, telefono) values (67, 'Quinta Gorrissen', '1056 Roth Court', '2735791258');
insert into clientes (id_cliente, nombre, direccion, telefono) values (68, 'Drake Furmenger', '7 Fuller Crossing', '6844951794');
insert into clientes (id_cliente, nombre, direccion, telefono) values (69, 'Beverlee Chatelot', '18992 Sunnysid_clientee Avenue', '4463898452');
insert into clientes (id_cliente, nombre, direccion, telefono) values (70, 'Natasha Poate', '27362 Fair Oaks Drive', '8115135425');

-- (2) INSUMOS

INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (1,'leche','litros',1,350);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (2,'huevos','unidades',1,20);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (3,'muzzarela','kg',1,2200);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (4,'jamon','kg',1,3650);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (5,'salchicha','paquetes de 6',1,230);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (6,'aceitunas','kg',1,1210);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (7,'salame','kg',1,210);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (8,'salsa de tomate','litros',1,370);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (9,'oregano','kg',1,2390);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (10,'sal','kg',1,270);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (11,'azucar','kg',1,450);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (12,'cebolla','kg',1,600);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (13,'tomate','kg',1,400);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (14,'morron','kg',1,200);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (15,'rucula','kg',1,890);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (16,'queso rallado','kg',1,3200);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (17,'levadura','kg',1,760);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (18,'longaniza','kg',1,4250);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (19,'harina','kg',1,320);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (20,'aceite de oliva','botella 1 litros',1,1050);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (21,'palmitos','lata de 800 gr',1,3600);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (22,'cajas','unidades',2,45);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (23,'mesita de plastico','kg',2,840);
INSERT INTO insumos(id_insumo,nombre,unidad,tipo,costo) VALUES (24,'papel interior','kg',2,950);


-- (3) PROVEEDORES

INSERT INTO proveedores VALUES (NULL, 'Maxiconsumo', 'Larrea 456', '1143212354');
INSERT INTO proveedores VALUES (NULL, 'Dany', 'Paez 555', '1534567890');
INSERT INTO proveedores VALUES (NULL, 'Rocio', 'Corrientes 789', '1134345890');
INSERT INTO proveedores VALUES (NULL, 'Malena', 'Urquiza 123', '1167655890');

-- (4) COMPRAS

INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (1,1,'2022-11-01 12:00:00');
INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (2,2,'2022-11-01 12:00:00');
INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (3,3,'2022-11-01 12:00:00');
INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (4,1,'2022-11-10 12:00:00');
INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (5,2,'2022-11-10 12:00:00');
INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (6,1,'2022-11-20 12:00:00');
INSERT INTO compras(id_compra,id_proveedor,fecha) VALUES (7,4,'2022-12-01 12:00:00');

-- (5) COMPRAS INSUMOS

INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (1,1,1,6,300);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (2,1,2,24,20);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (3,1,3,3,2200);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (4,1,4,2,3600);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (5,1,5,6,200);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (7,1,6,1,1200);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (8,1,7,10,200);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (9,1,8,2,360);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (10,2,9,1,2380);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (11,2,10,1,250);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (12,2,11,1,400);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (13,2,12,1,600);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (14,2,13,4,400);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (15,2,14,3,200);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (16,2,15,2,890);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (17,3,16,1,3200);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (18,3,17,1,760);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (19,3,18,0.5,4250);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (20,3,19,5,300);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (21,3,20,1,1000);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (22,3,21,1,3500);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (23,3,22,100,40);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (24,3,23,1,846);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (25,3,24,1,951);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (26,4,1,5,350);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (27,4,4,1000,3650);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (28,4,5,4,230);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (29,4,12,2,600);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (30,5,6,1,1210);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (31,5,7,10,210);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (32,5,8,2,370);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (33,5,9,1,2390);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (34,5,10,1,270);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (35,5,11,1,450);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (36,6,20,1,1100);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (37,6,21,1,3550);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (38,6,22,100,45);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (39,6,23,1,850);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (40,6,24,1,1000);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (41,7,19,2,320);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (42,7,20,1,1050);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (43,7,21,1,3600);
INSERT INTO compras_insumos(id_unique,id_compra,id_insumo,cantidad,precio_x_unidad) VALUES (44,7,22,100,45);


-- (6) TIPOS PREPIZZAS INSUMOS

INSERT INTO tipos_prepizzas(id_tipo_prepizza, nombre_tipo) VALUES (1, 'Clasica');
INSERT INTO tipos_prepizzas(id_tipo_prepizza, nombre_tipo) VALUES (2,'Rellena');

-- (7) TIPOS PREPIZZAS INSUMOS

INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (1,1,8,0.001);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (2,1,3,0.25);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (3,1,19,0.25);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (4,1,10,0.00025);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (5,1,17,0.0125);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (6,1,9,0.0001);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (7,2,8,0.001);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (8,2,3,0.5);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (9,2,19,0.5);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (10,2,10,0.0005);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (11,2,17,0.02);
INSERT INTO tipos_prepizzas_insumos(id_unique,id_tipo_prepizza,id_insumo,cantidad) VALUES (12,2,9,0.0001);

-- (8) SABORES

INSERT INTO sabores(id_sabor,nombre) VALUES (1,'Muzarella');
INSERT INTO sabores(id_sabor,nombre) VALUES (2,'Napolitana');
INSERT INTO sabores(id_sabor,nombre) VALUES (3,'Rucula');
INSERT INTO sabores(id_sabor,nombre) VALUES (4,'Jamon y Morron');
INSERT INTO sabores(id_sabor,nombre) VALUES (5,'Huevo');
INSERT INTO sabores(id_sabor,nombre) VALUES (6,'Palmitos');
INSERT INTO sabores(id_sabor,nombre) VALUES (7,'Cebolla');
INSERT INTO sabores(id_sabor,nombre) VALUES (8,'Salchicha');
INSERT INTO sabores(id_sabor,nombre) VALUES (9,'Salame');

-- (9) SABORES INSUMOS

INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (1,2,13,0.5);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (2,3,15,0.15);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (3,4,4,0.15);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (4,4,14,0.3);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (5,5,2,2);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (6,6,21,0.5);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (7,7,12,0.3);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (8,8,5,0.5);
INSERT INTO sabores_insumos(id_unique,id_sabor,id_insumo,cantidad) VALUES (9,9,7,0.1);

-- (10) PRODUCTOS

INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (1,1,1,'Muzzarella Clasica','Muzzarella 8 porciones clasica',2970);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (2,1,2,'Napolitana Clasica','Tomate 8 porciones clasica',3300);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (3,1,3,'Rucula Clasica','Rucula 8 porciones clasica',3410);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (4,1,4,'Jamon y Morron Clasica','Jamon y morrón 8 porciones clasica',3520);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (5,1,5,'Huevo Clasica','Huevo 8 porciones  clasica',3630);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (6,1,6,'Palmitos Clasica','Palmitos 8 porciones clasica',3740);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (7,1,7,'Fugazza Clasica','Cebolla 8 porciones clasica',3850);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (8,1,8,'Salchicha Clasica','Salchicha 8 porciones clasica',3740);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (9,1,9,'Salame Clasica','Salame 8 porciones clasica',3267);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (10,2,1,'Muzzarella Rellena','Muzzarella 6 porciones muzzarella extra',3630);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (11,2,2,'Napolitana Rellena','Tomate 6 porciones muzzarella extra',3751);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (12,2,3,'Rucula Rellena','Rucula 6 porciones muzzarella extra',3872);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (13,2,4,'Jamon y Morron Rellena','Jamon y morrón 6 porciones muzzarella extra',3993);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (14,2,5,'Huevo Rellena','Huevo 6 porciones  muzzarella extra',4114);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (15,2,6,'Palmitos Rellena','Palmitos 6 porciones muzzarella extra',4235);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (16,2,7,'Fugazza Rellena','Cebolla 6 porciones muzzarella extra',4114);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (17,2,8,'Salchicha Rellena','Salchicha 6 porciones muzzarella extra',3595);
INSERT INTO productos(id_producto,id_tipo_prepizza,id_sabor,nombre,descripcion,precio) VALUES (18,2,9,'Salame Rellena','Salame 6 porciones muzzarella extra',3993);

-- (11) ACCESORIOS CANTIDAD

INSERT INTO accesorios_cantidad(id_unique,id_insumo,cantidad) VALUES (1,22,1);
INSERT INTO accesorios_cantidad(id_unique,id_insumo,cantidad) VALUES (2,23,0.002);
INSERT INTO accesorios_cantidad(id_unique,id_insumo,cantidad) VALUES (3,24,0.005);

-- (12) ACTUALIZACIONES PRECIOS PRODUCTOS

INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (1,'2022-11-01',1,2700,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (2,'2022-11-01',2,3000,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (3,'2022-11-01',3,3100,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (4,'2022-11-01',4,3200,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (5,'2022-11-01',5,3300,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (6,'2022-11-01',6,3400,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (7,'2022-11-01',7,3500,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (8,'2022-11-01',8,3400,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (9,'2022-11-01',9,2970,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (10,'2022-11-01',10,3300,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (11,'2022-11-01',11,3410,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (12,'2022-11-01',12,3520,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (13,'2022-11-01',13,3630,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (14,'2022-11-01',14,3740,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (15,'2022-11-01',15,3850,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (16,'2022-11-01',16,3740,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (17,'2022-11-01',17,3267,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (18,'2022-11-01',18,3630,0);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (19,'2022-12-01',1,2970,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (20,'2022-12-02',2,3300,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (21,'2022-12-03',3,3410,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (22,'2022-12-04',4,3520,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (23,'2022-12-05',5,3630,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (24,'2022-12-06',6,3740,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (25,'2022-12-07',7,3850,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (26,'2022-12-08',8,3740,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (27,'2022-12-09',9,3267,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (28,'2022-12-10',10,3630,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (29,'2022-12-11',11,3751,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (30,'2022-12-12',12,3872,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (31,'2022-12-13',13,3993,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (32,'2022-12-14',14,4114,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (33,'2022-12-15',15,4235,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (34,'2022-12-16',16,4114,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (35,'2022-12-17',17,3595,1);
INSERT INTO actualizaciones_precios_productos(id_unique,fecha,id_producto,nuevo_precio,es_precio_actual) VALUES (36,'2022-12-18',18,3993,1);

-- (13) PEDIDOS

INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (1,56,'2022/11/03',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (2,30,'2022/11/04',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (3,40,'2022/11/04',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (4,41,'2022/11/05',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (5,34,'2022/11/05',NULL,80,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (6,15,'2022/11/05',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (7,39,'2022/11/05',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (8,10,'2022/11/06',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (9,16,'2022/11/06',NULL,35,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (10,34,'2022/11/06',NULL,65,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (11,11,'2022/11/07',NULL,70,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (12,58,'2022/11/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (13,25,'2022/11/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (14,53,'2022/11/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (15,65,'2022/11/08',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (16,13,'2022/11/08',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (17,43,'2022/11/08',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (18,30,'2022/11/08',NULL,140,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (19,57,'2022/11/08',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (20,66,'2022/11/08',NULL,10,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (21,42,'2022/11/09',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (22,15,'2022/11/09',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (23,51,'2022/11/09',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (24,39,'2022/11/10',NULL,80,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (25,20,'2022/11/10',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (26,23,'2022/11/10',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (27,40,'2022/11/11',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (28,8,'2022/11/11',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (29,59,'2022/11/11',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (30,38,'2022/11/11',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (31,59,'2022/11/11',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (32,11,'2022/11/12',NULL,15,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (33,65,'2022/11/12',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (34,64,'2022/11/13',NULL,80,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (35,17,'2022/11/13',NULL,10,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (36,43,'2022/11/13',NULL,10,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (37,65,'2022/11/13',NULL,10,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (38,1,'2022/11/13',NULL,65,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (39,53,'2022/11/13',NULL,20,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (40,19,'2022/11/14',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (41,65,'2022/11/14',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (42,46,'2022/11/14',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (43,22,'2022/11/15',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (44,23,'2022/11/16',NULL,155,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (45,26,'2022/11/16',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (46,27,'2022/11/17',NULL,140,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (47,21,'2022/11/17',NULL,35,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (48,1,'2022/11/17',NULL,145,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (49,17,'2022/11/17',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (50,42,'2022/11/18',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (51,55,'2022/11/18',NULL,125,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (52,66,'2022/11/18',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (53,41,'2022/11/19',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (54,37,'2022/11/20',NULL,195,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (55,65,'2022/11/20',NULL,240,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (56,12,'2022/11/20',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (57,17,'2022/11/20',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (58,47,'2022/11/21',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (59,36,'2022/11/21',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (60,38,'2022/11/25',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (61,67,'2022/11/25',NULL,155,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (62,9,'2022/11/25',NULL,55,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (63,28,'2022/11/26',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (64,58,'2022/11/26',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (65,17,'2022/11/28',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (66,70,'2022/11/28',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (67,14,'2022/11/28',NULL,135,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (68,50,'2022/11/30',NULL,55,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (69,19,'2022/11/30',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (70,20,'2022/11/30',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (71,8,'2022/11/30',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (72,34,'2022/11/30',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (73,37,'2022/12/01',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (74,26,'2022/12/02',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (75,11,'2022/12/02',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (76,26,'2022/12/05',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (77,58,'2022/12/05',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (78,14,'2022/12/05',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (79,21,'2022/12/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (80,35,'2022/12/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (81,32,'2022/12/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (82,63,'2022/12/07',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (83,42,'2022/12/10',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (84,64,'2022/12/10',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (85,25,'2022/12/10',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (86,16,'2022/12/10',NULL,55,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (87,68,'2022/12/10',NULL,180,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (88,13,'2022/12/11',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (89,39,'2022/12/13',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (90,49,'2022/12/13',NULL,150,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (91,70,'2022/12/13',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (92,37,'2022/12/15',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (93,35,'2022/12/15',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (94,68,'2022/12/17',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (95,17,'2022/12/17',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (96,60,'2022/12/17',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (97,58,'2022/12/17',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (98,59,'2022/12/20',NULL,0,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (99,43,'2022/12/20',NULL,25,NULL,1);
INSERT INTO pedidos(id_pedido,id_cliente,fecha,sub_total,descuento,monto_final,estado) VALUES (100,50,'2022/12/20',NULL,0,NULL,1);

-- (14) PEDIDOS PRODUCTOS

INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (1,1,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (2,1,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (3,2,10,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (4,2,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (5,2,12,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (6,3,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (7,3,6,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (8,4,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (9,4,5,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (10,4,18,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (11,4,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (12,5,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (13,6,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (14,6,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (15,7,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (16,7,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (17,8,5,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (18,8,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (19,8,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (20,9,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (21,9,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (22,9,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (23,9,2,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (24,9,11,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (25,9,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (26,10,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (27,10,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (28,11,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (29,11,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (30,11,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (31,12,5,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (32,12,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (33,12,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (34,12,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (35,13,7,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (36,13,10,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (37,14,15,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (38,14,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (39,14,2,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (40,14,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (41,15,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (42,15,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (43,16,6,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (44,17,18,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (45,17,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (46,17,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (47,18,7,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (48,18,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (49,18,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (50,19,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (51,20,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (52,20,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (53,21,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (54,21,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (55,22,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (56,22,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (57,23,7,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (58,23,11,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (59,23,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (60,23,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (61,24,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (62,24,13,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (63,25,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (64,25,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (65,25,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (66,25,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (67,26,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (68,27,13,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (69,27,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (70,27,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (71,27,12,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (72,28,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (73,29,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (74,29,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (75,29,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (76,29,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (77,30,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (78,30,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (79,30,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (80,31,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (81,31,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (82,32,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (83,32,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (84,32,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (85,32,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (86,33,6,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (87,33,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (88,33,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (89,33,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (90,34,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (91,35,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (92,35,18,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (93,35,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (94,35,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (95,36,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (96,36,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (97,37,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (98,37,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (99,37,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (100,38,13,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (101,38,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (102,38,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (103,39,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (104,39,18,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (105,39,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (106,40,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (107,40,7,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (108,41,7,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (109,41,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (110,41,13,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (111,42,13,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (112,42,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (113,42,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (114,42,2,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (115,43,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (116,43,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (117,44,6,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (118,46,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (119,46,10,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (120,46,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (121,47,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (122,47,6,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (123,47,4,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (124,48,6,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (125,49,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (126,49,4,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (127,50,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (128,50,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (129,50,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (130,51,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (131,51,15,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (132,52,15,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (133,53,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (134,53,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (135,54,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (136,54,7,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (137,54,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (138,55,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (139,56,13,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (140,56,11,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (141,56,7,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (142,57,15,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (143,57,11,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (144,58,4,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (145,58,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (146,58,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (147,59,5,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (148,59,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (149,59,2,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (150,60,6,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (151,60,5,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (152,60,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (153,61,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (154,61,12,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (155,62,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (156,62,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (157,63,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (158,65,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (159,65,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (160,65,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (161,66,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (162,66,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (163,66,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (164,67,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (165,67,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (166,68,12,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (167,68,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (168,68,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (169,69,10,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (170,70,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (171,70,10,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (172,70,18,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (173,71,12,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (174,71,2,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (175,71,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (176,72,12,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (177,72,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (178,73,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (179,74,4,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (180,74,12,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (181,74,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (182,75,13,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (183,77,2,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (184,77,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (185,77,13,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (186,77,7,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (187,77,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (188,78,6,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (189,78,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (190,78,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (191,79,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (192,79,10,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (193,79,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (194,79,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (195,79,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (196,80,7,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (197,80,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (198,80,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (199,80,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (200,80,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (201,81,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (202,81,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (203,81,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (204,82,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (205,82,18,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (206,83,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (207,83,17,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (208,84,1,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (209,84,4,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (210,84,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (211,85,12,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (212,85,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (213,86,15,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (214,86,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (215,86,3,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (216,87,17,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (217,87,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (218,87,8,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (219,87,9,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (220,87,2,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (221,88,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (222,88,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (223,89,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (224,89,11,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (225,89,4,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (226,90,16,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (227,91,14,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (228,92,11,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (229,92,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (230,92,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (231,94,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (232,94,10,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (233,94,11,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (234,95,16,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (235,95,10,3);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (236,95,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (237,96,8,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (238,96,1,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (239,97,3,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (240,98,9,1);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (241,98,14,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (242,100,5,2);
INSERT INTO pedidos_productos(id_unique,id_pedido,id_producto,cantidad) VALUES (243,100,4,1);

-- (15) DELIVERYS

INSERT INTO deliverys(id_delivery,nombre,telefono) VALUES (1,'Sofia Garcia','1122334455');
INSERT INTO deliverys(id_delivery,nombre,telefono) VALUES (2,'Eliana Gomez','1198544567');
INSERT INTO deliverys(id_delivery,nombre,telefono) VALUES (3,'Santino Perez','1187459658');
INSERT INTO deliverys(id_delivery,nombre,telefono) VALUES (4,'Tomas Sosa','1145851232');
INSERT INTO deliverys(id_delivery,nombre,telefono) VALUES (5,'Lucia Martinez','1174855236');

-- (16) VEHICULOS

insert into vehiculos (clase, descripcion, patente) values ('auto', 'Volskwagen Gol', 'IZK 043');
insert into vehiculos (clase, descripcion, patente) values ('auto', 'Ford K', 'JKL 123');
insert into vehiculos (clase, descripcion, patente) values ('moto', 'Zanella 110', 'A 042 PNS');
insert into vehiculos (clase, descripcion, patente) values ('moto', 'Motomel 150', 'IKS 012');
insert into vehiculos (clase, descripcion, patente) values ('bici', 'Goldenbike Azul', NULL);
insert into vehiculos (clase, descripcion, patente) values ('bici', 'Enjoy de Ride Roja', NULL);

-- (17) ENTREGAS

INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (1,3,6,'2022/11/03','22:19:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (2,2,5,'2022/11/04','23:31:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (3,3,5,'2022/11/05','23:16:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (4,5,6,'2022/11/05','22:48:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (5,5,4,'2022/11/06','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (6,3,2,'2022/11/06','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (7,2,3,'2022/11/07','20:24:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (8,5,3,'2022/11/07','23:16:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (9,3,2,'2022/11/08','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (10,2,3,'2022/11/08','21:36:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (11,2,5,'2022/11/08','23:45:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (12,5,2,'2022/11/09','22:33:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (13,4,5,'2022/11/10','23:31:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (14,3,4,'2022/11/11','23:31:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (15,1,1,'2022/11/11','21:36:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (16,2,3,'2022/11/11','21:50:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (17,3,2,'2022/11/12','22:33:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (18,5,3,'2022/11/13','20:38:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (19,2,6,'2022/11/13','22:48:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (20,1,1,'2022/11/13','23:31:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (21,1,1,'2022/11/14','20:38:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (22,4,2,'2022/11/15','22:04:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (23,1,5,'2022/11/16','20:38:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (24,4,4,'2022/12/17','22:04:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (25,3,3,'2022/12/18','20:38:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (26,1,5,'2022/11/19','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (27,5,1,'2022/11/20','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (28,3,6,'2022/11/20','21:36:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (29,2,5,'2022/11/21','23:02:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (30,3,5,'2022/11/25','23:31:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (31,4,3,'2022/11/26','20:24:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (32,4,6,'2022/11/28','22:33:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (33,5,4,'2022/11/30','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (34,3,6,'2022/11/30','23:45:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (35,5,2,'2022/12/01','20:24:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (36,2,6,'2022/12/02','22:33:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (37,4,6,'2022/12/05','20:38:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (38,2,4,'2022/12/07','22:19:12');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (39,3,3,'2022/12/07','21:36:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (40,3,2,'2022/12/10','20:38:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (41,5,1,'2022/12/10','21:50:24');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (42,1,3,'2022/12/11','22:04:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (43,4,1,'2022/12/13','22:48:00');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (44,4,3,'2022/12/15','21:21:36');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (45,2,6,'2022/12/17','22:04:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (46,3,5,'2022/12/17','20:52:48');
INSERT INTO entregas(id_entrega,id_delivery,id_vehiculo,fecha,horario_salida) VALUES (47,3,3,'2022/12/20','22:48:00');

-- (18) ENTREGAS PEDIDOS

INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (1,1,1);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (2,2,2);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (3,2,3);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (4,3,4);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (5,3,5);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (6,4,6);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (7,4,7);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (8,5,8);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (9,5,9);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (10,6,10);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (11,7,11);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (12,7,12);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (13,8,13);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (14,8,14);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (15,9,15);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (16,9,16);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (17,10,17);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (18,10,18);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (19,11,19);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (20,11,20);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (21,12,21);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (22,12,22);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (23,12,23);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (24,13,24);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (25,13,25);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (26,13,26);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (27,14,27);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (28,14,28);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (29,15,29);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (30,15,30);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (31,16,31);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (32,17,32);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (33,17,33);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (34,18,34);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (35,18,35);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (36,19,36);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (37,19,37);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (38,20,38);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (39,20,39);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (40,21,40);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (41,21,41);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (42,21,42);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (43,22,43);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (44,23,44);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (45,23,45);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (46,24,46);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (47,24,47);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (48,24,48);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (49,24,49);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (50,25,50);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (51,25,51);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (52,25,52);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (53,26,53);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (54,27,54);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (55,27,55);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (56,28,56);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (57,28,57);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (58,29,58);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (59,29,59);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (60,30,60);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (61,30,61);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (62,30,62);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (63,31,63);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (64,31,64);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (65,32,65);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (66,32,66);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (67,32,67);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (68,33,68);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (69,33,69);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (70,34,70);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (71,34,71);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (72,34,72);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (73,35,73);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (74,36,74);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (75,36,75);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (76,37,76);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (77,37,77);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (78,37,78);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (79,39,79);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (80,39,80);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (81,39,81);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (82,39,82);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (83,40,83);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (84,40,84);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (85,41,85);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (86,41,86);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (87,41,87);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (88,42,88);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (89,43,89);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (90,43,90);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (91,43,91);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (92,44,92);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (93,44,93);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (94,45,94);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (95,45,95);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (96,46,96);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (97,46,97);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (98,47,98);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (99,47,99);
INSERT INTO entregas_pedidos(id_unique,id_entrega,id_pedido) VALUES (100,47,100);


