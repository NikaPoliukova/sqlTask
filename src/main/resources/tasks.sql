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
  --