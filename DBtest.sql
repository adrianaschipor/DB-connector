show databases;

/*2. Create TABLES for 'test' database*/

use test;

CREATE TABLE Items (
    ItemID int NOT NULL,
    price int NOT NULL,
    brand varchar(30),
    PRIMARY KEY (ItemID)
);

CREATE TABLE Customers (
    CustomerID int NOT NULL,
    LastName varchar(30),
    FirstName varchar(30),
    Adress varchar(30),
    City varchar(30),
    Country varchar(30),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Orders (
    OrderID int NOT NULL,
    CustomerID int,
    OrderDate date,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

/*add OrderID as FK in Items*/
ALTER TABLE Items
ADD column OrderID int;

ALTER TABLE Items
ADD CONSTRAINT FK_OrderID
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
/*add OrderID as FK in Items*/

/*2.Create TABLES for 'test' database*/

/*ALTER TABLE Customers CHANGE Address Adress varchar(30);*/

/* 3. Populate each table with some random data*/

/* POPULATE Customers TABLE*/
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (1, 'Sue', 'Burling', '598 Declaration Avenue', 'Quinta da Queimada', 'Portugal'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (2, 'Justin', 'Fasham', '6714 8th Street', 'Trinidad', 'Cuba'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (3, 'Hal', 'Agus', '8 Claremont Parkway', 'Kurmuk', 'Sudan'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (4, 'Sidonia', 'Ffoulkes', '66 Dixon Road', 'Blagoevgrad', 'Bulgaria'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (5, 'Gabrielle', 'Allingham', '075 Scofield Park', 'Lanjaghbyur', 'Armenia'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (6, 'Jolie', 'McVity', '060 Stang Lane', 'Czudec', 'Poland'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (7, 'Robinia', 'Keigher', '39 Linden Alley', 'Buawan', 'Philippines'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (8, 'Efrem', 'Foreman', '19567 Anderson Court', 'Utena', 'Lithuania'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (9, 'Noell', 'McGucken', '6848 Bultman Trail', 'Ndibène Dahra', 'Senegal'); 
insert into Customers (CustomerID, LastName, FirstName, Adress, City, Country) 
values (10, 'Willard', 'Pickavant', '785 Shasta Road', 'Vantaa', 'Finland');
/* POPULATE Customers TABLE*/


/* POPULATE Items TABLE*/
insert into Items (ItemID, price, brand, OrderID)
values (1, 25, 'Ursodiol', 1);
insert into Items (ItemID, price, brand, OrderID) 
values (2, 30, 'Clearasil', 2); 
insert into Items (ItemID, price, brand, OrderID) 
values (3, 20, 'ATACAND', 3); 
insert into Items (ItemID, price, brand, OrderID) 
values (4, 67, 'Eve Lom', 2);
insert into Items (ItemID, price, brand, OrderID) 
values (5, 80, 'Fentanyl', 4); 
insert into Items (ItemID, price, brand, OrderID) 
values (6, 90, 'Acetate', 6); 
insert into Items (ItemID, price, brand, OrderID) 
values (7, 48, 'Glipizide', 1); 
insert into Items (ItemID, price, brand, OrderID) 
values (8, 29, 'RXS', 5); 
insert into Items (ItemID, price, brand, OrderID) 
values (9, 50, 'Feathers', 7); 
insert into Items (ItemID, price, brand, OrderID) 
values (10, 100, 'Cold', 8); 
insert into Items (ItemID, price, brand, OrderID) 
values (11, 11, 'METFORM', 9); 
insert into Items (ItemID, price, brand, OrderID) 
values (12, 18, 'RoC Multi', 5); 
insert into Items (ItemID, price, brand, OrderID) 
values (13, 73, 'Cefazolin', 3); 
insert into Items (ItemID, price, brand, OrderID) 
values (14, 95, 'Alprazolam', 5); 
insert into Items (ItemID, price, brand, OrderID) 
values (15, 89, 'Pilocarpine', 10);
/* POPULATE Items TABLE*/


/*POPULATE Orders Table*/
insert into Orders (OrderID, CustomerID, OrderDate) 
values (1, 1, '2020-02-17'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (2, 2, '2020-07-06'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (3, 1, '2020-12-11'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (4, 4, '2020-02-11'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (5, 3, '2020-05-12'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (6, 9, '2020-06-16'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (7, 2, '2020-02-25'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (8, 5, '2020-10-29'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (9, 6, '2020-03-05'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (10, 1, '2020-10-11'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (11, 7, '2020-07-04'); 
insert into Orders (OrderID, CustomerID, OrderDate) 
values (12, 9, '2020-08-22');
/*POPULATE Orders Table*/

/* 3. Populate each table with some random data*/


/* 4. Manipulate the data */

/* Update an item's price */
SELECT ItemID, price AS initial_price FROM Items
WHERE ItemID=1;
UPDATE Items
SET price = 29
WHERE ItemId=1;
SELECT ItemID, price AS final_price FROM Items
WHERE ItemID=1;
/* Update an item's price */

use test;
/* Display the cheapest item*/
SELECT ItemID,brand, price
FROM Items
GROUP BY price
HAVING price=MIN(price)
LIMIT 1;

SELECT * FROM Items
ORDER BY price
LIMIT 1;

SELECT * FROM Items
where price = (Select min(price) from Items);

Select min(price) from Items;

/* Display the cheapest item*/


/*Display top 3 most expensive items*/
SELECT * FROM Items
ORDER BY price DESC
LIMIT 3;
/*Display top 3 most expensive items*/

/* Order items by price */
SELECT * FROM Items
ORDER BY price;
/* Order items by price */

/* Display the latest order */
SELECT MAX(OrderDate) AS LatestOrder
FROM Orders;
/* Display the latest order */

/* Dislay number of orders per costumer */
SELECT Customers.CustomerID, Customers.LastName, COUNT(Orders.OrderID) AS NumberOfOrders 
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY CustomerID
ORDER BY COUNT(Orders.OrderID) DESC;
/* Dislay number of orders per costumer */

/*Display the prices of orders*/
SELECT Orders.OrderID, COUNT(Items.ItemID) AS NoOfItems, SUM(Items.price) AS OrderPrice FROM Items
LEFT JOIN Orders ON Items.OrderID = Orders.OrderID
GROUP BY OrderID;
/*Display the prices of orders*/

/* 4. Manipulate the data */

/*Disply all customers who spent more than 50*/
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, SUM(price) AS Spent
FROM (( Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Items ON Orders.OrderID = Items.OrderID)
GROUP BY Customers.CustomerID
HAVING SUM(price) > 50
ORDER BY SUM(price) DESC;
/*Disply all customers who spent more than 50*/


/*UPDATE prices by 50% for all items*/
UPDATE Items
SET price = price + 0.5*price
WHERE ItemID>0;
/*UPDATE prices by 50% for all items*/

/* Cancel 50% UPDATE*/
UPDATE Items
SET price = price/1.5
WHERE ItemID>0;
/* Cancel 50% UPDATE*/


SELECT * FROM Items;







