# VISTAS 

# Lista de precios actual
CREATE VIEW v_precios_actuales AS
    SELECT 
        prod.nombre AS 'Pizza', precios.nuevo_precio AS 'Precio'
    FROM
        productos AS prod
            JOIN
        actualizaciones_precios_productos AS precios ON prod.id_producto = precios.id_producto
    WHERE
        es_precio_actual = 1;

# Cantidad total de pizzas vendidas por mes
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

# Cantidad total de pizzas que pidio cada cliente ordenados de mayor a menor
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

# Cantidad de pedidos entregados por delivery, en el mes corriente 
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

# Cantidad total pedida de cada tipo de pizza
CREATE VIEW v_ventas_x_producto AS
    SELECT 
        p.nombre AS 'Pizza', SUM(pp.cantidad) AS 'Cantidad'
    FROM
        productos AS p
            INNER JOIN
        pedidos_productos AS pp ON p.id_producto = pp.id_producto
    GROUP BY p.id_producto;

