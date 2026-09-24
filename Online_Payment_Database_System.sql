-- CREATE ONLINE PAYMENT DATABASE

DROP DATABASE IF EXISTS OnlinePaymentDB;

CREATE DATABASE OnlinePaymentDB;
USE OnlinePaymentDB;

-- CREATE CUSTOMERS TABLE

CREATE TABLE Customers (
    CustomerID       INT PRIMARY KEY,
    FirstName        VARCHAR(50) NOT NULL,
    LastName         VARCHAR(50) NOT NULL,
    Email            VARCHAR(100) NOT NULL UNIQUE,
    Phone            VARCHAR(15) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL
);


-- CREATE ACCOUNTS TABLE


CREATE TABLE Accounts (
    AccountID     INT PRIMARY KEY,
    CustomerID    INT NOT NULL,
    AccountType   VARCHAR(20) NOT NULL,
    Balance       DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    AccountStatus VARCHAR(15) NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_accounts_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT chk_balance_nonneg CHECK (Balance >= 0)
);


-- CREATE MERCHANTS TABLE

CREATE TABLE Merchants (
    MerchantID   INT PRIMARY KEY,
    MerchantName VARCHAR(100) NOT NULL,
    Category     VARCHAR(50) NOT NULL,
    City         VARCHAR(50) NOT NULL
);


-- CREATE PAYMENTMETHODS TABLE

CREATE TABLE PaymentMethods (
    PaymentMethodID   INT PRIMARY KEY,
    PaymentMethodName VARCHAR(30) NOT NULL,
    Provider          VARCHAR(50) NOT NULL,
    PaymentType       VARCHAR(20) NOT NULL,
    Status            VARCHAR(15) NOT NULL DEFAULT 'Active'
);


-- CREATE TRANSACTIONS TABLE
-- Relationships: Customers, Accounts, Merchants, PaymentMethods -> Transactions

CREATE TABLE Transactions (
    TransactionID    INT PRIMARY KEY,
    CustomerID       INT NOT NULL,
    AccountID        INT NOT NULL,
    MerchantID       INT NOT NULL,
    PaymentMethodID  INT NOT NULL,
    TransactionDate  DATE NOT NULL,
    Amount           DECIMAL(12,2) NOT NULL,
    TransactionType  VARCHAR(15) NOT NULL,
    Status           VARCHAR(15) NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_txn_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT fk_txn_account  FOREIGN KEY (AccountID)  REFERENCES Accounts(AccountID),
    CONSTRAINT fk_txn_merchant FOREIGN KEY (MerchantID) REFERENCES Merchants(MerchantID),
    CONSTRAINT fk_txn_method   FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID),
    CONSTRAINT chk_amount_positive CHECK (Amount > 0)
);


-- CREATE REFUNDS TABLE
-- Relationship: Transactions -> Refunds

CREATE TABLE Refunds (
    RefundID      INT PRIMARY KEY,
    TransactionID INT NOT NULL,
    RefundDate    DATE NOT NULL,
    RefundAmount  DECIMAL(12,2) NOT NULL,
    RefundReason  VARCHAR(50) NOT NULL,
    RefundStatus  VARCHAR(15) NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_refund_txn FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    CONSTRAINT chk_refund_positive CHECK (RefundAmount > 0)
);


-- INDEXES FOR ANALYSIS QUERIES

CREATE INDEX idx_txn_date ON Transactions(TransactionDate);

CREATE INDEX idx_txn_status ON Transactions(Status);


