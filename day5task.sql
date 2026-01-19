create database bookstoredb
go

use bookstoredb
go

create table author(
  author_id int IDENTITY(1,1)primary key,
  author_name varchar(100)not null,
  email varchar(150),
  country varchar(50)
  );
  go

  create table books(
   book_id int identity (1,1)primary key,
   title varchar(150)not null,
   genre varchar(50),
   price decimal(10,2)not null,
   published_year int,
   author_id int not null,

   constraint fk_books_authors
    foreign key (author_id)
    references author(author_id)
  );

  insert into author(author_name,email,country)values
  ('J.K. Rowling', 'jkrowling@gmail.com', 'UK'),
('George R.R. Martin', 'grrm@gmail.com', 'USA'),
('Paulo Coelho', 'paulo@gmail.com', 'Brazil'),
('Chetan Bhagat', 'chetan@gmail.com', 'India');
GO

insert into books(title,genre,price,published_year,author_id)values
('Harry Potter', 'Fantasy', 599.00, 1997, 1),
('Game of Thrones', 'Fantasy', 799.00, 1996, 2),
('The Alchemist', 'Fiction', 299.00, 1988, 3),
('Half Girlfriend', 'Romance', 249.00, 2014, 4),
('2 States', 'Romance', 199.00, 2009, 4);
GO


create view vw_booksauthordetails
as
select
  b.book_id,
    b.title,
    b.genre,
    b.price,
    b.published_year,

    a.author_id,
    a.author_name,
    a.email,
    a.country
    from books b
    inner join author a
    on b.author_id=a.author_id;
    go

    select *from vw_booksauthordetails;