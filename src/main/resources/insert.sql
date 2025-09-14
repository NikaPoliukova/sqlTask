INSERT INTO student (id, name, surname, dob, primary_skill, created_datetime, updated_datetime) VALUES
(1, 'John',    'Smith',      '2000-01-01', 'Java',                now(), now()),
(2, 'Alice',   'Johnson',    '2001-02-02', 'Data Science',        now(), now()),
(3, 'Bob',     'K. Petrova',         '2002-03-03', 'C++',                 now(), now()),
(4, 'Diana',   'Petrova',    '1999-04-04', 'Machine-Learning',    now(), now()),
(5, 'Mark',    'Lee',        '2000-05-05', 'Python Developer',    now(), now()),
(6, 'Elena',   'Ivanova',    '2001-06-06', 'Java-Spring',         now(), now()),
(7, 'George',  'Brown',      '2002-07-07', 'DevOps',              now(), now()),
(8, 'Olga',    'S. Brown',         '2000-08-08', 'QA Engineer',         now(), now()),
(9, 'Peter',   'Taylor',     '2001-09-09', 'Frontend Developer',  now(), now()),
(10,'Nika',    'Peterson',   '1998-10-10', 'Backend',             now(), now());

-- === PHONE ===
INSERT INTO phone (id, student_id, number) VALUES
(1, 1, '+123456789'),
(2, 1, '+987654321'),
(3, 2, '+112233445'),
(4, 3, '+998877665'),
(5, 4, '+101010101'),
(6, 5, '+202020202');

-- === SUBJECT ===
INSERT INTO subject (name, tutor) VALUES
('Mathematics', 'Prof. White'),
('Physics',     'Dr. Black'),
('Databases',   'Prof. Green'),
('Algorithms',  'Dr. Gray'),
('AI',          'Prof. Blue');

-- === EXAM_RESULT ===
-- Student 1: passed multiple subjects
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(1, 1, 9),
(1, 2, 8),
(1, 3, 5),
(1, 5, null),
(1, 6, null),
(1, 7, null);

-- Student 2: different subjects
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(2, 1, 7),
(2, 2, 6),
(2, 4, 8);

-- Student 3: same subject twice
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(3, 3, 4),
(3, 3, 6);

-- Student 4: one exam
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(4, 5, 10);

-- Student 5: two exams, same subject
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(5, 2, 3),
(5, 2, 2);

-- Student 6: mix
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(6, 1, 5),
(6, 4, 6);

-- Student 7: no exams (для заданий про студентов без экзаменов)

-- Student 8: one exam
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(8, 1, 7);

-- Student 9: multiple subjects
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(9, 2, 4),
(9, 3, 8),
(9, 5, 9);

-- Student 10: only one exam
INSERT INTO exam_result (student_id, subject_id, mark) VALUES
(10, 4, 1);
(22, 1, null);
(22, 2, null);
(22, 3, null);
