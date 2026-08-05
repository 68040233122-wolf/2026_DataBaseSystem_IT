--1
select * from Employees
SELECT TitleOfCourtesy,
    FirstName,
    LastName,
    City
from Employees
where City = 'London'
--2
select * from customers
select ProductID,ProductName,UnitPrice,UnitsInStock
from Products
Where UnitsInstock <30
--3
select CustomerID, CompanyName, phone
from Customers where country in ('Sweden','Germany','France','Spain','Spain','UK')
--4
select * from Customers
Where Fax is null
--5
select * from products
where UnitsInStock < ReorderLevel and UnitsOnOrder > 0
--6
select FirstName, LastName
from Employees
where year (HireDate) = 1993
--7
select * from Products
where UnitPrice between 50 and 100
--8
select * from Customers
where companyName like 'M%'
--9
select * from customers
where ContactTitle like '%Manager%'
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--เปลี่ยนไปเป็น miniMart
--ต้องการจำนวนสินค้า, ราคาเฉลี่ย, ราคาสูงสุด, ราคาต่ำสุด, จำนวนค้ารวมทั้งหมด
select count(*)as จำนวน,
avg(unitprice) as ราคาเฉลี่ย,
Max(Unitprice) as ราคาสูง,
Min(Unitprice) as ราคาต่ำสุด,
sum(Unitsinstock) as จำนวนสินค้ารวมทั้งหมด
from Products
where CategoryID = 1
select * from Products
------------------------------------------------------------------------------
--สินค้าแต่ละหมวดหมู่มีจำนวนกี่ชนิด------------------------------------------------------
select categoryID, count(*) as จำนวน from products
group by CategoryID
--ใบเสร็จแต่ละใบ มียอดรวมจำนวนเท่าใด---------------------------------------------------
select ReceiptID, sum(UnitPrice * Quantity) as ยอดรวม
from details
group by receiptID

--สินค้าแต่ละหมวดหมู่มีจำนวนกี่ชนิด ต้องการเฉพาะหมวดหมู่ที่มี มากกว่า 2 ชนิดสินค้า
select CategoryID,count(*)as จำนวน from products
group by CategoryID
having count(*) > 2
--ใบเสร็จแต่ละใบ มียอดรวมเท่าใด ต้องการเฉพาะยอดเงินในใบเสร็จ ต่ำกว่า100
select ReceiptID, sum(Unitprice*Quantity) as ยอดรวม
from details
group by ReceiptID
having sum(UnitPrice*Quantity)<100
--โจทย์ทอดลอง goup by และ having ใน Northwind
select * from customers
--แสดงชื่อประเทศของลูกค้า และจำนวนลูกค้าในแต่ละประเทศ แสดงเฉพาะประเทศที่มีจำนวนลูกค้ามากกว่า3ราย
select country, count(*) as จำนวนลูกค้า from customers
group by Country
having count(*) > 3
order by count(*) desc

--แสดงเลขที่ใบเสร็จ และจำนวนรายการที่ขายในแต่ละใบเสร็จ แสดงเฉพาะใบเสร็จที่มี 1 รายการขาย(order details)
select orderID, count(*) as จำนวนรายการ from [order Details]
group by orderID
having count(*)=1


--รหัสหมวดหมู่สินค้า ราคาเฉลี่ย ราคาสูงสุด ราคาต่ำสุด เฉพาะ สินค้าที่มาจากผู้จำหน่ายรหัส 1-10ฃ
--แสดงเฉพาะสินค้าที่มีราคาต่ำกว่า 20
select CategoryID, avg(unitprice), max(unitprice) as ราคาสูงสุด, min(unitprice) as ราคาต่ำสุด
, max(Unitprice) as ราคาสูง, min(unitprice) as ราคาต่ำสุด
from products
where supplierID < 10
group by categoryID
having avg(unitprice) < 20
--จากตาราง orders ต้องการรหัสพนักงานและ จำนวนใบเสร็จที่รับผิดชอบ เฉพาะรายการที่เกิดขึ้นในปี 1997
--เลือกมาเฉพาะรายการที่ส่งสินค้าไปประเทศ USA
--ให้เลือกเฉพาะนักงานที่ขายได้ตั้งแต่ 10 รายการขึ้นไป
select * from orders
select employeeID, count(*) as จำนวนใบเสร็จ from orders
where year(OrderDate) = 1997 and Shipcountry = 'USA'
group by EmployeeID
having count(*) >= 10