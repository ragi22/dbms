CREATE TABLE account (
  Username VARCHAR(100),
  Name VARCHAR(100),
  Password VARCHAR(100),
  Sec_Q VARCHAR(100),
  Answer VARCHAR(100)
);
INSERT INTO account (Username, Name, Password, Sec_Q, Answer)
VALUES ('johndoe', 'John Doe', 'mypassword', 'What is your nickname?', 'Blue');


CREATE TABLE book_ticket (
  Ticket_No INT ,
  Flight_Id VARCHAR(100),
  Flight_Name VARCHAR(100),
  Source VARCHAR(100),
  Destination VARCHAR(100),
  Date Varchar(100),
  Arrival_Time Varchar(100),
  Departure_Time TIME,
  Total_Price FLOAT,
  Seats INT,
  C_Name VARCHAR(100)
);
INSERT INTO book_ticket (Ticket_No, Flight_Id, Flight_Name, Source, Destination, Date, Arrival_Time, Departure_Time, Total_Price, Seats, C_Name)
VALUES (123456, 'ABC123', 'Flight One', 'New York', 'Los Angeles', '2023-05-01', '08:00:00 AM', '05:00:00 AM', 500.00, 2, 'John Doe');


CREATE TABLE cancel_ticket (
  Ticket_No INT ,
  Flight_Id INT,
  Flight_Name VARCHAR(100),
  Source VARCHAR(100),
  Destination VARCHAR(100),
  Booking_Date VARCHAR(100),
  Arrival_Time VARCHAR(100),
  Departure_Time VARCHAR(100),
  Price FLOAT,
  Seats INT,
  C_Name VARCHAR(100),
  Return_Date VARCHAR(100)
);
INSERT INTO cancel_ticket (Ticket_No, Flight_Id, Flight_Name, Source, Destination, Booking_Date, Arrival_Time, Departure_Time, Price, Seats, C_Name, Return_Date)
VALUES (123456, 7890, 'Flight Two', 'Los Angeles', 'New York', '2023-05-01', '10:00:00 AM', '07:00:00 AM', 250.00, 1, 'Jane Smith', '2023-05-08');



CREATE TABLE flight (
  Flight_Id INT,
  Flight_Name VARCHAR(100),
  Source VARCHAR(100),
  Destination VARCHAR(100),
  Date VARCHAR(100),
  Arrival_Time VARCHAR(100),
  Departure_Time VARCHAR(100),
  Flight_Price FLOAT
);
INSERT INTO flight (Flight_Id, Flight_Name, Source, Destination, Date, Arrival_Time, Departure_Time, Flight_Price)
VALUES (7890, 'Flight Two', 'Los Angeles', 'New York', '2023-05-08', '01:00:00 PM', '10:00:00 AM', 350.00);


SELECT * FROM account;
SELECT * FROM book_ticket;
SELECT * FROM cancel_ticket;
SELECT * FROM flight;



CREATE TRIGGER update_flight_price
ON flight
AFTER INSERT
AS
BEGIN
  UPDATE flight
  SET Flight_Price = 1000
  WHERE Flight_Id IN (SELECT Flight_Id FROM inserted);
END;
--{This trigger will update the "Flight_Price" column to 1000 for all new flights inserted into the "flight" table.}

SELECT *
FROM sys.triggers
WHERE name = 'update_flight_price';


CREATE PROCEDURE get_flight_details 
  @Flight_Name VARCHAR(100)
AS
BEGIN
  SELECT *
  FROM flight
  WHERE Flight_Name = @Flight_Name;
END; 
--{This stored procedure is named "get_flight_details" and accepts one input parameter "@Flight_Name" of type "VARCHAR(100)". 
--The procedure returns all columns from the "flight" table where the "Flight_Name" column matches the input parameter value.}

DECLARE @Flight_Name VARCHAR(100) = 'Flight 123';
EXEC get_flight_details @Flight_Name;
SELECT *
FROM flight
WHERE Flight_Name = @Flight_Name;