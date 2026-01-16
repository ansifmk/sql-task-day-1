CREATE DATABASE LibraryTaskNEW;
GO

USE LibraryTaskNEW;
GO

CREATE TABLE Authors(
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Publishers(
    PublisherID INT IDENTITY(1,1) PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Books(
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    PublicationYear INT NOT NULL,

    AuthorID INT NOT NULL,
    PublisherID INT NOT NULL,

    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Authors(AuthorName) VALUES
('Paulo Coelho'),
('A. P. J. Abdul Kalam'),
('J. K. Rowling'),
('Robert Kiyosaki'),
('Charles Duhigg'),
('James Clear');

INSERT INTO Publishers(PublisherName) VALUES
('HarperCollins'),
('Bloomsbury'),
('Penguin'),
('Random House');

INSERT INTO Books (Title, PublicationYear, AuthorID, PublisherID) VALUES
('The Alchemist', 1988, 1, 1),
('Wings of Fire', 1999, 2, 3),
('Harry Potter and the Philosopher''s Stone', 1997, 3, 2),
('Harry Potter and the Chamber of Secrets', 1998, 3, 2),
('Rich Dad Poor Dad', 1997, 4, 4),
('The Power of Habit', 2012, 5, 3),
('Atomic Habits', 2018, 6, 1);

SELECT b.Title, a.AuthorName, p.PublisherName
FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID
INNER JOIN Publishers p ON b.PublisherID = p.PublisherID;

SELECT b.Title, a.AuthorName, p.PublisherName
FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID
LEFT JOIN Publishers p ON b.PublisherID = p.PublisherID;

SELECT b.Title, a.AuthorName, p.PublisherName
FROM Books b
RIGHT JOIN  Publishers p ON b.PublisherID = p.PublisherID
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

SELECT b.Title, a.AuthorName, p.PublisherName
FROM Books b
RIGHT JOIN Publishers p ON b.PublisherID = p.PublisherID
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

SELECT b.Title, a.AuthorName, p.PublisherName
FROM Books b
RIGHT JOIN Publishers p ON b.PublisherID = p.PublisherID
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

SELECT AuthorName AS Name FROM Authors
UNION ALL 
SELECT PublisherName FROM Publishers;