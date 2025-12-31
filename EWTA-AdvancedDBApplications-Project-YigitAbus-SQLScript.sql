USE master
GO
/****** Creating the Database ******/
CREATE DATABASE db_YigitAbus
ON PRIMARY 
(NAME = 'db_YigitAbus', FILENAME = 'C:\db_YigitAbus.mdf', SIZE = 5120KB, FILEGROWTH = 1024KB)
 LOG ON 
(NAME = 'db_YigitAbus_log', FILENAME = 'C:\db_YigitAbus_log.ldf', SIZE = 1024KB, FILEGROWTH = 1024KB)
GO
ALTER DATABASE db_YigitAbus SET COMPATIBILITY_LEVEL = 160
GO
/****** Creating the Tables ******/
CREATE TABLE tbl_Lookups (
    LK_ID INT PRIMARY KEY,
    Title VARCHAR(50),
    Gender VARCHAR(10),
    Role VARCHAR(50)
)

CREATE TABLE tbl_Departments (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Dept_Phone VARCHAR(20),
    Manager_ID INT
)

CREATE TABLE tbl_Users (
    User_ID INT PRIMARY KEY,
    User_Name VARCHAR(50),
    User_Psw VARCHAR(50),
    Role_ID INT
)

CREATE TABLE tbl_Employees (
    Empl_ID INT PRIMARY KEY,
    Empl_FName VARCHAR(50),
    Empl_LName VARCHAR(50),
    Empl_BDate DATE,
    City VARCHAR(50),
    Province VARCHAR(50),
    Country VARCHAR(50),
    Emp_Start_Date DATE,
    Empl_Left_Date DATE,
    Empl_Address VARCHAR(255),
    Empl_City VARCHAR(50),
    Empl_Province VARCHAR(50),
    Empl_Phone VARCHAR(20),
    Empl_Cell VARCHAR(20),
    Empl_Email VARCHAR(100),
    Dept_ID INT,
    Gender_ID INT,
    Title_ID INT,
    Empl_Photo VARBINARY(MAX),
    Empl_CV VARBINARY(MAX),
    Empl_CV_File VARCHAR(255),
    Empl_CV_Web VARCHAR(255),
    Entered_ID INT,
    Entered_Date DATE,
    Is_Empl_Active BIT,
    CONSTRAINT FK_Dept FOREIGN KEY (Dept_ID) REFERENCES tbl_Departments(Dept_ID)
)
CREATE TABLE tbl_Wages (
    Wage_ID INT PRIMARY KEY,
    Empl_ID INT,
    Wage_Date DATE,
    Wage_Amount DECIMAL(10,2),
    Wage_Commission DECIMAL(10,2),
    Wage_Total DECIMAL(10,2),
    Month_ID INT,
    Wage_Year INT,
    FOREIGN KEY (Empl_ID) REFERENCES tbl_Employees(Empl_ID));

CREATE TABLE tbl_EmployeeWages (
    Wage_ID INT PRIMARY KEY,
    Empl_ID INT,
    Wage_Date DATE,
    Wage_Amount DECIMAL(10,2),
    Wage_Commission DECIMAL(10,2),
    Month_ID INT,
    CONSTRAINT FK_Empl FOREIGN KEY (Empl_ID) REFERENCES tbl_Employees(Empl_ID)
)

/****** Creating Calculation Fields ******/
ALTER TABLE tbl_Employees ADD Empl_Name AS (Empl_FName + ' ' + Empl_LName)
ALTER TABLE tbl_EmployeeWages ADD Wage_Total AS (Wage_Amount + Wage_Commission)
ALTER TABLE tbl_EmployeeWages ADD Wage_Year AS (datepart(year,Wage_Date))
GO
/******* Entering Data ******/
INSERT INTO tbl_Lookups (LK_ID, Title, Gender, Role) VALUES
(1, 'Engineer', 'Male', 'User'),
(2, 'Manager', 'Male', 'Admin'),
(3, 'Technician', 'Male', 'User'),
(4, 'HR Specialist', 'Female', 'User'),
(5, 'Data Analyst', 'Male', 'Admin'),
(6, 'Marketer', 'Female', 'User');

