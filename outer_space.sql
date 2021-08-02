-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

INSERT INTO galaxies (name)
VALUES ('Milky Way')
;

CREATE TABLE planets (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  galaxy_id INTEGER NOT NULL REFERENCES galaxies ON DELETE CASCADE DEFAULT 1,
  moons TEXT[]
);

INSERT INTO planets
  (name, moons)
VALUES
  ('Earth', '{"The Moon"}'),
  ('Mars', '{"Phobos", "Deimos"}'),
  ('Venus', '{}'),
  ('Neptune', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
  ('Proxima Centauri b', '{}'),
  ('Gliese 876 b', '{}'),
  ('The Sun', '{}'),
  ('Proxima Centauri', '{}'),
  ('Gliese 876', '{}')
;

CREATE TABLE orbitals (
  id SERIAL PRIMARY KEY,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around_planet_id INTEGER NOT NULL REFERENCES planets ON DELETE CASCADE,
  planet_id INTEGER NOT NULL REFERENCES planets ON DELETE CASCADE,
  UNIQUE (orbits_around_planet_id, planet_id)
);

INSERT INTO orbitals
  (planet_id, orbital_period_in_years, orbits_around_planet_id)
VALUES
  (1, 1.00, 7),
  (2, 1.88, 7),
  (3, 0.62, 7),
  (4, 164.8,7),
  (5, 0.03, 8),
  (6, 0.23, 9)
;

-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');
