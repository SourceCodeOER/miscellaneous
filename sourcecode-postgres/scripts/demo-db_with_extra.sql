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

-- need that so that following inserts work as expected
ALTER SEQUENCE exercises_library."Tags_id_seq" RESTART WITH 180;

-- Creates N (here N=10) 'PENDING' tags called "admin ?" (where ? is replaced by a letter of the alphabet string)
INSERT INTO exercises_library."Tags" (text, "createdAt", "updatedAt", version, category_id, state)
SELECT
    CONCAT('admin', ' ', a),
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

-- Add the common exercises used for validation
COPY exercises_library."Exercises" (id, title, description, "createdAt", "updatedAt", version, user_id, state, file, url) FROM stdin;
224	Decision Making in Java - if	<p>if statement is the most simple decision making statement. It is used to decide whether a certain statement or block of statements will be executed or not i.e if a certain condition is true then a block of statement is executed otherwise not.</p><p>Syntax:</p><p>if(condition) {</p><p>   // Statements to execute if</p><p>   // condition is true</p><p>}</p><p>Here, condition after evaluation will be either true or false. if statement accepts boolean values – if the value is true then it will execute the block of statements under it.</p><p>If we do not provide the curly braces { and } after if( condition ) then by default if statement will consider the immediate one statement to be inside its block.</p><p>Example :</p><p>// Java program to illustrate If statement </p><p>class IfDemo </p><p>{ </p><p>    public static void main(String args[]) </p><p>    { </p><p>        int i = 10; </p><p>  </p><p>        if (i &gt; 15) </p><p>            System.out.println("10 is less than 15"); </p><p>  </p><p>        // This statement will be executed </p><p>        // as if considers one statement by default </p><p>        System.out.println("I am Not in if"); </p><p>    } </p><p>} </p><p>Output:</p><p>I am Not in if</p>	2020-04-26 07:03:48.24+00	2020-04-26 07:03:48.242+00	0	1	PENDING	\N	\N
225	Decision Making in Java - if-else	<p>The if statement alone tells us that if a condition is true it will execute a block of statements and if the condition is false it won’t. But what if we want to do something else if the condition is false. Here comes the else statement. We can use the else statement with if statement to execute a block of code when the condition is false.</p><p>Syntax:</p><p>if (condition)</p><p>{</p><p>    // Executes this block if</p><p>    // condition is true</p><p>}</p><p>else</p><p>{</p><p>    // Executes this block if</p><p>    // condition is false</p><p>}</p><p>Example:</p><p>// Java program to illustrate if-else statement </p><p>class IfElseDemo </p><p>{ </p><p>    public static void main(String args[]) </p><p>    { </p><p>        int i = 10; </p><p>  </p><p>        if (i &lt; 15) </p><p>            System.out.println("i is smaller than 15"); </p><p>        else</p><p>            System.out.println("i is greater than 15"); </p><p>    } </p><p>} </p><p>Output:</p><p>i is smaller than 15</p>	2020-04-26 07:05:34.263+00	2020-04-26 07:05:34.264+00	0	1	PENDING	\N	\N
226	Decision Making in Java - nested-if	<p>A nested if is an if statement that is the target of another if or else. Nested if statements means an if statement inside an if statement. Yes, java allows us to nest if statements within if statements. i.e, we can place an if statement inside another if statement.</p><p>Syntax:</p><p>if (condition1) </p><p>{</p><p>   // Executes when condition1 is true</p><p>   if (condition2) </p><p>   {</p><p>      // Executes when condition2 is true</p><p>   }</p><p>}</p><p>Example:</p><p>// Java program to illustrate nested-if statement </p><p>class NestedIfDemo </p><p>{ </p><p>    public static void main(String args[]) </p><p>    { </p><p>        int i = 10; </p><p>  </p><p>        if (i == 10) </p><p>        { </p><p>            // First if statement </p><p>            if (i &lt; 15) </p><p>                System.out.println("i is smaller than 15"); </p><p>  </p><p>            // Nested - if statement </p><p>            // Will only be executed if statement above </p><p>            // it is true </p><p>            if (i &lt; 12) </p><p>                System.out.println("i is smaller than 12 too"); </p><p>            else</p><p>                System.out.println("i is greater than 15"); </p><p>        } </p><p>    } </p><p>} </p><p>Output:</p><p>i is smaller than 15</p><p>i is smaller than 12 too</p>	2020-04-26 07:06:38.67+00	2020-04-26 07:06:38.67+00	0	1	PENDING	\N	\N
227	Decision Making in Java - if-else-if ladder	<p>Here, a user can decide among multiple options.The if statements are executed from the top down. As soon as one of the conditions controlling the if is true, the statement associated with that if is executed, and the rest of the ladder is bypassed. If none of the conditions is true, then the final else statement will be executed.</p><p>if (condition)</p><p>    statement;</p><p>else if (condition)</p><p>    statement;</p><p>//...</p><p>//...</p><p>else</p><p>    statement;</p><p>Example:</p><p>// Java program to illustrate if-else-if ladder </p><p>class ifelseifDemo </p><p>{ </p><p>    public static void main(String args[]) </p><p>    { </p><p>        int i = 20; </p><p>  </p><p>        if (i == 10) </p><p>            System.out.println("i is 10"); </p><p>        else if (i == 15) </p><p>            System.out.println("i is 15"); </p><p>        else if (i == 20) </p><p>            System.out.println("i is 20"); </p><p>        else</p><p>            System.out.println("i is not present"); </p><p>    } </p><p>} </p><p>Output:</p><p>i is 20</p>	2020-04-26 07:07:26.682+00	2020-04-26 07:07:26.683+00	0	1	PENDING	\N	\N
\.

COPY exercises_library."Exercises_Metrics" (id, vote_count, avg_vote_score, tags_ids, exercise_id) FROM stdin;
224	0	0.00	{178,133,180,179,49}	224
225	0	0.00	{49,178,179,181,133}	225
226	0	0.00	{179,133,178,49,182}	226
227	0	0.00	{183,178,179,133,49}	227
\.

COPY exercises_library."Exercises_Tags" (exercise_id, tag_id) FROM stdin;
224	178
224	133
224	180
224	179
224	49
225	49
225	178
225	179
225	181
225	133
226	179
226	133
226	178
226	49
226	182
227	183
227	178
227	179
227	133
227	49
\.

-- Don't forgot to update sequence numbers !!!
ALTER SEQUENCE exercises_library."Exercises_Metrics_id_seq" RESTART WITH 228;
ALTER SEQUENCE exercises_library."Exercises_id_seq" RESTART WITH 228;