INSERT INTO tbl_Departments (Dept_ID, Dept_Name, Dept_Phone, Manager_ID) VALUES
(1, 'IT', '0212-1234567', NULL),
(2, 'HR', '0212-7654321', NULL),
(3, 'Sales', '0212-1357910', NULL),
(4, 'Customer Relations', '0212-1097531', NULL),
(5, 'R&D', '0212-2468135', NULL);

INSERT INTO tbl_Users (User_ID, User_Name, User_Psw, Role_ID) VALUES
(1, 'admin', 'sirketsahibi34', 1),
(2, 'user', 'kullanici123', 2)

INSERT INTO tbl_Employees (
    Empl_ID, Empl_FName, Empl_LName, Empl_BDate, City, Province, Country,
    Emp_Start_Date, Empl_Left_Date, Empl_Address, Empl_City, Empl_Province,
    Empl_Phone, Empl_Cell, Empl_Email, Dept_ID, Gender_ID, Title_ID,
    Empl_Photo, Empl_CV, Empl_CV_File, Empl_CV_Web, Entered_ID, Entered_Date, Is_Empl_Active
) VALUES
(1, 'Yigit', 'Abus', '2003-05-15', 'Golbasi', 'Ankara', 'Turkey',
 '2023-06-01', NULL, 'Bezirhane Mah. No:21', 'Golbasi', 'Ankara',
 '0312-1234567', '0555-1234567', 'yigit@icloud.com', 1, 1, 1,
 NULL, NULL, 'CV_Yigit.pdf', 'http://yigitcv.com', 1, GETDATE(), 1),

(2, 'Hulya', 'Melan', '1999-09-26', 'Pursaklar', 'Ankara', 'Turkey',
 '2025-05-21', NULL, 'Altinova Mah. No:21', 'Pursaklar', 'Ankara',
 '0312-1234568', '0555-1234568', 'hulya@icloud.com', 2, 2, 4,
 NULL, NULL, 'CV_Hulya.pdf', 'http://hulyacv.com', 2, GETDATE(), 1),

(3, 'Mehmet', 'Kaya', '1990-02-11', 'Kecioren', 'Ankara', 'Turkey',
 '2021-03-10', NULL, 'Ataturk Cad. No:5', 'Kecioren', 'Ankara',
 '0312-1234569', '0555-1234569', 'mehmet.kaya@icloud.com', 1, 1, 1,
 NULL, NULL, 'CV_Mehmet.pdf', 'http://mehmetcv.com', 1, GETDATE(), 1),

(4, 'Meryem', 'Dogan', '1988-08-22', 'Cankaya', 'Ankara', 'Turkey',
 '2022-07-01', NULL, 'Bahcelievler Mah. No:9', 'Cankaya', 'Ankara',
 '0312-1234570', '0555-1234570', 'meryem.dogan@icloud.com', 2, 2, 4,
 NULL, NULL, 'CV_Meryem.pdf', 'http://meryemcv.com', 2, GETDATE(), 1),

(5, 'Cem', 'Yilmaz', '1995-03-12', 'Etimesgut', 'Ankara', 'Turkey',
 '2023-01-15', NULL, 'Turgut Ozal Blv. No:16', 'Etimesgut', 'Ankara',
 '0312-1234571', '0555-1234571', 'cem.yilmaz@icloud.com', 5, 1, 5,
 NULL, NULL, 'CV_Cem.pdf', 'http://cemcv.com', 1, GETDATE(), 1),

(6, 'Elif', 'Sari', '1992-04-17', 'Kadikoy', 'Istanbul', 'Turkey',
 '2020-11-23', NULL, 'Bagdat Cad. No:31', 'Kadikoy', 'Istanbul',
 '0216-1234572', '0555-1234572', 'elif.sari@icloud.com', 3, 2, 2,
 NULL, NULL, 'CV_Elif.pdf', 'http://elifcv.com', 2, GETDATE(), 1),

