-- from the terminal run:
-- psql < craigslist.pgsql

DROP DATABASE IF EXISTS craigslist_exercise
;

CREATE DATABASE craigslist_exercise
;

\c craigslist_exercise

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    title VARCHAR(20) NOT NULL UNIQUE,
    description TEXT DEFAULT 'No description provided.'
);

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(15) NOT NULL UNIQUE,
    preferred_region INTEGER REFERENCES regions ON DELETE SET NULL
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    -- renamed from "text" in ERD
    content TEXT DEFAULT 'Empty post content :(',
    location TEXT NOT NULL,
    category INTEGER NOT NULL REFERENCES categories ON DELETE CASCADE,
    author INTEGER NOT NULL REFERENCES users ON DELETE CASCADE,
    region INTEGER NOT NULL REFERENCES regions ON DELETE CASCADE
);

-- 6
INSERT INTO categories
    (title)
VALUES
    ('Kitchen decor'),
    ('Kitchen appliances'),
    ('Yard tools'),
    ('House tools'),
    ('Games'),
    ('Clothing')
;

-- 3
INSERT INTO regions
    (name)
VALUES
    ('San Francisco'),
    ('Atlanta'),
    ('Seattle')
;

-- 4
INSERT INTO users
    (username, preferred_region)
VALUES
    ('CatLuver23', 1),
    ('SnakeBoi81', 2),
    ('PotatoKing26', 3),
    ('PopcornSack57', 2)
;

INSERT INTO posts
    (title, location, category, region, author)
VALUES
    ('Fridge magnets', '8048 Rockledge Drive. Feasterville Trevose, PA 19053', 1, 1, 2),
    ('Sorry sliders boardgame', '7836 Sunset Lane. Phoenixville, PA 19460', 5, 2, 1),
    ('Garden tools set', '7796 Wall Avenue. Fairfax, VA 22030', 3, 3, 4)
;
