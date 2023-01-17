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

-- #12 (Tabla historial)
CREATE TABLE IF NOT EXISTS ACTUALIZACIONES_PRECIOS_PRODUCTOS(
	id_actualizacion INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	fecha DATE NOT NULL,
	id_producto INT NOT NULL,
    nuevo_precio DECIMAL(9,2) NOT NULL,
    
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
    sub_total DECIMAL(9,2) NOT NULL DEFAULT 0,
    descuento DECIMAL(9,2) NOT NULL DEFAULT 0,
    monto_final DECIMAL(9,2) NOT NULL DEFAULT 0,
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

-- #19 (Tabla auditoria)

CREATE TABLE auditoria_clientes (
	id_auditoria INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    id_cliente INT,
    insertado_por VARCHAR(100),
    fecha_insercion DATE,
    hora_insercion TIME,
    actualizado_por VARCHAR(100),
    fecha_actualizacion DATE,
    hora_actualizacion TIME,
    FOREIGN KEY (id_cliente)
		REFERENCES clientes (id_cliente)
			ON DELETE CASCADE
            ON UPDATE CASCADE
);



