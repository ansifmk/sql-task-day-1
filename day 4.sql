create database books_store_db;
go

use books_store_db;
go

create table books(
  book_id int identity(1,1)primary key,
  title varchar(150) not null,
  author varchar(100)not null,
  price decimal(10,2) not null
);

insert into books(title,author,price)values
('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 499.00),
('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 550.00),
('The Alchemist', 'Paulo Coelho', 399.00),
('Eleven Minutes', 'Paulo Coelho', 450.00),
('Wings of Fire', 'A.P.J Abdul Kalam', 300.00),
('Ignited Minds', 'A.P.J Abdul Kalam', 320.00);
GO

create procedure sp_getallbooktitles
as
begin
 select title
 from books;
 end
 go

 exec sp_getallbooktitles;

 create procedure sp_getbooksbyauthor
 @author_name varchar(150)
 as
 begin
 select book_id, title,author,price
 from books
 where author=@author_name;
 end;
 go
 EXEC sp_GetBooksByAuthor 'Paulo Coelho';

 create function dbo.fn_bookcountbyauthor
 (
 @author_name varchar(100)
 )
 returns int
 as
 begin
 declare @total_books int;

 select @total_books=count(*)
 from books
 where author=@author_name;
 return @total_books;
 end;

 SELECT dbo.fn_BookCountByAuthor('J.K. Rowling') AS total_books;
GO
SELECT * FROM books;
GO
SELECT author,
       dbo.fn_BookCountByAuthor(author) AS book_count
FROM books
GROUP BY author;
GO
