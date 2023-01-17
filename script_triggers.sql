# Una de las tablas en la que va a tener efecto el trigger es la de actualizaciones_precios_productos que ya la habia creado anteriormente
# la cual contendra el historial de los precios de los productos

# La otra tabla de auditoria la cree recientemente y es la llamada auditoria_clientes
# En esta tabla estaran los registros de auditoria cada vez que se inserte o actualice un registro en la tabla clientes

DELIMITER $$
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

# DROP TRIGGER tr_insert_clientes;
# DROP TRIGGER tr_update_clientes;
# DROP TRIGGER tr_update_precios_productos;
# DROP TRIGGER tr_sub_total_pedidos;
# DROP TRIGGER tr_monto_final_pedidos;