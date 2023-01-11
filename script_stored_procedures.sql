USE pizzeria;

# Este procedimiento muestra la tabla productos ordenada por el campo que se le indique en el parametro 'campo_orden'
# y en la forma que se le indique en el parametro 'forma'
# El campo de ordenamiento puede ser 'id_producto', 'id_tipo_prepizza', 'id_sabor', 'nombre', 'descripcion', 'precio'
# La forma puede ser 'ASC' o 'DESC'
DELIMITER $$
CREATE PROCEDURE ordenar_productos (IN campo_orden VARCHAR(20), IN forma VARCHAR(5))
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

# Ejemplo del llamado al procedimiento de ordenamiento
CALL ordenar_productos('nombre','ASC');

# El siguiente procedimiento, inserta un registro en la tabla clientes y muestra la tabla en forma descendente para visualizar el registro insertado recientemente
# Si todos los campos estan completos, lo inserta y da un mensaje de exito
# Si alguno de los datos nombre, direccion o telefono esta en blanco, no realiza la insercion y da un mensaje de error

$$
CREATE PROCEDURE insertar_cliente(IN nombre VARCHAR(50), IN direccion VARCHAR(120), IN telefono VARCHAR(20), OUT mensaje VARCHAR(100))
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

# Ejemplo 1 (Insesion exitosa)
CALL insertar_cliente('Carolina Caruso','Corrientes 123','1512345678', @resultado);
SELECT @resultado;

# Ejemplo 2 (Insesion no exitosa)
CALL insertar_cliente('Alejandro Perez','','1556785678', @resultado);
SELECT @resultado;