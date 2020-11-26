----Q1----
SELECT [Name], Europe, [North America] , Pacific
FROM (	SELECT Production.Product.[Name],  Sales.SalesOrderDetail.OrderQty, sales.SalesTerritory.[Group]
		FROM Production.Product 
			INNER JOIN Sales.SalesOrderDetail 
				ON (Production.Product.ProductID = Sales.SalesOrderDetail.ProductID)
			INNER JOIN sales.SalesOrderHeader
				ON (sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID)
			INNER JOIN sales.SalesTerritory
				ON (sales.SalesTerritory.TerritoryID = sales.SalesOrderHeader.TerritoryID) )as SourceTable
PIVOT(COUNT(OrderQty)
		FOR [Group] IN (Europe, [North America], Pacific))as PVT


----Q2----
SELECT PersonType, M, F 
FROM (	SELECT Person.BusinessEntityID, PersonType, Gender
		FROM Person.Person 
		  JOIN HumanResources.Employee 
			ON (Person.BusinessEntityID = Employee.BusinessEntityID))as SourceTable
PIVOT(COUNT (BusinessEntityID)
		for Gender IN (M, F) )as PVT


----Q3----
SELECT [name]
FROM Production.Product 
WHERE (LEN ([name]) < 15 AND SUBSTRING([name], LEN ([name]) - 1, 1) = 'e')
ORDER BY [name]


----Q4----
CREATE FUNCTION date_conversion (@date_in CHAR(10))
    RETURNS varchar(100)
    BEGIN
    DECLARE @output VARCHAR(100);
    DECLARE @year INT;
    DECLARE @month INT;
    DECLARE @day INT;              


                            if (SUBSTRING(@date_in,5,1) != '/') or (SUBSTRING(@date_in,8,1) != '/') 
                                set @output = 'Wrong format input';
                            else if (len(@date_in) < 10)
                                set @output = 'Wrong format input';

                            else 
                                begin 

                            set @year = SUBSTRING(@date_in,1,4);
                            set @month = SUBSTRING(@date_in,6,2);
                            set @day = SUBSTRING(@date_in,9,2);  

                            if (@day > 31)
                             set @output = 'Wrong format input';
                            else if (@month = 01)
                             set @output = 'January' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 02)  
                             set @output = 'February' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 03)  
                             set @output = 'March' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 04)  
                             set @output = 'April' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 05)  
                             set @output = 'May' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 06)  
                             set @output = 'June' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 07)  
                             set @output = 'July' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 08)  
                             set @output = 'August' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 09)  
                             set @output = 'September' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 10)  
                             set @output = 'October' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 11)  
                             set @output = 'November' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else if (@month = 12)  
                             set @output = 'December' + ' ' + CONVERT(varchar(40),@day) + ' ' + CONVERT(varchar(40),@year);
                            else 
                             set @output = 'Wrong format input';
                        END                
    RETURN @output
END


select dbo.date_conversion('2019/09/17') as date
select dbo.date_conversion('201/09/17') as date


----Q5----
create FUNCTION FUNC (@year int,
                         @month int,
                         @name varchar(50)
                        )
    returns table 

    as 

        return 
              
            select DISTINCT sales.SalesTerritory.name as TerritoryName
            from Production.Product 
                inner join  Sales.SalesOrderDetail 
                on (Production.Product.ProductID = Sales.SalesOrderDetail.ProductID)
                inner join sales.SalesOrderHeader
                on (sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID)
                inner join sales.SalesTerritory
                on (sales.SalesTerritory.TerritoryID = sales.SalesOrderHeader.TerritoryID)
            where (Production.Product.Name = @name) 
                    and 
                   (year(Sales.SalesOrderHeader.OrderDate) = @year)
                    and 
                   (month(Sales.SalesOrderHeader.OrderDate) = @month)



select * 
from dbo.FUNC(2008, 07,'AWC Logo Cap')
order by TerritoryName

select * 
from dbo.FUNC(2005, 10,'Mountain-100 Black, 42')
order by TerritoryName