(7, 'Ahmet', 'Topal', '1991-01-01', 'Sisli', 'Istanbul', 'Turkey',
 '2019-04-20', NULL, 'Nisantasi No:12', 'Sisli', 'Istanbul',
 '0212-1234573', '0555-1234573', 'ahmet.topal@icloud.com', 4, 1, 3,
 NULL, NULL, 'CV_Ahmet.pdf', 'http://ahmetcv.com', 1, GETDATE(), 1),

(8, 'Zeynep', 'Korkmaz', '1996-06-06', 'Alsancak', 'Izmir', 'Turkey',
 '2024-02-01', NULL, 'Kordon Boyu No:88', 'Alsancak', 'Izmir',
 '0232-1234574', '0555-1234574', 'zeynep.korkmaz@icloud.com', 3, 2, 5,
 NULL, NULL, 'CV_Zeynep.pdf', 'http://zeynepcv.com', 2, GETDATE(), 1),

(9, 'Baran', 'Ercan', '1994-12-30', 'Osmangazi', 'Bursa', 'Turkey',
 '2021-09-17', NULL, 'Heykel Mah. No:55', 'Osmangazi', 'Bursa',
 '0224-1234575', '0555-1234575', 'baran.ercan@icloud.com', 4, 1, 2,
 NULL, NULL, 'CV_Baran.pdf', 'http://barancv.com', 1, GETDATE(), 1),

 (10, 'Berk', 'Yildiz', '1995-04-18', 'Besiktas', 'Istanbul', 'Turkey',
    '2024-04-10', NULL, 'Levent Mah. No:45', 'Besiktas', 'Istanbul',
    '0212-9988776', '0542-1234567', 'berk.yildiz@company.com', 5, 1, 3,
    NULL, NULL, 'CV_Berk.pdf', 'http://berkcv.com', 1, GETDATE(), 1),

    (11, 'Melis', 'Karaca', '1994-07-22', 'Buca', 'Izmir', 'Turkey',
    '2024-03-01', NULL, 'Ataturk Cad. No:19', 'Buca', 'Izmir',
    '0232-5554443', '0533-9988776', 'melis.karaca@company.com', 3, 2, 6,
    NULL, NULL, 'CV_Melis.pdf', 'http://meliscv.com', 2, GETDATE(), 1);

INSERT INTO tbl_EmployeeWages (Wage_ID, Empl_ID, Wage_Date, Wage_Amount, Wage_Commission, Month_ID) VALUES
(1, 1, '2023-06-01', 15000.00, 1000.00, 6),
(2, 2, '2025-05-21', 14500.00, 800.00, 5),
(3, 3, '2024-03-10', 16000.00, 1200.00, 3),
(4, 4, '2022-11-15', 14000.00, 700.00, 11),
(5, 5, '2023-01-20', 15500.00, 950.00, 1),
(6, 6, '2024-08-05', 17000.00, 1300.00, 8),
(7, 7, '2023-07-12', 13800.00, 600.00, 7),
(8, 8, '2024-02-28', 14200.00, 750.00, 2),
(9, 9, '2023-10-03', 13500.00, 500.00, 10);

INSERT INTO tbl_Wages (Wage_ID, Empl_ID, Wage_Date, Wage_Amount, Wage_Commission, Wage_Total, Month_ID, Wage_Year) VALUES
(1, 1, '2023-06-01', 15000.00, 1000.00, 16000.00, 6, 2023),
(2, 2, '2025-05-21', 14500.00, 800.00, 15300.00, 5, 2025),
(3, 3, '2024-03-10', 16000.00, 1200.00, 17200.00, 3, 2024),
(4, 4, '2022-11-15', 14000.00, 700.00, 14700.00, 11, 2022),
(5, 5, '2023-01-20', 15500.00, 950.00, 16450.00, 1, 2023),
(6, 6, '2024-08-05', 17000.00, 1300.00, 18300.00, 8, 2024),
(7, 7, '2023-07-12', 13800.00, 600.00, 14400.00, 7, 2023),
(8, 8, '2024-02-28', 14200.00, 750.00, 14950.00, 2, 2024),
(9, 9, '2023-10-03', 13500.00, 500.00, 14000.00, 10, 2023);

