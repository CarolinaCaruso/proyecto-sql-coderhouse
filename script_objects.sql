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

-- #12 (Tabla historial que sera completada a traves de triggers)
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

-- #19 (Tabla auditoria que sera completada a traves de triggers)
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

#  << -------------------------------- << VISTAS >> -------------------------------------- >>

DELIMITER $$

# (1) Cantidad total de pizzas vendidas por mes

CREATE VIEW v_pizzas_x_mes AS
    SELECT 
        MONTH(p.fecha) AS 'Mes', SUM(pp.cantidad) AS 'Pizzas'
    FROM
        pedidos AS p
            INNER JOIN
        pedidos_productos AS pp ON p.id_pedido = pp.id_pedido
    WHERE
        estado = 1
    GROUP BY MONTH(fecha);    
$$

# (2) Cantidad total de pizzas que pidio cada cliente ordenados de mayor a menor

CREATE VIEW v_pizzas_x_cliente AS
SELECT 
    c.nombre AS 'Cliente', SUM(pp.cantidad) AS 'Pizzas'
FROM
    clientes AS c
        INNER JOIN
    pedidos AS p ON c.id_cliente = p.id_cliente
        INNER JOIN
    pedidos_productos AS pp ON p.id_pedido = pp.id_pedido
GROUP BY c.nombre
ORDER BY Pizzas DESC;
$$

# (3) Cantidad de pedidos entregados por delivery, en el mes corriente 

CREATE VIEW v_entregas_x_delivery_mes_actual AS
    SELECT 
        d.nombre AS 'Delivery',
        COUNT(ep.id_pedido) AS 'Pedidos Entregados'
    FROM
        deliverys AS d
            INNER JOIN
        entregas AS e ON d.id_delivery = e.id_delivery
            INNER JOIN
        entregas_pedidos AS ep ON e.id_entrega = ep.id_entrega
    WHERE
        MONTH(e.fecha) = MONTH(CURRENT_TIMESTAMP())
    GROUP BY d.id_delivery
    ORDER BY Delivery;
$$

# (4) Cantidad total pedida de cada tipo de pizza

CREATE VIEW v_ventas_x_producto AS
    SELECT 
        p.nombre AS 'Pizza', SUM(pp.cantidad) AS 'Cantidad'
    FROM
        productos AS p
            INNER JOIN
        pedidos_productos AS pp ON p.id_producto = pp.id_producto
    GROUP BY p.id_producto;
$$

 # (5) 	Facturacion mensual
 
 CREATE VIEW v_facturacion_mensual AS
    SELECT 
        MONTH(fecha) AS 'Mes', SUM(monto_final) AS 'Total'
    FROM
        pedidos
    GROUP BY MONTH(fecha)
$$
  
# << --------------------------------  << FUNCIONES >> ----------------------------------------- >>

# (1) Funcion que calcula el costo total de una pizza, recibe el id de la pizza y retorna el costo

CREATE FUNCTION f_costo_producto(id_prod INT) RETURNS DECIMAL(9,2)
READS SQL DATA
BEGIN
	DECLARE costo_prepizza DECIMAL(9,2);
	DECLARE costo_sabor_adicional DECIMAL(9,2);
	DECLARE costo_materiales DECIMAL(9,2);

	SET costo_prepizza =   (SELECT 
								SUM(i.costo * t.cantidad)
							FROM
								insumos AS i
									JOIN
								tipos_prepizzas_insumos AS t ON i.id_insumo = t.id_insumo
							WHERE t.id_tipo_prepizza = (SELECT 
															id_tipo_prepizza
														FROM
															productos
														WHERE
															id_producto = id_prod));
	SET costo_sabor_adicional =		(SELECT 
										SUM(i.costo * s.cantidad)
									FROM
										insumos AS i
											INNER JOIN
										sabores_insumos AS s ON i.id_insumo = s.id_insumo
									WHERE
										s.id_sabor =   (SELECT 
															id_sabor
														FROM
															productos
														WHERE
															id_producto = id_prod));
							
	# Este condicional es porque las pizzas de muzarella no tienen sabores adicionales, entonces esta variable valdria NULL y no se podria hacer la suma del final
	IF costo_sabor_adicional IS NULL THEN 
		SET costo_sabor_adicional = 0;
	END IF;

	SET costo_materiales =	(SELECT 
								SUM(i.costo * a.cantidad)
							FROM
								insumos AS i
									JOIN
								accesorios_cantidad AS a ON i.id_insumo = a.id_insumo);

	RETURN costo_prepizza + costo_sabor_adicional + costo_materiales;

