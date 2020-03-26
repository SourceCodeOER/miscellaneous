-- Update all exercises with status "VALIDATED"

UPDATE exercises_library."Exercises"
SET state = 'VALIDATED';

-- Creates a Tag with "course" category with text "validation mémoire"
COPY exercises_library."Tags" (id, text, "createdAt", "updatedAt", version, category_id, state) FROM stdin;
178	validation mémoire	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	2	VALIDATED
179	StudentJob	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	3	VALIDATED
180	match	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	3	DEPRECATED
181	example	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	3	DEPRECATED
\.

-- Update state of following exercises
UPDATE exercises_library."Exercises"
SET state = 'PENDING'
WHERE id IN (102, 196, 162);