/******* Creating Table Foreign Keys and Defaults ******/
ALTER TABLE dbo.tbl_Employees
ADD CONSTRAINT FK_Employees_Department
    FOREIGN KEY (Dept_ID)
    REFERENCES dbo.tbl_Departments(Dept_ID);

ALTER TABLE dbo.tbl_Employees
ADD CONSTRAINT FK_Employees_Gender
    FOREIGN KEY (Gender_ID)
    REFERENCES dbo.tbl_Lookups(LK_ID);

ALTER TABLE dbo.tbl_Employees
ADD CONSTRAINT FK_Employees_Title
    FOREIGN KEY (Title_ID)
    REFERENCES dbo.tbl_Lookups(LK_ID);

ALTER TABLE dbo.tbl_Employees
ADD CONSTRAINT DF_Employees_IsActive
    DEFAULT (1) FOR Is_Empl_Active;

ALTER TABLE dbo.tbl_Users
ADD CONSTRAINT FK_Users_Role
    FOREIGN KEY (Role_ID)
    REFERENCES dbo.tbl_Lookups(LK_ID);

ALTER TABLE dbo.tbl_EmployeeWages
ADD CONSTRAINT FK_Wages_Employee
    FOREIGN KEY (Empl_ID)
    REFERENCES dbo.tbl_Employees(Empl_ID);

/******* Advanced DB Specific Questions to Answer ******/
--Q1: List the employees who work in Ankara.
SELECT * FROM tbl_Employees WHERE Empl_Province = 'Ankara'

--Q2: List the names of the provinces where more than two employees work.
SELECT Empl_Province, COUNT(*) AS Empl_Count FROM tbl_Employees
GROUP BY Empl_Province HAVING COUNT(*) > 2

--Q3: List the average employee wages by departments.
SELECT D.Dept_Name, AVG(W.Wage_Amount) AS Avg_Wage
FROM tbl_EmployeeWages W
JOIN tbl_Employees E ON W.Empl_ID = E.Empl_ID
JOIN tbl_Departments D ON E.Dept_ID = D.Dept_ID
GROUP BY D.Dept_Name

--Q4: List the employees whose names contain the letter "M".
SELECT * FROM tbl_Employees WHERE Empl_FName LIKE '%M%'

--Q5: List the Department Name and Department Phone Numbers of the Employees.
SELECT (Empl_FName + ' ' + Empl_LName) AS Empl_FullName, D.Dept_Name, D.Dept_Phone
FROM tbl_Employees E
JOIN tbl_Departments D ON E.Dept_ID = D.Dept_ID;

--Q6: List the total annual salaries paid to the employees by year.
SELECT YEAR(Wage_Date) AS Wage_Year, SUM(Wage_Amount + Wage_Commission) AS Total_Annual_Salary
FROM tbl_EmployeeWages
GROUP BY YEAR(Wage_Date);

--Q7: Write the query that lists the first letter and surname of the employee's name. For example, like “mcoruh”
SELECT LOWER(LEFT(Empl_FName,1) + Empl_LName) AS ShortName FROM tbl_Employees

--Q8: Write a query that calculates the ages of the employees.
SELECT (Empl_FName + ' ' + Empl_LName) AS Empl_FullName, DATEDIFF(YEAR, Empl_BDate, GETDATE()) AS Age
FROM tbl_Employees;

--Q9: Write the update query that changes the password of user 2 in the Users table.
UPDATE tbl_Users SET User_Psw = 'UserYeniSifre34' WHERE User_ID = 2

--Q10: Delete the employee whose title is “Marketer” from the tbl_Employees table.
DELETE FROM tbl_Employees WHERE Title_ID IN (
    SELECT LK_ID FROM tbl_Lookups WHERE Title = 'Marketer'
)

/****** Querying Tables ******/
SELECT * FROM tbl_Lookups
SELECT * FROM tbl_Departments
SELECT * FROM tbl_Employees
SELECT * FROM tbl_Wages
SELECT * FROM tbl_Users
