-- ============================================================================
-- ShopSphere Database Setup Script
-- ASP.NET Web Forms & SQL Server
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

-- Table 2: Electricity bills (progressive slabs and GST)
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

-- Table 3: Screen time logs
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

PRINT '=======================================================';
PRINT 'ShopSphere Database Setup Completed Successfully!';
PRINT '=======================================================';