END;
$$
 
 # (2)
 
 # (1ra Subfuncion) Devuelve la cantidad de determinado ACCESORIO que se utilizo en determinado mes
CREATE FUNCTION sf_cantidad_accesorio_x_mes(id_accesorio INT, mes INT) RETURNS DECIMAL(9,5)
READS SQL DATA
BEGIN 
DECLARE cantidad DECIMAL(9,5);
	SET cantidad = (SELECT SUM(pp.cantidad)*a.cantidad AS cantidad
				FROM
					pedidos AS p 
						INNER JOIN
					pedidos_productos AS pp ON p.id_pedido = pp.id_pedido
						INNER JOIN
					accesorios_cantidad AS a ON a.id_insumo = id_accesorio
				WHERE
					p.estado = 1 AND MONTH(p.fecha) = mes);
		RETURN cantidad;
	END;
$$

 # (2da Subfuncion) Devuelve la cantidad de determinado INGREDIENTE que se utilizo en determinado mes
CREATE FUNCTION sf_cantidad_ingrediente_x_mes(id_ingrediente INT, mes INT) RETURNS DECIMAL(9,5)
READS SQL DATA
BEGIN
	DECLARE cantidad_en_prepizza DECIMAL(9,5);
	DECLARE cantidad_en_sabor_adicional DECIMAL(9,5);
	SET cantidad_en_prepizza =	(SELECT 
									SUM(pp.cantidad * t.cantidad)  
								 FROM
									pedidos as ped
										INNER JOIN
									pedidos_productos as pp ON ped.id_pedido = pp.id_pedido
										INNER JOIN
									productos as prod ON pp.id_producto = prod.id_producto
										INNER JOIN
									tipos_prepizzas_insumos as t ON prod.id_tipo_prepizza = t.id_tipo_prepizza
								 WHERE 
									t.id_insumo = id_ingrediente AND MONTH(ped.fecha) = mes);
            
	IF cantidad_en_prepizza is NULL THEN SET cantidad_en_prepizza = 0;
	END IF;

	SET cantidad_en_sabor_adicional =  (SELECT 
											SUM(pp.cantidad * s.cantidad) 
										FROM
											pedidos as ped
												INNER JOIN
											pedidos_productos as pp ON ped.id_pedido = pp.id_pedido
												INNER JOIN
											productos as prod ON pp.id_producto = prod.id_producto
												INNER JOIN
											sabores_insumos as s ON s.id_sabor = prod.id_sabor
										WHERE 
											s.id_insumo = id_ingrediente AND MONTH(ped.fecha) = mes);

    IF cantidad_en_sabor_adicional is NULL THEN SET cantidad_en_sabor_adicional = 0;
	END IF;

    RETURN cantidad_en_prepizza + cantidad_en_sabor_adicional;
END;

 # (2) FUNCION PRINCIPAL 
 # Recibe un id_insumo, si el tipo de insumo es ACCEOSORIO llama a sf_cantidad_accesorio_x_mes, 
 # si es INGREDIENTE llama a sf_cantidad_ingrediente_x_mes
$$
CREATE FUNCTION f_cantidad_insumo_x_mes(id_ins INT, mes INT) RETURNS DECIMAL (9,5)
READS SQL DATA
BEGIN
	IF (SELECT tipo FROM insumos WHERE id_insumo = id_ins) = 'ingrediente' THEN
		RETURN cantidad_ingrediente_x_mes(id_ins, mes);
	ELSE
		RETURN cantidad_accesorio_x_mes(id_ins, mes);
	END IF;
END;
$$


# << --------------------------------  << STORED PROCEDURES >>  ------------------------------------ >>

# (1)

CREATE PROCEDURE sp_ordenar_productos (IN campo_orden VARCHAR(20), IN forma VARCHAR(5))
BEGIN 
	 
	IF campo_orden <> '' THEN 
		SET @ordenar_productos = concat(' ORDER BY ', campo_orden, ' ' , forma);
	ELSE
		SET @ordenar_productos = '';
	END IF;
    
	SET @clausula = concat('SELECT * FROM productos', @ordenar_productos);
	PREPARE ejecutar_clausula FROM @clausula;
    EXECUTE ejecutar_clausula;
    DEALLOCATE PREPARE ejecutar_clausula;

