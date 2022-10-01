-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE passengers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  airline TEXT NOT NULL
);

CREATE TABLE from_city
(
  id SERIAL PRIMARY KEY,
  city TEXT NOT NULL
);

CREATE TABLE to_city
(
  id SERIAL PRIMARY KEY,
  city TEXT NOT NULL
);

CREATE TABLE from_country
(
  id SERIAL PRIMARY KEY,
  country TEXT NOT NULL
);

CREATE TABLE to_country
(
  id SERIAL PRIMARY KEY,
  country TEXT NOT NULL
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  passengers_id INT NOT NULL,
  seat TEXT NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline_id INT NOT NULL,
  from_city_id INT NOT NULL,
  from_country_id INT NOT NULL,
  to_city_id INT NOT NULL,
  to_country_id INT NOT NULL
);

INSERT INTO tickets
  (passengers_id, seat, departure, arrival, airline_id, from_city_id, from_country_id, to_city_id, to_country_id)
VALUES
  (1, '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 1, 1, 1),
  (2, '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 2, 2, 2, 2),
  (3, '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 3, 1, 3, 1),
  (1, '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 4, 1, 4, 3),
  (4, '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 5, 3, 5, 4),
  (2, '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 6, 4, 6, 5),
  (5, '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 7, 1, 7, 1),
  (6, '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 8, 1, 8, 1),
  (5, '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 9, 1, 9, 1),
  (7, '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 10, 5, 10, 6);

INSERT INTO passengers
  (first_name,last_name)
VALUES
  ('Jennifer','Finch'),('Thadeus','Gathercoal'),('Sonja','Pauley'),('Waneta','Skeleton'),('Berkie','Wycliff'),('Alvin','Leathes'),('Cory','Squibbes');

INSERT INTO airlines
  (airline)
VALUES
  ('United'),('British Airways'),('Delta'),('TUI Fly Belgium'),('Air China'),('American Airlines'),('Avianca Brasil');

INSERT INTO from_city
  (city)
VALUES
  ('Washington DC'),('Tokyo'),('Los Angeles'),('Seattle'),('Paris'),('Dubai'),('New York'),('Cedar Rapids'),('Charlotte'),('Sao Paolo');

INSERT INTO to_city
  (city)
VALUES
  ('Seattle'),('London'),('Las Vegas'),('Mexico City'),('Casablanca'),('Beijing'),('Charlotte'),('Chicago'),('New Orleans'),('Santiago');

INSERT INTO from_country
  (country)
VALUES
  ('United States'),('Japan'),('France'),('UAE'),('Brazil');

INSERT INTO to_country
  (country)
VALUES
  ('United States'),('United Kingdom'),('Mexico'),('Morocco'),('China'),('Chile');

ALTER TABLE tickets ADD FOREIGN KEY (passengers_id) REFERENCES passengers(id);

ALTER TABLE tickets ADD FOREIGN KEY (airline_id) REFERENCES airlines(id);

ALTER TABLE tickets ADD FOREIGN KEY (from_city_id) REFERENCES from_city(id);

ALTER TABLE tickets ADD FOREIGN KEY (from_country_id) REFERENCES from_country(id);

ALTER TABLE tickets ADD FOREIGN KEY (to_city_id) REFERENCES to_city(id);

ALTER TABLE tickets ADD FOREIGN KEY (to_country_id) REFERENCES to_country(id);

-- Test

SELECT passengers.first_name, passengers.last_name, tickets.seat, airlines.airline, from_city.city AS from_city, from_country.country AS from_country, to_city.city AS to_city, to_country.country AS to_country FROM tickets JOIN passengers ON tickets.passengers_id = passengers.id JOIN airlines ON tickets.airline_id = airlines.id JOIN from_city ON tickets.from_city_id = from_city.id JOIN from_country ON tickets.from_country_id = from_country.id JOIN to_city ON tickets.to_city_id = to_city.id JOIN to_country ON tickets.to_country_id = to_country.id;

Result:
 first_name | last_name  | seat |      airline      |   from_city   | from_country  |   to_city   |   to_country
------------+------------+------+-------------------+---------------+---------------+-------------+----------------
 Jennifer   | Finch      | 33B  | United            | Washington DC | United States | Seattle     | United States
 Thadeus    | Gathercoal | 8A   | British Airways   | Tokyo         | Japan         | London      | United Kingdom
 Sonja      | Pauley     | 12F  | Delta             | Los Angeles   | United States | Las Vegas   | United States
 Jennifer   | Finch      | 20A  | Delta             | Seattle       | United States | Mexico City | Mexico
 Waneta     | Skeleton   | 23D  | TUI Fly Belgium   | Paris         | France        | Casablanca  | Morocco
 Thadeus    | Gathercoal | 18C  | Air China         | Dubai         | UAE           | Beijing     | China
 Berkie     | Wycliff    | 9E   | United            | New York      | United States | Charlotte   | United States
 Alvin      | Leathes    | 1A   | American Airlines | Cedar Rapids  | United States | Chicago     | United States
 Berkie     | Wycliff    | 32B  | American Airlines | Charlotte     | United States | New Orleans | United States
 Cory       | Squibbes   | 10D  | Avianca Brasil    | Sao Paolo     | Brazil        | Santiago    | Chile
