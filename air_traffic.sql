-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE airlines (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers ON DELETE CASCADE,
  seat TEXT NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline_id INTEGER NOT NULL REFERENCES airlines ON DELETE CASCADE,
  from_city_id INTEGER NOT NULL REFERENCES cities ON DELETE CASCADE,
  from_country_id INTEGER NOT NULL REFERENCES countries ON DELETE CASCADE,
  to_city_id INTEGER NOT NULL REFERENCES cities ON DELETE CASCADE,
  to_country_id INTEGER NOT NULL REFERENCES countries ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Waneta', 'Skeleton'),
  ('Berkie', 'Wycliff'),
  ('Cory', 'Squibbes'),
  ('Alvin', 'Leathes')
;

INSERT INTO airlines (name)
VALUES
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil')
;

INSERT INTO cities (name)
VALUES
  ('Cedar Rapids'), ('Chicago'),
  ('Charlotte'), ('New Orleans'),
  ('Dubai'), ('Beijing'),
  ('Los Angeles'), ('Las Vegas'),
  ('New York'), ('Paris'),
  ('Casablanca'), ('Sao Paolo'),
  ('Santiago'), ('Seattle'),
  ('Mexico City'), ('Tokyo'),
  ('London'), ('Washington DC')
;

INSERT INTO countries (name)
VALUES
  ('Brazil'), ('Chile'),
  ('France'), ('Morocco'),
  ('Japan'), ('United Kingdom'),
  ('UAE'), ('China'),
  ('United States'), ('Mexico')
;

INSERT INTO tickets
  (customer_id, seat, departure, arrival, airline_id, from_city_id, from_country_id, to_city_id, to_country_id)
VALUES
  (1, '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 18, 9, 14, 9),
  (2, '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 16, 5, 17, 6),
  (3, '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 7, 9, 8, 9),
  (1, '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 14, 9, 15, 10),
  (4, '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 10, 3, 11, 4),
  (2, '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 5, 7, 6, 8),
  (5, '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 9, 9, 3, 9),
  (7, '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 1, 9, 2, 9),
  (5, '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 3, 9, 4, 9),
  (6, '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 12, 1, 13, 2)
;

-- CREATE TABLE tickets
-- (
--   id SERIAL PRIMARY KEY,
--   first_name TEXT NOT NULL,
--   last_name TEXT NOT NULL,
--   seat TEXT NOT NULL,
--   departure TIMESTAMP NOT NULL,
--   arrival TIMESTAMP NOT NULL,
--   airline TEXT NOT NULL,
--   from_city TEXT NOT NULL,
--   from_country TEXT NOT NULL,
--   to_city TEXT NOT NULL,
--   to_country TEXT NOT NULL
-- );

-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');
