create database flight_booking_final;
use flight_booking_final;


CREATE TABLE flight (
flightid INT PRIMARY KEY AUTO_INCREMENT,
gate VARCHAR(40),
destination VARCHAR(40),
seats INT,
time TIME,
date DATE,
from_location VARCHAR(50),
pay DECIMAL(10,2),
airline VARCHAR(50)
);

create table ISO_CODE(
ISO_CODE VARCHAR(10) primary KEY,
country varchar(400),
flightid INT 
);

ALTER TABLE ISO_CODE  ADD FOREIGN KEY (Flightid) REFERENCES flight(flightid); 

create table booking(
bookingID INT PRIMARY KEY AUTO_INCREMENT,
destination VARCHAR(40),
airline VARCHAR(50),
class varchar(50),
flightid INT ,
dete_T varchar(50),
date_R varchar(50),
Form varchar(50),
fare varchar(50)
);
ALTER TABLE booking ADD FOREIGN KEY (Flightid) REFERENCES flight(flightid); 

create table fare(
fare varchar(50),
Form varchar(50) PRIMARY KEY,
To_trip varchar(50),
bookingID INT
);

ALTER TABLE fare ADD FOREIGN KEY (bookingID) REFERENCES booking(bookingID); 

create table Ticket(
Ticketnum INT PRIMARY KEY AUTO_INCREMENT,
passport_id varchar(50),
gate VARCHAR(40),
seats INT,
bookingID INT,
date DATE);

ALTER TABLE Ticket ADD FOREIGN KEY (bookingID) REFERENCES booking(bookingID);

create table staff(
Email varchar(50) primary key not null,
F_name varchar(50) not null,
M_name varchar (50) not null,
L_name varchar (50) not null,
Phone_num varchar(50) ,
password varchar(50)
);

create table passenger(
passport_id varchar(50) primary key not null,
Email varchar(50) not null,
F_name varchar(50) not null,
M_name varchar (50) not null,
L_name varchar (50) not null,
Phone_num varchar(50) ,
Birthday date ,
nationality varchar(50)
);

create table book_for(
transaction_id int ,
Email varchar(50) ,
amount varchar(50),
bookingID INT,
passport_id varchar(50),
primary key (Email,bookingID,passport_id)
);

create table admin(
admin_id  int auto_increment primary key,
Email varchar(50) not null,
F_name varchar(50) not null,
M_name varchar (50) not null,
L_name varchar (50) not null,
Phone_num varchar(50) ,
gender varchar(1),
password varchar(50)
);
INSERT INTO book_for (transaction_id, Email, amount, bookingID, passport_id)
VALUES (1, 'staff1@example.com', '500.00', 1, 'ABCD1234'),
(2, 'staff2@example.com', '700.00', 2, 'EFGH5678'),
(3, 'staff1@example.com', '1200.00', 3, 'IJKL9012');


ALTER TABLE book_for ADD FOREIGN KEY (bookingID) REFERENCES booking(bookingID);

ALTER TABLE book_for ADD FOREIGN KEY (Email) REFERENCES staff(Email);

ALTER TABLE book_for ADD FOREIGN KEY (passport_id) REFERENCES passenger(passport_id);



INSERT INTO flight (gate, destination, seats, time, date, from_location, pay, airline)
VALUES ('A1', 'New York', 150, '12:00:00', '2023-06-01', 'London', 500.00, 'Airline A'),
('B2', 'Paris', 200, '14:30:00', '2023-06-02', 'Berlin', 350.00, 'Airline B'),
('C3', 'Tokyo', 100, '09:45:00', '2023-06-03', 'Sydney', 800.00, 'Airline C');

INSERT INTO ISO_CODE (ISO_CODE, country, flightid)
VALUES ('US', 'United States', 1),
('FR', 'France', 2),
('JP', 'Japan', 3);

