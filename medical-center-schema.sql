
CREATE TABLE patients (
    id serial primary key,
    name text NOT NULL
);

CREATE TABLE medical_centers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE doctors (
    id serial primary key,
    name text NOT NULL,
    specialty text
);

CREATE TABLE diagnoses (
    id serial primary key,
    diagnosis text NOT NULL
);

ALTER TABLE patients ADD doctors_id INT REFERENCES doctors;

ALTER TABLE patients ADD diagnoses_id INT REFERENCES diagnoses;

ALTER TABLE doctors ADD medical_center_id INT NOT NULL REFERENCES medical_centers;

ALTER TABLE doctors ADD patients_id INT REFERENCES patients;

-- Testing database: VVVVV

INSERT INTO medical_centers (name) VALUES ('Mercy Medical Center');

INSERT INTO diagnoses (diagnosis) VALUES ('flu'),('pregnant'),('cancer');

INSERT INTO patients (name,doctors_id,diagnoses_id) VALUES ('Mike',2,1),('Megan',3,2),('Greg',1,3);

INSERT INTO doctors (name,specialty,medical_center_id,patients_id) VALUES ('Dr. Rachel Sanders','oncologist',1,3),('Dr. Susan McCoy','general practitioner',1,1),('Dr. Mallory Smith','obgyn',1,2);

-- Database tests:
-- SELECT patients.name,doctors.name,diagnoses.diagnosis FROM patients JOIN doctors ON patients.doctors_id = doctors.id JOIN diagnoses ON diagnoses.id = patients.diagnoses_id;

-- RESULT: 
--  name  |        name        | diagnosis
-- -------+--------------------+-----------
--  Mike  | Dr. Susan McCoy    | flu
--  Megan | Dr. Mallory Smith  | pregnant
--  Greg  | Dr. Rachel Sanders | cancer

-- SELECT doctors.name,medical_centers.name,patients.name FROM doctors JOIN medical_centers ON doctors.medical_center_id = medical_centers.id JOIN patients ON patients.id = doctors.patients_id;

-- RESULT:
--         name        |         name         | name
-- --------------------+----------------------+-------
--  Dr. Susan McCoy    | Mercy Medical Center | Mike
--  Dr. Mallory Smith  | Mercy Medical Center | Megan
--  Dr. Rachel Sanders | Mercy Medical Center | Greg