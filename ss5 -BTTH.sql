create database dữ_liệu_khách_hàng;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(255),
    Email VARCHAR(255),
    RegistrationDate DATE,
    City VARCHAR(100),
    Status VARCHAR(50)
    );
    
INSERT INTO Customers (CustomerID, FullName, Email, RegistrationDate, City, Status) VALUES
(1, 'Nguyen Van An', 'an.nguyen@email.com', '2023-01-15', 'Ho Chi Minh', 'Active'),
(2, 'Tran Thi Ba', 'ba.tran@email.com', '2023-02-20', 'Hanoi', 'Active'),
(3, 'Le Van Cuong', 'cuong.le@email.com', '2023-02-25', 'Da Nang', 'Inactive'),
(4, 'Pham Thi Dung', 'dung.pham@email.com', '2023-03-10', 'Hanoi', 'Potential'),
(5, 'Hoang Van Em', 'em.hoang@email.com', '2023-04-01', 'Ho Chi Minh', 'Active');
    
INSERT INTO Customers (CustomerID, FullName, Email, RegistrationDate, City, Status) VALUES
(6, 'Ly Thi Giang', 'giang.ly@email.com', '2023-05-20', 'Can Tho', 'Potential');
    
select customers.FullName,customers.Email
from customers;

select a.City
from customers a ;

select *
from customers a 
ORDER BY RegistrationDate desc;

/*
desc   từ trên xuống ( giảm dần )
*/
select *
from customers a 
where city = 'hanoi';

select *
from customers a 
where a.city = 'Ho Chi Minh'
and a.Status = 'Active';

update customers
set status = 'Active'
WHERE fullname = 'Le Van Cuong';

select *
from customers s
where CustomerID = 3;

delete from customers
where CustomerID = 3;