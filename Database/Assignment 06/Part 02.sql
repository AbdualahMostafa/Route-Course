Use AdventureWorks2012

-- 1. Display the SalesOrderID, ShipDate of the SalesOrderHearder 
--table (Sales schema) to designate SalesOrders that occurred 
--within the period ‘7/28/2002’ and ‘7/29/2014’
Select SalesOrderID, ShipDate
From Sales.SalesOrderHeader
Where ShipDate between  '7/8/2002' and '7/29/2014'

-- 2. Display only Products(Production schema) with a StandardCost 
--below $110.00 (show ProductID, Name only)
Select ProductID,Name
From Production.Product
where StandardCost < 110.00

-- 3.  Display ProductID, Name if its weight is unknown
Select ProductID, Name 
From Production.Product 
where Weight is null 

-- 4.  Display all Products with a Silver, Black, or Red Color
Select ProductID, Name, Color
From Production.Product
where Color in ('Silver', 'Black', 'Red')

-- 5. Display any Product with a Name starting with the letter B
Select Name
From Production.Product
where Name like 'B'

-- 6. Run the following Query
--UPDATE Production.ProductDescription
--SET Description = 'Chromoly steel_High of defects'
--WHERE ProductDescriptionID = 3
--Then write a query that displays any Product description with 
--underscore value in its description
Update Production.ProductDescription
Set Description = 'Chromoly steel_High of defects'
where ProductDescriptionID=3
Select *
From Production.ProductDescription
where Description like'%[_]%'

-- 7. Display the Employees HireDate (note no repeated values are allowed)
Select ,HireDate
From HumanResources.Employee

-- 8. Display the Product Name and its ListPrice within the values of 100
--and 120 the list should have the following format "The [product 
--name] is only! [List price]" (the list will be sorted according to its 
--ListPrice value)
Select Name 'Product Name',ListPrice 'ListPrice'
From Production.Product
where ListPrice between 100 and 120 
order by ListPrice 