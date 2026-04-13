mysql://root:jpPOaVCbCXnTWjDOBzPtDoRKYwqqiClR@caboose.proxy.rlwy.net:45033/{whicheverschema}
-- DROP ALL 6 DATABASES 
USE notification;
DROP DATABASE IF EXISTS notification;
USE booking;
DROP DATABASE IF EXISTS booking;
USE payment;
DROP DATABASE IF EXISTS payment;
USE driver;
DROP DATABASE IF EXISTS driver;
USE maintenance;
DROP DATABASE IF EXISTS maintenance;


CREATE DATABASE IF NOT EXISTS notification;
USE notification;

CREATE TABLE IF NOT EXISTS Notification (
    notificationID INT AUTO_INCREMENT PRIMARY KEY,
    driverID INT NULL,
    message VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    sentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) NOT NULL DEFAULT 'sent'
        CHECK (status IN ('sent', 'failed'))
);


CREATE DATABASE IF NOT EXISTS booking;
USE booking;

CREATE TABLE IF NOT EXISTS Bookings (
    bookingID INT AUTO_INCREMENT PRIMARY KEY,
    driverID INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    startTime TIMESTAMP NOT NULL,
    endTime TIMESTAMP NOT NULL,
    minsLate INT NOT NULL DEFAULT 0,
    slotID INT NOT NULL,
    depositAmount DECIMAL(10, 2) NOT NULL
);



CREATE DATABASE IF NOT EXISTS payment;
USE payment;

CREATE TABLE IF NOT EXISTS Payment (
    paymentID INT AUTO_INCREMENT PRIMARY KEY,
    driverID INT NOT NULL,
    bookingID INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    type VARCHAR(20) NOT NULL
        CHECK (type IN ('hold', 'refund', 'late-fee', 'forfeit')),
    status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'completed', 'failed')),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE DATABASE IF NOT EXISTS driver;
USE driver;

CREATE TABLE IF NOT EXISTS Drivers (
    driverID INT AUTO_INCREMENT PRIMARY KEY,
    late_count INT NOT NULL DEFAULT 0,
    telegram_chat_id VARCHAR(100) DEFAULT NULL

);

CREATE DATABASE IF NOT EXISTS station;
USE station;

CREATE TABLE IF NOT EXISTS Station (
    slotID INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(10) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available', 'faulty'))
);

CREATE DATABASE IF NOT EXISTS maintenance;
USE maintenance;

CREATE TABLE IF NOT EXISTS Maintainance (
    ticketID INT AUTO_INCREMENT PRIMARY KEY,
    slotID INT NOT NULL,
    reportedBy VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    chargerType VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'open'
        CHECK (status IN ('open', 'in-progress', 'resolved')),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolvedAt TIMESTAMP NULL
);

Dummy

USE driver; INSERT INTO Drivers (driverID, late_count, telegram_chat_id) VALUES (1, 0,NULL), (2, 2,NULL), (3, 1,NULL);
USE station; INSERT INTO Station (slotID, status) VALUES (1, 'available'), (2, 'available'), (3, 'faulty');
USE booking; INSERT INTO Bookings (bookingID, driverID, status, startTime, endTime, minsLate, slotID, depositAmount) VALUES
(1, 1, 'completed', '2026-03-20 08:00:00', '2026-03-20 10:00:00', 0, 1, 50.00),
(2, 2, 'completed', '2026-03-20 11:00:00', '2026-03-20 12:00:00', 15, 2, 50.00),
(3, 3, 'cancelled', '2026-03-21 09:00:00', '2026-03-21 11:00:00', 0, 1, 50.00);


USE payment; INSERT INTO Payment (paymentID, driverID, bookingID, amount, type, status, createdAt) VALUES
(1, 1, 1, 50.00, 'hold', 'completed', '2026-03-20 08:00:00'),
(2, 1, 1, 50.00, 'refund', 'completed', '2026-03-20 10:05:00'),
(3, 2, 2, 50.00, 'hold', 'completed', '2026-03-20 11:00:00'),
(4, 2, 2, 15.00, 'late-fee', 'completed', '2026-03-20 12:20:00'),
(5, 3, 3, 50.00, 'forfeit', 'completed', '2026-03-21 09:00:00');

USE notification; INSERT INTO Notification (notificationID, driverID, message, type, sentAt, status) VALUES
(1, 1, 'Your booking #1 is confirmed.', 'booking', '2026-03-20 08:00:00', 'sent'),
(2, 2, 'You have been charged a late fee.', 'late-fee', '2026-03-20 12:20:00', 'sent'),
(3, 3, 'No-show detected. Deposit forfeited.', 'no-show', '2026-03-21 09:05:00', 'sent'),
(4, NULL, 'Fault reported at slot 3.', 'fault', '2026-03-21 14:00:00', 'sent');

USE maintenance; INSERT INTO Maintainance (ticketID, slotID, reportedBy, description, chargerType, status, createdAt, resolvedAt) VALUES
(1, 3, 'driver_3', 'Charger not working at slot 3.', 'AC Type 2', 'resolved', '2026-03-21 09:00:00', '2026-03-21 15:00:00'),
(2, 2, 'staff', 'Loose cable detected at slot 2.', 'DC CCS', 'in-progress', '2026-03-21 10:00:00', NULL),
(3, 1, 'driver_1', 'Screen flickering on slot 1.', 'AC Type 1', 'open', '2026-03-22 08:00:00', NULL);



USE driver; SELECT * FROM Drivers ORDER BY driverID;
USE station; SELECT * FROM Station ORDER BY slotID;
USE booking; SELECT * FROM Bookings ORDER BY bookingID;
USE payment; SELECT * FROM Payment ORDER BY paymentID;
USE notification; SELECT * FROM Notification ORDER BY notificationID;
USE maintenance; SELECT * FROM Maintainance ORDER BY ticketID;












https://personal-dftp1xlj.outsystemscloud.com/Status/rest/Status/#/Status/GetAvailableStations

