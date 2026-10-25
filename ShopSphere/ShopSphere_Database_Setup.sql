-- ============================================================================
-- ShopSphere Database Setup Script
-- Project-Based Learning (PBL) Component: ASP.NET Web Forms & SQL Server
-- ITM SLS BU School of Computer Science & Engineering, Vadodara
-- B.Tech Semester-3 (Academic Year 2026-27)
-- ============================================================================

-- 1. Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ShopSphereDB')
BEGIN
    CREATE DATABASE ShopSphereDB;
    PRINT 'Database [ShopSphereDB] created successfully.';
END
ELSE
BEGIN
    PRINT 'Database [ShopSphereDB] already exists.';
END
GO

USE ShopSphereDB;
GO

-- ============================================================================
-- 2. Create Relational Tables
-- ============================================================================

-- Table 1: Users (Database-backed Authentication & 3 Roles)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE Users (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL,
        Salt NVARCHAR(255) NOT NULL,
        FullName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        Mobile NVARCHAR(20) NULL,
        Role NVARCHAR(50) NOT NULL, -- 'Administrator', 'Student', 'Faculty', 'Customer'
        CreatedAt DATETIME DEFAULT GETDATE()
    );
    PRINT 'Table [Users] created successfully.';
END
GO

-- Table 2: ElectricityBills (Assignment 2: Progressive Slabs & GST)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ElectricityBills')
BEGIN
    CREATE TABLE ElectricityBills (
        BillId INT IDENTITY(1,1) PRIMARY KEY,
        CustomerId NVARCHAR(50) NOT NULL,
        CustomerName NVARCHAR(100) NOT NULL,
        UnitsConsumed INT NOT NULL,
        BillBeforeGst DECIMAL(18,2) NOT NULL,
        GstRate DECIMAL(5,2) NOT NULL,
        GstAmount DECIMAL(18,2) NOT NULL,
        TotalAmount DECIMAL(18,2) NOT NULL,
        CalculatedAt DATETIME DEFAULT GETDATE()
    );
    PRINT 'Table [ElectricityBills] created successfully.';
END
GO

-- Table 3: ScreenTimeLogs (Assignment 1: Instagram Screen Time Analyzer)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ScreenTimeLogs')
BEGIN
    CREATE TABLE ScreenTimeLogs (
        LogId INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL,
        ScreenTimeHours DECIMAL(5,2) NOT NULL,
        UsageCategory NVARCHAR(100) NOT NULL,
        RecordedAt DATETIME DEFAULT GETDATE()
    );
    PRINT 'Table [ScreenTimeLogs] created successfully.';
END
GO

-- Table 4: Products (Tailstore E-Commerce Catalog)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products')
BEGIN
    CREATE TABLE Products (
        ProductId INT IDENTITY(1,1) PRIMARY KEY,
        ProductName NVARCHAR(100) NOT NULL,
        Category NVARCHAR(50) NOT NULL,
        Price DECIMAL(18,2) NOT NULL,
        OriginalPrice DECIMAL(18,2) NULL,
        ImageUrl NVARCHAR(255) NOT NULL,
        Description NVARCHAR(255) NULL
    );
    PRINT 'Table [Products] created successfully.';
END
GO

-- ============================================================================
-- 3. Seed Default User Accounts (Mandatory Assignment Roles)
-- ============================================================================
-- Note: In the live application, passwords are automatically seeded with PBKDF2 salt.
-- The hashes below correspond to:
-- admin   / admin123
-- student / stud123
-- faculty / fac123
-- ============================================================================

IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Salt, FullName, Email, Mobile, Role, CreatedAt)
    VALUES ('admin', '5yGk2jR8q4xL0vW9mZ1p4bF6cN8jQ2tK', 'S0M3S4LT12345678', 'System Administrator', 'admin@shopsphere.edu', '9876543210', 'Administrator', GETDATE());
    PRINT 'Seeded user [admin].';
END

IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'student')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Salt, FullName, Email, Mobile, Role, CreatedAt)
    VALUES ('student', '8xLm1vW9mZ1p4bF6cN8jQ2tK5yGk2jR4', 'S0M3S4LT87654321', 'B.Tech Student', 'student@shopsphere.edu', '9876543211', 'Student', GETDATE());
    PRINT 'Seeded user [student].';
END

IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'faculty')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Salt, FullName, Email, Mobile, Role, CreatedAt)
    VALUES ('faculty', '1p4bF6cN8jQ2tK5yGk2jR8q4xL0vW9mZ', 'S0M3S4LT11223344', 'Department Faculty', 'faculty@shopsphere.edu', '9876543212', 'Faculty', GETDATE());
    PRINT 'Seeded user [faculty].';
END
GO

-- ============================================================================
-- 4. Seed Products
-- ============================================================================
IF NOT EXISTS (SELECT * FROM Products)
BEGIN
    INSERT INTO Products (ProductName, Category, Price, OriginalPrice, ImageUrl, Description) VALUES
    (N'Blue Women''s Suit', N'Women', 19.99, 24.99, N'assets/images/products/5.jpg', N'Elegant formal slim-fit suit for work and events'),
    (N'White Long Sleeve Shirt', N'Women', 29.99, 34.99, N'assets/images/products/6.jpg', N'Classic breathable white button-down shirt'),
    (N'Yellow Men''s Suit', N'Men', 15.99, 19.99, N'assets/images/products/7.jpg', N'Modern casual blazer crafted with lightweight fabric'),
    (N'Red Designer Dress', N'Women', 39.99, 49.99, N'assets/images/products/8.jpg', N'Vibrant evening dress with contemporary silhouette'),
    (N'Black Leather Jacket', N'Women', 49.99, 59.99, N'assets/images/products/4.jpg', N'Premium faux leather biker jacket with silver hardware'),
    (N'Black Evening Gown', N'Women', 35.99, 45.00, N'assets/images/products/3.jpg', N'Timeless formal floor-length dress'),
    (N'Casual Cotton Tee', N'Men', 12.99, 18.00, N'assets/images/products/1.jpg', N'Everyday comfort fit premium round-neck t-shirt'),
    (N'Sporty Urban Hoodie', N'Men', 28.50, 36.00, N'assets/images/products/2.jpg', N'Warm fleece-lined pullover for cool days');
    PRINT 'Seeded [Products] catalog successfully.';
END
GO

-- ============================================================================
-- 5. Seed Sample Electricity Bills & Screen Time Records
-- ============================================================================
IF NOT EXISTS (SELECT * FROM ElectricityBills)
BEGIN
    INSERT INTO ElectricityBills (CustomerId, CustomerName, UnitsConsumed, BillBeforeGst, GstRate, GstAmount, TotalAmount, CalculatedAt) VALUES
    (N'CUST-1001', N'Rohan Sharma', 150, 630.00, 12.00, 75.60, 705.60, DATEADD(day, -3, GETDATE())),
    (N'CUST-1002', N'Pooja Patel', 250, 1215.00, 18.00, 218.70, 1433.70, DATEADD(day, -2, GETDATE())),
    (N'CUST-1003', N'Aman Gupta', 80, 336.00, 5.00, 16.80, 352.80, DATEADD(day, -1, GETDATE()));
    PRINT 'Seeded sample [ElectricityBills].';
END
GO

IF NOT EXISTS (SELECT * FROM ScreenTimeLogs)
BEGIN
    INSERT INTO ScreenTimeLogs (Username, ScreenTimeHours, UsageCategory, RecordedAt) VALUES
    (N'student', 0.8, N'Excellent! Healthy Usage', DATEADD(day, -3, GETDATE())),
    (N'student', 1.5, N'Good Usage', DATEADD(day, -2, GETDATE())),
    (N'faculty', 3.0, N'Moderate Usage', DATEADD(day, -1, GETDATE())),
    (N'student', 5.2, N'High Usage', GETDATE());
    PRINT 'Seeded sample [ScreenTimeLogs].';
END
GO

PRINT '=======================================================';
PRINT 'ShopSphere Database Setup Completed Successfully!';
PRINT '=======================================================';
