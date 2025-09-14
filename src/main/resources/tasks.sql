--***Task  1--
--Select all primary skills that contain more than one word
--(please note that both ‘-‘ and ‘ ’ could be used as a separator)
SELECT  primary_skill
	FROM public.student
WHERE primary_skill LIKE '% %'
   OR primary_skill LIKE '%-%';

 --***Task  2--
 --Select all students who does not have second name
 --(it is absent or consists from only one letter/letter with dot)
 SELECT  *
 	FROM public.student
 	where surname NOT LIKE '%.%'

 --***Task  3--
  --Select number of students passed exams for each subject and order result by number of student descending
SELECT subject_id,  count(DISTINCT student_id) as count_students
	FROM public.exam_result
	where mark is not null
	group by subject_id
	order by count_students desc;

 --***Task  4--
  --Select number of students with the same exam marks for each subject

SELECT subject_id, mark ,  count(DISTINCT student_id) as count_students
	FROM public.exam_result
	where mark is not null
	group by subject_id, mark

--***Task  5--
--Select students who passed at least two exams for different subject.
SELECT student_id,
       COUNT(DISTINCT subject_id) AS subject_count
FROM public.exam_result
WHERE mark IS NOT NULL
GROUP BY student_id
HAVING COUNT(DISTINCT subject_id) >= 2;
--***Task  6--
--Select students who passed at least two exams for the same subject.
SELECT student_id,
       subject_id,
       COUNT(*) AS exam_count
FROM public.exam_result
WHERE mark IS NOT NULL
GROUP BY student_id, subject_id
HAVING COUNT(*) >1;

--***Task  7--
--Select all subjects which exams passed only students with the same primary skills.
SELECT subject.id, subject.name
FROM subject
JOIN exam_result ON subject.id = exam_result.subject_id
JOIN student ON exam_result.student_id = student.id
WHERE exam_result.mark IS NOT NULL
GROUP BY subject.id, subject.name
HAVING COUNT(DISTINCT student.primary_skill) = 1;

--***Task  8--
--Select all subjects which exams passed only students with the different primary skills.
--It means that all students passed the exam for the one subject must have different primary skill
SELECT subject.id, subject.name
FROM subject
JOIN exam_result ON subject.id = exam_result.subject_id
JOIN student ON exam_result.student_id = student.id
WHERE exam_result.mark IS NOT NULL
GROUP BY subject.id, subject.name
HAVING COUNT(student.id) = COUNT(DISTINCT student.primary_skill);
--***Task  9--
--Select students who does not pass any exam using each the following operator:
 -- 1) Outer join
SELECT s.id, s.name
FROM student s
LEFT JOIN exam_result er
    ON s.id = er.student_id
GROUP BY s.id, s.name
HAVING COUNT(er.mark) = 0;

 -- 2)Subquery with ‘not in’ clause
SELECT s.id, s.name
FROM student s
WHERE s.id NOT IN (
    SELECT er.student_id
    FROM exam_result er
    WHERE er.mark IS NOT NULL
);

  --3)Subquery with ‘any ‘
SELECT s.id, s.name
FROM student s
WHERE NOT s.id = ANY (
    SELECT er.student_id
    FROM exam_result er
    WHERE er.mark IS NOT NULL
);
--***Task  10--
--Select all students whose average mark is bigger than overall average mark
SELECT s.id, s.name, AVG(er.mark) AS avgcount
FROM student s
JOIN exam_result er ON s.id = er.student_id
GROUP BY s.id, s.name
HAVING AVG(er.mark) > (
    SELECT AVG(mark)
    FROM exam_result
    WHERE mark IS NOT NULL
)
--***Task  11--
--Select top 5 students who passed their last exam better than average students.
SELECT s.id, s.name, AVG(er.mark) AS avgcount
FROM student s
JOIN exam_result er ON s.id = er.student_id
GROUP BY s.id, s.name
HAVING AVG(er.mark) > (
    SELECT AVG(mark)
    FROM exam_result
    WHERE mark IS NOT NULL
)
ORDER BY avgcount DESC
LIMIT 5
--***Task  12--
--Select biggest mark for each student and add text description for the mark (use COALESCE and WHEN operators)
  -- In case if student has not passed any exam ‘not passed' should be returned.
  --If student mark is 1,2,3 – it should be returned as ‘BAD’
  --If student mark is 4,5,6 – it should be returned as ‘AVERAGE’
  --If student mark is 7,8 – it should be returned as ‘GOOD’
  --If student mark is 9,10 – it should be returned as ‘EXCELLENT’

  SELECT
      s.id,
      s.name,
      COALESCE(
          CASE
              WHEN MAX(er.mark) BETWEEN 1 AND 3 THEN 'BAD'
              WHEN MAX(er.mark) BETWEEN 4 AND 6 THEN 'AVERAGE'
              WHEN MAX(er.mark) BETWEEN 7 AND 8 THEN 'GOOD'
              WHEN MAX(er.mark) BETWEEN 9 AND 10 THEN 'EXCELLENT'
          END,
          'not passed'
      ) AS mark_description
  FROM student s
  LEFT JOIN exam_result er
      ON s.id = er.student_id
  GROUP BY s.id, s.name
  ORDER BY s.id;


--***Task  13--
--Select number of all marks for each mark type (‘BAD’, ‘AVERAGE’,…)
SELECT
    CASE
        WHEN mark BETWEEN 1 AND 3 THEN 'BAD'
        WHEN mark BETWEEN 4 AND 6 THEN 'AVERAGE'
        WHEN mark BETWEEN 7 AND 8 THEN 'GOOD'
        WHEN mark BETWEEN 9 AND 10 THEN 'EXCELLENT'
    END AS mark_type,
    COUNT(*) AS count_marks
FROM exam_result
WHERE mark IS NOT NULL
GROUP BY mark_type
