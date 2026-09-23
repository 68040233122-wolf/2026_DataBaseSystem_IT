--Workshop Tansacton ด้วย Northwind


-- 1. ตรวจสอบข้อมูลลูกค้า
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID = 'ALFKI';

-- 2. ตรวจสอบข้อมูลพนักงาน (EmployeeID = 1)
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeID = 1;

-- 3. ตรวจสอบข้อมูลสินค้าที่จะนำมาทดสอบ (ProductID = 1 และ 2)
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductID in (1, 2);

--เริ่ม Transaction และสร้างคำสั่งซื้อ (Orders)
BEGIN TRANSACTION;

INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 50.00);

-- ดึงค่า OrderID ล่าสุดที่เพิ่ง INSERT ไปใน Session ปัจจุบัน
SELECT SCOPE_IDENTITY() AS NewOrderID;

-- เพิ่มสินค้าชิ้นที่ 1 (ProductID = 1, จำนวน = 2)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079,ProductID,UnitPrice,2,0 from Products where ProductID = 1


-- เพิ่มสินค้าชิ้นที่ 2 (ProductID = 2, จำนวน = 3)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079,ProductID,UnitPrice,2,0 from Products where ProductID = 2

--ตรวจสอบข้อมูลก่อน COMMIT
Select * from Orders where OrderID = 11079
Select * from [Order Details] where OrderID = 11079
--ทดสอบ Rollback
Rollback

--การใช้ ROLLBACK (ยกเลิกการเปลี่ยนแปลง) part2

BEGIN TRANSACTION;

INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 75.00);

--ตรวจสอบ OrderID ล่าสุด
SELECT SCOPE_IDENTITY() AS RollbackOrderID;

--เพิ่มรายการสินค้าลงใน Order Details
-- เพิ่มสินค้าชิ้นที่ 1 (ProductID = 1, จำนวน = 1)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079,ProductID,UnitPrice,2,0 from Products where ProductID = 1

-- เพิ่มสินค้าชิ้นที่ 2 (ProductID = 2, จำนวน = 2)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079,ProductID,UnitPrice,2,0 from Products where ProductID = 2

Rollback