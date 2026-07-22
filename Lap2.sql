USE MiniMart;
GO

-- ดูข้อมูลตาราง
SELECT * FROM Employees;
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Receipts;
SELECT * FROM Details;


-- ดูรายชื่อตาราง
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


-- ดูโครงสร้างตาราง
EXEC sp_help 'dbo.Products';


-- เลือกบาง Column
SELECT 
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products;


-- แสดง 5 รายการแรก
SELECT TOP(5) *
FROM Products;


-- แก้ราคาสินค้า ProductID = 1
UPDATE Products
SET UnitPrice = 12
WHERE ProductID = 1;


-- แก้ราคาสินค้าชื่อดินสอ
UPDATE Products
SET UnitPrice = 12
WHERE ProductName = 'ดินสอ';


-- เพิ่มจำนวนสินค้า ยางลบ
UPDATE Products
SET UnitsInStock = UnitsInStock + 250
WHERE ProductName = 'ยางลบ';


-- เพิ่มจำนวนสินค้า ดินสอ
UPDATE Products
SET UnitsInStock = UnitsInStock + 100
WHERE ProductName = 'ดินสอ';


-- เพิ่มราคาสินค้าทุกตัว 5%
UPDATE Products
SET UnitPrice = UnitPrice * 1.05;


-- แสดงรหัสและชื่อสินค้า
SELECT
    ProductID,
    ProductName
FROM Products;


-- ดูพนักงานตำแหน่ง Sale Manager
SELECT 
    FirstName,
    LastName
FROM Employees
WHERE Position = 'Sale Manager';


-- ดูสินค้าทั้งหมด
SELECT *
FROM Products;


-- สินค้าที่เหลือน้อยกว่า 400
select * from products
where UnitsInStock < 400;

select *
from Products
where CategoryID = 1 And UnitsInStock <=20

select *
from Products
where CategoryID = 1 or UnitsInStock <=20

select * 
from Products
where not Discontinued = 1;

select * 
from Products
where not Discontinued = 1;

select * 
from Products
where  Discontinued <> 1;

select 
	productID,
	ProductName,
	UnitPrice
from Products
where UnitPrice between 10 and 20;

select 
	productID,
	ProductName,
	UnitPrice
from Products
where CategoryID in (1,2,4);

--Using Like to show data that's starts with 'น้ำ'
select 
	productID,
	ProductName,
	UnitPrice
from Products
where ProductName like 'น้ำ%';
--Using Like to show data that's ends with 'คำ'
select firstname , lastname from Employees
where lastname like '%คำ'

select productName, unitprice
from products
where productName like'ส้ม'

insert into Employees(FirstName,UserName,Password)
values ('แทน','tan','1234')

insert into Employees(FirstName,lastname,UserName,Password)
values ('เตวิช','','tavid','1234')

select*from Employees
where LastName is null or lastname =''

select Title+FirstName+' '+lastname as ชื่อนามกุลพนักงาน
from Employees

select * from Receipts
where ReceiptDate= '2013/02/10'
select * from Receipts
where ReceiptDate< '2013/02/10'
select * from Receipts
where ReceiptDate>= '2013/02/10'
select * from Receipts
where ReceiptDate between '2013-02-01'and'2013-02-07'

select * from Receipts
where year(ReceiptDate)=2013

select * from Receipts
where year(ReceiptDate)=2013 and month(ReceiptDate)=2

select ProductId,ProductName,UnitPrice,UnitsInStock
from products 
order by productName asc

select ProductId,ProductName,UnitPrice,UnitsInStock
from products 
order by UnitPrice desc

select*from products
order by CategoryId

select top (3)*from products
order by UnitsInStock desc


