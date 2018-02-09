DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
 user_id INTEGER PRIMARY KEY NOT NULL,
 timestamp DATETIME NOT NULL,
 email VARCHAR(50)
);

CREATE TABLE reviews(
 review_id INTEGER PRIMARY KEY NOT NULL,
 user_id INTEGER NOT NULL,
 movie VARCHAR(50) NOT NULL,
 rating INTEGER,
 foreign key(user_id) references users(user_id)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\users.csv' 
INTO TABLE users
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(user_id, @timestamp, email)
SET 
timestamp = STR_TO_DATE(@timestamp, '%d/%m/%Y %H:%i:%s')
;

LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\reviews.csv' 
INTO TABLE reviews
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(review_id, user_id, movie, @rating)
SET
rating = nullif(@rating,0)
;