-- INSERT CUSTOMER DATA

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, RegistrationDate) VALUES
(1, 'Akash', 'Kulkarni', 'akash.kulkarni1@gmail.com', '9126855092', '2024-07-17'),
(2, 'Meera', 'Singh', 'meera.singh2@gmail.com', '9249827706', '2023-07-29'),
(3, 'Radhika', 'Naik', 'radhika.naik3@gmail.com', '9193349856', '2026-04-24'),
(4, 'Preeti', 'Patil', 'preeti.patil4@gmail.com', '9131994523', '2023-07-11'),
(5, 'Kavita', 'Singh', 'kavita.singh5@gmail.com', '9642621108', '2026-05-17'),
(6, 'Priya', 'Naik', 'priya.naik6@gmail.com', '9313500298', '2026-01-21'),
(7, 'Ajay', 'Singh', 'ajay.singh7@gmail.com', '9582334538', '2026-04-21'),
(8, 'Ritu', 'Sharma', 'ritu.sharma8@gmail.com', '9914763202', '2023-11-23'),
(9, 'Sunil', 'Chavan', 'sunil.chavan9@gmail.com', '9465341213', '2024-07-23'),
(10, 'Pooja', 'Kumar', 'pooja.kumar10@gmail.com', '9919795579', '2024-11-20'),
(11, 'Karan', 'Joshi', 'karan.joshi11@gmail.com', '9507943839', '2023-07-18'),
(12, 'Deepak', 'Gupta', 'deepak.gupta12@gmail.com', '9748245888', '2024-06-25'),
(13, 'Amit', 'Pawar', 'amit.pawar13@gmail.com', '9675770529', '2023-09-13'),
(14, 'Vijay', 'Joshi', 'vijay.joshi14@gmail.com', '9692749116', '2024-08-23'),
(15, 'Akash', 'Agarwal', 'akash.agarwal15@gmail.com', '9488302652', '2026-03-28'),
(16, 'Suresh', 'Joshi', 'suresh.joshi16@gmail.com', '9149203558', '2024-04-11'),
(17, 'Rupali', 'Nair', 'rupali.nair17@gmail.com', '9185675980', '2024-04-21'),
(18, 'Karan', 'Verma', 'karan.verma18@gmail.com', '9398471886', '2025-07-17'),
(19, 'Akash', 'Gupta', 'akash.gupta19@gmail.com', '9274648506', '2025-01-28'),
(20, 'Deepak', 'Kumar', 'deepak.kumar20@gmail.com', '9819595113', '2024-06-30'),
(21, 'Sunil', 'Joshi', 'sunil.joshi21@gmail.com', '9754049436', '2023-12-17'),
(22, 'Yash', 'Singh', 'yash.singh22@gmail.com', '9275452091', '2025-08-04'),
(23, 'Vijay', 'Reddy', 'vijay.reddy23@gmail.com', '9787194506', '2026-02-14'),
(24, 'Rajesh', 'Iyer', 'rajesh.iyer24@gmail.com', '9924970419', '2023-04-25'),
(25, 'Rajesh', 'Patil', 'rajesh.patil25@gmail.com', '9964411347', '2024-10-08'),
(26, 'Shreya', 'Reddy', 'shreya.reddy26@gmail.com', '9171069472', '2024-03-08'),
(27, 'Siddharth', 'Iyer', 'siddharth.iyer27@gmail.com', '9328306011', '2025-10-19'),
(28, 'Shreya', 'Pawar', 'shreya.pawar28@gmail.com', '9253407200', '2024-06-26'),
(29, 'Aman', 'Singh', 'aman.singh29@gmail.com', '9899925830', '2026-02-23'),
(30, 'Yash', 'Reddy', 'yash.reddy30@gmail.com', '9902099969', '2026-04-12'),
(31, 'Preeti', 'Shah', 'preeti.shah31@gmail.com', '9528853029', '2025-01-11'),
(32, 'Rajesh', 'Mehta', 'rajesh.mehta32@gmail.com', '9647099690', '2025-10-07'),
(33, 'Neha', 'Patil', 'neha.patil33@gmail.com', '9217734861', '2023-11-10'),
(34, 'Akash', 'Deshmukh', 'akash.deshmukh34@gmail.com', '9950488739', '2025-05-14'),
(35, 'Harish', 'Joshi', 'harish.joshi35@gmail.com', '9513140753', '2025-02-20'),
(36, 'Harish', 'Pawar', 'harish.pawar36@gmail.com', '9668132202', '2024-05-29'),
(37, 'Komal', 'Sharma', 'komal.sharma37@gmail.com', '9830448745', '2023-08-23'),
(38, 'Radhika', 'Naik', 'radhika.naik38@gmail.com', '9906248900', '2024-06-30'),
(39, 'Rupali', 'Iyer', 'rupali.iyer39@gmail.com', '9219778234', '2024-08-24'),
(40, 'Preeti', 'Deshmukh', 'preeti.deshmukh40@gmail.com', '9587182120', '2023-01-07'),
(41, 'Ravi', 'Reddy', 'ravi.reddy41@gmail.com', '9637500247', '2024-01-01'),
(42, 'Omkar', 'Kulkarni', 'omkar.kulkarni42@gmail.com', '9771410971', '2024-09-03'),
(43, 'Akash', 'Rao', 'akash.rao43@gmail.com', '9753876785', '2024-02-12'),
(44, 'Pooja', 'Gupta', 'pooja.gupta44@gmail.com', '9918739736', '2023-11-27'),
(45, 'Yash', 'Rao', 'yash.rao45@gmail.com', '9100614068', '2026-05-11'),
(46, 'Manoj', 'Bhosale', 'manoj.bhosale46@gmail.com', '9120912992', '2023-08-18'),
(47, 'Anita', 'Nair', 'anita.nair47@gmail.com', '9357109965', '2023-04-29'),
(48, 'Meera', 'Shah', 'meera.shah48@gmail.com', '9184564737', '2023-06-25'),
(49, 'Ravi', 'Bhosale', 'ravi.bhosale49@gmail.com', '9976198296', '2023-05-22'),
(50, 'Mahesh', 'Naik', 'mahesh.naik50@gmail.com', '9922308461', '2023-09-15'),
(51, 'Aman', 'Bhosale', 'aman.bhosale51@gmail.com', '9690347116', '2023-12-05'),
(52, 'Sanjay', 'Rao', 'sanjay.rao52@gmail.com', '9751325257', '2025-05-16'),
(53, 'Kavita', 'Naik', 'kavita.naik53@gmail.com', '9910959828', '2024-02-16'),
(54, 'Madhuri', 'Nair', 'madhuri.nair54@gmail.com', '9528414718', '2025-02-03'),
(55, 'Nikhil', 'Rao', 'nikhil.rao55@gmail.com', '9584779555', '2023-09-05'),
(56, 'Meera', 'Singh', 'meera.singh56@gmail.com', '9168747287', '2024-11-23'),
(57, 'Priya', 'Shah', 'priya.shah57@gmail.com', '9694768704', '2024-04-16'),
(58, 'Tanvi', 'Singh', 'tanvi.singh58@gmail.com', '9107721109', '2023-05-26'),
(59, 'Madhuri', 'Patil', 'madhuri.patil59@gmail.com', '9345824373', '2023-05-19'),
(60, 'Amit', 'Iyer', 'amit.iyer60@gmail.com', '9176082500', '2025-11-18'),
(61, 'Meera', 'Reddy', 'meera.reddy61@gmail.com', '9818309417', '2025-09-21'),
(62, 'Kavita', 'Naik', 'kavita.naik62@gmail.com', '9242068763', '2026-03-15'),
(63, 'Siddharth', 'Bhosale', 'siddharth.bhosale63@gmail.com', '9360916298', '2025-08-26'),
(64, 'Ajay', 'Kumar', 'ajay.kumar64@gmail.com', '9201281557', '2023-07-18'),
(65, 'Prakash', 'Chavan', 'prakash.chavan65@gmail.com', '9480424119', '2025-05-17'),
(66, 'Ajay', 'Pawar', 'ajay.pawar66@gmail.com', '9882839238', '2023-04-21'),
(67, 'Radhika', 'Kulkarni', 'radhika.kulkarni67@gmail.com', '9165082363', '2025-04-04'),
(68, 'Ravi', 'Iyer', 'ravi.iyer68@gmail.com', '9959629660', '2023-08-12'),
(69, 'Meera', 'Kumar', 'meera.kumar69@gmail.com', '9304235259', '2026-01-03'),
(70, 'Nikhil', 'Mehta', 'nikhil.mehta70@gmail.com', '9552991960', '2024-01-11'),
(71, 'Ritu', 'Pawar', 'ritu.pawar71@gmail.com', '9368227631', '2023-06-04'),
(72, 'Nikhil', 'Naik', 'nikhil.naik72@gmail.com', '9205128697', '2023-04-14'),
(73, 'Ishita', 'Naik', 'ishita.naik73@gmail.com', '9997677788', '2023-01-31'),
(74, 'Neha', 'Singh', 'neha.singh74@gmail.com', '9278575192', '2025-04-12'),
(75, 'Vaishnavi', 'Bhosale', 'vaishnavi.bhosale75@gmail.com', '9329509408', '2025-04-01'),
(76, 'Sneha', 'Deshmukh', 'sneha.deshmukh76@gmail.com', '9506919288', '2023-01-05'),
(77, 'Vijay', 'Reddy', 'vijay.reddy77@gmail.com', '9941889393', '2025-07-20'),
(78, 'Arjun', 'Chavan', 'arjun.chavan78@gmail.com', '9847959430', '2026-02-12'),
(79, 'Prakash', 'Bhosale', 'prakash.bhosale79@gmail.com', '9266211829', '2024-01-24'),
(80, 'Arjun', 'Kumar', 'arjun.kumar80@gmail.com', '9162795957', '2026-04-01'),
(81, 'Snehal', 'Naik', 'snehal.naik81@gmail.com', '9165452690', '2024-10-04'),
(82, 'Sneha', 'Patil', 'sneha.patil82@gmail.com', '9727255918', '2025-09-03'),
(83, 'Omkar', 'Rao', 'omkar.rao83@gmail.com', '9269042105', '2023-04-27'),
(84, 'Omkar', 'Joshi', 'omkar.joshi84@gmail.com', '9299528037', '2023-05-21'),
(85, 'Harish', 'Joshi', 'harish.joshi85@gmail.com', '9825003955', '2024-04-26'),
(86, 'Shreya', 'Kulkarni', 'shreya.kulkarni86@gmail.com', '9711684318', '2024-05-19'),
(87, 'Tanvi', 'Agarwal', 'tanvi.agarwal87@gmail.com', '9142672287', '2026-06-22'),
(88, 'Neha', 'Chavan', 'neha.chavan88@gmail.com', '9805849060', '2026-04-10'),
(89, 'Siddharth', 'Rao', 'siddharth.rao89@gmail.com', '9439699535', '2024-06-18'),
(90, 'Kavita', 'Iyer', 'kavita.iyer90@gmail.com', '9356287095', '2024-06-27'),
(91, 'Shreya', 'Mehta', 'shreya.mehta91@gmail.com', '9821221887', '2024-09-06'),
(92, 'Kiran', 'Iyer', 'kiran.iyer92@gmail.com', '9907308348', '2023-05-29'),
(93, 'Rahul', 'Pawar', 'rahul.pawar93@gmail.com', '9766964667', '2026-02-27'),
(94, 'Karan', 'Joshi', 'karan.joshi94@gmail.com', '9677280546', '2024-03-12'),
(95, 'Omkar', 'Reddy', 'omkar.reddy95@gmail.com', '9242224154', '2024-12-15'),
(96, 'Rohan', 'Singh', 'rohan.singh96@gmail.com', '9496776692', '2024-08-06'),
(97, 'Vikram', 'Pawar', 'vikram.pawar97@gmail.com', '9995226828', '2026-01-17'),
(98, 'Madhuri', 'Nair', 'madhuri.nair98@gmail.com', '9756783995', '2025-12-19'),
(99, 'Rahul', 'Naik', 'rahul.naik99@gmail.com', '9421455482', '2023-08-01'),
(100, 'Aman', 'Reddy', 'aman.reddy100@gmail.com', '9223940587', '2023-08-08'),
(101, 'Snehal', 'Naik', 'snehal.naik101@gmail.com', '9266910922', '2024-07-11'),
(102, 'Arjun', 'Agarwal', 'arjun.agarwal102@gmail.com', '9326161867', '2024-12-03'),
(103, 'Kavita', 'Reddy', 'kavita.reddy103@gmail.com', '9642678844', '2025-09-27'),
(104, 'Sanjay', 'Patil', 'sanjay.patil104@gmail.com', '9199104722', '2025-05-17'),
(105, 'Ritu', 'Patil', 'ritu.patil105@gmail.com', '9103807155', '2024-11-14'),
(106, 'Rupali', 'Mehta', 'rupali.mehta106@gmail.com', '9784095277', '2024-06-20'),
(107, 'Vikram', 'Pawar', 'vikram.pawar107@gmail.com', '9692362342', '2025-05-25'),
(108, 'Komal', 'Sharma', 'komal.sharma108@gmail.com', '9220123666', '2023-06-04'),
(109, 'Sunil', 'Mehta', 'sunil.mehta109@gmail.com', '9685823118', '2023-03-15'),
(110, 'Anita', 'Shah', 'anita.shah110@gmail.com', '9693269304', '2023-10-31'),
(111, 'Preeti', 'Mehta', 'preeti.mehta111@gmail.com', '9144913399', '2024-09-23'),
(112, 'Anita', 'Patil', 'anita.patil112@gmail.com', '9484194737', '2024-03-06'),
(113, 'Radhika', 'Singh', 'radhika.singh113@gmail.com', '9816114302', '2023-07-30'),
(114, 'Deepak', 'Naik', 'deepak.naik114@gmail.com', '9536344399', '2026-06-25'),
(115, 'Snehal', 'Mehta', 'snehal.mehta115@gmail.com', '9354194771', '2023-11-29'),
(116, 'Anjali', 'Chavan', 'anjali.chavan116@gmail.com', '9126614158', '2024-01-03'),
(117, 'Snehal', 'Iyer', 'snehal.iyer117@gmail.com', '9940081098', '2025-04-23'),
(118, 'Prakash', 'Singh', 'prakash.singh118@gmail.com', '9386480450', '2023-11-23'),
(119, 'Sunil', 'Kulkarni', 'sunil.kulkarni119@gmail.com', '9510751046', '2023-03-21'),
(120, 'Ganesh', 'Singh', 'ganesh.singh120@gmail.com', '9314289692', '2025-07-31'),
(121, 'Deepak', 'Nair', 'deepak.nair121@gmail.com', '9981044229', '2024-04-11'),
(122, 'Rajesh', 'Sharma', 'rajesh.sharma122@gmail.com', '9808705238', '2024-01-31'),
(123, 'Shreya', 'Iyer', 'shreya.iyer123@gmail.com', '9399147754', '2023-05-23'),
(124, 'Rupali', 'Reddy', 'rupali.reddy124@gmail.com', '9477040284', '2025-11-09'),
(125, 'Shreya', 'Naik', 'shreya.naik125@gmail.com', '9455569462', '2023-02-26'),
(126, 'Divya', 'Reddy', 'divya.reddy126@gmail.com', '9291735734', '2026-04-04'),
(127, 'Sanjay', 'Patil', 'sanjay.patil127@gmail.com', '9216396351', '2026-05-06'),
(128, 'Preeti', 'Gupta', 'preeti.gupta128@gmail.com', '9882269302', '2024-10-04'),
(129, 'Preeti', 'Agarwal', 'preeti.agarwal129@gmail.com', '9649136331', '2023-08-25'),
(130, 'Vijay', 'Shah', 'vijay.shah130@gmail.com', '9304095531', '2024-06-05'),
(131, 'Amit', 'Chavan', 'amit.chavan131@gmail.com', '9101815992', '2025-11-30'),
(132, 'Yash', 'Kumar', 'yash.kumar132@gmail.com', '9491079829', '2025-06-02'),
(133, 'Rohan', 'Iyer', 'rohan.iyer133@gmail.com', '9769108025', '2024-10-04'),
(134, 'Prakash', 'Kulkarni', 'prakash.kulkarni134@gmail.com', '9872830248', '2024-09-07'),
(135, 'Omkar', 'Nair', 'omkar.nair135@gmail.com', '9816070802', '2025-04-16'),
(136, 'Manoj', 'Verma', 'manoj.verma136@gmail.com', '9848621833', '2024-08-28'),
(137, 'Komal', 'Mehta', 'komal.mehta137@gmail.com', '9305986733', '2025-05-11'),
(138, 'Prakash', 'Verma', 'prakash.verma138@gmail.com', '9827264603', '2023-12-23'),
(139, 'Bhavna', 'Shah', 'bhavna.shah139@gmail.com', '9423142470', '2025-04-11'),
(140, 'Komal', 'Sharma', 'komal.sharma140@gmail.com', '9426283245', '2024-08-10'),
(141, 'Kavita', 'Chavan', 'kavita.chavan141@gmail.com', '9943702118', '2026-04-02'),
(142, 'Harish', 'Iyer', 'harish.iyer142@gmail.com', '9599277266', '2025-06-23'),
(143, 'Nikhil', 'Kumar', 'nikhil.kumar143@gmail.com', '9648868899', '2025-08-27'),
(144, 'Snehal', 'Deshmukh', 'snehal.deshmukh144@gmail.com', '9807435606', '2023-06-23'),
(145, 'Arjun', 'Rao', 'arjun.rao145@gmail.com', '9812807629', '2026-06-22'),
(146, 'Swati', 'Joshi', 'swati.joshi146@gmail.com', '9978775497', '2024-04-26'),
(147, 'Radhika', 'Nair', 'radhika.nair147@gmail.com', '9341206079', '2024-02-12'),
(148, 'Pooja', 'Sharma', 'pooja.sharma148@gmail.com', '9149621604', '2024-05-16'),
(149, 'Ganesh', 'Agarwal', 'ganesh.agarwal149@gmail.com', '9925159146', '2023-05-30'),
(150, 'Kiran', 'Chavan', 'kiran.chavan150@gmail.com', '9776205431', '2026-03-24');


