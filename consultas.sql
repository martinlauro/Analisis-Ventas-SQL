/*ventas totales*/
SELECT SUM(total_venta) AS ventas_totales
FROM ventas;

/*ventas por mes*/

SELECT DATE_FORMAT(fecha, '%Y-%m') AS mes,
       SUM(total_venta) AS ventas_mes
FROM ventas
GROUP BY mes
ORDER BY mes;

/*Top 5 productos más vendidos (por monto)*/

SELECT producto,
       SUM(total_venta) AS total_vendido
FROM ventas
GROUP BY producto
ORDER BY total_vendido DESC
LIMIT 5;

/*Ticket promedio por cliente*/

SELECT cliente,
       AVG(total_venta) AS ticket_promedio,
       COUNT(*) AS compras
FROM ventas
GROUP BY cliente
ORDER BY ticket_promedio DESC;

/*Ventas por región*/

SELECT region,
       SUM(total_venta) AS ventas_region
FROM ventas
GROUP BY region
ORDER BY ventas_region DESC;

