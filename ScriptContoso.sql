-- PROYECTO CONTOSO 
-- ANALISIS : Gestion de inventarios y logistica (evitar el exceso o la escases de producto

USE Contoso
GO 

--Identificacion de schemas
select name
from sys.schemas
where SCHEMA_ID <> principal_id
order by name
go

-- Objetivo de medición : 
-- ¿Que productos estana en riesgo de agotarse y cuales han sobrado en almacen?
-- Tablas a considerar
select top 5 * from FactInventory 
select top 5 * from factsales
select top 5 * from FactOnlineSales
select top 5 * from DimProduct
select top 5 * from DimStore
select top 5 * from DimDate

-- Vista Inventory

create or alter view vw_Inventory_PBI1
as
select 
	convert(char (10),datekey,103) as Fecha_registro,	
	storekey as ID_Tienda,
	ProductKey as ID_producto,
	currencykey as Moneda,
	OnHandQuantity Stock_fisico,
	OnOrderQuantity as Pedido,
	SafetyStockQuantity as Stock_minimo,
	UnitCost as Costo_unitario
from 
	FactInventory
where DateKey >= '20080101'
go

select * from vw_Inventory_PBI1


-- Vista factsales
select top 5 * from factsales

create or alter view vw_Ventas_PBI1
as
select	
	saleskey as ID_venta,
	convert (char(19),datekey,103) as Fecha_registro,
	storekey as ID_Tienda,
	ProductKey as ID_producto,
	currencykey as Moneda,
	UnitPrice as Precio_unitario,
	SalesQuantity as Cantidad_venta,
	SalesAmount as Monto_venta,
	TotalCost as Costo_total,
	(SalesAmount - TotalCost) as Utilidad
from 
	factsales
where DateKey >= '20090101'
go

select top 5 * from vw_Ventas_PBI1

-- Vista factonlinesales

select top 5 * from FactOnlineSales

create or alter view vw_Ventas_PBI2
as
select	
	OnlineSalesKey as ID_venta,
	convert(char(10),datekey,103) as Fecha_registro,
	storekey as ID_Tienda,
	ProductKey as ID_producto,
	currencykey as Moneda,
	UnitPrice as Precio_unitario,
	SalesQuantity as Cantidad_venta,
	SalesAmount as Monto_venta,
	TotalCost as Costo_total,
	(SalesAmount - TotalCost) as Utilidad	
	from
	FactOnlineSales
	where DateKey >= '20090101'
	go

select top 5 * from vw_Ventas_PBI2


-- select top 5 * from DimProduct
select top 50 * from DimProduct

Create or alter view vw_DimProducto_PBI as 
select
	p.ProductKey as ID_producto,
	p.ProductName as Nombre_producto,
	p.ProductDescription as Descripcion_producto,
	p.ColorID as Color,
	p.BrandName as Marca,
	c.ProductCategoryName as Categoria,
	s.ProductSubcategoryName as Subcategoria
from 
	dimproduct p 
	left join dimproductsubcategory s on p.ProductSubcategoryKey = s.ProductSubcategoryKey
	left join dimproductcategory c on s.ProductCategoryKey = c.ProductCategoryKey
		
select * from vw_DimProducto_PBI


-- select top 5 * from DimStore

select top 5 * from DimStore

create or alter view vw_DimTienda_PBI as
select 
	StoreKey as ID_Tienda,
	StoreName as Nombre_tienda,
	StoreType as Tipo_tienda,
	Status as estado,
	StoreDescription as Descripcion,
	EntityKey, 
	GeographyKey 
from DimStore
where status = 'Activado'
go

select * from vw_DimTienda_PBI

-- Vista DimDate
select top 5 * from DimDate

create or alter view vw_DimFecha_PBI as
select 
	DateKey, 
	FullDateLabel as Fecha,
	CalendarYear as anio,
	CalendarMonthLabel as mes,
	CalendarWeekLabel as semana
from DimDate
go

select * from vw_DimFecha_PBI

-- Contamos con 6 vistas para alimentar nuestro modelo de datos en Power BI
-- con las cuales podremos realizar un analisis de los productos que estan 
-- en riesgo de agotarse y cuales han sobrado en almacen, ademas de analizar 
-- las ventas por producto, tienda y fecha.

-- Relacion de vistas con las tablas del modelo de datos
select * from vw_Inventory_PBI
select * from vw_Ventas_PBI1
select * from vw_Ventas_PBI2
select * from vw_DimProducto_PBI
select * from vw_DimTienda_PBI
select * from vw_DimFecha_PBI
---------------