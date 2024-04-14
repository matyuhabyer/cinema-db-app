-- -----------------------------------------------------
-- Schema cinema_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS cinema_db;
CREATE SCHEMA IF NOT EXISTS cinema_db;
USE cinema_db;

-- -----------------------------------------------------
-- Table movie
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS movie(
  movie_id 			INT NOT NULL AUTO_INCREMENT,
  title 			VARCHAR(45) NOT NULL,
  director 			VARCHAR(45) NOT NULL,
  genre 			VARCHAR(45) NOT NULL,
  release_date 		DATE NOT NULL,
  duration 			INT NOT NULL,
  mtrcb_rating 		ENUM('G', 'PG', 'R-13', 'R-16', 'R-18') NOT NULL,
  
  PRIMARY KEY 		(movie_id),
  UNIQUE INDEX 		movie_id_UNIQUE (movie_id ASC)
);


-- -----------------------------------------------------
-- Table employee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS employee(
  employee_id         INT NOT NULL AUTO_INCREMENT,
  password            VARCHAR(45) NOT NULL,
  email               VARCHAR(45) NOT NULL,
  full_name           VARCHAR(45) NOT NULL,
  shift_start_time    TIME NOT NULL,
  shift_end_time      TIME NOT NULL,
  position            ENUM('Manager', 'Maintenance', 'Ticket Staff', 'Snacks Vendor') NOT NULL,
  
  PRIMARY KEY         (employee_id),
  UNIQUE INDEX        full_name_UNIQUE (full_name ASC),
  UNIQUE INDEX        employee_id_UNIQUE (employee_id ASC),
  UNIQUE INDEX        email_UNIQUE (email ASC)
) AUTO_INCREMENT = 12200001;


-- -----------------------------------------------------
-- Table snacks
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS snacks(
  snacks_id         INT NOT NULL AUTO_INCREMENT,
  food_type         ENUM('Popcorn', 'Nachos') NOT NULL,
  food_size         ENUM('Small', 'Medium', 'Large') NOT NULL,
  food_flavor       ENUM('BBQ', 'Cheese', 'Sour Cream') NOT NULL,
  food_price        DECIMAL(10, 2) NOT NULL,
  food_quantity     INT DEFAULT 0,
  drinks            ENUM('Iced Tea', 'Coke', 'Coke Zero', 'Sprite', 'Royal', 'Pineapple Juice') NOT NULL,
  drinks_size       ENUM('Small', 'Medium', 'Large') NOT NULL,
  drinks_price      DECIMAL(10, 2) NOT NULL,
  drink_quantity	INT DEFAULT 0,  
  
  PRIMARY KEY       (snacks_id),
  UNIQUE INDEX 		snacks_id_UNIQUE (snacks_id ASC)
) AUTO_INCREMENT = 2000;


-- -----------------------------------------------------
-- Table screen_room
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS screen_room(
  room_number 		ENUM('1', '2', '3', '4') NOT NULL,
  total_seats 		INT NOT NULL,
  available_seats 	INT NOT NULL,
  PRIMARY KEY 		(room_number)
  );


-- -----------------------------------------------------
-- Table showtime
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS showtime(
  showtime_id     INT NOT NULL AUTO_INCREMENT,
  movie_id        INT NOT NULL,
  room_number     ENUM('1', '2', '3', '4') NOT NULL,
  start_time      TIME NOT NULL,
  end_time        TIME NOT NULL,
  ticket_price    DECIMAL(10, 2) NOT NULL,
  
  PRIMARY KEY     (showtime_id),
  INDEX           fk_showtime_movie_idx (movie_id ASC),
  UNIQUE INDEX    showtime_id_UNIQUE (showtime_id ASC),
  INDEX           fk_showtime_screen_room1_idx (room_number ASC),
  CONSTRAINT      fk_showtime_movie
    FOREIGN KEY   (movie_id)
    REFERENCES    movie (movie_id)
    ON DELETE     CASCADE
    ON UPDATE     CASCADE,
  CONSTRAINT      fk_showtime_screen_room1
    FOREIGN KEY   (room_number)
    REFERENCES    screen_room (room_number)
    ON DELETE     NO ACTION
    ON UPDATE     NO ACTION
) AUTO_INCREMENT = 3000;


