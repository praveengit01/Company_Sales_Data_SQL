-- Sales Table: Contains information about each sale.
-- Products Table: Contains information about the products being sold.
-- Customers Table: Contains information about the customers making the purchases.
create database Company_Sales;
Use Company_Sales;
-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert sample data into Products Table
INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
    (1, 'Laptop', 'Electronics', 800.00),
    (2, 'Mobile Phone', 'Electronics', 500.00),
    (3, 'Headphones', 'Electronics', 50.00),
    (4, 'T-Shirt', 'Clothing', 20.00),
    (5, 'Jeans', 'Clothing', 40.00),
    (6, 'Shoes', 'Clothing', 60.00);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50)
);

-- Insert sample data into Customers Table
INSERT INTO Customers (CustomerID, CustomerName, City, State)
VALUES
    (101, 'John Doe', 'Mumbai', 'Maharashtra'),
    (202, 'Jane Smith', 'Delhi', 'Delhi'),
    (303, 'Alice Johnson', 'Bangalore', 'Karnataka'),
    (404, 'Bob Williams', 'Chennai', 'Tamil Nadu'),
    (505, 'David Brown', 'Hyderabad', 'Telangana');

-- Create Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data into Sales Table
INSERT INTO Sales (SaleID, ProductID, CustomerID, SaleDate, Quantity, TotalAmount)
VALUES
    (111, 1, 101, '2022-01-05', 2, 1600.00),
    (222, 2, 202, '2022-02-10', 1, 500.00),
    (333, 3, 303, '2022-03-15', 3, 150.00),
    (444, 4, 404, '2022-04-20', 5, 100.00),
    (555, 5, 505, '2022-05-25', 2, 80.00),
    (666, 6, 101, '2022-06-30', 1, 60.00),
    (777, 1, 202, '2022-07-05', 3, 2400.00),
    (888, 2, 303, '2022-08-10', 2, 1000.00),
    (999, 3, 404, '2022-09-15', 1, 50.00),
    (100, 4, 505, '2022-10-20', 4, 80.00),
    (112, 5, 101, '2022-11-25', 2, 80.00),
    (123, 6, 202, '2022-12-30', 1, 60.00),
    (134, 1, 303, '2023-01-05', 2, 1600.00),
    (145, 2, 404, '2023-02-10', 1, 500.00),
    (156, 3, 505, '2023-03-15', 3, 150.00),
    (167, 4, 101, '2023-04-20', 5, 100.00),
    (178, 5, 202, '2023-05-25', 2, 80.00),
    (189, 6, 303, '2023-06-30', 1, 60.00),
    (190, 1, 404, '2023-07-05', 3, 2400.00),
    (201, 2, 505, '2023-08-10', 2, 1000.00),
    (212, 3, 101, '2023-09-15', 1, 50.00),
    (223, 4, 202, '2023-10-20', 4, 80.00),
    (234, 5, 303, '2023-11-25', 2, 80.00),
    (245, 6, 404, '2023-12-30', 1, 60.00);

-- What are the top 3 best-selling products in terms of total revenue?

select ProductName, sum(TotalAmount) as TotalRevene
from products pr
Inner Join sales s on pr.ProductID = s.ProductID
group by pr.ProductName
Limit 3;

-- How many sales transactions were made in each month of the year 2022?

select extract(month from SaleDate) as month, count(*) as Sales_Transactions
from Sales
where extract(Year From SaleDate) = 2022
group by month;

-- What is the total revenue generated from sales in the state of Maharashtra?

select sum(TotalAmount) as Revenue, c.State
from sales s
Join customers c on s.CustomerID = c.CustomerID
where State = 'Maharashtra';

-- Which customer made the highest number of purchases?

select c.CustomerName as Name, count(*) as Total_Purchase
from sales s
Join customers c on s.CustomerID = c.CustomerID
group by c.CustomerName
Limit 1;

-- What is the average price of products sold in the "Electronics" category?

select Category, avg(Price) as Average_price
from products
where Category = "Electronics";

-- How many units of the product "T-Shirt" were sold in the year 2023?

select sum(s.Quantity) as Units_Sold
from sales s
Join products p on s.ProductID = p.ProductID
where p.ProductName = "T-Shirt" and extract(Year from SaleDate) = 2023
group by extract(Year from SaleDate);

-- Which city had the highest total sales revenue in the year 2023?

select c.City as City, sum(s.TotalAmount) as Revenue
from customers c
Join sales s on c.CustomerID = s.CustomerID
where extract(Year from SaleDate) = 2023
group by c.City
order by Revenue desc
limit 1;

-- What is the total quantity of products sold in the state of Karnataka?

select State, sum(Quantity) as Total_Quantity
from customers c
Join sales s on c.CustomerID = s.CustomerID
where state = "Karnataka";

-- What is the total revenue generated from sales in the month of May 2022?

select sum(TotalAmount) as Total_Revenue 
from sales
where extract(Year from SaleDate) = 2022 and extract(Month from SaleDate) = 5;

-- Which customer spent the most on purchases in the year 2022?

select customerName, sum(TotalAmount) as Total_Purchase
from customers c
Join sales s on c.CustomerID = s.CustomerID
where extract(Year from SaleDate) = 2022
group by CustomerName
order by Total_Purchase desc
Limit 1;

-- How many distinct products were sold in the year 2022?

select count(Distinct p.ProductName) as Distinct_Product
from products p
Join sales s on p.ProductID = s.ProductID
where extract(Year from SaleDate) = 2022;

-- What is the total revenue generated from sales of "Headphones"?

select p.ProductName as Product, sum(TotalAmount) as Total_Revenue
from sales s
Join products p on s.ProductID = p.ProductID
where p.ProductName = "Headphones";

-- How many customers made purchases in the state of Tamil Nadu?

select Count(Distinct customerID) as Customer, State
from customers 
where state = 'Tamil Nadu';

-- What is the average quantity of products sold per transaction?

select avg(Quantity) as Average_Quantity
from Sales;

-- Which product had the highest average price?

select avg(Price) as Highest_AVG, ProductName
from products 
group by ProductName
order by Highest_AVG desc
Limit 1;








