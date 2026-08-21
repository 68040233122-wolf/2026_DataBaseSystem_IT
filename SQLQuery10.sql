--Lap ในชั้นเรียนวันที่ 19 ส.ค. 2569
--ต้องการข้อมูล เลขที่ใบสั่งซื้อ และยอดเงินจำหน่ายสินค้าในใบสั่งซื้อนั้น

select orderID,ProductID,UnitPrice,Quantity,Discount,
		UnitPrice*Quantity*(1-Discount) as TotalPrice
from [Order Details]
--ต้องการชื่อเต็ม รหัสพนักงาน(คำนำหน้า ชื่อ นาสกุล) ตำแหน่ง โทร ของพนักงาน
Select EmployeeID, TitleOfCourtesy+ FirstName+space(2)+LastName as EmpName,
		Title,HomePhone
from Employees
--ต้องการ รหัสสินค้า ราคา จำนวนที่ขายได้ ยอดเงินที่ขายได้ เรียงตามลำดับสินค้า
select ProductID, sum(Quantity) as จำนวนที่ขายได้
		,cast(Sum(UnitPrice*Quantity*(1-Discount)) as numeric(10,2)) as ยอดที่ขายได้
from [Order Details]
group by ProductID
order by Sum(UnitPrice*Quantity*(1-Discount)) desc

--CAST(5634.6334 as numeric(10,2))
--ต้องการ ชื่อ พนักงาน และ ปีที่เข้าทำงาน
Select TitleOfCourtesy+ FirstName+space(2)+LastName as EmpName,
		year(hiredate)+543 [ปีที่ พ.ศ. เข้าทำงาน]
from Employees

--แสดง รหัสสินค้า ชื่อสินค้าราคา และ ช่วงราคา(สูง ปานกลาง ต่ำ)
select ProductID, ProductName, UnitPrice,
		case when UnitPrice >= 75 Then 'high'
			 when  UnitPrice >= 35 Then 'Medium'
			 else 'low'
		end as PriceLEvel
from Products

--ต้องกการ join ตารางที่มีความสัมพันธ์กัน
--ต้องการชื่อสินค้าทั้งหมด และ ชื่อหมวดหมู่ของสินค้า

Select products.ProductName, Categories.CategoryName
from Products join Categories
on products.CategoryID = Categories.CategoryID

--เขียน แบบย่อ

Select ProductName, c.CategoryName, c.categoryID
from Products as p join Categories as c
on p.CategoryID = c.CategoryID


--Products + Suppliers (ตรารางA)
Select
	p.ProductName,
	s.CompanyName as Supplier
from Products as p 
join Suppliers as s
	on p.SupplierID = s.SupplierID;

--Orders + Customers (ตารางB)
select
	o.OrderID, Convert(varchar,OrderDate,6) as [order date],
	c.CompanyName

from Orders as o
join Customers as c
on o.CustomerID = c.CustomerID
order by 3 asc

--1. ต้องการชื่อบริษัทขนส่ง และ จำนวนใบสั่งซื้อที่เกี่ยวข้อง
select
	s.Companyname as ShipperName,
	count (o.OrderID) as Totalorders
	from Orders as o
	join Shippers as s
	on o.ShipVia = s.ShipperID
group by s.CompanyName;

--2.1 ต้องการชื่อเต็มพนักงาน และจำนวนใบสั่งซื้อที่เกี่ยวข้อง
select
  e.EmployeeID,
  e.TitleOfCourtesy+e.FirstName+e.LastName as EmpName,
  COUNT(o.OrderID) as OrderCount
from Employees as e
 JOIN Orders as o
  on e.EmployeeID = o.EmployeeID
group by
  e.EmployeeID, e.TitleOfCourtesy, e.FirstName, e.LastName
order by OrderCount desc;

--2.2 ชื่อบริษัท ลูกค้า ประเทศลูกค้า และจำนวนฬบสั่งซื้อที่เกี่ยวข้อง
SELECT
  c.CustomerID,
  c.CompanyName,
  c.Country,
  COUNT(o.OrderID) AS OrderCount
FROM Customers AS c
LEFT JOIN Orders AS o
  ON c.CustomerID = o.CustomerID
GROUP BY
  c.CustomerID, c.CompanyName, c.Country
ORDER BY
  OrderCount DESC, c.CompanyName;

--3.1 หมายเลขใบสั่งซื้อ และ ชื่อบริษัทขนส่ง
SELECT
  o.OrderID,
  s.CompanyName AS Shipper
FROM Orders AS o
LEFT JOIN Shippers AS s
  ON o.ShipVia = s.ShipperID
ORDER BY o.OrderID;
		
--3.2 รหัสสินค้า ชื่อสินค้า และ ชื่อบริษัทผู้จำหน่าย(supplier)
select
  p.ProductID,
  p.ProductName,
  s.CompanyName as Supplier
from Products as p
JOIN Suppliers as s
  ON p.SupplierID = s.SupplierID
order by p.ProductID;

--การ join 3 ขึ้นไป
--ต้องการหมายเลขใบสั่งซื้อ วันที่สั่งซื้อ บริษัทลูกค้า ชื่อสกุลพนักงาน ผู้ขาย
SELECT
  o.OrderID,
  CONVERT(varchar(11), o.OrderDate, 6) AS [order date],
  c.CompanyName,
  e.TitleOfCourtesy+e.FirstName+e.LastName AS EmpName
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
ORDER BY o.OrderID;

--ต้องการ รหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย ชื่อหมวดหมู่ ชื่อบริษัทผู้จำหน่าย
SELECT
  p.ProductID,
  p.ProductName,
  p.UnitPrice,
  c.CategoryName,
  s.CompanyName AS Supplier
FROM Products AS p
LEFT JOIN Categories AS c
  ON p.CategoryID = c.CategoryID
LEFT JOIN Suppliers AS s
  ON p.SupplierID = s.SupplierID
ORDER BY p.ProductID;


--ต้องการ รหัสหมวดหมุ่ ชื่อหมวดหมู่ ยอดขายทั้งหมดในหมวดหมู่ แสดงเฉพาะยอดขาย สูงสุด 3 อันดับแรก
select
  c.CategoryID,
  c.CategoryName,
  cast(sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as numeric(10,2)) as TotalSales
from Categories as c
JOIN Products    as p  on p.CategoryID = c.CategoryID
JOIN [Order Details] as od on od.ProductID = p.ProductID
group by c.CategoryID, c.CategoryName
order by 3 desc;

-- (4 ตาราง ) ในแต่ละ รายการสั่งซื้อ มีบริษัทลูกค้าใดซื้อสิน ชื่ออะไร จำนวน และ มียอดขายเท่าใด
select 
    o.OrderID,
    c.CompanyName,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    od.UnitPrice * od.Quantity as Amount
from Orders as o
JOIN Customers as c
    on o.CustomerID = c.CustomerID
JOIN [Order Details] as od
    on o.OrderID = od.OrderID
JOIN Products as p
    on od.ProductID = p.ProductID

--ลูกค้าบริษัทใด มีการซื้อสินค้าที่มาจากประเทศ USA บ้าง (5 ตาราง)
Select distinct c.CompanyName
from orders o join customers c        on o.CustomerID = c.CustomerID
              join [Order Details] od on o.OrderID = od.OrderID
              join products p         on p.ProductID = od.ProductID
              join suppliers s        on p.SupplierID = s.SupplierID
where s.Country = 'USA'