-- INSERT ACCOUNT DATA

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, AccountStatus) VALUES
(1, 1, 'Savings', 143810.01, 'Active'),
(2, 2, 'Current', 49174.90, 'Active'),
(3, 3, 'Savings', 178585.64, 'Active'),
(4, 4, 'Savings', 155794.87, 'Active'),
(5, 5, 'Wallet', 103832.57, 'Active'),
(6, 6, 'Savings', 183535.27, 'Active'),
(7, 7, 'Savings', 160382.61, 'Active'),
(8, 8, 'Wallet', 119292.74, 'Inactive'),
(9, 9, 'Current', 122724.14, 'Active'),
(10, 10, 'Wallet', 85634.78, 'Inactive'),
(11, 11, 'Current', 179493.02, 'Active'),
(12, 12, 'Current', 90288.92, 'Active'),
(13, 13, 'Wallet', 55823.61, 'Active'),
(14, 14, 'Current', 125536.31, 'Active'),
(15, 15, 'Savings', 142852.20, 'Active'),
(16, 16, 'Current', 64282.06, 'Active'),
(17, 17, 'Savings', 30590.72, 'Active'),
(18, 18, 'Savings', 141430.62, 'Active'),
(19, 19, 'Current', 66510.84, 'Active'),
(20, 20, 'Savings', 41763.46, 'Active'),
(21, 21, 'Wallet', 189239.38, 'Active'),
(22, 22, 'Wallet', 76386.02, 'Active'),
(23, 23, 'Current', 60073.22, 'Active'),
(24, 24, 'Current', 107875.00, 'Active'),
(25, 25, 'Wallet', 179613.36, 'Active'),
(26, 26, 'Current', 87449.28, 'Active'),
(27, 27, 'Current', 133940.29, 'Active'),
(28, 28, 'Wallet', 33426.42, 'Active'),
(29, 29, 'Savings', 196154.03, 'Active'),
(30, 30, 'Current', 118582.61, 'Active'),
(31, 31, 'Savings', 128728.55, 'Active'),
(32, 32, 'Current', 36754.94, 'Active'),
(33, 33, 'Current', 42726.23, 'Active'),
(34, 34, 'Current', 56012.19, 'Inactive'),
(35, 35, 'Current', 50828.17, 'Active'),
(36, 36, 'Savings', 149930.34, 'Active'),
(37, 37, 'Current', 45232.32, 'Active'),
(38, 38, 'Wallet', 8531.50, 'Active'),
(39, 39, 'Savings', 40272.46, 'Active'),
(40, 40, 'Savings', 48089.72, 'Active'),
(41, 41, 'Savings', 113011.93, 'Active'),
(42, 42, 'Wallet', 51620.62, 'Active'),
(43, 43, 'Wallet', 121645.88, 'Active'),
(44, 44, 'Savings', 155669.48, 'Active'),
(45, 45, 'Current', 22065.70, 'Active'),
(46, 46, 'Current', 115371.45, 'Inactive'),
(47, 47, 'Current', 79632.56, 'Active'),
(48, 48, 'Savings', 118623.52, 'Active'),
(49, 49, 'Savings', 20829.31, 'Active'),
(50, 50, 'Wallet', 120282.12, 'Active'),
(51, 51, 'Wallet', 156635.75, 'Active'),
(52, 52, 'Current', 132473.51, 'Active'),
(53, 53, 'Wallet', 68575.62, 'Active'),
(54, 54, 'Current', 21555.00, 'Inactive'),
(55, 55, 'Wallet', 178369.22, 'Active'),
(56, 56, 'Savings', 87379.69, 'Active'),
(57, 57, 'Wallet', 54381.44, 'Active'),
(58, 58, 'Wallet', 155040.97, 'Active'),
(59, 59, 'Wallet', 118698.69, 'Active'),
(60, 60, 'Savings', 166230.84, 'Active'),
(61, 61, 'Current', 49150.76, 'Active'),
(62, 62, 'Wallet', 133803.60, 'Active'),
(63, 63, 'Current', 170265.09, 'Active'),
(64, 64, 'Savings', 71287.58, 'Active'),
(65, 65, 'Current', 176123.84, 'Active'),
(66, 66, 'Current', 111380.31, 'Active'),
(67, 67, 'Savings', 17579.79, 'Active'),
(68, 68, 'Current', 111257.65, 'Active'),
(69, 69, 'Current', 129357.63, 'Active'),
(70, 70, 'Savings', 19064.14, 'Active'),
(71, 71, 'Wallet', 49039.38, 'Active'),
(72, 72, 'Current', 94915.47, 'Active'),
(73, 73, 'Current', 199327.98, 'Active'),
(74, 74, 'Current', 140719.56, 'Active'),
(75, 75, 'Current', 46492.34, 'Active'),
(76, 76, 'Current', 24351.17, 'Active'),
(77, 77, 'Wallet', 37437.39, 'Active'),
(78, 78, 'Current', 55661.68, 'Active'),
(79, 79, 'Wallet', 119559.75, 'Inactive'),
(80, 80, 'Savings', 59601.17, 'Active'),
(81, 81, 'Current', 3322.60, 'Active'),
(82, 82, 'Current', 9580.38, 'Active'),
(83, 83, 'Current', 139634.77, 'Active'),
(84, 84, 'Current', 20966.24, 'Active'),
(85, 85, 'Current', 94144.69, 'Active'),
(86, 86, 'Savings', 193116.78, 'Active'),
(87, 87, 'Current', 23260.38, 'Active'),
(88, 88, 'Current', 15279.39, 'Active'),
(89, 89, 'Savings', 30769.54, 'Active'),
(90, 90, 'Current', 17493.59, 'Active'),
(91, 91, 'Wallet', 153006.47, 'Active'),
(92, 92, 'Wallet', 45524.58, 'Active'),
(93, 93, 'Current', 181746.62, 'Active'),
(94, 94, 'Wallet', 198011.24, 'Active'),
(95, 95, 'Wallet', 12515.95, 'Inactive'),
(96, 96, 'Savings', 189544.24, 'Active'),
(97, 97, 'Savings', 53296.90, 'Active'),
(98, 98, 'Savings', 35175.80, 'Active'),
(99, 99, 'Savings', 81999.26, 'Active'),
(100, 100, 'Current', 58606.23, 'Active'),
(101, 101, 'Wallet', 56902.32, 'Active'),
(102, 102, 'Savings', 137633.29, 'Inactive'),
(103, 103, 'Wallet', 118163.02, 'Active'),
(104, 104, 'Savings', 85315.22, 'Active'),
(105, 105, 'Wallet', 30223.39, 'Active'),
(106, 106, 'Savings', 14746.26, 'Active'),
(107, 107, 'Current', 119211.29, 'Active'),
(108, 108, 'Current', 88111.11, 'Active'),
(109, 109, 'Current', 140096.87, 'Inactive'),
(110, 110, 'Wallet', 108226.32, 'Active'),
(111, 111, 'Wallet', 8452.23, 'Active'),
(112, 112, 'Current', 120940.87, 'Active'),
(113, 113, 'Savings', 192401.26, 'Active'),
(114, 114, 'Wallet', 117631.02, 'Active'),
(115, 115, 'Wallet', 164373.54, 'Active'),
(116, 116, 'Savings', 94364.91, 'Active'),
(117, 117, 'Current', 36707.08, 'Active'),
(118, 118, 'Wallet', 162941.87, 'Inactive'),
(119, 119, 'Current', 69918.23, 'Active'),
(120, 120, 'Wallet', 21367.68, 'Active'),
(121, 121, 'Current', 138887.90, 'Active'),
(122, 122, 'Current', 162806.42, 'Active'),
(123, 123, 'Current', 18067.93, 'Active'),
(124, 124, 'Savings', 194051.85, 'Active'),
(125, 125, 'Wallet', 165072.98, 'Active'),
(126, 126, 'Wallet', 92664.28, 'Active'),
(127, 127, 'Wallet', 72674.98, 'Active'),
(128, 128, 'Wallet', 88687.17, 'Active'),
(129, 129, 'Current', 110069.32, 'Inactive'),
(130, 130, 'Current', 176228.90, 'Active'),
(131, 131, 'Savings', 194642.79, 'Active'),
(132, 132, 'Savings', 142101.67, 'Active'),
(133, 133, 'Savings', 110674.16, 'Active'),
(134, 134, 'Savings', 92558.85, 'Active'),
(135, 135, 'Savings', 99925.91, 'Active'),
(136, 136, 'Wallet', 141229.62, 'Active'),
(137, 137, 'Current', 196058.80, 'Active'),
(138, 138, 'Wallet', 29356.07, 'Active'),
(139, 139, 'Wallet', 101894.06, 'Active'),
(140, 140, 'Savings', 55611.36, 'Active'),
(141, 141, 'Current', 68305.11, 'Active'),
(142, 142, 'Current', 164199.62, 'Active'),
(143, 143, 'Current', 167576.45, 'Active'),
(144, 144, 'Wallet', 98183.25, 'Active'),
(145, 145, 'Wallet', 97126.11, 'Active'),
(146, 146, 'Wallet', 75753.41, 'Inactive'),
(147, 147, 'Savings', 196164.54, 'Active'),
(148, 148, 'Current', 47095.71, 'Active'),
(149, 149, 'Savings', 63976.18, 'Active'),
(150, 150, 'Current', 77522.71, 'Active');