-- -----------------------------------------------------
-- Table transactions
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS transactions(
	transaction_id		INT NOT NULL AUTO_INCREMENT,
    transaction_type	ENUM('Ticket','Snack') NOT NULL,
    showtime_id			INT,
    num_tickets			INT,
    snacks_id			INT,
    num_foods			INT,
    num_drinks			INT,
    
    PRIMARY KEY			(transaction_id),
	INDEX 				fk_transaction_showtime_idx (showtime_id ASC),
    INDEX 				fk_transaction_snacks_idx (snacks_id ASC),
    CONSTRAINT 			fk_transaction_showtime
        FOREIGN KEY 	(showtime_id)
        REFERENCES 		showtime (showtime_id)
        ON DELETE 		NO ACTION
        ON UPDATE 		NO ACTION,
    CONSTRAINT 			fk_transaction_snacks
        FOREIGN KEY 	(snacks_id)
        REFERENCES 		snacks (snacks_id)
        ON DELETE 		NO ACTION
        ON UPDATE 		NO ACTION
) AUTO_INCREMENT = 4000; 


-- -----------------------------------------------------
-- Add records to movie
-- -----------------------------------------------------
INSERT INTO movie (title, director, genre, release_date, duration, mtrcb_rating)
	VALUES	('American Fiction', 'Cord Jefferson', 'Comedy/Drama', '2023-09-08', 117, 'R-13'),
			('Anatomy of a Fall', 'Justine Triet', 'Crime/Thriller', '2023-08-23', 152, 'R-13'),
            ('Barbie', 'Greta Gerwig', 'Comedy/Fantasy', '2023-07-21', 114, 'PG'),
            ('The Holdovers', 'Alexander Payne', 'Comedy/Drama', '2023-10-27', 133, 'R-13'),
            ('Killers of the Flower Moon', 'Martin Scorsese', 'Crime/Western', '2023-10-20', 206, 'R-13'),
            ('Maestro', 'Bradley Cooper', 'Romance/Drama', '2023-09-02', 129, 'PG'),
            ('Oppenheimer', 'Cristopher Nolan', 'Thriller/Historical Drama', '2023-07-21', 180, 'R-16'),
            ('Past Lives', 'Celine Song', 'Romance/Drama', '2023-06-02', 106, 'PG'),
            ('Poor Things', 'Yorgos Lanthimos', 'Comedy/Science Fiction', '2023-12-08', 141, 'R-16'),
            ('The Zone of Interest', 'Jonathan Glazer', 'War/Crime', '2023-12-15', 106, 'R-13');


-- -----------------------------------------------------
-- Add records to employee
-- -----------------------------------------------------
INSERT INTO employee (password, email, full_name, shift_start_time, shift_end_time, position)
	VALUES ('matthew', 'matyu@gmail.com', 'Matthew Javier', '09:00:00', '17:00:00', 'Manager'),
		   ('alec', 'alec@gmail.com', 'Alec Dela Cruz', '09:00:00', '17:00:00', 'Maintenance'),
           ('margaux', 'margaux@gmail.com', 'Margaux Miranda', '09:00:00', '17:00:00', 'Snacks Vendor'),
           ('josh', 'josh@gmail.com', 'Josh Policarpio', '09:00:00', '17:00:00', 'Ticket Staff');


-- -----------------------------------------------------
-- Add records to screen_room
-- -----------------------------------------------------
INSERT INTO screen_room (room_number, total_seats, available_seats)
	VALUES ('1', 50, 50),
		   ('2', 50, 50),
           ('3', 50, 50),
           ('4', 50, 50);


