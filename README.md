# Proyecto_contosoSQLBI
Proyecto de la DB MSFT Contoso Gestion de inventario  SQL - PBI  
Pregunta Clave : ¿Que productos estan en Riesgo de agotarse y cuales estan sobrando en almacen?

## Especificaciones Tecnicas del proyecto
Dataset:ContosoRetailDW 
Volumen de Datos: Mid-size dataset 
(> 12.6 MM en fact)
Arquitectura:Data Warehouse relacional con modelado V o modelo constelación.
Tipo de Analisis: OLAP
Herramientas:SQL Server (Vistas y ETL), Power BI (DAX & Data Modeling).
Complejidad: Mid-size dataset 
Cardinalidad 1:N 
Compresión: Rendimiento fluido del motor VertiPaq.

## Analisis de Contoso
Core: 
   Contoso vende productos electrónicos (computadoras, cámaras, TV, juegos) 
   Canales de venta principales:
      Tiendas físicas (Stores)
      Venta Online (E-commerce)
      Catálogo (Resellers)
## Estructura de Tablas analizadas
Fact Tables : 
  FactSales (Ventas en tiendas)
  FactOnlineSales (Ventas por internet) 
  FactInventory (Movimientos de stock)
Dim Tables: 
  DimProduct (Categorías, subcategorías y nombres de productos)
  DimStore (Ubicación geográfica, tamaño de la tienda y tipo)
  DimCustomer (Datos demográficos de los clientes)
  DimDate (Datos tiempo)

## Modelado en PBI
Modelado en PBI
Se adjunta Modelado 



