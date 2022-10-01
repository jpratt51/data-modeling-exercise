CREATE TABLE home_team (
    id SERIAL PRIMARY KEY,
    h_team TEXT NOT NULL,
    rank INT
);

CREATE TABLE away_team (
    id SERIAL PRIMARY KEY,
    a_team TEXT NOT NULL
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    matches_id INT NOT NULL,
    players_id INT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    teams_id INT
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    matches_id INT
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    date TEXT,
    location TEXT,
    home_team INT,
    away_team INT,
    referees_id INT
);

CREATE TABLE season_dates (
    id SERIAL PRIMARY KEY,
    start_date TEXT,
    end_date TEXT
);

ALTER TABLE goals ADD FOREIGN KEY (matches_id) REFERENCES matches(id);

ALTER TABLE goals ADD FOREIGN KEY (players_id) REFERENCES players(id);

ALTER TABLE players ADD FOREIGN KEY (teams_id) REFERENCES home_team(id);

ALTER TABLE referees ADD FOREIGN KEY (matches_id) REFERENCES matches(id);

ALTER TABLE matches ADD FOREIGN KEY (home_team) REFERENCES home_team(id);

ALTER TABLE matches ADD FOREIGN KEY (away_team) REFERENCES away_team(id);

ALTER TABLE matches ADD FOREIGN KEY (referees_id) REFERENCES referees(id);

-- Testing database: VVVVV

INSERT INTO home_team (h_team,rank) VALUES ('Arsenal',1),('Man City',2),('Tottenham',3),('Brighton',4),('Chelsea',5);

INSERT INTO away_team (a_team) VALUES ('Arsenal'),('Man City'),('Tottenham'),('Brighton'),('Chelsea');

INSERT INTO players (name,teams_id) VALUES ('Gabriel Jesus',1),('Erling Haaland',2),('Harry Kane',3),('Julio Enciso',4),('Conor Gallagher',5), ('Jorginho',5),('Denis Undav',4),('Djed Spence',3),('Scott Carson',2),('Thomas Partey',1);

INSERT INTO matches (date,location,home_team,away_team) VALUES ('12/22/2020','Emirates Stadium',1,2),('1/5/2022','Stamford Bridge',5,3),('10/22/2022','Etihad Stadium',2,4),('08/21/2022','Emirates Stadium',1,5),('12/29/2020','Falmer Stadium',4,1);

INSERT INTO referees (name,matches_id) VALUES ('John',1),('Jacob',2);

UPDATE matches SET referees_id = 1 WHERE id = 1;

UPDATE matches SET referees_id = 1 WHERE id = 3;

UPDATE matches SET referees_id = 1 WHERE id = 4;

UPDATE matches SET referees_id = 2 WHERE id = 2;

UPDATE matches SET referees_id = 2 WHERE id = 5;

INSERT INTO season_dates (start_date,end_date) VALUES ('09/12/2020','05/23/2020'),('08/13/2021','05/22/2022'),('08/06/2022','05/22/2022');

INSERT INTO goals (matches_id,players_id) VALUES (1,1),(1,10),(2,2),(2,9),(3,9),(3,4),(4,1),(4,5),(5,10),(5,7);

-- Database tests:

SELECT matches.date,matches.location,home_team.h_team,away_team.a_team FROM matches JOIN home_team ON matches.home_team = home_team.id JOIN away_team ON matches.away_team = away_team.id;

Result:
    date    |     location     |  h_team  |  a_team
------------+------------------+----------+-----------
 12/22/2020 | Emirates Stadium | Arsenal  | Man City
 10/22/2022 | Etihad Stadium   | Man City | Brighton
 08/21/2022 | Emirates Stadium | Arsenal  | Chelsea
 1/5/2022   | Stamford Bridge  | Chelsea  | Tottenham
 12/29/2020 | Falmer Stadium   | Brighton | Arsenal

SELECT matches.date,matches.location,players.name FROM goals JOIN matches ON goals.matches_id = matches.id JOIN players ON goals.players_id = players.id;

Result:
    date    |     location     |      name
------------+------------------+-----------------
 12/22/2020 | Emirates Stadium | Gabriel Jesus
 12/22/2020 | Emirates Stadium | Thomas Partey
 1/5/2022   | Stamford Bridge  | Erling Haaland
 1/5/2022   | Stamford Bridge  | Scott Carson
 10/22/2022 | Etihad Stadium   | Scott Carson
 10/22/2022 | Etihad Stadium   | Julio Enciso
 08/21/2022 | Emirates Stadium | Gabriel Jesus
 08/21/2022 | Emirates Stadium | Conor Gallagher
 12/29/2020 | Falmer Stadium   | Thomas Partey
 12/29/2020 | Falmer Stadium   | Denis Undav