-- INSERT MERCHANT DATA

INSERT INTO Merchants (MerchantID, MerchantName, Category, City) VALUES
(1, 'UrbanCloset', 'Shopping', 'Mumbai'),
(2, 'ShopEasy', 'Shopping', 'Ahmedabad'),
(3, 'City Hospital', 'Healthcare', 'Chennai'),
(4, 'BiteExpress', 'Food', 'Chennai'),
(5, 'DailyBasket', 'Grocery', 'Hyderabad'),
(6, 'FashionHub', 'Shopping', 'Chennai'),
(7, 'YatraPlus', 'Travel', 'Ahmedabad'),
(8, 'BookPoint', 'Education', 'Delhi'),
(9, 'EduMart', 'Education', 'Chennai'),
(10, 'Farm2Home', 'Grocery', 'Pune'),
(11, 'ElectroMart', 'Electronics', 'Ratnagiri'),
(12, 'FoodieHub', 'Food', 'Pune'),
(13, 'FoodieHub 23', 'Food', 'Bengaluru'),
(14, 'FreshMart', 'Grocery', 'Delhi'),
(15, 'GreenGrocer', 'Grocery', 'Delhi'),
(16, 'HealthFirst', 'Healthcare', 'Nashik'),
(17, 'ByteShop', 'Electronics', 'Hyderabad'),
(18, 'StyleBazaar', 'Shopping', 'Nashik'),
(19, 'BiteExpress 50', 'Food', 'Ahmedabad'),
(20, 'CircuitStore', 'Electronics', 'Ahmedabad'),
(21, 'StyleBazaar 61', 'Shopping', 'Bengaluru'),
(22, 'PlayArena', 'Entertainment', 'Mumbai'),
(23, 'PlayArena 88', 'Entertainment', 'Kolkata'),
(24, 'FashionHub 58', 'Shopping', 'Delhi'),
(25, 'VoyageIndia', 'Travel', 'Bengaluru'),
(26, 'PlayArena 27', 'Entertainment', 'Hyderabad'),
(27, 'MovieMax', 'Entertainment', 'Ratnagiri'),
(28, 'KnowledgeBase', 'Education', 'Delhi'),
(29, 'YatraPlus 4', 'Travel', 'Hyderabad'),
(30, 'TravelGo', 'Travel', 'Ahmedabad'),
(31, 'Farm2Home 97', 'Grocery', 'Chennai'),
(32, 'TripEasy', 'Travel', 'Ahmedabad'),
(33, 'CareClinic', 'Healthcare', 'Ratnagiri'),
(34, 'TripEasy 82', 'Travel', 'Pune'),
(35, 'GreenGrocer 58', 'Grocery', 'Mumbai'),
(36, 'CareClinic 13', 'Healthcare', 'Bengaluru'),
(37, 'HealthFirst 24', 'Healthcare', 'Ratnagiri'),
(38, 'ShopEasy 48', 'Shopping', 'Kolkata'),
(39, 'TripEasy 34', 'Travel', 'Chennai'),
(40, 'YatraPlus 16', 'Travel', 'Chennai'),
(41, 'TastyTreat', 'Food', 'Ratnagiri'),
(42, 'KnowledgeBase 48', 'Education', 'Pune'),
(43, 'BookPoint 35', 'Education', 'Kolkata'),
(44, 'FoodieHub 49', 'Food', 'Bengaluru'),
(45, 'EduMart 15', 'Education', 'Ratnagiri'),
(46, 'MovieMax 81', 'Entertainment', 'Kolkata'),
(47, 'WellnessCare', 'Healthcare', 'Ratnagiri'),
(48, 'FoodieHub 91', 'Food', 'Bengaluru'),
(49, 'BookPoint 19', 'Education', 'Mumbai'),
(50, 'GreenGrocer 65', 'Grocery', 'Pune'),
(51, 'TastyTreat 70', 'Food', 'Nashik'),
(52, 'StudyCorner', 'Education', 'Delhi'),
(53, 'KnowledgeBase 97', 'Education', 'Nashik'),
(54, 'BookPoint 64', 'Education', 'Ahmedabad'),
(55, 'EduMart 6', 'Education', 'Delhi'),
(56, 'CircuitStore 58', 'Electronics', 'Ratnagiri'),
(57, 'City Hospital 89', 'Healthcare', 'Delhi'),
(58, 'City Hospital 52', 'Healthcare', 'Bengaluru'),
(59, 'TechWorld', 'Electronics', 'Chennai'),
(60, 'TastyTreat 84', 'Food', 'Ahmedabad'),
(61, 'FreshMart 44', 'Grocery', 'Ratnagiri'),
(62, 'ShopEasy 28', 'Shopping', 'Pune'),
(63, 'ByteShop 29', 'Electronics', 'Ratnagiri'),
(64, 'CareClinic 78', 'Healthcare', 'Mumbai'),
(65, 'TripEasy 18', 'Travel', 'Kolkata'),
(66, 'TripEasy 16', 'Travel', 'Mumbai'),
(67, 'FashionHub 47', 'Shopping', 'Ratnagiri'),
(68, 'City Hospital 24', 'Healthcare', 'Bengaluru'),
(69, 'DailyBasket 96', 'Grocery', 'Hyderabad'),
(70, 'QuickBite', 'Food', 'Chennai'),
(71, 'PlayArena 67', 'Entertainment', 'Ahmedabad'),
(72, 'FoodieHub 66', 'Food', 'Ratnagiri'),
(73, 'Farm2Home 40', 'Grocery', 'Chennai'),
(74, 'FreshMart 63', 'Grocery', 'Hyderabad'),
(75, 'BookPoint 64', 'Education', 'Chennai'),
(76, 'QuickBite 43', 'Food', 'Ahmedabad'),
(77, 'FashionHub 18', 'Shopping', 'Bengaluru'),
(78, 'HealthFirst 78', 'Healthcare', 'Kolkata'),
(79, 'VoyageIndia 66', 'Travel', 'Ahmedabad'),
(80, 'BookPoint 91', 'Education', 'Pune'),
(81, 'CircuitStore 59', 'Electronics', 'Ratnagiri'),
(82, 'EduMart 60', 'Education', 'Hyderabad'),
(83, 'BookPoint 42', 'Education', 'Hyderabad'),
(84, 'MedPlus Store', 'Healthcare', 'Delhi'),
(85, 'UrbanCloset 10', 'Shopping', 'Pune'),
(86, 'QuickBite 57', 'Food', 'Pune'),
(87, 'CareClinic 73', 'Healthcare', 'Mumbai'),
(88, 'City Hospital 54', 'Healthcare', 'Delhi'),
(89, 'BookPoint 38', 'Education', 'Ahmedabad'),
(90, 'YatraPlus 15', 'Travel', 'Ahmedabad'),
(91, 'GadgetZone', 'Electronics', 'Chennai'),
(92, 'TechWorld 46', 'Electronics', 'Kolkata'),
(93, 'City Hospital 99', 'Healthcare', 'Bengaluru'),
(94, 'CircuitStore 73', 'Electronics', 'Ahmedabad'),
(95, 'Farm2Home 86', 'Grocery', 'Bengaluru'),
(96, 'DailyBasket 36', 'Grocery', 'Bengaluru'),
(97, 'MedPlus Store 2', 'Healthcare', 'Nashik'),
(98, 'ShopEasy 86', 'Shopping', 'Hyderabad'),
(99, 'TastyTreat 96', 'Food', 'Mumbai'),
(100, 'BiteExpress 29', 'Food', 'Hyderabad'),
(101, 'StudyCorner 45', 'Education', 'Nashik'),
(102, 'MedPlus Store 94', 'Healthcare', 'Delhi'),
(103, 'QuickBite 21', 'Food', 'Nashik'),
(104, 'FreshMart 36', 'Grocery', 'Chennai'),
(105, 'StudyCorner 79', 'Education', 'Chennai'),
(106, 'EduMart 29', 'Education', 'Kolkata'),
(107, 'SpiceKitchen', 'Food', 'Hyderabad'),
(108, 'SpiceKitchen 88', 'Food', 'Ahmedabad'),
(109, 'GameHub', 'Entertainment', 'Bengaluru'),
(110, 'DailyBasket 52', 'Grocery', 'Ahmedabad'),
(111, 'FreshMart 28', 'Grocery', 'Bengaluru'),
(112, 'GadgetZone 99', 'Electronics', 'Bengaluru'),
(113, 'YatraPlus 17', 'Travel', 'Mumbai'),
(114, 'StreamTime', 'Entertainment', 'Nashik'),
(115, 'UrbanCloset 70', 'Shopping', 'Ratnagiri'),
(116, 'City Hospital 52', 'Healthcare', 'Mumbai'),
(117, 'BookPoint 60', 'Education', 'Pune'),
(118, 'WellnessCare 56', 'Healthcare', 'Ahmedabad'),
(119, 'StudyCorner 39', 'Education', 'Pune'),
(120, 'BookPoint 43', 'Education', 'Nashik'),
(121, 'PlayArena 13', 'Entertainment', 'Hyderabad'),
(122, 'TastyTreat 57', 'Food', 'Ahmedabad'),
(123, 'KnowledgeBase 12', 'Education', 'Hyderabad'),
(124, 'YatraPlus 30', 'Travel', 'Delhi'),
(125, 'FashionHub 67', 'Shopping', 'Pune'),
(126, 'ElectroMart 46', 'Electronics', 'Nashik'),
(127, 'TechWorld 20', 'Electronics', 'Bengaluru'),
(128, 'GadgetZone 79', 'Electronics', 'Nashik'),
(129, 'TastyTreat 82', 'Food', 'Chennai'),
(130, 'GameHub 99', 'Entertainment', 'Ahmedabad'),
(131, 'GameHub 84', 'Entertainment', 'Ahmedabad'),
(132, 'MedPlus Store 21', 'Healthcare', 'Chennai'),
(133, 'FoodieHub 58', 'Food', 'Bengaluru'),
(134, 'JourneyMart', 'Travel', 'Mumbai'),
(135, 'WellnessCare 11', 'Healthcare', 'Bengaluru'),
(136, 'StreamTime 6', 'Entertainment', 'Mumbai'),
(137, 'MedPlus Store 11', 'Healthcare', 'Pune'),
(138, 'StudyCorner 76', 'Education', 'Kolkata'),
(139, 'BigBazaar Mart', 'Grocery', 'Ahmedabad'),
(140, 'ElectroMart 79', 'Electronics', 'Chennai'),
(141, 'FashionHub 59', 'Shopping', 'Pune'),
(142, 'City Hospital 66', 'Healthcare', 'Nashik'),
(143, 'DailyBasket 92', 'Grocery', 'Chennai'),
(144, 'GameHub 68', 'Entertainment', 'Ahmedabad'),
(145, 'TrendMart', 'Shopping', 'Delhi'),
(146, 'VoyageIndia 54', 'Travel', 'Delhi'),
(147, 'GreenGrocer 10', 'Grocery', 'Delhi'),
(148, 'BiteExpress 88', 'Food', 'Hyderabad'),
(149, 'YatraPlus 94', 'Travel', 'Ahmedabad'),
(150, 'TrendMart 12', 'Shopping', 'Ahmedabad');