-- -----------------------------------------------------
-- Add records to showtime
-- -----------------------------------------------------
INSERT IGNORE INTO showtime (movie_id, room_number, start_time, end_time, ticket_price)
VALUES 
    -- American Fiction in room 1
    (1, '1', '10:00:00', ADDTIME('10:00:00', '01:57:00'), 300.00),
    -- Anatomy of a Fall in room 2
    (2, '2', '11:00:00', ADDTIME('11:00:00', '02:32:00'), 300.00),
    -- Barbie in room 3
    (3, '3', '12:30:00', ADDTIME('12:30:00', '01:54:00'), 350.00),
    -- The Holdovers in room 4
    (4, '4', '13:00:00', ADDTIME('13:00:00', '02:13:00'), 300.00),
    -- Killers of the Flower Moon in room 1
    (5, '1', '14:00:00', ADDTIME('14:00:00', '03:26:00'), 350.00),
    -- Maestro in room 2
    (6, '2', '15:00:00', ADDTIME('15:00:00', '02:09:00'), 300.00),
    -- Oppenheimer in room 3
    (7, '3', '16:00:00', ADDTIME('16:00:00', '03:00:00'), 350.00),
    -- Past Lives in room 4
    (8, '4', '17:00:00', ADDTIME('17:00:00', '01:46:00'), 350.00),
    -- Poor Things in room 1
    (9, '1', '18:00:00', ADDTIME('18:00:00', '02:21:00'), 300.00),
    -- The Zone of Interest in room 2
    (10, '2', '19:00:00', ADDTIME('19:00:00', '01:46:00'), 300.00);


-- -----------------------------------------------------
-- Add records to snacks
-- -----------------------------------------------------
INSERT INTO snacks(food_type, food_size, food_flavor, food_price, food_quantity, drinks, drinks_size, drinks_price, drink_quantity)
VALUES 
    ('Popcorn', 'Small', 'BBQ', 120.00, 50, 'Coke', 'Small', 40.00, 100),
    ('Popcorn', 'Medium', 'BBQ', 130.00, 50, 'Coke', 'Medium', 45.00, 100),
    ('Popcorn', 'Large', 'BBQ', 150.00, 50, 'Coke', 'Large', 50.00, 100),
    ('Popcorn', 'Small', 'BBQ', 120.00, 50, 'Iced Tea', 'Small', 40.00, 100),
    ('Popcorn', 'Medium', 'BBQ', 130.00, 50, 'Iced Tea', 'Medium', 45.00, 100),
    ('Popcorn', 'Large', 'BBQ', 150.00, 50, 'Iced Tea', 'Large', 50.00, 100),
    ('Popcorn', 'Small', 'Cheese', 120.00, 50, 'Sprite', 'Small', 40.00, 100),
    ('Popcorn', 'Medium', 'Cheese', 130.00, 50, 'Sprite', 'Medium', 45.00, 100),
    ('Popcorn', 'Large', 'Cheese', 150.00, 50, 'Sprite', 'Large', 50.00, 100),
    ('Nachos', 'Small', 'BBQ', 170.00, 50, 'Coke Zero', 'Small', 40.00, 100),
    ('Nachos', 'Medium', 'BBQ', 180.00, 50, 'Coke Zero', 'Medium', 45.00, 100),
    ('Nachos', 'Large', 'BBQ', 200.00, 50, 'Coke Zero', 'Large', 50.00, 100),
    ('Nachos', 'Small', 'Sour Cream', 170.00, 50, 'Pineapple Juice', 'Small', 50.00, 100),
    ('Nachos', 'Medium', 'Sour Cream', 180.00, 50, 'Pineapple Juice', 'Medium', 55.00, 100),
    ('Nachos', 'Large', 'Sour Cream', 200.00, 50, 'Pineapple Juice', 'Large', 60.00, 100);


            
