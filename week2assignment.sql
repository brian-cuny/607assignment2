DROP TABLE IF EXISTS ratings;

CREATE TABLE ratings(
 rating_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 star_wars INTEGER,
 beauty_and_the_beast INTEGER,
 wonder_woman INTEGER,
 guardians_of_the_galaxy_2 INTEGER,
 jumanji INTEGER,
 spiderman_homecoming INTEGER
);

LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\week2assignmentMovies.csv' 
INTO TABLE ratings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(@dummy, @dummy, @star_wars, @beauty_and_the_beast, @wonder_woman, @guardians_of_the_galaxy_2, @jumanji, @spiderman_homecoming)
SET
star_wars = nullif(@star_wars,0),
beauty_and_the_beast = nullif(@beauty_and_the_beast,0),
wonder_woman = nullif(@wonder_woman,0),
guardians_of_the_galaxy_2 = nullif(@guardians_of_the_galaxy_2,0),
jumanji = nullif(@jumanji,0),
spiderman_homecoming = nullif(@spiderman_homecoming,0)
;

