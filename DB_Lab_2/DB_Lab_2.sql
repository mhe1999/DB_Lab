----------------------------------------------------------------------------------------------------
---Q1---
select SalesOrderID, Status, CustomerID, TerritoryID, SubTotal, TotalDue
from Sales.SalesOrderHeader as s
where s.TotalDue < 500000 AND s.TotalDue > 100000 and s.TerritoryID in (
																		Select TerritoryID
																		From Sales.SalesTerritory
																		Where [Group] = 'North America' OR [Name] = 'France');




----------------------------------------------------------------------------------------------------
---Q2---
select o.SalesOrderID, o.CustomerID, o.TotalDue, o.OrderDate, t.Name 
from Sales.SalesOrderHeader as O left join Sales.SalesTerritory as t on (o.TerritoryID = t.TerritoryID)




----------------------------------------------------------------------------------------------------
---Q3---
select t1.ProductID, t2.TerritoryID
from (select ProductID, max(num) as num
	  from (select d.ProductID, h.TerritoryID, count(h.TerritoryID) as num
   			from Sales.SalesOrderDetail as d inner join Sales.SalesOrderHeader as h on (d.SalesOrderID = h.SalesOrderID)
			group by d.ProductID, h.TerritoryID) as test
	  group by ProductID) as t1
	  
	  inner join 

	  (select d.ProductID, h.TerritoryID, count(h.TerritoryID) as num
   	   from Sales.SalesOrderDetail as d inner join Sales.SalesOrderHeader as h on (d.SalesOrderID = h.SalesOrderID)
       group by d.ProductID, h.TerritoryID) as t2

	   on(t1.ProductID = t2.ProductID and t1.num = t2.num)

order by t1.ProductID




----------------------------------------------------------------------------------------------------
---Q4---

create table NAmerica_Sales (
	SalesOrderID int,
	Status tinyint,
	CustomerID int,
	TerritoryID int, 
	SubTotal money, 
	TotalDue money
);

with Q1 (SalesOrderID, Status, CustomerID, TerritoryID, SubTotal, TotalDue) as
	(select SalesOrderID, Status, CustomerID, TerritoryID, SubTotal, TotalDue
	from Sales.SalesOrderHeader as s
	where s.TotalDue < 500000 AND s.TotalDue > 100000 and s.TerritoryID in (Select TerritoryID
																			From Sales.SalesTerritory
																			Where [Group] = 'North America' OR [Name] = 'France'))

select * from NAmerica_Sales

insert into NAmerica_Sales
select *
from Q1 
where TerritoryID in (Select TerritoryID
				   	  From Sales.SalesTerritory
					  Where [Group] = 'North America')



ALTER table NAmerica_Sales
ADD ttt char(4);

ALTER table NAmerica_Sales
ADD check (ttt in ('LOW', 'High', 'Mid'))


update NAmerica_Sales
set ttt = case
			when TotalDue > (select AVG(TotalDue) from NAmerica_Sales) then 'High'
			when TotalDue = (select AVG(TotalDue) from NAmerica_Sales) then 'Mid'
			when TotalDue < (select AVG(TotalDue) from NAmerica_Sales) then 'LOW'
		  END



----------------------------------------------------------------------------------------------------
---Q5---
WITH TempTable (BusinessEntityID,ratePerHour) AS
        (SELECT BusinessEntityID ,max(Rate)
        FROM HumanResources.EmployeePayHistory
        GROUP BY BusinessEntityID),
     
    TempTable2 (BusinessEntityID,ratePerHour, LEVEL) AS
        (select BusinessEntityID,ratePerHour, CASE 
                            WHEN ratePerHour < 29.0000 THEN 3
                            WHEN ratePerHour >= 29.0000 and ratePerHour < 50.0000 THEN 2
                            WHEN ratePerHour >= 50.0000 THEN 1
                    END as LEVEL
        from TempTable),
    
     myAVgTable (avg_Salary) AS
        (select AVG(ratePerHour)
        from TempTable2),

    TempTable3 (BusinessEntityID,ratePerHour,LEVEL) AS 
        (select BusinessEntityID, CASE 
                            WHEN ratePerHour <= avg_Salary/2 THEN (ratePerHour + (ratePerHour*20)/100)
                            WHEN ratePerHour > avg_Salary/2 and ratePerHour <= avg_Salary THEN (ratePerHour + (ratePerHour*15)/100)
                            WHEN ratePerHour > avg_Salary and ratePerHour <= avg_Salary + avg_Salary/2 THEN (ratePerHour + (ratePerHour*10)/100)
                          WHEN ratePerHour > avg_Salary + avg_Salary/2 THEN (ratePerHour + (ratePerHour*5)/100)
                                END, LEVEL
        from TempTable2,myAVgTable)
select * 
from TempTable3
ORDER BY BusinessEntityID;