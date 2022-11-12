show databases;
use mysql01;
show tables;

CREATE TABLE Book (
  bookid      INTEGER PRIMARY KEY,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INTEGER 
);

CREATE TABLE  Customer (
  custid      INTEGER PRIMARY KEY,  
  name        VARCHAR(40),
  address     VARCHAR(50),
  phone       VARCHAR(20)
);

CREATE TABLE Orders (
  orderid INTEGER PRIMARY KEY,
  custid  INTEGER ,
  bookid  INTEGER ,
  saleprice INTEGER ,
  orderdate DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);

select * from book;
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

select * from customer;
INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

select * from Orders;
INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2014-07-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2014-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2014-07-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2014-07-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2014-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2014-07-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2014-07-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2014-07-10','%Y-%m-%d'));

select phone FROM Customer WHERE name='김연아';
select bookname,price FROM Book;
select price,bookname FROM Book;
select * FROM Book WHERE price < 10000;
select * FROM Book WHERE price BETWEEN 10000 AND 20000;
select * FROM Book WHERE publisher IN('굿스포츠','대한미디어');
select distinct name FROM Customer,Orders WHERE Customer.custid = Orders.custid;
select * FROM Book WHERE publisher NOT IN('굿스포츠','대한미디어');
select bookname,publisher FROM Book WHERE bookname LIKE '%축구%';
select * FROM Book WHERE bookname LIKE '%_구%';
select * FROM Book WHERE bookname LIKE '%축구%' AND price > 20000;
select * FROM Book ORDER BY bookname;
select * FROM Book ORDER BY price,bookname;
select * FROM Book ORDER BY price DESC, publisher ASC;
select * FROM Book ORDER BY price ASC, publisher ASC;
select SUM(saleprice) FROM Orders;
select SUM(saleprice) AS 총매출 FROM Orders;
select SUM(saleprice) AS 김연아구매액 FROM Orders WHERE custid=2;
select SUM(saleprice) AS Total, AVG(saleprice) AS Average, MIN(saleprice) AS Minimum, MAX(saleprice) AS Maximum FROM Orders;
select COUNT(*) FROM Orders;
select custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액 FROM Orders GROUP BY custid;
select * FROM Customer,Orders WHERE Customer.custid=Orders.custid;
select * FROM Customer,Orders WHERE Customer.custid=Orders.custid ORDER BY Customer.custid;
select name,saleprice FROM Customer,Orders WHERE Customer.custid=Orders.custid;
select name,SUM(saleprice) FROM Customer,Orders WHERE Customer.custid=Orders.custid GROUP BY Customer.custid ORDER BY Customer.custid;
select Customer.name,Book.bookname FROM Customer,Orders,Book WHERE Customer.custid =Orders.custid AND Orders.bookid=Book.bookid AND Book.price = 20000;
select Customer.name,saleprice FROM Customer LEFT OUTER JOIN Orders ON Customer.custid = Orders.custid;
select MAX(price) FROM Book;
select bookname FROM Book WHERE price=35000;
select bookname FROM Book WHERE price = (select MAX(price) FROM Book);
select * FROM Customer,Orders WHERE Customer.custid = Orders.custid;
CREATE VIEW Voders AS SELECT orderid,O.custid,name,O.bookid,bookname,saleprice,orderdate FROM Customer C, Orders O,Book B WHERE C.custid=O.custid and B.bookid=O.bookid;
select * FROM Voders;