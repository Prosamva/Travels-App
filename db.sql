# Database

CREATE DATABASE TRAVELS_COMPANY;
USE TRAVELS_COMPANY;

# Tables

CREATE TABLE Bus
(
    id          INT PRIMARY KEY,
    chair_count INT         NOT NULL,
    ac          BOOL        NOT NULL,
    automatic   BOOL        NOT NULL,
    ps          INT         NOT NULL,
    brand       VARCHAR(30) NOT NULL
);

CREATE TABLE Driver
(
    id           INT PRIMARY KEY,
    name         VARCHAR(30) NOT NULL,
    mobile_no    BIGINT(10),
    hire_date    DATE        NOT NULL,
    basic_salary INT         NOT NULL,
    job_grade    CHAR(1)     NOT NULL
);

CREATE TABLE Town
(
    name  VARCHAR(30) PRIMARY KEY,
    state VARCHAR(30) NOT NULL
);

CREATE TABLE Station
(
    station_id   INT PRIMARY KEY,
    name         VARCHAR(30) NOT NULL,
    town_located VARCHAR(30) NOT NULL,
    FOREIGN KEY (town_located) REFERENCES Town (name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Route
(
    route_no    INT PRIMARY KEY,
    distance    FLOAT(2) NOT NULL,
    start_point INT      NOT NULL,
    end_point   INT      NOT NULL,
    duration    TIME     NOT NULL,
    FOREIGN KEY (start_point) REFERENCES Station (station_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (end_point) REFERENCES Station (station_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE InterRouteTowns
(
    in_route_no INT,
    inter_town  VARCHAR(30),
    FOREIGN KEY (in_route_no) REFERENCES Route (route_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (inter_town) REFERENCES Town (name) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (in_route_no, inter_town)
);

CREATE TABLE BusAllocation
(
    bus_id     INT PRIMARY KEY,
    route_no   INT DEFAULT NULL,
    start_time TIME,
    end_time   TIME,
    FOREIGN KEY (bus_id) REFERENCES Bus (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (route_no) REFERENCES Route (route_no) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE DriverAllocation
(
    driver_id     INT PRIMARY KEY,
    bus_id        INT DEFAULT NULL,
    last_route_id INT DEFAULT NULL,
    FOREIGN KEY (driver_id) REFERENCES Driver (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bus_id) REFERENCES Bus (id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (last_route_id) REFERENCES Route (route_no) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Customer
(
    face_id  VARCHAR(36) PRIMARY KEY,
    email    VARCHAR(30) NOT NULL,
    name     VARCHAR(30) NOT NULL,
    phone    VARCHAR(10) NOT NULL
);

CREATE TABLE Registrations
(
    face_id VARCHAR(36),
    bus_id INT,
    PRIMARY KEY (face_id, bus_id),
    FOREIGN KEY (face_id) REFERENCES Customer(face_id),
    FOREIGN KEY (bus_id) REFERENCES Bus(id)
);

# Triggers

CREATE TRIGGER trig_driver_rec_insert
    AFTER INSERT
    ON Driver
    FOR EACH ROW INSERT INTO DriverAllocation(driver_id) VALUE (NEW.id);

CREATE TRIGGER trig_allocation_rec_insert
    AFTER INSERT
    ON Bus
    FOR EACH ROW INSERT INTO BusAllocation(bus_id) VALUE (NEW.id);

# Insert data

INSERT INTO Bus
VALUES (384, 35, TRUE, FALSE, 316, 'Mahindra Comfio'),
       (770, 50, TRUE, FALSE, 400, 'BharatBenz'),
       (642, 25, FALSE, TRUE, 260, 'MAN SE'),
       (901, 25, FALSE, TRUE, 260, 'SML Isuzu'),
       (521, 30, FALSE, TRUE, 288, 'JCBL'),
       (268, 40, TRUE, FALSE, 344, 'Eicher Skyline'),
       (910, 35, TRUE, FALSE, 316, 'Tata Marcopolo'),
       (784, 50, FALSE, TRUE, 400, 'SML Isuzu'),
       (401, 45, TRUE, FALSE, 372, 'Scania'),
       (786, 40, FALSE, TRUE, 344, 'SML Isuzu'),
       (659, 35, TRUE, TRUE, 316, 'Tata Marcopolo'),
       (920, 30, TRUE, TRUE, 288, 'MAN SE'),
       (283, 50, TRUE, FALSE, 400, 'Scania'),
       (412, 30, FALSE, TRUE, 288, 'Eicher Skyline'),
       (413, 30, TRUE, FALSE, 288, 'Force Motors Traveller'),
       (796, 50, TRUE, TRUE, 400, 'Ashok Leyland Lynx'),
       (927, 25, TRUE, TRUE, 260, 'JCBL'),
       (800, 50, FALSE, FALSE, 400, 'Tata Marcopolo'),
       (415, 35, TRUE, TRUE, 316, 'Force Motors Traveller'),
       (288, 50, FALSE, TRUE, 400, 'Scania'),
       (292, 45, FALSE, FALSE, 372, 'Eicher Skyline'),
       (932, 50, TRUE, TRUE, 400, 'Scania'),
       (167, 30, FALSE, FALSE, 288, 'JCBL'),
       (809, 30, FALSE, FALSE, 288, 'JCBL'),
       (427, 50, TRUE, TRUE, 400, 'Force Motors Traveller'),
       (683, 25, FALSE, FALSE, 260, 'SML Isuzu'),
       (557, 50, FALSE, FALSE, 400, 'Force Motors Traveller'),
       (558, 50, FALSE, TRUE, 400, 'BharatBenz'),
       (300, 35, FALSE, FALSE, 316, 'Ashok Leyland Lynx'),
       (832, 40, TRUE, FALSE, 344, 'Tata Marcopolo'),
       (198, 40, TRUE, FALSE, 344, 'Eicher Skyline'),
       (455, 40, FALSE, FALSE, 344, 'Mahindra Comfio'),
       (583, 45, FALSE, TRUE, 372, 'Force Motors Traveller'),
       (713, 40, TRUE, FALSE, 344, 'Ashok Leyland Lynx'),
       (458, 40, TRUE, TRUE, 344, 'JCBL'),
       (710, 50, FALSE, FALSE, 400, 'BharatBenz'),
       (206, 50, FALSE, FALSE, 400, 'JCBL'),
       (850, 45, FALSE, FALSE, 372, 'Eicher Skyline'),
       (338, 30, FALSE, FALSE, 288, 'MAN SE'),
       (597, 30, FALSE, TRUE, 288, 'Eicher Skyline'),
       (858, 45, FALSE, FALSE, 372, 'Mahindra Comfio'),
       (604, 35, TRUE, FALSE, 316, 'Scania'),
       (222, 30, TRUE, TRUE, 288, 'SML Isuzu'),
       (103, 45, FALSE, TRUE, 372, 'MAN SE'),
       (360, 25, FALSE, TRUE, 260, 'Ashok Leyland Lynx'),
       (232, 30, TRUE, FALSE, 288, 'MAN SE'),
       (873, 40, TRUE, FALSE, 344, 'Ashok Leyland Lynx'),
       (879, 45, TRUE, TRUE, 372, 'BharatBenz'),
       (112, 50, FALSE, FALSE, 400, 'MAN SE'),
       (623, 40, TRUE, FALSE, 344, 'JCBL');

INSERT INTO Driver
VALUES (513, 'Prabhas Kambhampati', 9840451728, '2020-08-02', 15000, 'B'),
       (521, 'Nirmohi Lalima', NULL, '2021-11-28', 15000, 'A'),
       (526, 'Parashuram Keshavan', 8943741643, '2020-04-07', 30000, 'A'),
       (530, 'Shivesh Bhagyamma', 9543905248, '2021-05-01', 35000, 'A'),
       (531, 'Acharya Vasumati', 8941951055, '2020-03-03', 10000, 'D'),
       (535, 'Rajkiran Aranasi', 8423843079, '2021-04-25', 30000, 'D'),
       (566, 'Harkrishna Simha', NULL, '2021-03-22', 15000, 'A'),
       (587, 'Sanchit Srini', 7773825030, '2019-03-05', 25000, 'C'),
       (601, 'Pulastya Yamura', 6944354981, '2021-10-07', 20000, 'D'),
       (605, 'Bibek Hattangady', 7863535996, '2021-09-25', 35000, 'B'),
       (104, 'Indeever Rajan', 9512815839, '2020-04-10', 20000, 'D'),
       (617, 'Vidyasagar Riddhi', 9115761209, '2020-11-11', 40000, 'A'),
       (109, 'Chinmay Anadi Sudheer', 6937853076, '2019-12-20', 35000, 'D'),
       (630, 'Bansilal Sanat', 7724294023, '2021-06-23', 35000, 'B'),
       (121, 'Abhisar Sitamraju', 9126587081, '2021-08-10', 35000, 'B'),
       (128, 'Navnit Tanmaya', 9562670151, '2019-03-20', 15000, 'C'),
       (130, 'Harsha Anipindi', 6727736643, '2020-02-08', 25000, 'C'),
       (141, 'Suryabhan Somasundaram', 8027185804, '2021-08-13', 30000, 'B'),
       (142, 'Abhimanyusuta Shahid', 7790996084, '2020-03-04', 35000, 'B'),
       (653, 'Niramitra Suhrid Sangem', 8855180469, '2020-09-15', 15000, 'D'),
       (145, 'Mohnish Thyagarajan', 9373367479, '2021-01-28', 25000, 'A'),
       (661, 'Jalal Srijoy', 9637165595, '2020-01-20', 15000, 'D'),
       (668, 'Gagan Sudama Sandipa', 8523963588, '2019-08-22', 30000, 'C'),
       (669, 'Sugriva Mittal', 7111597982, '2021-07-19', 40000, 'D'),
       (156, 'Meghashyam Sethuraman', NULL, '2020-10-13', 25000, 'D'),
       (157, 'Amitesh Tapan', 7165706339, '2021-12-17', 35000, 'A'),
       (672, 'Harkrishna Sarangarajan', 6469570685, '2021-04-21', 15000, 'B'),
       (671, 'Jayadeep Chennapragada', 9171356181, '2019-06-02', 20000, 'D'),
       (162, 'Vaman Debashish Yashovarman', 8691425130, '2021-02-07', 10000, 'B'),
       (676, 'Paranjay Dinath', 8063402328, '2021-01-07', 20000, 'B'),
       (678, 'Aashish Jyothsna', NULL, '2019-09-24', 40000, 'B'),
       (679, 'Mehboob Nageswar', 6590082694, '2021-04-18', 25000, 'D'),
       (179, 'Gurbachan Anivella', 6200068931, '2019-11-12', 25000, 'D'),
       (697, 'Shantanu Dhatri', 9569018437, '2021-05-14', 15000, 'D'),
       (698, 'Uday Raman', 8229268655, '2020-12-25', 10000, 'A'),
       (704, 'Sashreek Gajraj', NULL, '2021-07-16', 15000, 'D'),
       (204, 'Vasava Vadakke', 6072012591, '2019-11-20', 15000, 'B'),
       (210, 'Sitanshu Rudraraju', 9900245792, '2019-07-18', 25000, 'A'),
       (730, 'Bitasok Praharaj', 7061911522, '2019-09-11', 15000, 'B'),
       (227, 'Kanwalkishore Manjusha', 9459089936, '2019-06-18', 40000, 'D'),
       (235, 'Dhawal Saldanha', 7298685605, '2020-08-12', 10000, 'B'),
       (236, 'Jaganmay Parmar', 6344534998, '2021-06-13', 20000, 'D'),
       (750, 'Saipratap Neelakantachar', 9456177215, '2021-03-23', 40000, 'A'),
       (756, 'Balaram Suri', 8485611679, '2020-04-11', 30000, 'C'),
       (249, 'Kanchan Shiv Sajid', 8382291086, '2021-09-09', 25000, 'A'),
       (251, 'Dheerendra Vedati', 6680316323, '2021-03-10', 15000, 'A'),
       (253, 'Navaneet Ranjan', 8898833978, '2019-11-26', 30000, 'C'),
       (257, 'Omja Samiksha', NULL, '2020-11-11', 40000, 'C'),
       (265, 'Balkrishan Addepalli', 8830006257, '2019-02-18', 10000, 'A'),
       (777, 'Mahabala Nema', 9833469781, '2019-05-23', 10000, 'B'),
       (269, 'Yagya Aryasomayajula', 8099713456, '2020-09-27', 15000, 'C'),
       (272, 'Raghunath Kambhampat', NULL, '2020-03-09', 25000, 'B'),
       (286, 'Pannalal Kandula', 7139523988, '2021-01-28', 40000, 'D'),
       (798, 'Abhibhava Karumuri', 6724256741, '2020-12-23', 40000, 'D'),
       (802, 'Indradutt Shaik', 9230883401, '2021-08-04', 10000, 'D'),
       (807, 'Mahesh Kachwaha', NULL, '2021-02-11', 30000, 'B'),
       (808, 'Sidhu Potapragada', 9399094865, '2021-02-06', 20000, 'D'),
       (307, 'Soumyakanti Shourov', 7569475293, '2020-01-15', 25000, 'B'),
       (822, 'Suvan Gade', 7481461105, '2020-12-20', 20000, 'B'),
       (317, 'Gurbachan Gajendra', 9176440875, '2020-07-25', 40000, 'A'),
       (322, 'Himachal Katragadda', 8959797582, '2021-07-04', 15000, 'A'),
       (323, 'Shailesh Daman Kabir', 9258801741, '2020-03-16', 20000, 'A'),
       (325, 'Mitesh Cansai', 8046716662, '2019-07-05', 40000, 'D'),
       (330, 'Shrinivas Harku', 9469708467, '2021-01-18', 25000, 'C'),
       (845, 'Jyotirdhar Neil', 9692920083, '2020-06-20', 35000, 'A'),
       (853, 'Mandhatri Tumkur', 7382842355, '2021-07-13', 20000, 'D'),
       (341, 'Varij Varadarajan', 6654876585, '2019-07-14', 20000, 'A'),
       (342, 'Vikramaditya Jafferbhoy', 7747094255, '2019-08-19', 10000, 'D'),
       (344, 'Nivith Gumma', NULL, '2020-10-08', 40000, 'D'),
       (350, 'Ilesh Prafull', 6045938550, '2020-06-08', 25000, 'B'),
       (863, 'Jeemutbahan Roy', 6559158401, '2020-10-05', 10000, 'D'),
       (867, 'Eeshan Sripaada', 9202876025, '2021-08-15', 35000, 'B'),
       (359, 'Madhuk Yashodhara', 9337448661, '2021-10-08', 15000, 'B'),
       (368, 'Trilokesh Shantinath', 7709296528, '2020-02-08', 40000, 'D'),
       (881, 'Sanatan Srivathsan', 8783836424, '2020-09-26', 15000, 'A'),
       (374, 'Samarjit Tammana', 8741796509, '2019-12-21', 10000, 'B'),
       (376, 'Tripurari Shreshta Saru', 7110741904, '2021-12-03', 20000, 'B'),
       (379, 'Sankalpa Soogoor', 6969678112, '2020-05-05', 40000, 'B'),
       (382, 'Ulhas Rajarama', 8643035877, '2021-07-01', 40000, 'B'),
       (895, 'Rizvan Kandadai', 6232576734, '2019-03-02', 40000, 'B'),
       (896, 'Quasim Yadgiri', 7462642679, '2021-06-12', 25000, 'B'),
       (900, 'Shalin Punnoose', 8133787085, '2021-10-27', 35000, 'D'),
       (390, 'Roshan Rangwala', 8366945369, '2019-03-09', 35000, 'D'),
       (396, 'Dev Kumar Vemuganti', 9482022328, '2020-07-11', 15000, 'A'),
       (402, 'Jyotirmoy Isar Muddiah', 8420362670, '2021-01-15', 20000, 'A'),
       (916, 'Badri Kumawagra', 8959258570, '2021-06-13', 15000, 'A'),
       (420, 'Gandhik Saraf', 8685424489, '2019-07-10', 40000, 'A'),
       (433, 'Vikram Hazare', 8542134870, '2021-09-22', 25000, 'A'),
       (441, 'Vinay Laul', 9666485139, '2019-04-18', 20000, 'C'),
       (954, 'Satyajit Dhatri', 9886820105, '2020-08-16', 40000, 'D'),
       (958, 'Anand Subramaniam', 7207858209, '2019-10-17', 25000, 'C'),
       (446, 'Kularanjan Sadashiv', 6393186908, '2021-05-07', 20000, 'D'),
       (967, 'Kailashnath Sarang Murtugudde', 6694934572, '2019-06-20', 10000, 'A'),
       (456, 'Kartikeya Puri', 6276132852, '2019-01-17', 30000, 'C'),
       (977, 'Paravasu Suji', 8777581752, '2019-04-22', 30000, 'C'),
       (465, 'Nikunj Kedar', 6195257103, '2020-03-04', 35000, 'D'),
       (981, 'Siddharth Kulasekaran', NULL, '2021-06-18', 10000, 'D'),
       (472, 'Deviprasad Sengupta', 7658564236, '2021-06-25', 40000, 'A'),
       (477, 'Prayag Sowrirajan', 6680585528, '2020-09-13', 15000, 'A'),
       (998, 'Nirmay Gollapalli', 6404007159, '2019-04-27', 25000, 'A');

INSERT INTO Town
VALUES ('Amaravati', 'Andhra Pradesh'),
       ('Bangalore', 'Karnataka'),
       ('Hyderabad', 'Telangana'),
       ('Kolkata', 'West Bengal'),
       ('Kurnool', 'Andhra Pradesh'),
       ('Mumbai', 'Maharastra'),
       ('Mysore', 'Karnataka'),
       ('Nagpur', 'Maharastra'),
       ('Visakhapatnam', 'Andhra Pradesh');

INSERT INTO Station
VALUES (45058, 'Travel Stop 035', 'Amaravati'),
       (87564, 'Public Bus Transit Station', 'Amaravati'),
       (97294, 'Standard Bus Transit Stop', 'Amaravati'),
       (72214, 'Travel Station 032', 'Nagpur'),
       (65046, 'General Bus Stand', 'Hyderabad'),
       (37400, 'Public Bus Pick up', 'Hyderabad'),
       (87090, 'BTTC Transit Stop 017', 'Hyderabad'),
       (81468, 'BTTC Standard Bus Stand', 'Visakhapatnam'),
       (74816, 'BTTC Public Stop 067', 'Kurnool'),
       (37959, 'Standard Bus Center', 'Kurnool'),
       (56909, 'BTTC Standard Center 030', 'Mumbai'),
       (12879, 'Standard Bus Stand', 'Mumbai'),
       (94290, 'Standard Bus Transit Stop', 'Mumbai'),
       (70227, 'Public Bus Transit Stop', 'Bangalore'),
       (55380, 'Standard Bus Stop', 'Bangalore'),
       (94806, 'Standard Bus Stand', 'Kolkata'),
       (54872, 'BTTC Standard Center 045', 'Kolkata'),
       (61530, 'BTTC Standard Bus Stop', 'Kolkata'),
       (57439, 'BTTC Public Bus Center', 'Mysore');

INSERT INTO Route
VALUES (45058, 501.18, 87090, 81468, '14:10:00'),
       (87564, 499.54, 81468, 74816, '14:50:00'),
       (97294, 274.28, 70227, 74816, '08:50:00'),
       (72214, 487.36, 74816, 81468, '14:40:00'),
       (65046, 491.23, 72214, 65046, '14:20:00'),
       (37400, 590.16, 55380, 57439, '16:10:00'),
       (87090, 353.25, 45058, 54872, '10:00:00'),
       (81468, 363.92, 74816, 72214, '11:30:00'),
       (74816, 597.92, 81468, 54872, '16:50:00'),
       (37959, 252.34, 72214, 87564, '08:40:00'),
       (56909, 502.76, 94806, 81468, '14:00:00'),
       (12879, 315.10, 37400, 61530, '09:20:00'),
       (94290, 254.45, 37400, 55380, '08:00:00'),
       (70227, 442.31, 87564, 81468, '13:00:00'),
       (55380, 316.39, 81468, 65046, '09:40:00'),
       (94806, 430.58, 70227, 72214, '12:10:00'),
       (54872, 440.92, 74816, 65046, '13:50:00'),
       (61530, 358.45, 72214, 55380, '10:40:00'),
       (57439, 322.73, 37400, 87564, '10:10:00'),
       (55392, 576.89, 94806, 72214, '16:10:00'),
       (41066, 317.30, 94806, 37400, '09:50:00'),
       (28273, 546.24, 57439, 37400, '15:10:00'),
       (26226, 501.70, 72214, 57439, '14:30:00'),
       (45682, 477.72, 81468, 72214, '13:00:00'),
       (91763, 387.10, 65046, 72214, '11:40:00'),
       (11895, 265.56, 70227, 81468, '08:30:00'),
       (93815, 333.98, 54872, 57439, '10:00:00'),
       (97408, 516.82, 57439, 74816, '14:30:00'),
       (68737, 364.63, 37959, 94806, '11:40:00'),
       (99458, 524.72, 65046, 37959, '15:10:00');

INSERT INTO InterRouteTowns
VALUES (45058, 'Bangalore'),
       (45058, 'Nagpur'),
       (72214, 'Amaravati'),
       (72214, 'Nagpur'),
       (72214, 'Hyderabad'),
       (65046, 'Kolkata'),
       (87090, 'Bangalore'),
       (87090, 'Kurnool'),
       (87090, 'Mumbai'),
       (81468, 'Bangalore'),
       (74816, 'Hyderabad'),
       (12879, 'Mysore'),
       (12879, 'Nagpur'),
       (94290, 'Kurnool'),
       (70227, 'Mysore'),
       (55380, 'Kurnool'),
       (94806, 'Kurnool'),
       (94806, 'Amaravati'),
       (94806, 'Mysore'),
       (61530, 'Kurnool'),
       (57439, 'Kolkata'),
       (41066, 'Amaravati'),
       (28273, 'Amaravati'),
       (28273, 'Visakhapatnam'),
       (26226, 'Kurnool'),
       (26226, 'Hyderabad'),
       (45682, 'Bangalore'),
       (45682, 'Mysore'),
       (45682, 'Kurnool'),
       (91763, 'Bangalore'),
       (91763, 'Mumbai'),
       (91763, 'Amaravati'),
       (93815, 'Amaravati'),
       (93815, 'Visakhapatnam'),
       (93815, 'Bangalore'),
       (97408, 'Nagpur'),
       (97408, 'Mumbai'),
       (97408, 'Bangalore'),
       (68737, 'Visakhapatnam'),
       (68737, 'Mysore');

UPDATE BusAllocation
SET route_no=81468,
    start_time='07:00:00',
    end_time=NULL
WHERE bus_id = 103;
UPDATE BusAllocation
SET route_no=72214,
    start_time='15:00:00',
    end_time=NULL
WHERE bus_id = 112;
UPDATE BusAllocation
SET route_no=57439,
    start_time='21:00:00',
    end_time=NULL
WHERE bus_id = 167;
UPDATE BusAllocation
SET route_no=55380,
    start_time='07:30:00',
    end_time=NULL
WHERE bus_id = 198;
UPDATE BusAllocation
SET route_no=68737,
    start_time='20:00:00',
    end_time=NULL
WHERE bus_id = 206;
UPDATE BusAllocation
SET route_no=93815,
    start_time='21:00:00',
    end_time=NULL
WHERE bus_id = 222;
UPDATE BusAllocation
SET route_no=99458,
    start_time='10:30:00',
    end_time=NULL
WHERE bus_id = 232;
UPDATE BusAllocation
SET route_no=65046,
    start_time='23:30:00',
    end_time=NULL
WHERE bus_id = 268;
UPDATE BusAllocation
SET route_no=87090,
    start_time='12:30:00',
    end_time=NULL
WHERE bus_id = 283;
UPDATE BusAllocation
SET route_no=26226,
    start_time='01:00:00',
    end_time=NULL
WHERE bus_id = 288;
UPDATE BusAllocation
SET route_no=45058,
    start_time='11:00:00',
    end_time=NULL
WHERE bus_id = 292;
UPDATE BusAllocation
SET route_no=12879,
    start_time='19:30:00',
    end_time=NULL
WHERE bus_id = 300;
UPDATE BusAllocation
SET route_no=45682,
    start_time='05:30:00',
    end_time=NULL
WHERE bus_id = 338;
UPDATE BusAllocation
SET route_no=NULL,
    start_time='16:30:00',
    end_time=NULL
WHERE bus_id = 360;
UPDATE BusAllocation
SET route_no=94806,
    start_time='21:30:00',
    end_time=NULL
WHERE bus_id = 384;
UPDATE BusAllocation
SET route_no=55392,
    start_time='06:00:00',
    end_time=NULL
WHERE bus_id = 401;
UPDATE BusAllocation
SET route_no=93815,
    start_time='22:00:00',
    end_time=NULL
WHERE bus_id = 412;
UPDATE BusAllocation
SET route_no=97294,
    start_time='06:00:00',
    end_time=NULL
WHERE bus_id = 413;
UPDATE BusAllocation
SET route_no=99458,
    start_time='09:00:00',
    end_time=NULL
WHERE bus_id = 415;
UPDATE BusAllocation
SET route_no=NULL,
    start_time='07:30:00',
    end_time=NULL
WHERE bus_id = 427;
UPDATE BusAllocation
SET route_no=41066,
    start_time='04:30:00',
    end_time=NULL
WHERE bus_id = 455;
UPDATE BusAllocation
SET route_no=74816,
    start_time='00:30:00',
    end_time=NULL
WHERE bus_id = 458;
UPDATE BusAllocation
SET route_no=56909,
    start_time='15:00:00',
    end_time=NULL
WHERE bus_id = 521;
UPDATE BusAllocation
SET route_no=65046,
    start_time='14:00:00',
    end_time=NULL
WHERE bus_id = 557;
UPDATE BusAllocation
SET route_no=45058,
    start_time='08:00:00',
    end_time=NULL
WHERE bus_id = 558;
UPDATE BusAllocation
SET route_no=97408,
    start_time='10:30:00',
    end_time=NULL
WHERE bus_id = 583;
UPDATE BusAllocation
SET route_no=41066,
    start_time='18:00:00',
    end_time=NULL
WHERE bus_id = 597;
UPDATE BusAllocation
SET route_no=NULL,
    start_time='17:30:00',
    end_time=NULL
WHERE bus_id = 604;
UPDATE BusAllocation
SET route_no=NULL,
    start_time='22:00:00',
    end_time=NULL
WHERE bus_id = 623;
UPDATE BusAllocation
SET route_no=72214,
    start_time='08:30:00',
    end_time=NULL
WHERE bus_id = 642;
UPDATE BusAllocation
SET route_no=11895,
    start_time='16:30:00',
    end_time=NULL
WHERE bus_id = 659;
UPDATE BusAllocation
SET route_no=87564,
    start_time='22:30:00',
    end_time=NULL
WHERE bus_id = 683;
UPDATE BusAllocation
SET route_no=37400,
    start_time='00:00:00',
    end_time=NULL
WHERE bus_id = 710;
UPDATE BusAllocation
SET route_no=87090,
    start_time='09:00:00',
    end_time=NULL
WHERE bus_id = 713;
UPDATE BusAllocation
SET route_no=55380,
    start_time='15:00:00',
    end_time=NULL
WHERE bus_id = 770;
UPDATE BusAllocation
SET route_no=55392,
    start_time='12:30:00',
    end_time=NULL
WHERE bus_id = 784;
UPDATE BusAllocation
SET route_no=NULL,
    start_time='13:00:00',
    end_time=NULL
WHERE bus_id = 786;
UPDATE BusAllocation
SET route_no=45058,
    start_time='21:00:00',
    end_time=NULL
WHERE bus_id = 796;
UPDATE BusAllocation
SET route_no=74816,
    start_time='09:00:00',
    end_time=NULL
WHERE bus_id = 800;
UPDATE BusAllocation
SET route_no=65046,
    start_time='15:00:00',
    end_time=NULL
WHERE bus_id = 809;
UPDATE BusAllocation
SET route_no=94806,
    start_time='10:00:00',
    end_time=NULL
WHERE bus_id = 832;
UPDATE BusAllocation
SET route_no=NULL,
    start_time='18:30:00',
    end_time=NULL
WHERE bus_id = 850;
UPDATE BusAllocation
SET route_no=45058,
    start_time='03:00:00',
    end_time=NULL
WHERE bus_id = 858;
UPDATE BusAllocation
SET route_no=61530,
    start_time='01:30:00',
    end_time=NULL
WHERE bus_id = 873;
UPDATE BusAllocation
SET route_no=11895,
    start_time='13:30:00',
    end_time=NULL
WHERE bus_id = 879;
UPDATE BusAllocation
SET route_no=45058,
    start_time='00:30:00',
    end_time=NULL
WHERE bus_id = 901;
UPDATE BusAllocation
SET route_no=70227,
    start_time='21:30:00',
    end_time=NULL
WHERE bus_id = 910;
UPDATE BusAllocation
SET route_no=97294,
    start_time='18:30:00',
    end_time=NULL
WHERE bus_id = 920;
UPDATE BusAllocation
SET route_no=97294,
    start_time='08:00:00',
    end_time=NULL
WHERE bus_id = 927;
UPDATE BusAllocation
SET route_no=54872,
    start_time='16:30:00',
    end_time=NULL
WHERE bus_id = 932;

UPDATE DriverAllocation
SET bus_id=292,
    last_route_id=NULL
WHERE driver_id = 350;
UPDATE DriverAllocation
SET bus_id=910,
    last_route_id=68737
WHERE driver_id = 325;
UPDATE DriverAllocation
SET bus_id=784,
    last_route_id=68737
WHERE driver_id = 396;
UPDATE DriverAllocation
SET bus_id=927,
    last_route_id=99458
WHERE driver_id = 531;
UPDATE DriverAllocation
SET bus_id=288,
    last_route_id=55392
WHERE driver_id = 390;
UPDATE DriverAllocation
SET bus_id=770,
    last_route_id=NULL
WHERE driver_id = 676;
UPDATE DriverAllocation
SET bus_id=558,
    last_route_id=55380
WHERE driver_id = 981;
UPDATE DriverAllocation
SET bus_id=796,
    last_route_id=NULL
WHERE driver_id = 668;
UPDATE DriverAllocation
SET bus_id=910,
    last_route_id=NULL
WHERE driver_id = 863;
UPDATE DriverAllocation
SET bus_id=458,
    last_route_id=93815
WHERE driver_id = 958;
UPDATE DriverAllocation
SET bus_id=809,
    last_route_id=41066
WHERE driver_id = 704;
UPDATE DriverAllocation
SET bus_id=458,
    last_route_id=NULL
WHERE driver_id = 145;
UPDATE DriverAllocation
SET bus_id=873,
    last_route_id=87090
WHERE driver_id = 368;
UPDATE DriverAllocation
SET bus_id=338,
    last_route_id=57439
WHERE driver_id = 661;
UPDATE DriverAllocation
SET bus_id=103,
    last_route_id=37959
WHERE driver_id = 322;
UPDATE DriverAllocation
SET bus_id=206,
    last_route_id=NULL
WHERE driver_id = 253;
UPDATE DriverAllocation
SET bus_id=415,
    last_route_id=55392
WHERE driver_id = 204;
UPDATE DriverAllocation
SET bus_id=770,
    last_route_id=81468
WHERE driver_id = 265;
UPDATE DriverAllocation
SET bus_id=198,
    last_route_id=70227
WHERE driver_id = 323;
UPDATE DriverAllocation
SET bus_id=927,
    last_route_id=NULL
WHERE driver_id = 845;
UPDATE DriverAllocation
SET bus_id=401,
    last_route_id=56909
WHERE driver_id = 465;
UPDATE DriverAllocation
SET bus_id=198,
    last_route_id=55380
WHERE driver_id = 587;
UPDATE DriverAllocation
SET bus_id=770,
    last_route_id=54872
WHERE driver_id = 104;
UPDATE DriverAllocation
SET bus_id=901,
    last_route_id=56909
WHERE driver_id = 853;
UPDATE DriverAllocation
SET bus_id=455,
    last_route_id=28273
WHERE driver_id = 141;
UPDATE DriverAllocation
SET bus_id=901,
    last_route_id=12879
WHERE driver_id = 977;
UPDATE DriverAllocation
SET bus_id=659,
    last_route_id=54872
WHERE driver_id = 881;
UPDATE DriverAllocation
SET bus_id=800,
    last_route_id=97294
WHERE driver_id = 179;
UPDATE DriverAllocation
SET bus_id=103,
    last_route_id=37400
WHERE driver_id = 227;
UPDATE DriverAllocation
SET bus_id=809,
    last_route_id=97408
WHERE driver_id = 896;
UPDATE DriverAllocation
SET bus_id=800,
    last_route_id=37959
WHERE driver_id = 967;
UPDATE DriverAllocation
SET bus_id=557,
    last_route_id=74816
WHERE driver_id = 822;
UPDATE DriverAllocation
SET bus_id=683,
    last_route_id=55380
WHERE driver_id = 630;
UPDATE DriverAllocation
SET bus_id=300,
    last_route_id=28273
WHERE driver_id = 162;
UPDATE DriverAllocation
SET bus_id=858,
    last_route_id=37959
WHERE driver_id = 653;
UPDATE DriverAllocation
SET bus_id=292,
    last_route_id=68737
WHERE driver_id = 249;
UPDATE DriverAllocation
SET bus_id=713,
    last_route_id=26226
WHERE driver_id = 330;
UPDATE DriverAllocation
SET bus_id=659,
    last_route_id=93815
WHERE driver_id = 802;
UPDATE DriverAllocation
SET bus_id=873,
    last_route_id=37959
WHERE driver_id = 307;
UPDATE DriverAllocation
SET bus_id=283,
    last_route_id=NULL
WHERE driver_id = 617;
UPDATE DriverAllocation
SET bus_id=458,
    last_route_id=70227
WHERE driver_id = 730;
UPDATE DriverAllocation
SET bus_id=412,
    last_route_id=26226
WHERE driver_id = 669;
UPDATE DriverAllocation
SET bus_id=413,
    last_route_id=54872
WHERE driver_id = 867;
UPDATE DriverAllocation
SET bus_id=413,
    last_route_id=28273
WHERE driver_id = 698;
UPDATE DriverAllocation
SET bus_id=112,
    last_route_id=93815
WHERE driver_id = 156;
UPDATE DriverAllocation
SET bus_id=910,
    last_route_id=55392
WHERE driver_id = 777;
UPDATE DriverAllocation
SET bus_id=642,
    last_route_id=37959
WHERE driver_id = 456;
UPDATE DriverAllocation
SET bus_id=659,
    last_route_id=37959
WHERE driver_id = 374;
UPDATE DriverAllocation
SET bus_id=288,
    last_route_id=65046
WHERE driver_id = 526;
UPDATE DriverAllocation
SET bus_id=232,
    last_route_id=45682
WHERE driver_id = 671;
UPDATE DriverAllocation
SET bus_id=300,
    last_route_id=94290
WHERE driver_id = 130;
UPDATE DriverAllocation
SET bus_id=597,
    last_route_id=61530
WHERE driver_id = 128;
UPDATE DriverAllocation
SET bus_id=222,
    last_route_id=11895
WHERE driver_id = 697;
UPDATE DriverAllocation
SET bus_id=198,
    last_route_id=28273
WHERE driver_id = 998;
UPDATE DriverAllocation
SET bus_id=858,
    last_route_id=NULL
WHERE driver_id = 535;
UPDATE DriverAllocation
SET bus_id=413,
    last_route_id=97408
WHERE driver_id = 679;
UPDATE DriverAllocation
SET bus_id=222,
    last_route_id=56909
WHERE driver_id = 756;
UPDATE DriverAllocation
SET bus_id=858,
    last_route_id=26226
WHERE driver_id = 376;
UPDATE DriverAllocation
SET bus_id=583,
    last_route_id=45058
WHERE driver_id = 286;
UPDATE DriverAllocation
SET bus_id=858,
    last_route_id=97408
WHERE driver_id = 798;
UPDATE DriverAllocation
SET bus_id=338,
    last_route_id=26226
WHERE driver_id = 272;
UPDATE DriverAllocation
SET bus_id=412,
    last_route_id=45682
WHERE driver_id = 808;
UPDATE DriverAllocation
SET bus_id=796,
    last_route_id=45058
WHERE driver_id = 142;
UPDATE DriverAllocation
SET bus_id=713,
    last_route_id=55392
WHERE driver_id = 235;
UPDATE DriverAllocation
SET bus_id=901,
    last_route_id=81468
WHERE driver_id = 900;
UPDATE DriverAllocation
SET bus_id=232,
    last_route_id=94290
WHERE driver_id = 672;
UPDATE DriverAllocation
SET bus_id=784,
    last_route_id=94290
WHERE driver_id = 236;
UPDATE DriverAllocation
SET bus_id=683,
    last_route_id=41066
WHERE driver_id = 807;
UPDATE DriverAllocation
SET bus_id=832,
    last_route_id=NULL
WHERE driver_id = 359;
UPDATE DriverAllocation
SET bus_id=521,
    last_route_id=57439
WHERE driver_id = 954;
UPDATE DriverAllocation
SET bus_id=920,
    last_route_id=81468
WHERE driver_id = 472;
UPDATE DriverAllocation
SET bus_id=300,
    last_route_id=61530
WHERE driver_id = 446;
UPDATE DriverAllocation
SET bus_id=910,
    last_route_id=56909
WHERE driver_id = 109;
UPDATE DriverAllocation
SET bus_id=932,
    last_route_id=65046
WHERE driver_id = 605;
UPDATE DriverAllocation
SET bus_id=338,
    last_route_id=87564
WHERE driver_id = 402;
UPDATE DriverAllocation
SET bus_id=927,
    last_route_id=NULL
WHERE driver_id = 379;
UPDATE DriverAllocation
SET bus_id=222,
    last_route_id=74816
WHERE driver_id = 750;
UPDATE DriverAllocation
SET bus_id=292,
    last_route_id=65046
WHERE driver_id = 521;
UPDATE DriverAllocation
SET bus_id=796,
    last_route_id=99458
WHERE driver_id = 342;
UPDATE DriverAllocation
SET bus_id=521,
    last_route_id=55392
WHERE driver_id = 157;
UPDATE DriverAllocation
SET bus_id=521,
    last_route_id=97294
WHERE driver_id = 251;
UPDATE DriverAllocation
SET bus_id=167,
    last_route_id=97408
WHERE driver_id = 341;
UPDATE DriverAllocation
SET bus_id=458,
    last_route_id=70227
WHERE driver_id = 210;
UPDATE DriverAllocation
SET bus_id=206,
    last_route_id=12879
WHERE driver_id = 317;
UPDATE DriverAllocation
SET bus_id=413,
    last_route_id=37959
WHERE driver_id = 566;
UPDATE DriverAllocation
SET bus_id=412,
    last_route_id=91763
WHERE driver_id = 269;
UPDATE DriverAllocation
SET bus_id=784,
    last_route_id=55380
WHERE driver_id = 420;
UPDATE DriverAllocation
SET bus_id=784,
    last_route_id=37959
WHERE driver_id = 433;
UPDATE DriverAllocation
SET bus_id=455,
    last_route_id=37400
WHERE driver_id = 344;
UPDATE DriverAllocation
SET bus_id=292,
    last_route_id=41066
WHERE driver_id = 895;
UPDATE DriverAllocation
SET bus_id=910,
    last_route_id=97408
WHERE driver_id = 121;
UPDATE DriverAllocation
SET bus_id=412,
    last_route_id=91763
WHERE driver_id = 530;
UPDATE DriverAllocation
SET bus_id=901,
    last_route_id=45682
WHERE driver_id = 382;
UPDATE DriverAllocation
SET bus_id=283,
    last_route_id=45682
WHERE driver_id = 916;
UPDATE DriverAllocation
SET bus_id=710,
    last_route_id=NULL
WHERE driver_id = 477;
UPDATE DriverAllocation
SET bus_id=455,
    last_route_id=72214
WHERE driver_id = 678;
UPDATE DriverAllocation
SET bus_id=112,
    last_route_id=26226
WHERE driver_id = 513;
UPDATE DriverAllocation
SET bus_id=873,
    last_route_id=55392
WHERE driver_id = 601;
UPDATE DriverAllocation
SET bus_id=283,
    last_route_id=NULL
WHERE driver_id = 441;
UPDATE DriverAllocation
SET bus_id=384,
    last_route_id=97408
WHERE driver_id = 257;