-- INSERT PAYMENT METHOD DATA

INSERT INTO PaymentMethods (PaymentMethodID, PaymentMethodName, Provider, PaymentType, Status) VALUES
(1, 'Credit Card', 'SBI', 'Card', 'Active'),
(2, 'Net Banking', 'Paytm', 'NetBanking', 'Active'),
(3, 'UPI', 'ICICI Bank', 'UPI', 'Active'),
(4, 'Debit Card', 'Paytm', 'Card', 'Active'),
(5, 'Wallet', 'PhonePe', 'Wallet', 'Active'),
(6, 'Net Banking', 'Amazon Pay', 'NetBanking', 'Active'),
(7, 'Debit Card', 'ICICI Bank', 'Card', 'Active'),
(8, 'Credit Card', 'SBI', 'Card', 'Inactive'),
(9, 'Net Banking', 'HDFC Bank', 'NetBanking', 'Active'),
(10, 'Credit Card', 'Paytm', 'Card', 'Active'),
(11, 'UPI', 'Amazon Pay', 'UPI', 'Active'),
(12, 'Wallet', 'Google Pay', 'Wallet', 'Active'),
(13, 'Wallet', 'Paytm', 'Wallet', 'Active'),
(14, 'Credit Card', 'Paytm', 'Card', 'Active'),
(15, 'Wallet', 'Paytm', 'Wallet', 'Active'),
(16, 'UPI', 'Axis Bank', 'UPI', 'Active'),
(17, 'Credit Card', 'Kotak Mahindra', 'Card', 'Active'),
(18, 'Net Banking', 'HDFC Bank', 'NetBanking', 'Active'),
(19, 'Debit Card', 'Kotak Mahindra', 'Card', 'Inactive'),
(20, 'Credit Card', 'SBI', 'Card', 'Active'),
(21, 'Wallet', 'Kotak Mahindra', 'Wallet', 'Active'),
(22, 'Debit Card', 'Axis Bank', 'Card', 'Active'),
(23, 'Net Banking', 'Paytm', 'NetBanking', 'Active'),
(24, 'Wallet', 'Paytm', 'Wallet', 'Active'),
(25, 'UPI', 'Kotak Mahindra', 'UPI', 'Active'),
(26, 'Wallet', 'PhonePe', 'Wallet', 'Active'),
(27, 'Wallet', 'PhonePe', 'Wallet', 'Active'),
(28, 'Credit Card', 'ICICI Bank', 'Card', 'Active'),
(29, 'Wallet', 'Paytm', 'Wallet', 'Active'),
(30, 'UPI', 'HDFC Bank', 'UPI', 'Active');


