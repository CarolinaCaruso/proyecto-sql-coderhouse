USE pizzeria;

-- REPORTE 1) CANTIDAD DE PIZZAS PEDIDAS POR DIA
-- Este muestra la cantidad pizzas se vende cada dia ordenados por fecha en orden descendente, para ver en primer lugar, los días más actuales
-- La finalidad es tener un panorama del flujo de ventas por dia, para tomar decisiones en cuanto a la compra de insumos y elaboracion de prepizzas
SELECT 
    p.fecha, SUM(pp.cantidad) AS 'pizzas'
FROM
    pedidos AS p
        INNER JOIN
    pedidos_productos AS pp ON p.id_pedido = pp.id_pedido
GROUP BY p.fecha
ORDER BY p.fecha DESC;

# REPORTE 2) - CLIENTES NUEVOS DE CADA MES
-- Este reporte muestra cuantos clientes nuevos piden en la pizzeria en cada mes
-- Sirve para tener una noción de que tanta popularidad está generando el negocio mes a mes
-- A partir de este reporte, se puede decidir si es necesario alguna inyeccion de publicidad, 
-- o buscar nuevas estrategias y analizar qué se puede mejorar para llegar a mas clientes
WITH cte_cliente_fecha_primer_pedido AS
(SELECT
	id_cliente, MIN(fecha) AS ingreso
FROM		
	pedidos
group BY id_cliente
)
SELECT YEAR(ingreso) AS 'Anio', MONTH(ingreso) AS 'Mes', COUNT(id_cliente) AS 'Clientes nuevos'
FROM cte_cliente_fecha_primer_pedido 
GROUP BY YEAR(ingreso), MONTH(ingreso)
ORDER BY YEAR(ingreso), MONTH(ingreso);
