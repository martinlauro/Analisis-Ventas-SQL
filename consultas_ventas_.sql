
/* =========================================================
   CONSULTAS SQL - BASE DE DATOS DE VENTAS
   Autor: Proyecto de Ejemplo
   Descripción: Consultas básicas y avanzadas sobre la tabla "ventas"
   ========================================================= */

-- ========================================
-- CONSULTAS BÁSICAS
-- ========================================

-- 1. Seleccionar todas las ventas de un cliente específico
SELECT * FROM ventas WHERE cliente = 'Luis Figueroa';

-- 2. Contar el número de ventas por región
SELECT region, COUNT(*) AS total_ventas
FROM ventas
GROUP BY region;

-- 3. Obtener el total vendido por cada producto
SELECT producto, SUM(total_venta) AS total_vendido
FROM ventas
GROUP BY producto
ORDER BY total_vendido DESC;

-- 4. Listar las ventas mayores a $5000
SELECT id_venta, cliente, total_venta
FROM ventas
WHERE total_venta > 5000
ORDER BY total_venta DESC;

-- 5. Promedio de ventas por región
SELECT region, AVG(total_venta) AS promedio_venta
FROM ventas
GROUP BY region;

-- 6. Ventas por cliente ordenadas de mayor a menor
SELECT cliente, SUM(total_venta) AS total_cliente
FROM ventas
GROUP BY cliente
ORDER BY total_cliente DESC;

-- 7. Obtener las ventas realizadas en junio de 2025
SELECT *
FROM ventas
WHERE fecha BETWEEN '2025-06-01' AND '2025-06-30';

-- 8. Contar cuántos productos distintos compró cada cliente
SELECT cliente, COUNT(DISTINCT producto) AS productos_distintos
FROM ventas
GROUP BY cliente;

-- 9. Ventas promedio por producto
SELECT producto, AVG(total_venta) AS promedio_producto
FROM ventas
GROUP BY producto;

-- 10. Mostrar los 5 clientes con mayores ventas totales
SELECT cliente, SUM(total_venta) AS total_cliente
FROM ventas
GROUP BY cliente
ORDER BY total_cliente DESC
LIMIT 5;


-- ========================================
-- CONSULTAS AVANZADAS
-- ========================================

-- 11. Promedio del total de ventas por producto y región
SELECT producto, region, ROUND(AVG(total_venta), 2) AS promedio_venta
FROM ventas
GROUP BY producto, region
ORDER BY producto, region;

-- 12. Clientes cuyo total vendido supera el promedio general
SELECT cliente, SUM(total_venta) AS total_cliente
FROM ventas
GROUP BY cliente
HAVING total_cliente > (SELECT AVG(total_venta) FROM ventas)
ORDER BY total_cliente DESC;

-- 13. Total de ventas por mes
SELECT DATE_FORMAT(fecha, '%Y-%m') AS mes, SUM(total_venta) AS total_mensual
FROM ventas
GROUP BY mes
ORDER BY mes;

-- 14. Producto más caro comprado por cada cliente
SELECT v1.cliente, v1.producto, v1.precio_unitario
FROM ventas v1
WHERE v1.precio_unitario = (
    SELECT MAX(v2.precio_unitario)
    FROM ventas v2
    WHERE v2.cliente = v1.cliente
)
ORDER BY v1.cliente;

-- 15. Porcentaje de ventas por región
SELECT region, ROUND(SUM(total_venta) * 100 / (SELECT SUM(total_venta) FROM ventas), 2) AS porcentaje_total
FROM ventas
GROUP BY region
ORDER BY porcentaje_total DESC;

-- 16. Promedio de ventas y cantidad de operaciones por producto
SELECT producto, COUNT(*) AS transacciones, ROUND(AVG(total_venta), 2) AS promedio_total_venta
FROM ventas
GROUP BY producto
ORDER BY promedio_total_venta DESC;

-- 17. Ranking de clientes por total de ventas
SET @rank := 0;
SELECT (@rank := @rank + 1) AS posicion, cliente, ROUND(SUM(total_venta), 2) AS total_cliente
FROM ventas
GROUP BY cliente
ORDER BY total_cliente DESC;

-- 18. Clientes con más de 3 tipos diferentes de productos comprados
SELECT cliente, COUNT(DISTINCT producto) AS productos_distintos
FROM ventas
GROUP BY cliente
HAVING productos_distintos > 3
ORDER BY productos_distintos DESC;

-- 19. Total de ventas por cliente y región (clientes más valiosos por zona)
SELECT cliente, region, SUM(total_venta) AS total_por_cliente
FROM ventas
GROUP BY cliente, region
ORDER BY total_por_cliente DESC;

-- 20. Productos más vendidos por cantidad total
SELECT producto, SUM(cantidad) AS total_cantidad_vendida
FROM ventas
GROUP BY producto
ORDER BY total_cantidad_vendida DESC;