-- INSERT TRANSACTION DATA

INSERT INTO Transactions (TransactionID, CustomerID, AccountID, MerchantID, PaymentMethodID, TransactionDate, Amount, TransactionType, Status) VALUES
(1, 90, 90, 7, 14, '2025-02-24', 39705.75, 'Payment', 'Success'),
(2, 21, 21, 96, 8, '2025-01-29', 31936.62, 'Payment', 'Success'),
(3, 86, 86, 38, 5, '2025-02-09', 28759.25, 'Payment', 'Success'),
(4, 36, 36, 121, 15, '2025-01-06', 90595.16, 'Payment', 'Success'),
(5, 39, 39, 141, 24, '2026-06-25', 42383.15, 'Payment', 'Success'),
(6, 32, 32, 13, 8, '2026-03-06', 63931.28, 'Payment', 'Success'),
(7, 128, 128, 138, 1, '2026-06-12', 57547.24, 'Payment', 'Success'),
(8, 1, 1, 91, 8, '2026-03-03', 18812.66, 'Payment', 'Success'),
(9, 93, 93, 18, 17, '2026-07-12', 50782.04, 'Transfer', 'Success'),
(10, 100, 100, 121, 2, '2026-02-01', 98105.84, 'Payment', 'Success'),
(11, 18, 18, 89, 8, '2025-04-17', 77172.99, 'Payment', 'Success'),
(12, 12, 12, 91, 18, '2025-12-13', 81369.54, 'Payment', 'Success'),
(13, 119, 119, 123, 21, '2025-07-06', 81168.62, 'Payment', 'Success'),
(14, 118, 118, 10, 10, '2025-07-26', 4476.25, 'Payment', 'Success'),
(15, 80, 80, 132, 13, '2026-07-11', 47392.64, 'Payment', 'Success'),
(16, 74, 74, 92, 28, '2025-02-18', 86593.25, 'Payment', 'Success'),
(17, 95, 95, 112, 29, '2026-02-14', 74356.44, 'Transfer', 'Success'),
(18, 48, 48, 128, 23, '2026-05-25', 36797.96, 'Payment', 'Success'),
(19, 22, 22, 109, 3, '2026-03-17', 60285.08, 'Payment', 'Success'),
(20, 83, 83, 27, 3, '2025-12-02', 66125.83, 'Payment', 'Success'),
(21, 110, 110, 43, 23, '2026-03-31', 35219.54, 'Payment', 'Failed'),
(22, 91, 91, 112, 9, '2025-02-28', 7596.61, 'Payment', 'Success'),
(23, 41, 41, 8, 5, '2026-03-25', 3576.42, 'Payment', 'Success'),
(24, 94, 94, 93, 13, '2025-02-03', 60548.97, 'Payment', 'Pending'),
(25, 96, 96, 114, 25, '2025-03-20', 57434.79, 'Payment', 'Success'),
(26, 72, 72, 64, 4, '2025-01-27', 73593.92, 'Payment', 'Success'),
(27, 144, 144, 31, 9, '2025-09-24', 70433.38, 'Payment', 'Success'),
(28, 126, 126, 52, 4, '2025-05-19', 85297.35, 'Payment', 'Failed'),
(29, 114, 114, 23, 26, '2025-11-24', 66817.20, 'Payment', 'Success'),
(30, 75, 75, 77, 28, '2025-06-11', 71209.73, 'Transfer', 'Success'),
(31, 93, 93, 131, 8, '2025-05-05', 98514.74, 'Payment', 'Success'),
(32, 127, 127, 7, 12, '2026-07-22', 57270.51, 'Payment', 'Pending'),
(33, 34, 34, 23, 3, '2025-11-13', 39876.18, 'Payment', 'Success'),
(34, 106, 106, 105, 27, '2025-03-17', 12620.15, 'Payment', 'Success'),
(35, 120, 120, 133, 12, '2025-05-12', 87808.22, 'Payment', 'Success'),
(36, 47, 47, 34, 14, '2026-05-30', 91080.16, 'Payment', 'Success'),
(37, 40, 40, 78, 6, '2025-06-15', 32333.81, 'Payment', 'Success'),
(38, 133, 133, 73, 28, '2025-03-22', 25135.47, 'Payment', 'Success'),
(39, 33, 33, 78, 20, '2026-07-01', 9433.50, 'Payment', 'Success'),
(40, 149, 149, 40, 6, '2025-12-12', 84268.75, 'Payment', 'Failed'),
(41, 8, 8, 21, 2, '2025-09-29', 65147.88, 'Payment', 'Success'),
(42, 8, 8, 128, 29, '2026-07-13', 29038.20, 'Transfer', 'Success'),
(43, 104, 104, 77, 15, '2025-03-16', 68892.50, 'Payment', 'Success'),
(44, 119, 119, 53, 11, '2025-05-28', 31326.99, 'Payment', 'Success'),
(45, 89, 89, 103, 5, '2026-01-15', 51546.52, 'Payment', 'Success'),
(46, 32, 32, 69, 15, '2025-09-11', 14173.68, 'Payment', 'Pending'),
(47, 108, 108, 64, 28, '2025-06-13', 81366.44, 'Transfer', 'Success'),
(48, 49, 49, 41, 16, '2026-06-12', 46734.83, 'Transfer', 'Success'),
(49, 24, 24, 101, 17, '2026-04-14', 96671.99, 'Payment', 'Success'),
(50, 13, 13, 73, 16, '2026-04-27', 28646.26, 'Payment', 'Success'),
(51, 35, 35, 68, 24, '2026-01-10', 76409.29, 'Payment', 'Success'),
(52, 146, 146, 144, 7, '2026-01-07', 55366.97, 'Payment', 'Success'),
(53, 141, 141, 72, 27, '2025-05-02', 12953.47, 'Payment', 'Success'),
(54, 87, 87, 143, 12, '2025-05-28', 19985.88, 'Payment', 'Success'),
(55, 12, 12, 10, 5, '2025-12-08', 80416.19, 'Payment', 'Success'),
(56, 132, 132, 36, 11, '2025-11-23', 16333.95, 'Transfer', 'Success'),
(57, 77, 77, 87, 17, '2026-06-06', 53280.75, 'Payment', 'Success'),
(58, 5, 5, 95, 11, '2025-04-23', 97991.81, 'Payment', 'Success'),
(59, 7, 7, 122, 9, '2025-08-22', 72167.87, 'Payment', 'Success'),
(60, 98, 98, 38, 27, '2025-09-06', 3253.89, 'Transfer', 'Success'),
(61, 5, 5, 113, 11, '2026-03-05', 15227.98, 'Payment', 'Success'),
(62, 121, 121, 16, 23, '2025-05-22', 51916.45, 'Payment', 'Pending'),
(63, 123, 123, 135, 13, '2025-11-18', 95672.88, 'Payment', 'Success'),
(64, 140, 140, 91, 22, '2025-09-28', 61046.65, 'Payment', 'Success'),
(65, 143, 143, 77, 8, '2025-11-01', 77140.31, 'Payment', 'Success'),
(66, 126, 126, 82, 16, '2025-12-24', 56092.71, 'Transfer', 'Success'),
(67, 74, 74, 32, 19, '2026-07-11', 38031.45, 'Transfer', 'Failed'),
(68, 38, 38, 75, 2, '2025-10-22', 95535.84, 'Payment', 'Pending'),
(69, 66, 66, 123, 7, '2025-07-26', 82812.38, 'Payment', 'Success'),
(70, 70, 70, 36, 4, '2025-09-03', 24321.56, 'Payment', 'Success'),
(71, 60, 60, 14, 4, '2026-02-28', 33096.33, 'Payment', 'Success'),
(72, 36, 36, 2, 18, '2025-06-11', 40750.05, 'Transfer', 'Failed'),
(73, 123, 123, 52, 25, '2025-10-22', 32184.65, 'Payment', 'Failed'),
(74, 23, 23, 147, 8, '2026-07-02', 73894.78, 'Transfer', 'Success'),
(75, 45, 45, 107, 29, '2025-06-30', 93398.87, 'Payment', 'Failed'),
(76, 127, 127, 48, 30, '2025-10-24', 87686.64, 'Payment', 'Success'),
(77, 28, 28, 86, 10, '2026-04-11', 98911.04, 'Payment', 'Success'),
(78, 35, 35, 130, 15, '2025-10-07', 19361.86, 'Payment', 'Success'),
(79, 118, 118, 66, 23, '2025-07-10', 1507.01, 'Payment', 'Success'),
(80, 50, 50, 45, 20, '2026-02-20', 82716.28, 'Payment', 'Success'),
(81, 25, 25, 48, 5, '2026-05-04', 32427.81, 'Payment', 'Success'),
(82, 61, 61, 115, 25, '2025-10-01', 95408.08, 'Payment', 'Success'),
(83, 3, 3, 67, 21, '2026-01-04', 69307.58, 'Payment', 'Success'),
(84, 79, 79, 41, 13, '2026-05-30', 92318.29, 'Transfer', 'Success'),
(85, 31, 31, 76, 12, '2025-08-15', 21990.95, 'Payment', 'Success'),
(86, 96, 96, 107, 23, '2026-07-17', 91288.41, 'Payment', 'Failed'),
(87, 56, 56, 64, 22, '2025-03-25', 52598.11, 'Payment', 'Success'),
(88, 145, 145, 29, 2, '2026-07-15', 90298.53, 'Payment', 'Success'),
(89, 43, 43, 84, 28, '2026-06-17', 44239.87, 'Payment', 'Success'),
(90, 126, 126, 24, 29, '2026-06-07', 44603.72, 'Payment', 'Success'),
(91, 107, 107, 117, 19, '2025-03-01', 55923.84, 'Payment', 'Success'),
(92, 6, 6, 102, 9, '2025-01-04', 74605.87, 'Payment', 'Success'),
(93, 89, 89, 17, 18, '2025-03-03', 93464.82, 'Payment', 'Pending'),
(94, 9, 9, 74, 14, '2025-07-04', 76920.31, 'Payment', 'Pending'),
(95, 108, 108, 96, 29, '2026-01-27', 44908.86, 'Transfer', 'Success'),
(96, 21, 21, 139, 5, '2025-12-23', 11951.45, 'Transfer', 'Success'),
(97, 33, 33, 58, 27, '2025-01-04', 75642.32, 'Transfer', 'Success'),
(98, 140, 140, 109, 18, '2026-01-24', 82353.71, 'Payment', 'Success'),
(99, 71, 71, 49, 30, '2025-04-26', 3318.51, 'Payment', 'Success'),
(100, 5, 5, 62, 7, '2025-03-10', 10179.58, 'Payment', 'Success'),
(101, 13, 13, 63, 24, '2025-02-15', 40286.31, 'Payment', 'Success'),
(102, 15, 15, 36, 17, '2025-10-24', 23492.74, 'Transfer', 'Success'),
(103, 148, 148, 83, 8, '2025-11-06', 87638.21, 'Transfer', 'Success'),
(104, 106, 106, 77, 9, '2025-03-04', 55716.14, 'Payment', 'Success'),
(105, 45, 45, 110, 18, '2026-05-23', 4783.72, 'Payment', 'Success'),
(106, 98, 98, 135, 11, '2026-03-03', 40885.09, 'Payment', 'Success'),
(107, 138, 138, 122, 8, '2025-08-19', 30143.57, 'Payment', 'Failed'),
(108, 15, 15, 144, 14, '2026-03-03', 55772.95, 'Payment', 'Success'),
(109, 53, 53, 85, 21, '2025-03-22', 92230.39, 'Payment', 'Success'),
(110, 49, 49, 14, 9, '2026-01-22', 67399.82, 'Payment', 'Failed'),
(111, 49, 49, 144, 7, '2026-05-06', 20968.02, 'Transfer', 'Success'),
(112, 4, 4, 55, 30, '2025-07-14', 96211.55, 'Payment', 'Pending'),
(113, 123, 123, 63, 23, '2025-07-29', 39723.54, 'Payment', 'Success'),
(114, 73, 73, 98, 15, '2026-07-01', 64907.26, 'Payment', 'Success'),
(115, 128, 128, 120, 4, '2026-04-26', 76186.73, 'Payment', 'Success'),
(116, 81, 81, 106, 2, '2026-07-31', 86422.08, 'Payment', 'Success'),
(117, 142, 142, 150, 19, '2026-03-04', 29589.71, 'Payment', 'Success'),
(118, 146, 146, 63, 16, '2026-07-18', 65495.34, 'Payment', 'Success'),
(119, 126, 126, 126, 15, '2025-06-22', 73303.95, 'Payment', 'Success'),
(120, 140, 140, 126, 6, '2026-07-10', 99033.32, 'Transfer', 'Success'),
(121, 20, 20, 13, 25, '2025-01-07', 41297.98, 'Payment', 'Success'),
(122, 39, 39, 3, 7, '2026-06-02', 45655.36, 'Payment', 'Success'),
(123, 124, 124, 125, 1, '2025-01-07', 53268.03, 'Payment', 'Success'),
(124, 71, 71, 138, 10, '2025-01-18', 50271.38, 'Payment', 'Success'),
(125, 46, 46, 28, 30, '2025-04-09', 52486.10, 'Payment', 'Success'),
(126, 65, 65, 91, 9, '2026-02-11', 7994.02, 'Transfer', 'Success'),
(127, 63, 63, 58, 10, '2025-03-24', 65408.20, 'Transfer', 'Success'),
(128, 24, 24, 104, 13, '2026-01-22', 55314.87, 'Payment', 'Success'),
(129, 44, 44, 22, 16, '2026-03-21', 64526.23, 'Payment', 'Pending'),
(130, 25, 25, 136, 30, '2025-02-13', 23053.67, 'Transfer', 'Success'),
(131, 146, 146, 122, 9, '2025-02-17', 92423.51, 'Payment', 'Success'),
(132, 140, 140, 145, 22, '2025-02-03', 18017.51, 'Transfer', 'Success'),
(133, 54, 54, 37, 25, '2026-02-12', 92894.61, 'Payment', 'Success'),
(134, 146, 146, 100, 22, '2026-07-08', 33239.81, 'Payment', 'Success'),
(135, 21, 21, 129, 24, '2025-12-21', 5464.27, 'Payment', 'Failed'),
(136, 88, 88, 102, 25, '2025-12-01', 3059.60, 'Payment', 'Pending'),
(137, 126, 126, 59, 12, '2026-07-21', 94120.17, 'Payment', 'Success'),
(138, 98, 98, 22, 25, '2025-10-30', 79825.71, 'Payment', 'Success'),
(139, 40, 40, 98, 23, '2025-06-07', 73991.56, 'Payment', 'Success'),
(140, 2, 2, 79, 15, '2026-01-04', 76158.51, 'Payment', 'Success'),
(141, 111, 111, 115, 18, '2026-07-23', 51292.84, 'Payment', 'Success'),
(142, 142, 142, 24, 20, '2025-11-29', 86385.45, 'Payment', 'Success'),
(143, 22, 22, 144, 29, '2025-09-06', 57238.85, 'Payment', 'Success'),
(144, 36, 36, 69, 10, '2025-10-02', 49363.08, 'Payment', 'Success'),
(145, 108, 108, 77, 16, '2025-03-20', 36176.38, 'Transfer', 'Success'),
(146, 127, 127, 51, 15, '2025-04-20', 13635.40, 'Payment', 'Success'),
(147, 98, 98, 85, 15, '2025-12-09', 43118.56, 'Payment', 'Success'),
(148, 35, 35, 77, 11, '2025-07-25', 47953.07, 'Payment', 'Success'),
(149, 82, 82, 75, 24, '2026-05-18', 96779.53, 'Payment', 'Success'),
(150, 72, 72, 101, 12, '2025-04-27', 93213.51, 'Payment', 'Pending');


