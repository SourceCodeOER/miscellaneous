-- Update all exercises with status "VALIDATED"

UPDATE exercises_library."Exercises"
SET state = 'VALIDATED';

-- Creates a Tag with "course" category with text "validation mémoire"
COPY exercises_library."Tags" (id, text, "createdAt", "updatedAt", version, category_id, state) FROM stdin;
178	validation mémoire	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	2	VALIDATED
179	example	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	3	DEPRECATED
\.

-- Update state of following exercises
UPDATE exercises_library."Exercises"
SET state = 'PENDING'
WHERE id IN (102, 196, 162);

-- Creates N (here N=10) admin users called "admin ?" (where ? is replaced by a letter of the alphabet string) with password "admin"
INSERT INTO exercises_library."Users"(email, password, "fullName", role)
SELECT 
    CONCAT('admin', a, '@sourcecode.be') AS "email",
    '$2a$10$jbUgpnaFTPbfnafT2uBRL.OuhCS.lY8DDQh9KfPj9F7jnGu8cuhAq' AS "password",
    CONCAT('Admin', ' ', a) AS "fullName",
    'admin' AS "role"
FROM unnest(
    regexp_split_to_array(
        LEFT('ABCDEFGHIJKLMNOPQRSTUVWXYZ',10),
        ''
    )
) a;