INSERT INTO booking (destination, airline, class, flightid, dete_T, date_R, Form, fare)
VALUES ('New York', 'Airline A', 'Economy', 1, 'One Way', '2023-06-01', 'London', '500.00'),
('Paris', 'Airline B', 'Business', 2, 'Return', '2023-06-02', 'Berlin', '700.00'),
('Tokyo', 'Airline C', 'First Class', 3, 'One Way', '2023-06-03', 'Sydney', '1200.00');

INSERT INTO fare (fare, Form, To_trip, bookingID)
VALUES ('500.00', 'London', 'New York', 1),
('350.00', 'Berlin', 'Paris', 2),
('600.00', 'Tokyo', 'Paris', 2);

INSERT INTO Ticket (passport_id, gate, seats, bookingID, date)
VALUES ('ABCD1234', 'A1', 1, 1, '2023-06-01'),
('EFGH5678', 'B2', 2, 2, '2023-06-02'),
('IJKL9012', 'C3', 3, 3, '2023-06-03');

INSERT INTO staff (Email, F_name, M_name, L_name, Phone_num, password)
VALUES ('staff1@example.com', 'John', 'Doe', 'Smith', '1234567890', 'password1'),
('staff2@example.com', 'Jane', 'Maria', 'Brown', '9876543210', 'password2');

INSERT INTO passenger (passport_id, Email, F_name, M_name, L_name, Phone_num, Birthday, nationality)
VALUES ('ABCD1234', 'passenger1@example.com', 'Michael', 'James', 'Johnson', '5551234567', '1990-05-10', 'USA'),
('EFGH5678', 'passenger2@example.com', 'Emily', 'Grace', 'Davis', '5559876543', '1985-09-22', 'UK');

INSERT INTO book_for (transaction_id, Email, amount, bookingID, passport_id)
VALUES
  (1, 'staff1@example.com', '500.00', 1, 'ABCD1234'),
  (2, 'staff2@example.com', '700.00', 2, 'EFGH5678');

INSERT INTO passenger (birthday, age)
VALUES ('1990-05-10', 32),
('1985-09-22', 37);

UPDATE flight
SET seats = 120
WHERE flightid = 1;

UPDATE booking
SET destination = 'Los Angeles',
    airline = 'Airline D'
WHERE bookingID = 2;

UPDATE fare
SET fare = '450.00'
WHERE Form = 'London' AND To_trip = 'New York';

UPDATE Ticket
SET gate = 'B3',
    seats = 2
WHERE Ticketnum = 1;

UPDATE staff
SET Phone_num = '5555555555'
WHERE Email = 'staff1@example.com';


UPDATE passenger
SET Email = 'newemail@example.com'
WHERE passport_id = 'ABCD1234';

SELECT * FROM flight;
SELECT * FROM passenger;
SELECT * FROM book_for;
SELECT * FROM staff;




DELETE FROM ISO_CODE
WHERE ISO_CODE = 'US';



DELETE FROM fare
WHERE Form = 'London' AND To_trip = 'New York';


DELETE FROM Ticket
WHERE Ticketnum = 1;

SELECT * FROM Fare;
SELECT * FROM Tickete;
SELECT * FROM ISO_CODE;

-- Create a view to show flight details and corresponding ISO codes
CREATE VIEW flight_details AS
SELECT f.flightid, f.gate, f.destination, f.seats, f.time, f.date, f.from_location, f.pay, f.airline, i.ISO_CODE, i.country
FROM flight f
JOIN ISO_CODE i ON f.flightid = i.flightid;

SELECT * FROM flight_details;


SELECT airline, SUM(pay) AS total_revenue
FROM flight;

SELECT flightid, destination, seats
FROM flight;

SELECT class, COUNT(*) AS total_bookings
FROM booking
GROUP BY class;

SELECT destination, COUNT(*) AS total_bookings
FROM booking
GROUP BY destination
ORDER BY total_bookings DESC
LIMIT 5;

SELECT nationality, COUNT(*) AS total_passengers
FROM passenger
GROUP BY nationality;









