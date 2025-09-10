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