-- INSERT REFUND DATA

INSERT INTO Refunds (RefundID, TransactionID, RefundDate, RefundAmount, RefundReason, RefundStatus) VALUES
(1, 142, '2025-12-11', 44148.89, 'Duplicate Payment', 'Completed'),
(2, 15, '2026-07-24', 38002.28, 'Product Returned', 'Completed'),
(3, 98, '2026-02-02', 69144.33, 'Duplicate Payment', 'Completed'),
(4, 48, '2026-06-14', 16715.15, 'Cancelled Order', 'Pending'),
(5, 92, '2025-01-15', 44135.88, 'Cancelled Order', 'Completed'),
(6, 45, '2026-01-25', 35517.96, 'Product Returned', 'Completed'),
(7, 12, '2025-12-23', 71313.42, 'Duplicate Payment', 'Pending'),
(8, 16, '2025-02-23', 66225.71, 'Customer Request', 'Completed'),
(9, 42, '2026-07-19', 21421.13, 'Product Returned', 'Completed'),
(10, 3, '2025-02-15', 8442.54, 'Duplicate Payment', 'Completed'),
(11, 47, '2025-06-16', 43497.79, 'Customer Request', 'Completed'),
(12, 31, '2025-05-16', 34342.53, 'Customer Request', 'Pending'),
(13, 66, '2025-12-27', 40174.05, 'Customer Request', 'Completed'),
(14, 41, '2025-10-02', 28083.15, 'Cancelled Order', 'Pending'),
(15, 132, '2025-02-17', 12531.68, 'Cancelled Order', 'Rejected'),
(16, 27, '2025-09-28', 41392.79, 'Payment Error', 'Rejected'),
(17, 131, '2025-02-25', 55856.19, 'Payment Error', 'Pending'),
(18, 74, '2026-07-16', 39349.29, 'Payment Error', 'Completed'),
(19, 17, '2026-02-15', 19788.96, 'Duplicate Payment', 'Completed'),
(20, 99, '2025-05-05', 1393.38, 'Cancelled Order', 'Completed'),
(21, 54, '2025-06-09', 11309.15, 'Payment Error', 'Completed'),
(22, 141, '2026-07-25', 14904.10, 'Cancelled Order', 'Pending'),
(23, 114, '2026-07-07', 55731.08, 'Customer Request', 'Pending'),
(24, 84, '2026-06-11', 21536.79, 'Payment Error', 'Completed'),
(25, 96, '2025-12-25', 11853.69, 'Duplicate Payment', 'Completed'),
(26, 1, '2025-03-04', 39683.92, 'Cancelled Order', 'Completed'),
(27, 145, '2025-03-28', 30872.30, 'Product Returned', 'Pending'),
(28, 124, '2025-01-31', 19583.56, 'Customer Request', 'Pending'),
(29, 116, '2026-08-10', 76815.31, 'Payment Error', 'Completed'),
(30, 126, '2026-02-15', 2489.24, 'Duplicate Payment', 'Pending');


