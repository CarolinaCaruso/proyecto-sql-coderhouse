DELIMITER $$
$$
# Funcion que calcula el costo total de una pizza, recibe el id de la pizza y retorna el costo
CREATE FUNCTION costo_producto(id_prod INT) RETURNS DECIMAL(9,2)
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
										s.id_sabor = (SELECT 
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

# Esta funcion calula la cantidad que se utilizo de determinado accesorio en determinado mes
# Por ejemplo, cuantas cajas(id_accesorio = 22) se utilizaron el mes de noviembre (mes = 11)
# Sirve exclusivamente para accesorios, es decir los insumos de tipo 2, no para insumos de tipo 1 (ingredientes)
CREATE FUNCTION cantidad_accesorio_x_mes(id_accesorio INT, mes INT) RETURNS DECIMAL(9,3)
READS SQL DATA
BEGIN 
DECLARE cantidad DECIMAL(9,3);
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
    

