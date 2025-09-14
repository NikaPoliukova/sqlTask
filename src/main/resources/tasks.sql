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
--