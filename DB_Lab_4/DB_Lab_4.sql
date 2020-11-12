
------Q2------
WITH
    TerritorySales(TerritoryID, SalesTotal, SalesCount)
    as(
        SELECT TerritoryID , SUM(SubTotal), COUNT(TerritoryID)
        FROM Sales.SalesOrderHeader as SOH
        GROUP BY TerritoryID
    ),

    TerritoryTotalCount(TerritoryName, Region, SalesTotal, SalesCount)
    as(
        SELECT ST.Name AS TerritoryName , ST.[Group] as Region, TS.SalesTotal, TS.SalesCount
        from TerritorySales as TS INNER JOIN Sales.SalesTerritory as ST
            ON TS.TerritoryID = ST.TerritoryID
    ),

    RegionTotalCount(TerritoryName, Region, SalesTotal, SalesCount)
    as(
        select 'All Territories', Region, SUM(SalesTotal), SUM(SalesCount)
        FROM TerritoryTotalCount
        GROUP BY Region
    ),

    AllRegionTotalCount(TerritoryName, Region, SalesTotal, SalesCount)
    as(
        SELECT 'All Territories', 'All Regions', SUM(SalesTotal), SUM(SalesCount)
        FROM RegionTotalCount
    )

SELECT *
FROM TerritoryTotalCount as TTC
UNION
SELECT *
FROM RegionTotalCount
UNION
SELECT *
FROM AllRegionTotalCount;


--------Q3----------
WITH
    productSubCatID(SubCatID, SalesTotal, SalesCount)
    as(
        SELECT p.ProductSubcategoryID, sum(SOD.LineTotal) , sum(SOD.OrderQty)
        FROM Sales.SalesOrderDetail AS SOD INNER JOIN Production.Product as P
            on SOD.ProductID = P.ProductID
        GROUP BY P.ProductSubcategoryID
    ),

    productSubCatName(cat, subCat, SalesCount, SalesTotal)
    as(
        SELECT PSC.ProductCategoryID, PSC.Name, PSCID.SalesCount, PSCID.SalesTotal
        FROM productSubCatID as PSCID INNER JOIN Production.ProductSubcategory as PSC
            ON PSC.ProductSubcategoryID = PSCID.SubCatID
    ),

    table1(subCat, cat, SalesCount, SalesTotal)
    AS(
        SELECT PSCN.subCat, PC.Name, PSCN.SalesCount, PSCN.SalesTotal
        FROM productSubCatName as PSCN INNER JOIN Production.ProductCategory as PC
            ON PSCN.cat = PC.ProductCategoryID
    ),

    catSum(subCat, cat, SalesCount, SalesTotal)
    as(
        SELECT 'All sub', cat, SUM(SalesCount), SUM(SalesTotal)
        FROM table1
        GROUP BY cat
    ),
    allCatSum(subCat, cat, SalesCount, SalesTotal)
    AS(
        SELECT 'All sub', 'All cat', SUM(SalesCount), SUM(SalesTotal)
        FROM catSum
    )

SELECT *
FROM table1
UNION
select *
FROM catSum
UNION
select *
FROM allCatSum
    ORDER BY cat, subCat