-- VERIFY TABLE STRUCTURE

DESCRIBE Customers;
DESCRIBE Accounts;
DESCRIBE Merchants;
DESCRIBE PaymentMethods;
DESCRIBE Transactions;
DESCRIBE Refunds;


-- VERIFY DATA -- VIEW ALL RECORDS

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Merchants;
SELECT * FROM PaymentMethods;
SELECT * FROM Transactions;
SELECT * FROM Refunds;


-- Display all successful transactions

SELECT *
FROM Transactions
WHERE Status = 'Success';


-- Filter transactions within a specific amount range.

SELECT TransactionID, Amount, Status
FROM Transactions
WHERE Amount BETWEEN 1000 AND 10000
ORDER BY Amount DESC;


-- Search customers based on a name pattern.

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE FirstName LIKE 'A%';


-- Display the 5 highest-value transactions

SELECT TransactionID, Amount, Status, TransactionDate
FROM Transactions
ORDER BY Amount DESC
LIMIT 5;


-- Display all different transaction statuses

SELECT DISTINCT Status
FROM Transactions;


-- Display the 10 most recent transactions

SELECT TransactionID, TransactionDate, Amount, Status
FROM Transactions
ORDER BY TransactionDate DESC
LIMIT 10;


-- Find the total number of transactions

SELECT COUNT(*) AS total_transactions
FROM Transactions;


-- Find the total successful payment amount

SELECT SUM(Amount) AS total_successful_amount
FROM Transactions
WHERE Status = 'Success';

-- Rank transactions from highest amount to lowest amount.

SELECT TransactionID, Amount,
RANK() OVER (ORDER BY Amount DESC) AS TransactionRank
FROM Transactions;

-- Find the number of transactions for each payment method

SELECT pm.PaymentMethodName, COUNT(*) AS tra_count
FROM Transactions t
JOIN PaymentMethods pm 
ON pm.PaymentMethodID = t.PaymentMethodID
GROUP BY pm.PaymentMethodName
ORDER BY tra_count DESC;


-- Find the total amount for each transaction status

SELECT Status, SUM(Amount) AS total_amount
FROM Transactions
GROUP BY Status;


-- Find the total amount spent by each customer

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(t.Amount) AS total_spent
FROM Customers c
JOIN Transactions t 
ON t.CustomerID = c.CustomerID
WHERE t.Status = 'Success'
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY total_spent DESC;


-- Find customers who have made more than 3 transactions

SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(*) AS txn_count
FROM Customers c
JOIN Transactions t 
ON t.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(*) > 3;


-- Find the average transaction amount for each payment method

SELECT pm.PaymentMethodName, AVG(t.Amount) AS avg_amount
FROM PaymentMethods pm
JOIN Transactions t 
ON t.PaymentMethodID = pm.PaymentMethodID
GROUP BY pm.PaymentMethodName
ORDER BY avg_amount DESC;


-- Display all transaction details along with only refund amount and refund status details

SELECT t.TransactionID, t.TransactionDate, t.Amount,
       r.RefundAmount, r.RefundStatus
FROM Transactions t
LEFT JOIN Refunds r 
ON r.TransactionID = t.TransactionID
order by RefundAmount desc;


-- Find the total refund amount for each refund status

SELECT RefundStatus, SUM(RefundAmount) AS total_refund_amount
FROM Refunds
GROUP BY RefundStatus;


-- Find the customer who has spent the highest total successful transaction amount

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(t.Amount) AS total_spent
FROM Customers c
JOIN Transactions t 
ON t.CustomerID = c.CustomerID
WHERE t.Status = 'Success'
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY total_spent DESC
LIMIT 1;


-- Accounts having balance higher than average balance
-- Subquery

select AccountID, AccountType, balance 
from accounts
where balance > (
select avg(Balance) 
from accounts
);


-- select merchant located in mumbai

create or replace view Merchant_From_Mumbai as
select merchantid, merchantname 
from merchants
where city = 'Mumbai';

select * from Merchant_From_Mumbai;




select c.firstname, c.lastname, t.transactiondate 
from customers c
inner join transactions t
on c.CustomerID = t.customerid;



