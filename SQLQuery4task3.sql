CREATE DATABASE book_store_db;
GO

USE book_store_db;
GO

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    price DECIMAL(10,2)
);
GO

CREATE TABLE sales (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT NOT NULL,
    sale_date DATE NOT NULL,
    sale_amount DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_sales_books
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
GO

INSERT INTO books (title, author, price) VALUES
('Atomic Habits', 'James Clear', 499.00),
('The Alchemist', 'Paulo Coelho', 399.00),
('Clean Code', 'Robert C. Martin', 799.00),
('Harry Potter', 'J.K. Rowling', 599.00);
GO

INSERT INTO sales (book_id, sale_date, sale_amount) VALUES
(1, '2024-01-10', 499.00),
(1, '2024-02-15', 499.00),
(1, '2025-03-05', 499.00),

(2, '2024-01-18', 399.00),
(2, '2024-03-20', 399.00),
(2, '2025-02-01', 399.00),

(3, '2024-02-01', 799.00),
(3, '2024-06-15', 799.00),
(3, '2025-05-01', 799.00),

(4, '2024-04-10', 599.00),
(4, '2025-07-20', 599.00),
(4, '2025-08-25', 599.00);
GO

SELECT 
    b.book_id,
    b.title,
    SUM(s.sale_amount) AS total_sales
FROM books b
JOIN sales s ON b.book_id = s.book_id
GROUP BY b.book_id, b.title;

SELECT
    b.book_id,
    b.title,
    YEAR(s.sale_date) AS sales_year,
    SUM(s.sale_amount) AS total_sales
FROM books b
JOIN sales s ON b.book_id = s.book_id
GROUP BY b.book_id, b.title, YEAR(s.sale_date)
ORDER BY b.title, sales_year;


SELECT 
    b.book_id,
    b.title,
    SUM(s.sale_amount) AS total_sales
FROM books b
JOIN sales s ON b.book_id = s.book_id
GROUP BY b.book_id, b.title
HAVING SUM(s.sale_amount) > 1000;


CREATE PROCEDURE sp_GetBookTotalSales
    @BookTitle VARCHAR(100)
AS
BEGIN
    SELECT 
        b.title,
        SUM(s.sale_amount) AS total_sales
    FROM books b
    JOIN sales s ON b.book_id = s.book_id
    WHERE b.title = @BookTitle
    GROUP BY b.title;
END;
GO

EXEC sp_GetBookTotalSales 'Atomic Habits';


CREATE FUNCTION fn_AvgSaleAmount()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @avg DECIMAL(10,2);

    SELECT @avg = AVG(sale_amount)
    FROM sales;

    RETURN @avg;
END;
GO

SELECT dbo.fn_AvgSaleAmount() AS average_sale_amount;
