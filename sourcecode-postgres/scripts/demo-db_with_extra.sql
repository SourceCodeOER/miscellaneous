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

-- Randomize "updatedAt" field of each sheet
-- ( since "createdAt" for each sheet is 2019-12-30 , an random interval of 90 days should be enough using NOW )
WITH randomizeRows AS (
    SELECT id, NOW() - (random() * (interval '90 days')) AS "randomTimestamp"
    FROM exercises_library."Exercises"
)
UPDATE exercises_library."Exercises" as f
SET "updatedAt" = randomizeRows."randomTimestamp"
FROM randomizeRows
WHERE f.id = randomizeRows.id;

-- Creates N (here N=10) 'PENDING' tags called "admin ?" (where ? is replaced by a letter of the alphabet string)
INSERT INTO exercises_library."Tags" (text, "createdAt", "updatedAt", version, category_id, state)
SELECT
    CONCAT('admin', ' ', a) AS "fullName",
    '2020-03-04 11:48:58.716+00',
    '2020-03-04 11:48:58.716+00',
    0,
    6,
    'PENDING'
FROM unnest(
    regexp_split_to_array(
        LEFT('ABCDEFGHIJKLMNOPQRSTUVWXYZ',10),
        ''
    )
) a;
