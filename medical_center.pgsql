-- from the terminal run:
-- psql < medical_center.pgsql

DROP DATABASE IF EXISTS medical_center_exercise
;

CREATE DATABASE medical_center_exercise
;

\c medical_center_exercise

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    contact TEXT DEFAULT 'No contact info provided'
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    age INTEGER NOT NULL CHECK (age BETWEEN 0 AND 150)
);

CREATE TABLE diagnoses (
    id SERIAL PRIMARY KEY,
    disease TEXT NOT NULL,
    patient INTEGER NOT NULL REFERENCES patients ON DELETE CASCADE
);

CREATE TABLE doctors_patients (
    id SERIAL PRIMARY KEY,
    doctor INTEGER REFERENCES doctors ON DELETE SET NULL,
    patient INTEGER NOT NULL REFERENCES patients ON DELETE CASCADE
);


-- 6
INSERT INTO doctors
    (name)
VALUES
    ('Eisa Stafford'),
    ('Faith Douglas'),
    ('Pollyanna Trevino'),
    ('Kaira Vega'),
    ('Alessandro Gutierrez'),
    ('Yusra Robson')
;

-- 10
INSERT INTO patients
    (name, age)
VALUES
    ('Vlad Noble', 25),
    ('Leon Ibarra', 64),
    ('Maci Austin', 14),
    ('Jozef Butt', 98),
    ('Kenneth Hills', 65),
    ('Shea Young', 35),
    ('Leslie Braun', 17),
    ('Kloe Barlow', 60),
    ('Jeff Greaves', 72),
    ('Chante Morley', 34)
;

INSERT INTO diagnoses
    (disease, patient)
VALUES
    ('Anaplasmosis', 1),
    ('Botulism', 5),
    ('Botulism', 1),
    ('Giardiasis', 3),
    ('Malaria', 8),
    ('Malaria', 10),
    ('Scombroid', 4)
;

INSERT INTO doctors_patients
    (doctor, patient)
Values
    (1, 4),
    (2, 4),
    (1, 7),
    (5, 9),
    (4, 2),
    (3, 1),
    (4, 5),
    (2, 10)
;
