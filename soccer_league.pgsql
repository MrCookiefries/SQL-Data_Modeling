-- from the terminal run:
-- psql < soccer_league.pgsql

DROP DATABASE IF EXISTS soccer_league_exercise
;

CREATE DATABASE soccer_league_exercise
;

\c soccer_league_exercise

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

-- 4
INSERT INTO referees
    (name)
VALUES
    ('Bobby Don'),
    ('Hick Willis'),
    ('Maria Walton'),
    ('James Patterson')
;

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- 5
INSERT INTO seasons
    (start_date, end_date)
VALUES
    ('2014-04-08', '2014-06-21'),
    ('2015-04-03', '2015-06-20'),
    ('2016-04-02', '2016-06-22'),
    ('2017-04-07', '2017-06-28'),
    ('2018-04-09', '2018-06-29')
;

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(15) NOT NULL
);

-- 5
INSERT INTO teams
    (name)
VALUES
    ('Ball kickers'),
    ('Sports people'),
    ('Quick shots'),
    ('Easter island'),
    ('yellow cans')
;

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    team_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE
);

-- 24
INSERT INTO players
    (name, team_id)
VALUES
    ('John Doe', 1), ('Hugh Duncan', 4), ('James Harden', 2),
    ('John Brown', 2), ('Walter White', 5), ('Larry Keller', 3),
    ('Ellie Smith', 3), ('Max Robinson', 1), ('Hairum Dogtoy', 4),
    ('Smith Rob', 4), ('Johnny Angel', 2), ('Butter Milk', 5),
    ('Rob Hunter', 5), ('Charlie Brown', 3), ('Patrick Star', 1),
    ('Jack Colt', 1), ('Some Name', 4), ('First Last', 2),
    ('Mike Luter', 2), ('Sarah Falls', 5), ('Rebecca Green', 3),
    ('Susy Rae', 3), ('Douglas Pane', 1), ('Angelina Bob', 4)
;

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    season_id INTEGER NOT NULL REFERENCES seasons,
    home_team_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE,
    away_team_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE
);

-- 25
INSERT INTO games
    (season_id, home_team_id, away_team_id)
VALUES
    (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5),
    (1, 2, 3), (4, 5, 1), (2, 3, 4), (5, 1, 2), (3, 4, 5),
    (5, 4, 3), (2, 1, 5), (4, 3, 2), (1, 5, 4), (3, 2, 1),
    (2, 1, 4), (5, 2, 5), (2, 4, 2), (5, 5, 2), (2, 4, 5),
    (4, 2, 1), (1, 5, 1), (2, 2, 3), (3, 4, 1), (3, 5, 1)
;

CREATE TABLE games_referees (
    id SERIAL PRIMARY KEY,
    referee_id INTEGER NOT NULL REFERENCES referees ON DELETE CASCADE,
    game_id INTEGER NOT NULL REFERENCES games ON DELETE CASCADE
);

INSERT INTO games_referees
    (referee_id, game_id)
VALUES
    (1, 1), (2, 2), (3, 3), (4, 4),
    (1, 5), (2, 11), (3, 17), (4, 23),
    (1, 6), (2, 12), (3, 18), (4, 24),
    (1, 7), (2, 13), (3, 19), (4, 25),
    (1, 8), (2, 14), (3, 20), (4, 1),
    (1, 9), (2, 15), (3, 21), (4, 2),
    (1, 10), (2, 16), (3, 22), (4, 3),
    (1, 4), (2, 6), (3, 13), (4, 18),
    (1, 4), (2, 7), (3, 13), (4, 2)
;

-- renamed to flip words from ERD
CREATE TABLE games_players (
    id SERIAL PRIMARY KEY,
    goals INTEGER DEFAULT 0 CHECK (goals >= 0),
    player_id INTEGER NOT NULL REFERENCES players ON DELETE CASCADE,
    game_id INTEGER NOT NULL REFERENCES games ON DELETE CASCADE
);

INSERT INTO games_players
    (goals, player_id, game_id)
VALUES
    (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5),
    (1, 2, 3), (4, 5, 1), (2, 3, 4), (5, 1, 2), (3, 4, 5),
    (5, 4, 3), (2, 1, 5), (4, 3, 2), (1, 5, 4), (3, 2, 1),
    (2, 1, 4), (5, 2, 5), (2, 4, 2), (5, 5, 2), (2, 4, 5),
    (4, 2, 1), (1, 5, 1), (2, 2, 3), (3, 4, 1), (3, 5, 1),
    (1, 10, 11), (2, 11, 21), (3, 13, 13), (4, 14, 14), (5, 15, 15),
    (1, 12, 12), (4, 16, 16), (2, 20, 20), (5, 24, 24), (3, 5, 6),
    (5, 11, 13), (2, 17, 17), (4, 21, 21), (1, 15, 25), (3, 6, 8),
    (2, 14, 14), (5, 18, 18), (2, 22, 22), (5, 12, 5), (2, 7, 11),
    (4, 15, 15), (1, 19, 19), (2, 23, 23), (3, 9, 9), (3, 8, 17)
;

-- Rankings Queries -----------------------------------------------

-- Top 3 teams
SELECT t.name AS team, SUM(gp.goals) AS goals_total
FROM games g
INNER JOIN teams t
    ON t.id IN (g.home_team_id, g.away_team_id)
INNER JOIN games_players gp
    ON gp.game_id = g.id
GROUP BY team
ORDER BY goals_total DESC
LIMIT 3
;

-- Top 10 players
SELECT p.name AS player, SUM(gp.goals) AS goals_total
FROM players p
INNER JOIN games_players gp
    ON gp.player_id = p.id
GROUP BY player
ORDER BY goals_total DESC
LIMIT 10
;
