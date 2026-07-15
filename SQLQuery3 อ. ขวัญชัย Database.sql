Create database ShopTK

Create table Employees (
	EmployeeID	int identity(1,1) Primary Key,
	Title		varchar(20),
	FirstName	varchar(50) not null,
	LastName	varchar(50),
	Posision	varchar(50),
	UserName	varchar(50) Unique,
	PasswordHash varchar(255) not null,
	IsActive	bit not null Default 1
)
-------------------------------------------
Insert Into Employees
	(Title, FirstName, LastName,
	 Posision, UserName, PasswordHash)
Values
	('นาย', 'เตวิช', 'แสนโบราณ',
	 'Sale Manager', 'user2', 'hashes1')
--ดูข้อมูลเพิ่มเติม
select * from Employees
--คำสั่งอันตราย
--คำสั่งลบตารางออกจากฐานข้อมูล แล้วสร้างตารางใหม่
drop table Employees
-----------------------------------
alter database TevitMinimart
collate Thai_CI_AS;
--ทดสอบข้อมูลคนที่ 2
Insert Into Employees
	(Title, FirstName, LastName,
	 Posision, UserName, PasswordHash)
Values
	('นาย', 'กาณฑ์', 'อุปไชย',
	 'Sale Manager', 'user3', 'hashes1')
-----------------------------------------
Create Table Categories(
	CategoryID	int identity(1,1) Primary Key,
	CategoryName varchar(50) not null Unique,
	Description varchar(200)
)
--เพิ่มข้อมูล 5 หมวดหมู่
--เครื่องปรุง, เครื่องดื่ม, อาหารสำเร็จรูป, เครื่องสำอาง, เวชภัณฑ์
Insert Into Categories(CategoryName)
Values ('เครื่องปรุง')
Insert Into Categories(CategoryName)
Values ('เครื่องดื่ม')
Insert Into Categories(CategoryName)
Values ('อาหารสำเร็จรูป')
Insert Into Categories(CategoryName)
Values ('เครื่องสำอาง')
Insert Into Categories(CategoryName)
Values ('เวชภัณฑ์')
--ดูข้อมูล
select * from Categories
--ตาราง
CREATE TABLE Products (
	ProductID	varchar(13) Primary Key,
	ProductName	varchar(100) not null,
	UnitPrice	decimal(10,2) not null default 0 check (UnitPrice >= 0),
	UnitInStock	int not null default 0 check (UnitInStock >= 0),
	CategoryID int not null references Categories(CategoryID),
	Discontinued bit not null default 0
)
--------------------------
insert into Products
	(ProductID, ProductName, UnitPrice,
	 UnitInStock, CategoryID)
values
	('8858757001948', 'โค้ก',
	 15.00, 290, 1)
--------------------------
insert into Products
	(ProductID, ProductName, UnitPrice,
	 UnitInStock, CategoryID)
values
	('8858757009999', 'สินค้าทดสอบ',
	 10.00, 20, 1)
--------------------------
select * from Products
--------------------------
drop table Categories --ดรอปไม่ได้ เพราะติด Foreign Key กับตารางอื่น
--------------------------
insert into Products
	(ProductID, ProductName, UnitPrice,
	 UnitInStock, CategoryID)
values
	('8858757009998', 'สินค้าทดสอบ',
	 10.00, 20, 99)
------------------------------------
CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);
---------------------------------
INSERT INTO Receipts 
    (EmployeeID, TotalCash)
VALUES 
    (1, 115.00);
------------
select * from Receipts
------------
CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
------------------------
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 3);
------------------------
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 0);
------------------------
select * from Details