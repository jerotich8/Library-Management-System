-- creating database library management
CREATE DATABASE LibraryManagement;

-- creating tables books,borrowers and transactions
create table Books(
BookID int primary key,
Authors varchar(255) not null,
Title varchar(255) not null,
ISBN varchar(255) unique not null,
PublicationYear year not null,
Genre varchar(255),
CopiesAvailable int default 0);

create table Borrowers(
BorrowerID int primary key,
FirstName varchar(255) not null,
LastName varchar(255) not null,
Email varchar(255) unique not null,
PhoneNumber varchar(255),
Address varchar(255));

create table Transactions(
TransactionID int auto_increment primary key,
BookID int,
BorrowerID int,
TransactionDate Date not null,
DueDate date,
ReturnDate date,
Foreign key (BookID) references Books(BookID),
Foreign key (BorrowerID) references Borrowers(BorrowerID)
);

-- Inserting sample data into Books
INSERT INTO Books (BookId,Title, authors, Isbn, PublicationYear, Genre, CopiesAvailable)
VALUES
(1,'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925, 'Classic', 5),
(2,'To Kill a Mockingbird', 'Harper Lee', '9780060935467', 1960, 'Fiction', 3),
(3,'1984', 'George Orwell', '9780451524935', 1949, 'Dystopian', 4),
(4,'Pride and Prejudice', 'Jane Austen', '9780141439518', 1913, 'Romance', 6),
(5,'The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 1951, 'Literary Fiction', 2);

-- Inserting sample data into Borrowers
INSERT INTO Borrowers (BorrowerID, FirstName, LastName, Email, PhoneNumber, Address )
VALUES
(1,'Jenny','Kim', 'jenny.kim@gmail.com', '555-1234', '123 Elm Street, Springfield'),
(2,'John','Smith', 'john.smith@yahoo.co.ke', '555-5678', '456 Oak Avenue, Springfield'),
(3,'Emily', 'Johnson', 'emily.johnson@gmail.com', '555-8765', '789 Pine Road, Springfield'),
(4,'Michael', 'Brandi', 'michael.brandi@gmail.com', '555-4321', '101 Maple Drive, Springfield'),
(5,'Sarah', 'Wanja', 'sarah.davis@outlook.com', '555-6789', '202 Birch Lane, Springfield');

-- Inserting sample data into Transactions
INSERT INTO Transactions (bookid, borrowerid, Transactiondate, returndate, duedate)
VALUES
(1, 1, '2024-09-01', '2024-09-15', '2024-09-15'),
(2, 2, '2024-09-05', NULL, '2024-09-20'),
(3, 3, '2024-08-20', '2024-09-05', '2024-09-05'),
(4, 4, '2024-09-10', NULL, '2024-09-24'),
(5, 5, '2024-09-07', '2024-09-14', '2024-09-14');

-- updating table book and transactions
UPDATE books
SET CopiesAvailable = 0
WHERE BookID = 5;

update transactions
set transactiondate= "2024-08-20", duedate = "2024-09-03"
where TransactionID = 4;

-- listing available books
SELECT * 
FROM books
WHERE CopiesAvailable>0;

-- checking out a book
INSERT INTO Transactions (bookid, borrowerid, transactiondate, duedate)
VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));

UPDATE Books
SET copiesavailable = copiesavailable - 1
WHERE bookid = 1;

-- updating return of a book
UPDATE Transactions
SET returndate = CURDATE()
WHERE transactionid = 2;

UPDATE Books
SET copiesavailable = copiesavailable + 1
WHERE bookid = (SELECT bookid FROM Transactions WHERE transactionid = 2);

-- finding overdue books
SELECT b.title, br.borrowerid, t.duedate
FROM Transactions t
JOIN Books b ON t.bookid = b.bookid
JOIN Borrowers br ON t.borrowerid = br.borrowerid
WHERE t.returndate IS NULL AND t.duedate < CURDATE();