END;
$$

# (2)

CREATE PROCEDURE sp_insertar_cliente(IN nombre VARCHAR(50), IN direccion VARCHAR(120), IN telefono VARCHAR(20), OUT mensaje VARCHAR(100))
BEGIN
	IF (nombre <> '' AND direccion <> '' AND telefono <> '') THEN
		INSERT INTO clientes VALUES(NULL, nombre, direccion, telefono);
        SET mensaje = "El registro se ha insertado con exito";
	ELSE
		SET mensaje = "No se pudo insertar el registro porque hay campos incompletos";
	END IF;
    SET @clausula =  'SELECT * FROM clientes ORDER BY id_cliente DESC';
    PREPARE ejecutar_clausula FROM @clausula;
    EXECUTE ejecutar_clausula;
    DEALLOCATE PREPARE ejecutar_clausula;
END;
$$ 

# Los triggers los agregue aunque no lo pedia mas que nada porque hay tablas y campos que se completan automaticamente por los triggers
# Entonces si se insertan los datos sin los triggers, por ejemplo el campo monto_final de la tabla pedidos quedaria vacio
# y la vista facturacion_mensual se mostraria vacia
 
# << ---------------------------------------  << TRIGGERS >>  ------------------------------------------- >>

# Cada vez que se inserta un nuevo cliente, se registra en la tabla auditoria_clientes el id_cliente, la fecha y hora del registro, y el usuario
CREATE TRIGGER `tr_insert_clientes`
AFTER INSERT ON `clientes`
FOR EACH ROW
INSERT INTO `auditoria_clientes`(id_cliente, insertado_por, fecha_insercion, hora_insercion, actualizado_por, fecha_actualizacion, hora_actualizacion) 
VALUES (NEW.id_cliente, USER(), CURRENT_DATE(), CURRENT_TIME(), USER(), CURRENT_DATE(), CURRENT_TIME());
$$

# Cada vez que se actualiza un nuevo cliente, se actualiza en la tabla auditoria_clientes el la fecha de actualizacion, 
# hora de actualizacion, y el usuario que lo actualiza
CREATE TRIGGER `tr_update_clientes`
AFTER UPDATE ON `clientes`
FOR EACH ROW
UPDATE auditoria_clientes 
	SET actualizado_por = USER(),  fecha_actualizacion = CURRENT_DATE(), hora_actualizacion = CURRENT_TIME()
	WHERE id_cliente = NEW.id_cliente;
$$

# Cada vez que se inserta un nuevo producto, se registra la fecha el id_producto y el precio en la tabla actualizaciones_precios_productos
CREATE TRIGGER `tr_insert_precios_productos`
AFTER INSERT ON `productos`
FOR EACH ROW
INSERT INTO `actualizaciones_precios_productos` (fecha, id_producto, nuevo_precio) VALUES (CURRENT_DATE(), NEW.id_producto, NEW.precio);
$$

# Cada vez que se actualiza el precio de un producto, se registra la fecha el id_producto y el nuevo precio en la tabla actualizaciones_precios_productos
CREATE TRIGGER `tr_update_precios_productos`
AFTER UPDATE ON `productos`
FOR EACH ROW
IF NEW.precio <> OLD.precio THEN
	INSERT INTO `actualizaciones_precios_productos` (fecha, id_producto, nuevo_precio) VALUES (CURRENT_DATE(), NEW.id_producto, NEW.precio);
    END IF;
$$

# El siguiente trigger es para calcular y actualizar el subtotal del pedido, cada vez que se inserta un registro en la tabla pedidos productos
CREATE TRIGGER `tr_sub_total_pedidos`
AFTER INSERT ON `pedidos_productos`
FOR EACH ROW
	UPDATE `pedidos` SET sub_total = sub_total + (SELECT precio FROM productos WHERE id_producto = NEW.id_producto)*NEW.cantidad WHERE id_pedido = NEW.id_pedido;
$$

# El siguiente trigger es para calcular el monto final de cada pedido cada vez que se actualiza el subtotal o el descuento sub_total - descuento)
CREATE TRIGGER `tr_monto_final_pedidos`
BEFORE UPDATE ON `pedidos`
FOR EACH ROW
IF NEW.sub_total <> OLD.sub_total  OR NEW.descuento <> OLD.descuento THEN
	SET NEW.monto_final = NEW.sub_total - NEW.descuento;
    END IF;
$$