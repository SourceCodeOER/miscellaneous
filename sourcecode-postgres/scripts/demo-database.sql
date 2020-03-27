--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: exercises_library; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA exercises_library;


--
-- Name: enum_Exercises_state; Type: TYPE; Schema: exercises_library; Owner: -
--

CREATE TYPE exercises_library."enum_Exercises_state" AS ENUM (
    'DRAFT',
    'PENDING',
    'VALIDATED',
    'NOT_VALIDATED',
    'ARCHIVED'
);


--
-- Name: enum_Tags_state; Type: TYPE; Schema: exercises_library; Owner: -
--

CREATE TYPE exercises_library."enum_Tags_state" AS ENUM (
    'NOT_VALIDATED',
    'VALIDATED',
    'DEPRECATED',
    'PENDING'
);


--
-- Name: enum_Users_role; Type: TYPE; Schema: exercises_library; Owner: -
--

CREATE TYPE exercises_library."enum_Users_role" AS ENUM (
    'admin',
    'super_admin',
    'user'
);


SET default_table_access_method = heap;

--
-- Name: Configurations; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Configurations" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    title character varying(255) DEFAULT ''::character varying,
    user_id integer NOT NULL
);


--
-- Name: Configurations_Tags; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Configurations_Tags" (
    configuration_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: Configurations_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Configurations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Configurations_id_seq" OWNED BY exercises_library."Configurations".id;


--
-- Name: Exercises; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Exercises" (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text DEFAULT ''::text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    user_id integer NOT NULL,
    state exercises_library."enum_Exercises_state" DEFAULT 'DRAFT'::exercises_library."enum_Exercises_state",
    file character varying,
    url character varying
);


--
-- Name: Exercises_Metrics; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Exercises_Metrics" (
    id integer NOT NULL,
    vote_count integer DEFAULT 0 NOT NULL,
    avg_vote_score numeric(3,2) DEFAULT 0 NOT NULL,
    tags_ids integer[] DEFAULT ARRAY[]::integer[] NOT NULL,
    exercise_id integer NOT NULL
);


--
-- Name: Exercises_Metrics_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Exercises_Metrics_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Exercises_Metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Exercises_Metrics_id_seq" OWNED BY exercises_library."Exercises_Metrics".id;


--
-- Name: Exercises_Tags; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Exercises_Tags" (
    exercise_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: Exercises_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Exercises_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Exercises_id_seq" OWNED BY exercises_library."Exercises".id;


--
-- Name: Notations; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Notations" (
    id integer NOT NULL,
    note numeric(3,2) NOT NULL,
    exercise_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: Notations_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Notations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Notations_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Notations_id_seq" OWNED BY exercises_library."Notations".id;


--
-- Name: SequelizeMeta; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."SequelizeMeta" (
    name character varying(255) NOT NULL
);


--
-- Name: Tag_Categories; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Tag_Categories" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL
);


--
-- Name: Tag_Categories_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Tag_Categories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Tag_Categories_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Tag_Categories_id_seq" OWNED BY exercises_library."Tag_Categories".id;


--
-- Name: Tags; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Tags" (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    category_id integer NOT NULL,
    state exercises_library."enum_Tags_state" DEFAULT 'NOT_VALIDATED'::exercises_library."enum_Tags_state"
);


--
-- Name: Tags_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Tags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Tags_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Tags_id_seq" OWNED BY exercises_library."Tags".id;


--
-- Name: Users; Type: TABLE; Schema: exercises_library; Owner: -
--

CREATE TABLE exercises_library."Users" (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "fullName" character varying(255) NOT NULL,
    role exercises_library."enum_Users_role" NOT NULL
);


--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: exercises_library; Owner: -
--

CREATE SEQUENCE exercises_library."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: exercises_library; Owner: -
--

ALTER SEQUENCE exercises_library."Users_id_seq" OWNED BY exercises_library."Users".id;


--
-- Name: Configurations id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Configurations" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Configurations_id_seq"'::regclass);


--
-- Name: Exercises id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Exercises_id_seq"'::regclass);


--
-- Name: Exercises_Metrics id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises_Metrics" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Exercises_Metrics_id_seq"'::regclass);


--
-- Name: Notations id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Notations" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Notations_id_seq"'::regclass);


--
-- Name: Tag_Categories id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Tag_Categories" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Tag_Categories_id_seq"'::regclass);


--
-- Name: Tags id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Tags" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Tags_id_seq"'::regclass);


--
-- Name: Users id; Type: DEFAULT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Users" ALTER COLUMN id SET DEFAULT nextval('exercises_library."Users_id_seq"'::regclass);


--
-- Data for Name: Configurations; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Configurations" (id, name, title, user_id) FROM stdin;
4	Recettes et algorithmes		2
9	Exos en C et Java	code	2
10	Testing en Java	Testing	1
11	Test de favori	Depth	2
7	Plateforme Google	li	2
12	Mon premier	mon	2
1	Cours de Java avec John		2
\.


--
-- Data for Name: Configurations_Tags; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Configurations_Tags" (configuration_id, tag_id) FROM stdin;
9	55
9	8
10	55
11	71
11	55
11	8
11	37
11	5
7	1
7	93
4	1
4	90
4	91
4	31
12	114
1	70
1	55
1	71
\.


--
-- Data for Name: Exercises; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Exercises" (id, title, description, "createdAt", "updatedAt", version, user_id, state, file, url) FROM stdin;
131	MyArrayList	<p>In this task, you have to implement your own version of the famous java's <code>ArrayList&lt;E&gt;</code> : a dynamic sized array. Each time you want to add an element, you must check that the item can fit and then append it at the end of the list. If the array is too small, you need to resize it so that new items can be added in the future. To remove an element you need to specify an index to choose which element of the list you want to remove (<code>remove(0)</code> for the first ... <code>remove(size()-1)</code> for the last). <strong>Never</strong> leave "blanks" in your array. When you remove an element at some <code>index</code>, <strong>all subsequents</strong> elements must be "shifted".</p>\n<p>So if your list look like this:</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/MyArrayList/before.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>Then after the call <code>remove(1)</code> it should look like this:</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/MyArrayList/after.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>You also need to implement the <code>MyArrayListIterator</code> class. <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Iterator.html">Iterator</a> is an interface you have to implement in order to make the class implementing it able to enumerate/browse/iterate over an object : here, we want you to implement a FIFO order iterator over your <code>MyArrayList</code>.</p>\n<blockquote>\n<p><strong>Pay attention</strong>, we add some constraints for this task:</p>\n<blockquote>\n<ul>\n<li>Your iterator don't have to implement the <code>remove</code> method from <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Iterator.html">Iterator</a>.</li>\n<li>Your iterator must throw a <code>ConcurrentModificationException</code> when you want to get the next element but some other element has been added to the list meanwhile.</li>\n<li>You cannot use <code>System.arraycopy</code> for this task.</li>\n<li>Your constructor must throw an <code>IndexOutOfBoundsException</code> if the parameter is smaller than 0.</li>\n<li>your <code>remove</code> method must throw an <code>IndexOutOfBoundsException</code> if the index parameter is smaller than <code>0</code> or greater than <code>size()-1</code>.</li>\n</ul>\n</blockquote>\n</blockquote>\n<p>A lot of classes implement this interface, including the official <a href="https://docs.oracle.com/javase/7/docs/api/java/util/ArrayList.html">ArrayList</a> from java. We <strong>strongly</strong> encourage you to experiment how the <code>ArrayList&lt;E&gt;</code> iterator works before implementing yours.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/MyArrayList/LEPL1402_MyArrayList.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<p>Here is the class (downloadable <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/MyArrayList/MyArrayList.java">here</a>) where we will insert your code :</p>\n<pre class="java"><code>import java.util.ConcurrentModificationException;\nimport java.util.Iterator;\n\npublic class MyArrayList&lt;Item&gt; implements Iterable&lt;Item&gt; {\n\n    private Object [] list;\n    private int size;\n\n\n    public MyArrayList(int initSize){\n        // YOUR CODE HERE\n    }\n\n\n    /*\n    * Checks if &#39;list&#39; needs to be resized then add the element at the end\n    * of the list.\n    */\n    public void enqueue(Item item){\n        // YOUR CODE HERE\n    }\n\n\n    /*\n    * Removes the element at the specified position in this list.\n    * Returns the element that was removed from the list. You dont need to\n    * resize when removing an element.\n    */\n    public Item remove(int index){\n        // YOUR CODE HERE\n    }\n\n\n    public int size(){\n        return this.size;\n    }\n\n\n    @Override\n    public Iterator&lt;Item&gt; iterator() {\n        return new MyArrayListIterator();\n    }\n\n\n    private class MyArrayListIterator implements Iterator&lt;Item&gt; {\n        // YOUR CODE HERE\n    }\n\n}</code></pre>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
206	Rabin Karp	<p>A la page 777 du livre "Algorithms" 4th edition, on vous propose l'implémentation suivante de l'algorithme de Rabin Karp.</p>\n<pre class="java"><code>public class RabinKarp {\n  private String pat;      // the pattern  // needed only for Las Vegas\n  private long patHash;    // pattern hash value\n  private int m;           // pattern length\n  private long q;          // a large prime, small enough to avoid long overflow\n  private int R;           // radix\n  private long RM;         // R^(M-1) % Q\n\n  public RabinKarp(String pat) {\n      this.pat = pat;      // save pattern (needed only for Las Vegas)\n      R = 256;\n      m = pat.length();\n      q = longRandomPrime();\n\n      // precompute R^(m-1) % q for use in removing leading digit\n      RM = 1;\n      for (int i = 1; i &lt;= m-1; i++)\n          RM = (R * RM) % q;\n      patHash = hash(pat, m);\n  }\n\n  // Compute hash for key[0..m-1].\n  private long hash(String key, int m) {\n      long h = 0;\n      for (int j = 0; j &lt; m; j++)\n          h = (R * h + key.charAt(j)) % q;\n      return h;\n  }\n\n  // Monte Carlo\n  private boolean check(int i) {\n      return true;\n  }\n\n  // Returns the index of the first occurrrence of the pattern string in the text string.\n  public int search(String txt) {\n      int n = txt.length();\n      if (n &lt; m) return n;\n      long txtHash = hash(txt, m);\n\n      // check for match at offset 0\n      if ((patHash == txtHash) &amp;&amp; check(txt, 0))\n          return 0;\n\n      // check for hash match; if hash match, check for exact match\n      for (int i = m; i &lt; n; i++) {\n          // Remove leading digit, add trailing digit, check for match.\n          txtHash = (txtHash + q - RM*txt.charAt(i-m) % q) % q;\n          txtHash = (txtHash*R + txt.charAt(i)) % q;\n\n          // match\n          int offset = i - m + 1;\n          if ((patHash == txtHash) &amp;&amp; check(txt, offset))\n              return offset;\n      }\n\n      // no match\n      return n;\n  }\n\n\n  // a random 31-bit prime\n  private static long longRandomPrime() {\n      BigInteger prime = BigInteger.probablePrime(31, new Random());\n      return prime.longValue();\n  }\n\n}</code></pre>\n	2019-12-30 17:05:18.963+00	2020-03-01 15:41:59.367+00	11	1	VALIDATED	\N	\N
187	Huffman	<p>Vous devez calculer un arbre de Huffman au départ de la fréquence donnée pour chacune des R lettres (characters).</p>\n<p>Pour rappel, dans un arbre de Huffman nous avons que <em>la somme de la fréquence associée à chaque feuille multipliée par la profondeur de celle-ci est minimale</em>.</p>\n<p>Par exemple, étant donné les fréquences suivantes:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5Huffman/huffmanin.png" class="align-center" width="500" alt="Input frequencies" /></p>\n<p>un arbre de Huffman pourrait être:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5Huffman/huffmanout.png" class="align-center" width="500" alt="Huffman tree" /></p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5Huffman/LSINF1121_PART5_Huffman.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2020-02-03 13:33:26.762+00	3	1	DRAFT	\N	\N
2	BST : Insert and Delete	<p>To help you study your english course, you've got the wonderful idea of creating a Binary Search Tree (BST). This will also help you to study for the LSINF1252 course! The key of each node will be the english word and the value will be the french word corresponding. Those are represented using an array of char. So let's define our 2 structures :</p>\n<pre class="c"><code>typedef struct bt {\n    struct node *root;\n} bt_t;\n\ntypedef struct node {\n    char *enWord;\n    char *frWord;\n    struct node *left;\n    struct node *right;\n} node_t;</code></pre>\n<p><strong>What is a Binary Search Tree (BST) ?</strong></p>\n<p>A Binary Search Tree is a tree for which every node has a special property : the subtree defined by node.left only contains keys(enWord) lower than the node's key. Similarly, the subtree defined by node.right only contains keys higher than the node's key. This is helpful when searching for a specific key in the data structure.</p>\n<p>TODO : SCHEME NEEDED + EXPLAIN WHICH NODE IS THE ROOT. + CHANGE THE CODE : word -&gt; enWord, definition -&gt; frWord.</p>\n<p><strong>Your mission</strong></p>\n<p>Your mission will be to implement the <strong>insert</strong> and the <strong>delete</strong> functions.</p>\n<ul>\n<li><strong>Insert</strong> function :</li>\n</ul>\n<p>For each node we know this : every key (<em>enWord</em>) in the node.left subpart is lower than the key of the node. Similarly, every key (<em>enWord</em>) in the node.right subpart is lower than the key of the node. We use the alphabetical order to check if one word is lower or higher than another one.</p>\n<ul>\n<li><strong>Delete</strong> function :</li>\n</ul>\n<p>Deleting a node in a tree like that might not be easy ! That's why I'll explain you how to proceed (you'll have to use this procedure in order to get the points). If the node we want to delete has 0 or only 1 child, it's quite easy, we only have to replace this node by his child (if there is one). When it comes to a node which has two children, it's harder. We first have to find the right subtree's leftmost child. In the example, if we want to suppress <em>XXX</em>, the leftmost node of the right subpart is <em>YYY</em>. Then, we can move <em>YYY</em> to <em>XXX</em> and replace <em>YYY</em> by his child (if it has one).</p>\n<p>SCHEME NEEDED for XXX and YYY.</p>\n<p><em>Hints :</em></p>\n<ul>\n<li><code>char *enWord</code> and <code>char *frWord</code> are pointers, memory must be allocated by using <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/malloc.3.html">malloc(3)</a> to copy the strings in the tree.</li>\n<li>Other useful commands: <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/strcpy.3.html">strcpy(3)</a>, <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/strlen.3.html">strlen(3)</a> and <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/strcmp.3.html">strcmp(3)</a>.</li>\n<li>Do not forget to free <strong>all</strong> the allocated space deleting an element.</li>\n</ul>\n	2019-12-30 17:00:49.294+00	2020-03-01 15:41:59.366+00	1	1	VALIDATED	\N	\N
211	La règle de trois	<p>Maintenant qu'on se rappelle du fonctionnement d'une règle de trois, il est temps de calculer les quantités nécessaires pour faire le gâteau pour plus de 2 personnes. A toi de voir pour combien de personnes tu veux faire la recette.</p>\n<p><strong>Recette pour deux personnes</strong></p>\n<ul>\n<li>45gr de farine</li>\n<li>45gr de sucre</li>\n<li>45gr de beurre</li>\n<li>1 oeuf</li>\n<li>3gr de levure chimique</li>\n</ul>\n	2019-12-30 17:05:33.853+00	2020-03-01 15:41:59.367+00	5	1	VALIDATED	\N	\N
132	Observer design pattern	<p>In this task, you have to implement the Observer design pattern for the case of a meteo station:</p>\n<pre class="java"><code>public class MeteoStation extends Observable {\n    // YOUR CODE HERE\n}\n\n\npublic class Client extends Observer {\n    // YOUR CODE HERE\n}</code></pre>\n<p>Note that <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Observer/Observable.java">Observable</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Observer/Observer.java">Observer</a> are two abstract classes containing abstract methods. Therefore, check and read them carefully in order to implement things correctly. For your <code>Client</code> class you have to extend the observer class and implement a constructor (do not forget instance variables). For the <code>MeteoStation</code> class, extend the Observable abstract class, you will need to use <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Observer/Pair.java">Pair</a> for this one.</p>\n<p>Note that your observers start to receive messages at the moment they subscribe but they should not see messages that were broadcast before they subscribed.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Observer/LEPL1402_Observer.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
133	Optional - no more concerns about NullPointerException	<p>The 8th version of java introduced the <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html">Optional</a> object to avoid NullPointerException in our codes without using too many check on nullable objects.</p>\n<p>For this task, we give you three small classes (<a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Optional/Person.java">Person</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Optional/Team.java">Team</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Optional/TeamLeader.java">TeamLeader</a>) and you have to implement the different methods of <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Optional/OptionalTest.java">OptionalTest</a>. All methods can be implemented in one line of code thanks to the different methods of <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html">Optional</a> and the lambda expressions.</p>\n<p>You are not allow to use <code>new TeamLeader()</code> in these exercises.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Optional/LEPL1402_Optional.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
200	Depth First Paths	<p>Consider this class, <code>DepthFirstPaths</code>, that computes paths to any connected node from a source node <code>s</code> in an undirected graph.</p>\n<pre class="java"><code>// TODO\n\npublic class DepthFirstPaths {\n    private boolean[] marked; // marked[v] = is there an s-v path?\n    private int[] edgeTo;     // edgeTo[v] = last edge on s-v path\n    private final int s;\n\n    /**\n     * Computes a path between s and every other vertex in graph G\n     * @param G the graph\n     * @param s the source vertex\n     */\n     public DepthFirstPaths(Graph G, int s) {\n         this.s = s;\n         edgeTo = new int[G.V()];\n         marked = new boolean[G.V()];\n         dfs(G, s);\n     }\n\n     // Depth first search from v\n     private void dfs(Graph G, int v) {\n         // TODO\n     }\n\n     /**\n      * Is there a path between the source s and vertex v?\n      * @param v the vertex\n      * @return true if there is a path, false otherwise\n      */\n     public boolean hasPathTo(int v) {\n         // TODO\n     }\n\n     /**\n      * Returns a path between the source vertex s and vertex v, or\n      * null if no such path\n      * @param v the vertex\n      * @return the sequence of vertices on a path between the source vertex\n      *         s and vertex v, as an Iterable\n      */\n     public Iterable&lt;Integer&gt; pathTo(int v) {\n         // TODO\n     }\n}</code></pre>\n<p>The class <code>Graph</code> is already implemented. Here is its specification:</p>\n<pre class="java"><code>public class Graph {\n    // @return the number of vertices\n    public int V() { }\n\n    // @return the number of edges\n    public int E() { }\n\n    // Add edge v-w to this graph\n    public void addEdge(int v, int w) { }\n\n    // @return the vertices adjacent to v\n    public Iterable&lt;Integer&gt; adj(int v) { }\n\n    // @return a string representation\n    public String toString() { }\n}</code></pre>\n<p><strong>Note:</strong> The following questions will ask you to implement the function left out. You don't need to put the brackets (<code>{ }</code>) surrounding the function body in your answer.</p>	2019-12-30 17:05:18.963+00	2020-03-01 15:41:59.367+00	1	1	VALIDATED	\N	\N
3	Liste doublement chaînée	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>	2019-12-30 17:00:49.294+00	2020-03-01 15:41:59.366+00	1	1	VALIDATED	\N	\N
5	Parcours de fichiers	<p>Parcourez un fichier sans jamais utiliser l'appel système read. Le syllabus est accessible depuis <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>	2019-12-30 17:00:49.294+00	2020-03-01 15:41:59.366+00	1	1	VALIDATED	\N	\N
9	Absolute value	<p>The absolute value of a number is defined as <em>|n| = n</em> if <em>n &gt;= 0</em>, <em>|n| = -n</em> else.</p>	2019-12-30 17:00:49.295+00	2020-03-01 15:41:59.367+00	1	1	VALIDATED	\N	\N
31	Factorial	<p>The factorial of an integer <em>n!</em> is defined as <code>n! = 1*2*3*...*(n-1)*n</code>, with <em>0! = 1</em>.</p>	2019-12-30 17:00:49.299+00	2019-12-30 17:00:49.299+00	0	1	DRAFT	\N	\N
163	Global Warming (implem)	<h1 id="context">Context</h1>\n<p>Supposons la matrice 5x5 suivante :</p>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};</code></pre>\n<p>représentée dans le tableau ci-dessous :</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part2GlobalWarming/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n<p>Chaque entrée de la matrice représente une altitude. L'objectif est d'implémenter une classe <code>GlobalWarmingImpl</code> qui étend la méthode <span class="title-ref">GlobalWarming</span> décrite ci-dessous.</p>\n<p>Compte tenu d'un niveau d'eau global, toutes les positions de la matrice ayant une valeur <em>&lt;=</em> au niveau d'eau sont inondées et donc peu sûres. Donc, en supposant que le niveau d'eau est de <em>3</em>, tous les points sûrs sont en vert (dans la représentation ci-dessus).</p>\n<p>La méthode que vous devez implémentez est <code>nbSafePoints</code></p>\n<ul>\n<li>le calcul du nombre de points de sécurité pour un niveau d'eau donné</li>\n</ul>\n<pre class="java"><code>import java.util.List;\n\nabstract class GlobalWarming {\n\n\n    final int[][] altitude;\n\n    /**\n     * @param altitude is a n x n matrix of int values representing altitudes (positive or negative)\n     */\n    public GlobalWarming(int[][] altitude) {\n        this.altitude = altitude;\n    }\n\n    /**\n     *\n     * @param waterLevel\n     * @return the number of entries in altitude matrix that would be above\n     *         the specified waterLevel.\n     *         Warning: this is not the waterLevel given in the constructor/\n     */\n    public abstract int nbSafePoints(int waterLevel);\n\n}</code></pre>\n<p><a href="/course/LSINF1121-2016/Part2GlobalWarming/LSINF1121_PART2_GlobalWarming.zip">Le projet IntelliJ est disponible ici</a>.</p>\n<h1 id="exercices-préliminaires">Exercices préliminaires</h1>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};\nGlobalWarming gw = new MyGlobalWarming(tab);</code></pre>\n	2019-12-30 17:05:18.959+00	2020-03-02 21:38:45.943+00	1	1	VALIDATED	\N	\N
181	Global Warming (implem)	<h1 id="context">Context</h1>\n<p>Supposons la matrice 5x5 suivante:</p>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};</code></pre>\n<p>représentée dans le tableau ci-dessous :</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6GlobalWarming/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n<p>Chaque entrée de la matrice représente une altitude. L'objectif est d'implémenter une classe <span class="title-ref">GlobalWarmingImpl</span> qui implémente toutes les méthodes décrites dans <span class="title-ref">GlobalWarming</span> données ci-dessous.</p>\n<p>Un niveau d'eau global spécifié dans le constructeur modélise le fait que toutes les positions de la matrice avec une valeur &lt;= le niveau d'eau sont inondées (sous l'eau) et donc dangereuses. Dans l'exemple ci-dessus, le niveau d'eau est de 3, tous les points sûrs sont en vert.</p>\n<p>La méthode que vous devez implémenter doit permettre de calculer le chemin le plus court entre deux positions sont sur la même île</p>\n<p>nous supposons que les points sont <strong>uniquement connectés verticalement ou horizontalement</strong>.</p>\n<p><a href="/course/LSINF1121-2016/Part6GlobalWarming/LSINF1121_PART6_GlobalWarming.zip">Le projet IntelliJ est disponible ici</a>.</p>\n<pre class="java"><code>import java.util.List;\n\nabstract class GlobalWarming {\n\n    /**\n     * A class to represent the coordinates on the altitude matrix\n     */\n    public static class Point {\n\n        final int x, y;\n\n        Point(int x, int y) {\n            this.x = x;\n            this.y = y;\n        }\n\n        @Override\n        public boolean equals(Object obj) {\n            Point p = (Point) obj;\n            return p.x == x &amp;&amp; p.y == y;\n        }\n    }\n\n    final int[][] altitude;\n    final int waterLevel;\n\n\n    /**\n     * In the following, we assume that the points are connected to\n     * horizontal or vertical neighbors but not to the diagonal ones\n     * @param altitude is a n x n matrix of int values representing altitudes (positive or negative)\n     * @param waterLevel is the water level, every entry &lt;= waterLevel is flooded\n     */\n    public GlobalWarming(int[][] altitude, int waterLevel) {\n        this.altitude = altitude;\n        this.waterLevel = waterLevel;\n    }\n\n\n    /**\n     *\n     * @param p1 a safe point with valid coordinates on altitude matrix\n     * @param p2 a safe point (different from p1) with valid coordinates on altitude matrix\n     * @return the shortest simple path (vertical/horizontal moves) if any between from p1 to p2 using only vertical/horizontal moves on safe points.\n     *         an empty list if not path exists (i.e. p1 and p2 are not on the same island).\n     */\n    public abstract List&lt;Point&gt; shortestPath(Point p1, Point p2);\n\n}</code></pre>\n<h1 id="exercices-preliminaires">Exercices Preliminaires</h1>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};\nGlobalWarming gw = new MyGlobalWarming(tab,3);</code></pre>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6GlobalWarming/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n	2019-12-30 17:05:18.961+00	2020-03-02 21:38:45.944+00	1	1	VALIDATED	\N	\N
180	Word Transformation Shortest Path (implem)	<p>On vous demande d'implémenter la classe <code>WordTransformationSP</code> qui permet de trouver le plus court chemin permettant de passer d'un string <em>A</em> à un autre string <em>B</em> (avec la certitude qu'il y a bien un chemin permettant de transformer <em>A</em> en <em>B</em>).</p>\n<p>Pour cela on definit une opération <code>rotation(x, y)</code> qui inverse l’ordre des lettres entre la position x et y (non-inclus). Par exemple, avec A=<code>HAMBURGER</code>, si l'on fait <code>rotation(A, 4, 8)</code>, cela nous donne <code>HAMBEGRUR</code>. Vous pouvez donc constater que la sous-string <code>URGE</code> a été inversé en <code>EGRU</code> et le reste de la chaine est resté inchangé: <code>HAMB</code> + <code>ECRU</code> + <code>R</code> = <code>HAMBEGRUR</code>.</p>\n<p>Disons qu’une <code>rotation(x, y)</code> a un cout de y-x. Par exemple passer de <code>HAMBURGER</code> à <code>HAMBEGRUR</code> coût <em>8-4 = 4</em>.</p>\n<p>La question est de savoir quel est le coût minimum pour atteindre une string B à partir A?</p>\n<p>Vous devez donc inmplémenter la méthode une fonction <code>public static int minimalCost(String A, String B)</code> qui retourne le cout minimal pour atteindre le String B depuis A en utilisant l'opération rotation.</p>\n<pre class="java"><code>import java.util.*;\n\npublic  class WordTransformationSP {\n    /**\n     *\n     * Rotate the substring between start and end of a given string s\n     * eg. s = HAMBURGER, rotation(s,4,8) = HAMBEGRUR i.e. HAMB + EGRU + R\n     * @param s\n     * @param start\n     * @param end\n     * @return rotated string\n     */\n    public static String rotation(String s, int start, int end) {\n        return s.substring(0,start)+new StringBuilder(s.substring(start,end)).reverse().toString()+s.substring(end);\n    }\n\n    /**\n     * Compute the minimal cost from string &quot;from&quot; to string &quot;to&quot; representing the shortest path\n     * @param from\n     * @param to\n     * @return\n     */\n    public static int minimalCost(String from, String to) {\n        //TODO\n        return 0;\n    }\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6DijkstraForWordTransformation/LSINF1121_PART6_WordTransformation.zip">Le projet IntelliJ est disponible ici</a>.</p>\n<p><strong>Note:</strong> vous pouvez ajouter d'autres fonctions et des private classes si vous le désirez.</p>	2019-12-30 17:05:18.961+00	2020-03-02 21:38:45.944+00	1	1	VALIDATED	\N	\N
64	make basics	<p><em>Estimated time: 20 minutes</em></p>\n<p><code>make</code> is a task runner for targets described in a <span class="title-ref">Makefile</span>. It is mostly used to control the compilation of an executable from source code. Thus, you can use it to automate the tidious task of compiling your c code, or even automate the compilation of a report made with LaTeX.</p>\n<h1 id="make-a-new-beginning"><code>make</code> a new beginning</h1>\n<p>To give you a first taste, open up a <em>terminal</em> and type the following command: <code>make</code>.</p>\n<p><code>make</code> will greet you with the following message:</p>\n<pre class=""><code>make: *** No targets specified and no makefile found.  Stop.</code></pre>\n<p>So what happened? <code>make</code> first start to search in your <em>current directory</em> for a file called <code>Makefile</code>. This file contains <em>instructions</em>, aka <em>rules</em>, that tell <code>make</code> what to do. Since there is no such file, <code>make</code> stops almost instantly.</p>\n<h1 id="make-it-simple"><code>make</code> it simple</h1>\n<p>Now write a simple hello world program, which you will save into a file called <code>hello.c</code>. This program will print the following on the standard output:</p>\n<pre class=""><code>Hello make</code></pre>\n<p>Now, fire up your terminal, use <code>cd path/to/hello/folder/</code> to go to the directory which contains <code>hello.c</code> (<a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s2_make/hello.c">download hello.c</a> to compare with what you did) and type: <code>make hello</code></p>\n<p>Now the <code>make</code> comes alive and tells you something like:</p>\n<pre class=""><code>gcc     hello.c   -o hello</code></pre>\n<p>Wow! What happened? When you typed <code>make hello</code>, <code>hello</code> is what is called a <strong>target</strong>. A <strong>target</strong> is usually the name of a file that is generated by a program; examples of targets are executable or object files.</p>\n<p>Basically, <code>make</code> will search for a file named <code>hello</code> and detect from that file what programming language it uses. For most languages, <code>make</code> has some basic builtin recipes, called <strong>implicit rules</strong>, to compile it. Here the <strong>recipe</strong> is given in the above output.</p>\n<p>In that output:</p>\n<ul>\n<li><code>gcc</code> stands for <em>GNU C Compiler</em>;</li>\n<li><code>hello.c</code> the C program to be compiled;</li>\n<li><code>-o hello</code> an option to place the output of the compilation in the file <code>hello</code>.</li>\n</ul>\n<p>Now if you type <code>ls</code> in your command line, you will see that a file <code>hello</code> appeared. This is the <strong>executable</strong> built by <code>make</code> from <code>hello.c</code>. Now you can execute it and verify what is printed on the standard output.</p>\n<p>If you type again <code>make hello</code> in your command line, it will tell you:</p>\n<pre class=""><code>make: &#39;hello&#39; is up to date.</code></pre>\n<p>That is because <code>make</code> only builds the files that are changed. If <code>hello</code> is more recent than its source file <code>hello.c</code>, <code>make</code> will skip the compilation process.</p>\n<p>To see this, modify <code>hello.c</code> to write the following on the standard output:</p>\n<pre class=""><code>Hello, make!</code></pre>\n<p>Finally, run <code>make hello</code> again. Since <code>hello.c</code> is more recent than <code>hello</code>, <code>make</code> will compile the source file again.</p>\n<p>Thats it, you made your first experiences with <code>make</code>.</p>\n<p>Now I strongly recommend you read <a href="https://www.gnu.org/software/make/manual/make.html#Introduction">sections 2.1 to 2.3. in the GNU make manual</a>. It will only take you 10 minutes (included in the above given estimated time) and will help you understand how to <code>make</code> magic happen.</p>\n<p>Once you read these 3 sections, let us practice a bit.</p>\n<p>To try the following questions locally, you can download a zip file of the questions folder <a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s2_make/make_me.zip">here</a>.</p>\n<hr />\n<h1 id="references">References</h1>\n<ul>\n<li><a href="https://sites.uclouvain.be/SystInfo/notes/Outils/html/make.html">https://sites.uclouvain.be/SystInfo/notes/Outils/html/make.html</a></li>\n<li><a href="https://www.gnu.org/software/make/manual/">https://www.gnu.org/software/make/manual/</a></li>\n</ul>\n	2019-12-30 17:00:49.306+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
66	make basics - multiple choice questions	<p><em>Estimated time: 5 minutes</em></p>\n	2019-12-30 17:00:49.306+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
67	Cunit basics	<p><em>Estimated time: 5 minutes</em></p>\n	2019-12-30 17:00:49.306+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
71	Save struct into file	<p><em>Estimated time: 25 minutes</em></p>\n<p>You are currently processing an array composed of <code>struct point</code> defined below. In this programme, you need to store the content of the entire array in a file to be able to reuse it later. Write a C function to write the array composed of <code>struct point</code> into a file. The file may already exist or not. After the execution of the function, the file should only contain the array. If the file has to be created, the user who created it must have the permission to read it.</p>\n<pre class="c"><code>typedef struct point {\n    int x;\n    int y;\n    int z;\n} point_t;</code></pre>\n<p>Use only <code>open(2)</code>, <code>write(2)</code> and <code>close(2)</code>. You can only call <code>write(2)</code> once.</p>\n<p>Hint : read carefully the man page of <code>open(2)</code> to manage all the cases mentioned above. Be sure to open the file with the appropriate rights.</p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
75	File exists	<p><em>Estimated time: 10 minutes</em></p>\n<p>Using <a href="https://sites.uclouvain.be/SystInfo/manpages/man2/open.2.html">open(2)</a>, determine if a file exists.</p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
86	Swap my integers	\n	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
89	true false	<p>true false</p>\n	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
96	Access Modifiers / Scopes	\n	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
109	Complexity : simple MCQ	\n	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
156	Binary Search Tree Iterator (implem)	<p>On s’intéresse à l'implémentation d'un itérateur (<code>BSTIterator</code>) qui permet de traverser un <code>Binary Search Tree</code> dans l'ordre croissant (<em>In-order transversal</em>).</p>\n<p>Par exemple si on a ce BST,</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3OrderedBstIterator/bst.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>on veut le parcourir comme suit <em>[3,8,9,11,12,14,15,18,20]</em></p>\n<p><em>Attention:</em> L'itérateur devra lancer des exceptions dans les cas suivants:</p>\n<ul>\n<li>étant donnée qu'on ne peut modifier l'itérateur alors qu'on est en train d'itérer, l'iterateur devra lancer un <code>ConcurrentModificationException</code> dans ce cas dans le <code>next</code> et le <code>hasNest</code>;</li>\n<li>si le <code>next</code> est appelé alors qu'il n'y a plus de prochain élément, l'iterateur devra lancer un <code>NoSuchElementException</code>.</li>\n</ul>\n<pre class="java"><code>import java.util.ConcurrentModificationException;\nimport java.util.Iterator;\nimport java.util.NoSuchElementException;\nimport java.util.Stack;\n\n   public class BST&lt;Key extends Comparable&lt;Key&gt;, Value&gt; implements Iterable&lt;Key&gt; {\n    private Node root;             // root of BST\n\n    private class Node {\n        private final Key key;       // sorted by key\n        private Value val;           // associated data\n        private Node left, right;    // left and right subtrees\n        private int size;            // number of nodes in subtree\n\n        public Node(Key key, Value val, int size) {\n            this.key = key;\n            this.val = val;\n            this.size = size;\n        }\n\n        public int getSize() {\n            return size;\n        }\n    }\n\n    /**\n     * Initializes an empty symbol table.\n     */\n    public BST() {}\n\n    /**\n     * Returns true if this symbol table is empty.\n     * @return {@code true} if this symbol table is empty; {@code false} otherwise\n     */\n    public boolean isEmpty() {\n        return size() == 0;\n    }\n\n    /**\n     * Returns the number of key-value pairs in this symbol table.\n     * @return the number of key-value pairs in this symbol table\n     */\n    public int size() {\n        return size(root);\n    }\n\n    // return number of key-value pairs in BST rooted at x\n    private int size(Node x) {\n        if (x == null) return 0;\n        else return x.size;\n    }\n\n    public void inOrder(){\n        inOrder(root);\n    }\n    private void inOrder(Node x) {\n        if (x == null) return;\n\n        inOrder(x.left);\n        System.out.println(x.key+&quot;=&gt;&quot;+x.val);\n        inOrder(x.right);\n    }\n\n    /**\n     * Returns the value associated with the given key.\n     *\n     * @param  key the key\n     * @return the value associated with the given key if the key is in the symbol table\n     *         and {@code null} if the key is not in the symbol table\n     */\n    public Value get(Key key) {\n        return get(root, key);\n    }\n\n    private Value get(Node x, Key key) {\n        if (x == null) return null;\n        int cmp = key.compareTo(x.key);\n        if      (cmp &lt; 0) return get(x.left, key);\n        else if (cmp &gt; 0) return get(x.right, key);\n        else              return x.val;\n    }\n\n    /**\n     * Search for key, update value if key is found. Grow table if key is new.\n     *\n     * @param  key the key\n     * @param  val the value\n     */\n    public void put(Key key, Value val) {\n        root = put(root, key, val);\n    }\n    private Node put(Node x, Key key, Value val) {\n        if (x == null) return new Node(key, val, 1);\n        int cmp = key.compareTo(x.key);\n        if      (cmp &lt; 0) x.left  = put(x.left,  key, val);\n        else if (cmp &gt; 0) x.right = put(x.right, key, val);\n        else              x.val   = val;\n        x.size = 1 + size(x.left) + size(x.right);\n        return x;\n    }\n\n    /**\n     * Returns an iterator that iterates through the keys in Incresing order\n     * (In-Order transversal).\n     * @return an iterator that iterates through the items in FIFO order.\n     */\n    @Override\n    public Iterator&lt;Key&gt; iterator() {\n        return new BSTIterator();\n    }\n\n        /**\n  * Implementation of an iterator that iterates through the keys of BST in incresing order (In-order transversal).\n  *\n  */\n    private class BSTIterator implements Iterator&lt;Key&gt; {\n\n        // TODO STUDDENT: Implement the BSTIterator\n\n    }\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3OrderedBstIterator/LSINF1121_PART3_OrderedBstIterator.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.958+00	2020-03-02 21:38:45.943+00	1	1	VALIDATED	\N	\N
159	Red Black Tree	<p>Prenons l'exemple d'un <code>Red-Black Tree</code> vide dans lequel on ajoute progressivement des chiffres.</p>\n<p>Les questions suivantes vous demanderont d'écrire une représentation du <code>Red-Black Tree</code> au fur et à mesure que nous y ajouterons des objets.</p>\n<p>Écrivez la réponse comme si vous lisiez le <code>Red-Black Tree</code> de gauche à droite et de haut en bas (en ignorant les blancs possibles). Par exemple, si votre réponse est :</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3Rbt/rbt.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>Vous écririez:</p>\n<pre><code>6 24 7 1 3 5 9</code></pre>\n<p>Remarquez comment le nœud 2-3 composé de <code>2</code>et <code>4</code> est écrit d'une manière fusionnée (<code>24</code>).</p>	2019-12-30 17:05:18.958+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
210	Les brochettes de fruits	<p>C'est le moment d'être créatif ! Tu vas pouvoir créer tes propres brochettes de fruits pour te régaler ! Fais attention, les pics à brochette doivent contenir 7 morceaux de fruits, pas plus, pas moins. Mais tu peux choisir ce que tu mets dessus.</p>\n<p>Tu as beaucoup de blocs à ta disposition mais tu ne dois pas tous les utiliser. A toi de réfléchir aux blocs qui sont utiles ou non, mais n'oublie pas que le thème de la séance, c'est les boucles ;)</p>\n<p><strong>Attention</strong> Chaque fois que tu veux créer une nouvelle brochette, tu dois recommencer un programme. Tu ne peux pas faire plusieurs brochettes en même temps.</p>\n	2019-12-30 17:05:33.853+00	2020-01-13 17:34:38.962+00	1	1	DRAFT	\N	\N
27	Comparing functions	<p>Pointers to functions can be used to handle functions in a dynamic fashion, and will be of great importance later in this course. It is hence important to grasp how they work.</p>\n<p>In this exercise, you will code a function which receives pointers to two functions, to determine if these functions are equivalent. Two functions are considered to be equivalent if they always produce the same output for the same input.</p>\n<p>The functions passed by pointers will be of the form <code>uint8_t func(uint8_t n)</code>.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
58	Capture The Flag 1	<p>Téléchargez <a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_ctf1/archive.tar.gz">cette archive</a>, ouvrez <code>FirstMission</code> et suivez les instructions. Un code individuel vous sera fourni à la fin de l'exercice. Entrez-le ci-dessous pour confirmer que vous avez complètement réalisé cet exercice.</p>	2019-12-30 17:00:49.305+00	2019-12-30 17:00:49.305+00	0	1	DRAFT	\N	\N
199	Bloom Filters	<h1 id="les-filtres-de-bloom">Les filtres de Bloom</h1>\n<p>Un filtre de Bloom, est une structure de donnée très compacte et efficace qui permet d'implémenter un test d'appartenance rapide (<code>.contains()</code>) à un très grand <em>ensemble</em>. Cependant, contrairement au test d'appartenance à un ensemble tel qu'implémenté à l'aide d'une HashMap, le test d'appartenance implémenté via un filtre de bloom peut renvoyer un résultat erroné (faux positifs possibles mais pas de faux négatifs) dans certains cas et cela, avec une faible probabilité.</p>\n<p>L'efficacité de cette structure, et le fait qu'elle ne requière qu'une quantité très faible (et constante !) de mémoire quel que soit le nombre d'éléments contenus dans l'ensemble en ont fait une structure de choix pour un très grand nombre d'applications. A titre d'exemple, on mentionnera le fait que les filtres de Bloom sont utilisés par certains devices réseaux pour faire du <em>Deep Packet Inspection</em>, ou encore que les bases de données <em>Google Big Table</em>, <em>Apache Cassandra</em> ou encore <em>Postgresql</em> utilisent cette structure de donnée afin de tester si une donnée se trouve en cache ou non.</p>\n<p>En effet la recherche de la donnée étant généralement coûteuse, un filtre de Bloom est utilisé pour éviter de faire une recherche si la donnée n'est pas présente. Par contre, comme les erreurs de type faux-positifs sont possibles, le filtre de Bloom peut dire que la donnée s'y trouve alors que ça n'est pas vrai. Dans ce cas, il faudra effectuer la recherche pour vérifier et payer le coût de cette recherche (par exemple une recherche linéaire avec des accès sur le disque).</p>\n<h1 id="concrètement">Concrètement</h1>\n<p>Concrètement, un filtre de bloom consiste en un vecteur <span class="math inline"><em>V</em> = <em>v</em><sub>1</sub>..<em>v</em><sub><em>n</em></sub></span> de bit et d'un ensemble <span class="math inline"><em>F</em> = <em>f</em><sub>1</sub>..<em>f</em><sub><em>k</em></sub></span> de fonctions de hachage</p>\n<p>Pour ajouter un élément <span class="math inline"><em>X</em></span> dans le set, on applique successivement chacune des fonctions <span class="math inline"><em>f</em><sub><em>i</em></sub> ∈ <em>F</em></span> de hachage. L'application de chacune de ces fonctions à l'élément <span class="math inline"><em>X</em></span> renvoie un nombre <span class="math inline"><em>h</em><sub><em>i</em></sub> ∈ [0..<em>n</em>−1]</span>. Pour marquer l'ajout de <span class="math inline"><em>X</em></span> au filtre de bloom, on met à 1 simplement chacun des <span class="math inline"><em>v</em><sub><em>h</em><sub><em>i</em></sub></sub></span> bits dans <span class="math inline"><em>V</em></span>.</p>\n<p>De façon similaire, pour tester l'appartenance d'un élément <span class="math inline"><em>X</em></span> au set, on vérifie que le <span class="math inline"><em>h</em><sub><em>i</em></sub></span> ème bit <span class="math inline"> ∈ <em>V</em></span> correspondant à <span class="math inline"><em>f</em><sub><em>i</em></sub>(<em>X</em>)</span> est égal à 1. Le test d'appartenance ne renverra <span class="title-ref">true</span> que ssi, cette condition est vérifiée pour chacune des <span class="math inline"><em>f</em><sub><em>i</em></sub> ∈ <em>F</em></span>.</p>\n<h2 id="exemples">Exemples</h2>\n<p>En supposant qu'on ait un filtre de Bloom représenté par 1 byte et 3 fonctions de hachage telles que:</p>\n<pre class=""><code>f1(&quot;Salut&quot;) = 0\nf2(&quot;Salut&quot;) = 1\nf3(&quot;Salut&quot;) = 2\n\net\n\nf1(&quot;1121&quot;) = 0\nf2(&quot;1121&quot;) = 1\nf3(&quot;1121&quot;) = 4</code></pre>\n<p>L'ajout de "Salut" au filtre 00000000 transforme celui-ci en 11100000. Si par la suite on veut tester que "Salut" est bien présent dans le filtre, on s'assure que les bits v1, v2 et v3 sont bien égaux à 1.</p>\n<p>En continuant sur le même exemple, on voit que la chaine "1121" n'est pas présente dans la structure puisque le 4eme bit est égal à 0.</p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.963+00	0	1	DRAFT	\N	\N
134	Parallel Merge Sort	<p>In this task, you will be asked to implement a special kind of merge sort using the <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/RecursiveAction.html">RecursiveAction</a> , <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ForkJoinPool.html">ForkJoinPool</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ForkJoinTask.html">ForkJoinTask</a> interfaces. You will understand by reading these interfaces that the merge sort you must implement is not only recursive but in parallel.</p>\n<p>You have to complete the following class : <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ParallelelMergeSort/ParallelMergeSort.java">ParallelMergeSort</a></p>\n<p>Here is an example of how we can use your implementation :</p>\n<pre class="java"><code>int size = 1000;\nInteger[] array = new Integer[size];\nfor(int i = 0 ; i &lt; size ; i++){\n    array[i] = rng.nextInt(10000);\n}\nParallelMergeSort task = new ParallelMergeSort(array, 0, size-1, new Integer[size],\n                Comparator.comparing(Integer::intValue));\nnew ForkJoinPool().invoke(task);</code></pre>\n<p>You will see that we've fixed a threshold, the reason we are using a threshold is easy to understand. Since you want your code to be effective on very large array, starting a thread for every element can be very ressource consuming and thus you would be losing the advantage you had of using concurrent programming. So when the subarray you're working on is smaller than the threshold, it simply run a normal sort.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ParallelelMergeSort/LEPL1402_ParallelelMergeSort.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
135	Postscript interpreter	<p>You are asked to write a mini-PostScript interpreter as described in the <em>pdf</em> (<a href="https://inginious.info.ucl.ac.be/course/LEPL1402/PostScript/mission.pdf">Mission</a>) of the mission. Precisely, you must implement the following interface :</p>\n<pre class="java"><code>public interface InterpreterInterface {\n    /**\n     * @pre: &#39;instructions&#39; is a valid chain of PostScript instructions\n     * @post: returns a String representing the state of the stack when a &#39;pstack&#39; instruction is encountered.\n     *    If several &#39;pstack&#39; instructions are present in the chain, a concatenation of the corresponding states (when &#39;pstack&#39; is encountered) must be returned, separated by whitespaces.\n     *    If several elements are still on the stack, separate them with whitespaces.\n     *    If there is no element on the stack or no &#39;pstack&#39; instruction, return the empty string (&quot;&quot;).\n     */\n    public String interpret(String instructions);\n}</code></pre>\n<p>We expect your interpreter to be able to handle all of the following specified operations:</p>\n<table>\n<colgroup>\n<col style="width: 28%" />\n<col style="width: 16%" />\n<col style="width: 54%" />\n</colgroup>\n<tbody>\n<tr class="odd">\n<td><blockquote>\n<p>Before</p>\n</blockquote></td>\n<td>After</td>\n<td>Description</td>\n</tr>\n<tr class="even">\n<td>any <strong>pstack</strong></td>\n<td>pstack</td>\n<td>print the top element of the pile to the standard output</td>\n</tr>\n<tr class="odd">\n<td>any1 any2 <strong>exch</strong></td>\n<td>any2 any1</td>\n<td>Swap the two top most element of the stack</td>\n</tr>\n<tr class="even">\n<td>any <strong>pop</strong></td>\n<td></td>\n<td>Pop the top most element of the stack</td>\n</tr>\n<tr class="odd">\n<td>any <strong>dup</strong></td>\n<td>any any</td>\n<td>Duplicate the top most element of the stack</td>\n</tr>\n<tr class="even">\n<td>any1 any2 <strong>add</strong></td>\n<td>any1+any2</td>\n<td>Pop two elements from the stack, compute their sum and push the result</td>\n</tr>\n<tr class="odd">\n<td>any1 any2 <strong>sub</strong></td>\n<td>any1-any2</td>\n<td>Same, but with a subtraction</td>\n</tr>\n<tr class="even">\n<td>any1 any2 <strong>mul</strong></td>\n<td>any1*any2</td>\n<td>Same, but with a multiplication</td>\n</tr>\n<tr class="odd">\n<td>any1 any2 <strong>div</strong></td>\n<td>any1/any2</td>\n<td>Same, but with a division</td>\n</tr>\n<tr class="even">\n<td>any1 any2 <strong>idiv</strong></td>\n<td>any3</td>\n<td><blockquote>\n<p>Compute the quotient of an integer division of any1 by any2, then push the result to the stack</p>\n</blockquote></td>\n</tr>\n</tbody>\n</table>\n<dl>\n<dt>The element of the stack could be:</dt>\n<dd><ul>\n<li>Operators - any operators from the array above.</li>\n<li>Operands - any integer, double or boolean (true, false)</li>\n</ul>\n</dd>\n</dl>\n<p>Don't forget to throw exceptions : <code>EmptyStackException</code> if there's not enough operand left on the stack, <code>ArithmeticException</code> when an illegal computation is submitted to your interpreter, <code>IllegalArgumentException</code> when a bad operand is found (for example, a boolean instead of an integer when performing a mathematical operation)</p>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
207	Binary Search Tree	<p>Etant donné un arbre de recherche binaire, dont les noeuds implémentent l'interface Node:</p>\n<pre class="java"><code>interface Node {\n    /**\n      * @return la valeur contenue dans ce noeud\n      */\n    int getValue();\n\n    /**\n     * @return Le noeud situe a gauche (dont la valeur est &lt; que la valeur actuelle) s&#39;il existe, null sinon\n     */\n    Node getLeft();\n\n    /**\n      * @return Le noeud situe a droite (dont la valeur est &gt; que la valeur actuelle) s&#39;il existe, null sinon\n      */\n    Node getRight();\n}</code></pre>\n<p>L'on vous demande de fournir le <strong>corps</strong> de la fonction <em>ceil</em>, qui trouve dans l'arbre le plus petit élément plus grand ou égal à <span class="title-ref">value</span> (donc soit l'élément lui-même soit l'élément situé directement après par ordre de grandeur). Si un tel élément n'existe pas, elle doit retourner <span class="title-ref">null</span>.</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/whiteexam2016bst/project.zip">Un projet Eclipse contenant des tests basiques vous est fourni en cliquant sur ce lien.</a></p>\n	2019-12-30 17:05:18.963+00	2020-01-13 17:35:23.113+00	1	1	DRAFT	\N	\N
214	Mon premier exercice	<pre><code><span class="hljs-keyword">import</span><span> axios </span><span class="hljs-keyword">from</span><span> </span><span class="hljs-string">'axios'</span><span>;\n\n</span><span class="hljs-keyword">async</span><span> test() {\n\n  </span><span class="hljs-keyword">const</span><span> response = </span><span class="hljs-keyword">await</span><span> axios.get(</span><span class="hljs-string">'api/tags'</span><span>);\n  </span><span class="hljs-built_in">console</span><span>.log(response);\n}\n\ntest();</span></code></pre><blockquote><p>Ce code est un test, mais voila quoi</p></blockquote>	2019-12-30 17:53:01.584+00	2020-03-01 15:36:15.51+00	25	2	VALIDATED	\N	\N
1	Simple Binary Search Tree	<p>For this task, you will implement a simple binary search on an existing binary tree. A binary tree has the following structure:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1252/BST/bst.png" width="540" height="340" alt="image" /></p>\n<p>This binary tree is composed of nodes implemented using the following structure.</p>\n<pre class="c"><code>/*\n* Node has a value, @value, and two children, @left and @right.\n* All the children of @left and itself have a smaller value than the node and all the children of @right and itself have a larger value than node\n*/\ntypedef struct node{\n    int value;\n    struct node* left; // to smaller values\n    struct node* right; // to larger values\n} node_t;</code></pre>\n<p>The binary tree itself is defined as follows.</p>\n<pre class="c"><code>typedef struct bt{\n    struct node* root;\n} bt_t;</code></pre>\n	2019-12-30 17:00:49.293+00	2020-03-01 15:41:59.366+00	1	1	VALIDATED	\N	\N
17	Simple linked list	<p>We ask you to write two simple functions that are needed to implement a simple linked list.</p>\n<pre class="c"><code>/**\n* Structure node\n*\n* @next: pointer to the next node in the list, NULL if last node_t\n* @value: value stored in the node\n*/\ntypedef struct node {\n  struct node *next;\n  int value;\n} node_t;\n\n/**\n* Structure list\n*\n* @first: first node of the list, NULL if list is empty\n* @size: number of nodes in the list\n*/\ntypedef struct list {\n  struct node *first;\n  int size;\n} list_t;</code></pre>\n<p><strong>In your functions, you cannot use the function</strong> <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/malloc.3.html">calloc(3)</a></p>	2019-12-30 17:00:49.297+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
7	Search and replace	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<p>Les pages de manuel sont accessibles depuis les URLs suivants : - <a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes) - <a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes) - <a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</p>\n	2019-12-30 17:00:49.295+00	2019-12-30 17:00:49.295+00	0	1	DRAFT	\N	\N
8	Stockage d'un vecteur de réels dans un fichier	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>\n	2019-12-30 17:00:49.295+00	2019-12-30 17:00:49.295+00	0	1	DRAFT	\N	\N
136	Threads - Producer/Consumer with locks	<p>In this task we will ask you to solve the producer/consumer problem, represented here as a concurrent bounded FIFO queue. We will run simultaneously two different types of threads on your queue :</p>\n<blockquote>\n<ul>\n<li>Consumers, consuming (= dequeuing) elements from the queue.</li>\n<li>Producers, producing (= enqueuing) elements to the queue.</li>\n</ul>\n</blockquote>\n<p>Your queue needs to be thread-safe : it must be able to operate in a concurrent environment. It also means that threads must wait if necessary. A producer can't progress if there's no space left in the queue. A consumer can't take element from the queue if it is empty. For this exercise, you will need to implement <code>enqueue</code> and <code>dequeue</code>, using all the instance variables that are in the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ProducerConsumer/LockQueue.java">LockQueue</a> class below. We strongly suggest you to look at <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/locks/Condition.html#await--">await</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/locks/Condition.html#signal--">signal</a> (or <code>signalAll</code>) methods. You are not allowed to instantiate new locks or condition objects.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ProducerConsumer/LEPL1402_ProducerConsumer.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>import java.util.concurrent.locks.Condition;\nimport java.util.concurrent.locks.ReentrantLock;\n\npublic class LockQueue {\n\n    public final static int SIZE = 100;\n\n    private final ReentrantLock lock = new ReentrantLock();\n    private final Condition notFull = lock.newCondition();\n    private final Condition notEmpty = lock.newCondition();\n\n    public int head = 0;\n    public int tail = 0;\n    public final Integer [] cells = new Integer[SIZE];\n    public int count = 0;\n\n\n\n    public Integer dequeue() {\n        // YOUR CODE HERE\n    }\n\n\n    public void enqueue(Integer i) {\n        // YOUR CODE HERE\n    }\n\n    public boolean full(){\n        return this.count == SIZE;\n    }\n\n    public boolean empty(){\n        return this.head == this.tail;\n    }\n\n    public int size() { return this.tail - this.head; }\n\n}</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
137	Queue with two stacks	<p>In this short exercise we will ask you to implement a FIFO queue using two stacks (provided as two Java <code>Stack&lt;E&gt;</code>). We need you to provide 4 methods : <code>enqueue</code>, <code>dequeue</code>, <code>peek</code>, <code>empty</code>. You can use the <code>Stack</code> <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Stack.html">API</a> , but you can't instantiate a new <code>Stack</code>. Use <code>s1</code> and <code>s2</code> from the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/QueueWithStacks/MyQueue.java">MyQueue</a> class below.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/QueueWithStacks/LEPL1402_QueueWithStacks.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>import java.util.Stack;\n\npublic class MyQueue&lt;E&gt; {\n\n    Stack&lt;E&gt; s1;\n    Stack&lt;E&gt; s2;\n\n    private E front;\n\n    /*\n    * Constructor\n    */\n    public MyQueue() {\n        s1 = new Stack&lt;&gt;();\n        s2 = new Stack&lt;&gt;();\n        this.front = null;\n    }\n\n    /*\n    * Push element x to the end of the queue (remember, a queue is FIFO)\n    */\n    public void enqueue(E elem) {\n        //TODO\n    }\n\n    /*\n    * Removes the front element of this queue\n    */\n    public E dequeue() {\n        //TODO\n    }\n\n    /*\n    * Get the first element of this list but does not remove it\n    */\n    public E peek() {\n        //TODO\n    }\n\n    /*\n    * Tells if the queue is empty or not.\n    */\n    public boolean empty() {\n        //TODO\n    }\n}</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
21	Bitwise operation: resetting the highest order bit	<p>In this exercise, we will work with operations on bits. When we speak about the position of a bit, index 0 corresponds to lowest order bit, 1 to the second-lowest order bit, ...</p>\n<p>In C source code, you can write a number in binary (base 2) by prefixing it via 0b., e.g. 0b11010 = 26.</p>\n<p>This exercise will introduce some non-standard data types which guarantee that the variable has a fixed number of bits. Indeed, on some machines, a <em>int</em> could use 2, 4 or 8 bytes. Hence, if we want to perform bitwise operations, we have to know first on how many bits we are working.</p>\n<p>For this, C introduces a new class of variable types :</p>\n<ul>\n<li><em>int8_t</em> (signed integer of 8 bits)</li>\n<li><em>uint8_t</em> (unsigned integer of 8 bits)</li>\n<li><em>uint16_t</em> (unsigned integer of 16 bits)</li>\n</ul>\n<p>You can mix <em>uint</em> or <em>int</em> with bit-lengths 8, 16, 32 and 64). These types are defined in &lt;stdint.h&gt;</p>	2019-12-30 17:00:49.297+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
138	Threads - Shared counter with monitors	<p>In this task we will ask you to use monitors for a thread-shared counter. When threads are executed concurrently and they share some piece of memory, unexpected/wrong results are very likely to happen. For example, if you run four threads on the same counter, each thread incrementing ten thousands times the counter, you would of course expect that the final value of the counter will be fourty thousands when all four threads are done... But in practice, if there is no synchronization mechanism of any kind between threads, you will see that the final value will certainly be different from what we expect. Your job for this task is thus to implement a synchronization mechanism for a counter using only java's built-in monitors. We ask you to implement the three following methods:</p>\n<blockquote>\n<ul>\n<li>void inc() : increment once the counter.</li>\n<li>void dec() : decrement the counter <strong>if and only if</strong> its current value is positive. In fact, the counter we ask you to implement must <strong>always</strong> be positive. If a thread wants to decrement the counter but its value is 0, it has to wait.</li>\n<li>int get() : returns the current value of the counter.</li>\n</ul>\n</blockquote>\n<p>Pay attention, you are not allowed to use <code>Lock</code> for this mission, only built-in <a href="https://www.artima.com/insidejvm/ed2/threadsynch.html">monitors</a>. You might also face a <a href="https://en.wikipedia.org/wiki/Deadlock">deadlock</a> problem.</p>\n<pre class="java"><code>public class SharedCounter {\n\n    private int counter = 0;\n\n    // YOUR CODE HERE\n\n}</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
141	Stack with a Queue	<p>In this short exercise we will ask you to implement a LIFO stack using a queue (provided as a Java <code>LinkedList&lt;E&gt;</code>). We need you to provide 4 methods : <code>push</code>, <code>pop</code>, <code>peek</code>, <code>empty</code>. You can't use the <code>LinkedList</code> API except for the methods listed below:</p>\n<ul>\n<li><code>add</code></li>\n<li><code>remove</code></li>\n<li><code>peek</code></li>\n<li><code>isEmpty</code></li>\n<li><code>size</code></li>\n</ul>\n<p>(You can find the file <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/StackWithQueue/MyStack.java">here</a>). The challenge of this exercise is to use <strong>only</strong> the queue that is provided as instance variable: <code>queue</code>. In other words, you <strong>can't</strong> instantiate a new <code>LinkedList</code> anywhere.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/StackWithQueue/LEPL1402_StackWithQueue.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>import java.util.LinkedList;\n\npublic class MyStack&lt;E&gt; {\n\n    private LinkedList&lt;E&gt; queue;\n\n    /*\n    * Constructor\n    */\n    public MyStack() {\n        this.queue = new LinkedList&lt;&gt;();\n    }\n\n    /*\n    * push an element at top (remember, a stack is &quot;Last In First Out&quot;)\n    */\n    public void push(E elem) {\n        //TODO\n    }\n\n    /*\n    * Return the top of the stack AND remove the retrieved element\n    */\n    public E pop() {\n        //TODO\n    }\n\n    /*\n    * Return the top element of the stack, without removing it\n    */\n    public E peek() {\n        //TODO\n    }\n\n    /*\n    * Tells if the stack is empty or not\n    */\n    public boolean empty() {\n        //TODO\n    }</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
30	Jeu de dames: tests de base	<p>\n  Cette tâche vous permet de vérifier que votre programme de jeu de dames passe les vérifications de base, telles que présence et fonctionnement du Makefile, nommage correct des exécutables, etc. Si votre programme ne passe pas ces tests, il ne sera <b>pas corrigé</b>.\n</p>\n	2019-12-30 17:00:49.299+00	2019-12-30 17:00:49.299+00	0	1	DRAFT	\N	\N
22	Bitwise operation: counting set bits	<p>In this exercise, we will work with operations on bits. When we speak about the position of a bit, index 0 corresponds to lowest order bit, 1 to the second-lowest order bit, ...</p>\n<p>In C source code, you can write a number in binary (base 2) by prefixing it via 0b., e.g. 0b11010 = 26.</p>\n<p>This exercise will introduce some non-standard data types which guarantee that the variable has a fixed number of bits. Indeed, on some machines, a <em>int</em> could use 2, 4 or 8 bytes. Hence, if we want to perform bitwise operations, we have to know first on how many bits we are working.</p>\n<p>For this, C introduces a new class of variable types :</p>\n<ul>\n<li><em>int8_t</em> (signed integer of 8 bits)</li>\n<li><em>uint8_t</em> (unsigned integer of 8 bits)</li>\n<li><em>uint16_t</em> (unsigned integer of 16 bits)</li>\n</ul>\n<p>You can mix <em>uint</em> or <em>int</em> with bit-lengths 8, 16, 32 and 64). These types are defined in &lt;stdint.h&gt;</p>	2019-12-30 17:00:49.297+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
29	Count the '\\0'	<p>The character '\\0' identifies the end of a string in C. But it can also play the role of a real character.</p>\n<p>In this exercice, write the body of the function <code>counting_zero</code>, which counts the number of occurence of the character '\\0'.</p>\n<p>You cannot use any function from the string library.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
34	Conversions hexadécimales	<p>On souhaite convertir un entier non signé vers sa représentation hexadécimale. Par exemple l'entier 42 vaut "2A" en hexadécimal. De même, on souhaite faire la conversion dans l'autre sens.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned int hex_to_int(char *hex)</span> qui prend en argument une chaîne de caractères représentant un nombre hexadécimal (cette chaîne ne peut comporter que les chiffres de 0 à 9 et les lettres A à F).</p>\n<p>Écrivez une fonction <span class="title-ref">char *int_to_hex(unsigned int value, char *dest)</span> qui prend en argument un entier non-signé et enregistre sa représentation hexadécimale dans la chaîne de caractères indiquée par dest. On suppose que dest est un tableau de 9 char au minimum. La fonction devra toujours renvoyer le pointeur dest.</p>	2019-12-30 17:00:49.299+00	2019-12-30 17:00:49.299+00	0	1	DRAFT	\N	\N
52	Pointer arithmetic	<p>A hacker wanted to challenge you and encrypted your hard drive. To unlock your drive, he gave you a function <code>get_key(int a, char b, int c)</code> which returns the decryption key if the correct parameters are given.</p>\n<p>He then hid the parameters <em>a</em>, <em>b</em> and <em>c</em> in memory, and gave you a pointer from which you can retrieve these parameters.</p>	2019-12-30 17:00:49.304+00	2019-12-30 17:00:49.304+00	0	1	DRAFT	\N	\N
142	Dealing with Streams	<p>Given the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams/Student.java">Student</a> class, You are asked to write the implementation of the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams/StudentFunctions.java">StudentFunctions</a> class ( that implements the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams/StudentStreamFunction.java">StudentStreamFunction</a> interface ) :</p>\n<pre class="java"><code>import java.util.stream.Stream;\n\npublic interface StudentStreamFunction {\n\n   // Find the N°2 and N°3 top students for the given course name in parameter\n   public Stream&lt;Student&gt; findSecondAndThirdTopStudentForGivenCourse(\n       Stream&lt;Student&gt; studentStream, String name);\n\n   // Compute for each student in the given section their average grade result,\n   // sorted by their result (ascending) as an array of array structured like that :\n   // [ [&quot;Student FirstName1 LastName1&quot;, 7.5], [&quot;Student FirstName2 LastName2&quot;, 9.5] ]\n   public Object[] computeAverageForStudentInSection(Stream&lt;Student&gt; studentStream,\n                                                       int section);\n\n   // Give the number of students that success in all courses (&gt; 10.0)\n   public int getNumberOfSuccessfulStudents(Stream&lt;Student&gt; studentStream);\n\n   // Find the student that is the last one in the lexicographic order\n   // ( You must first compare students on their lastNames then on their firstNames )\n   public Student findLastInLexicographicOrder(Stream&lt;Student&gt; studentStream);\n\n\n   // Give the full sum of the grade obtained by all students\n   public double getFullSum(Stream&lt;Student&gt; studentStream);\n\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams/LEPL1402_Streams.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
143	Dealing with Streams - 2	<p>In order to understand why the Stream class could be useful for genericity, we purpose you this small exercise that merged casting and streams.</p>\n<p>Given the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams2/Student.java">Student</a> class, You are asked to write the implementation of the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams/StudentFunctions.java">StudentFunctions</a> class ( that implements the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams2/StudentStreamFunction.java">StudentStreamFunction</a> interface ) :</p>\n<pre class="java"><code>import java.util.Map;\nimport java.util.function.Predicate;\nimport java.util.stream.Stream;\nimport java.util.Comparator;\n\npublic interface StudentStreamFunction {\n\n// In order to test efficiently your code, we use a Map&lt;String, Predicate&lt;?&gt;&gt;\n// structured like that :\n//    Key : String that is one of the fields of Student\n//          ( &quot;firstName&quot;, &quot;lastName&quot;, &quot;section&quot;, &quot;courses_results&quot;)\n//    Value : Predicate bounded to the type of the field to perform a check condition\n//\n// For example :\n//    Key:   &quot;firstName&quot;\n//  Value:   Predicate&lt;String&gt;\n\n\n// Returns a student if any match the given conditions\n// if it is not possible, you must return null\npublic Student findFirst(Stream&lt;Student&gt; studentsStream,\n                         Map&lt;String, Predicate&lt;?&gt;&gt; conditions);\n\n// Returns a array of student(s) that match the given conditions\npublic Student[] findAll(Stream&lt;Student&gt; studentsStream,\n                         Map&lt;String, Predicate&lt;?&gt;&gt; conditions);\n\n// Return true if we could find n student(s) that match the given condition\npublic boolean exists(Stream&lt;Student&gt; studentsStream,\n                      Map&lt;String, Predicate&lt;?&gt;&gt; conditions,\n                      int n);\n\n// Returns a ordered array of student(s) that match the given conditions,\n// depending of the given comparator\npublic Student[] filterThenSort(Stream&lt;Student&gt; studentsStream,\n                                Map&lt;String, Predicate&lt;?&gt;&gt; conditions,\n                                Comparator&lt;Student&gt; comparator);\n\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Streams2/LEPL1402_Streams2.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
144	Strings	<p>In this task, we ask you to implement several common methods inspired from java's <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#subSequence-int-int-">String</a> API. The objective of this task is to get you used to String manipulation in java. In order to succeed this task, you will have to implement four different methods from a class we called <code>StringUtils</code> :</p>\n<ul>\n<li><code>split(String str, char marker)</code> : separate a String into fragments each time a specific character <code>marker</code> is encountered. Note that, for simplicity, marker is a <code>char</code> whereas in java's <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#subSequence-int-int-">String</a> it is a <code>String</code>. For example, calling your method with "Here. I. Go." with marker '.' should return an array of size three with "Here", "I" and "Go" in its cells.</li>\n<li><code>indexOf(String str, String sub)</code> : returns the index of the first occurrence of the <code>String</code> sub in the <code>String</code> str. For example <code>indexOf("Hello", "ell")</code> should return 1, <code>indexOf("Hello", "o")</code> should return 4. If there is no occurrence of sub in str, return -1.</li>\n<li><code>toLowerCase(String str)</code> : returns a String with the same characters as 'str' except that all upper case characters have been replaced by their lower case equivalent.</li>\n<li><code>palindrome(String str)</code> : Returns true if the string 'str' is a palindrome : a string that reads the same from left to right AND from right to left (for example, "kayak"). Note that this method does not exist in java's <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#subSequence-int-int-">String</a> API because it's not very useful. But it is still a good exercise to train yourself to manipulate String objects in java.</li>\n</ul>\n<p>Here is the skeleton of the <code>StringUtils</code> (downloadable <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/StringUtils/StringUtils.java">here</a>):</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/StringUtils/LEPL1402_StringUtils.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>public class StringUtils {\n\n\n    /*\n    * Split the input string &#39;str&#39; w.r.t the character &#39;marker&#39; in an array of String\n    * for example split(&quot;test-test&quot;, &#39;-&#39;) =&gt; {&quot;test&quot;, &quot;test&quot;}\n    * Must return null if there is no occurrence of &#39;marker&#39; in &#39;str&#39;\n    */\n    public static String [] split(String str, char marker){\n        // YOUR CODE HERE\n    }\n\n\n    /*\n    * Returns the index of the first occurrence of sub in str\n    * or -1 if there is no occurrence of sub in str at all.\n    * Be careful, we ask you to make CASE SENSITIVE comparison between str and sub.\n    */\n    public static int indexOf(String str, String sub){\n        // YOUR CODE HERE\n    }\n\n    /*\n    * Returns a String with the same characters as &#39;str&#39; except that\n    * all upper case characters have been replaced by their lower case equivalent.\n    */\n    public static String toLowerCase(String str){\n        // YOUR CODE HERE\n    }\n\n\n    /*\n    * Returns true if the string &#39;str&#39; is a palindrome (a string that reads the same from\n    * left to right AND from right to left).\n    */\n    public static boolean palindrome(String str){\n        // YOUR CODE HERE\n    }\n\n\n}</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
25	Parcours d'un arbre binaire de recherche	<p>On souhaite parcourir un arbre binaire de recherche. Un arbre de recherche binaire est une structure de données où chaque nœud possède une clé et une valeur. En outre, chaque nœud peut avoir 2 nœuds fils : un à gauche dont la clé est toujours inférieure à la sienne, et un à droite dont la clé est toujours supérieure à la sienne. Autrement dit si vous êtes à un nœud dont la clé vaut 10 et que vous cherchez un nœud dont la clé vaut 5, vous savez que vous devez descendre à gauche pour espérer trouver un éventuel nœud dont la clé vaut 5.</p>\n<pre class="c"><code>typedef struct BSTreeNode {\n    int key;\n    int value;\n\n    struct BSTreeNode *left;\n    struct BSTreeNode *right;\n} Node;</code></pre>\n<p>Écrivez une fonction <span class="title-ref">int has_key(Node root, int key)</span> qui vérifie si l'arbre binaire dont le sommet est le nœud root possède un nœud dont la clé vaut key et renvoie 1 si oui, renvoie 0 sinon.</p>\n<p>Écrivez une fonction <span class="title-ref">int compare(Node root_a, Node root_b)</span> qui vérifie si les 2 arbres binaires passés en argument sont identiques (ils ont la même structure et tous les nœuds possèdent la même paire clé/valeur). Renvoie 1 si les arbres sont identiques, 0 sinon. Indice : pensez récursivement.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
45	Reading from the wire	<p>Back in 1977, you want to read your e-mail with your freshly bought Apple II. You are connected to the ARPANET through a modem, but unfortunately the modem's manufacturer has only given a single function <code>modem_read</code>, to read the data received by the modem, with the following prototype :</p>\n<p><code>void modem_read(void *buffer, int *buf_len);</code></p>\n<p>This function fills the supplied buffer with the data received from the modem (an array of <code>char</code>), and writes the number of bytes written to the value pointed by <code>buf_len</code>. It can write up to maximum 256 bytes in a single call. This function is guaranteed to return.</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
145	Small introduction to threads - Counters	<p>In this task, we will ask you to implement the <code>init</code> method of this <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ThreadsIntroduction/Launcher.java">Launcher</a> class :</p>\n<pre class="java"><code>public class Launcher {\n\n    /*\n     * Instantiate and start each thread from &quot;t&quot; with its OWN Counter object,\n     * then wait for all threads to finish and return the set of Counter objects\n     * the threads ran on. Each thread must be named according to its index in the\n     * &quot;t&quot; array.\n     */\n    public static Counter[] init(Thread [] t) {\n        // YOUR CODE HERE\n    }\n\n}</code></pre>\n<p>In Java, a thread needs an entry point to know where to start when we want it to run : this entry point can be any object implementing the <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/Runnable.html">Runnable</a> interface. For this exercise, we give you a small implementation of the <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/Runnable.html">Runnable</a> interface : <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ThreadsIntroduction/Counter.java">Counter</a>, a small class increasing an int variable <code>rnd</code> times.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ThreadsIntroduction/LEPL1402_ThreadsIntroduction.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>public class Counter implements Runnable {\n\n    private int count;\n    private int rnd;\n\n    public int getCount() {\n        return count;\n    }\n\n    public int getRnd(){\n        return rnd;\n    }\n\n    public Counter(){\n        this.count = 0;\n        this.rnd = (int) ( (Math.random()*100) + 1000);\n    }\n\n    @Override\n    public void run() {\n        for(int i=0; i&lt; getRnd(); i++){\n            count += 1;\n        }\n    }\n\n}</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
38	Listes chaînées: concepts de base	<p>\n  Une liste chaînée est une structure de données permettant de représenter une séquence d’éléments. Dans cet exercice, une liste chaînée sera représentée par un pointeur sur la structure suivante:\n</p>\n<pre class="code">\ntypedef struct node {\n  int value;\n  struct node *next;\n} node;\n</pre>\n<p>\n  La liste vide est représentée par un pointeur nul. Le but des questions suivantes est de vous familiariser avec les listes chaînées en C. (Remarque : vous ne devez jamais traiter le cas des listes contenant un cycle.)\n</p>\n	2019-12-30 17:00:49.3+00	2019-12-30 17:00:49.3+00	0	1	DRAFT	\N	\N
39	Listes chaînées: exercices avancés	<p>\n  Cet exercice contient des exercices plus avancés sur les listes chaînées. Il est conseillé de commencer par le premier exercice sur les listes chaînées avant celui-ci. À nouveau, une liste chaînée sera représentée par un pointeur sur la structure suivante\n</p>\n<pre class="code">\n     typedef struct node {\n       int value; /* valeur du nœud */\n       struct node *next; /* pointeur vers l’élément suivant */\n     } node;\n</pre>\n<p>\n  La liste vide est représentée par un pointeur nul. Le but de l’exercice est de comprendre comment manipuler les pointeurs pour modifier des structures chaînées.\n</p>\n<p>\n  Dans toutes les sous-questions, vous devez réutiliser les nœuds des listes passées en argument et modifier leur structure. Il n’est jamais nécessaire d’allouer un nouveau nœud. (Remarque : vous ne devez jamais traiter le cas des listes contenant un cycle.)\n</p>\n	2019-12-30 17:00:49.3+00	2019-12-30 17:00:49.3+00	0	1	DRAFT	\N	\N
40	Filtering a linked list	<p>You have a linked list. Each element of the list is a <code>struct node</code>.</p>\n<pre class="c"><code>struct node {\n    struct node *next;\n    int hash;\n    int id;\n    char name[20];\n    char buffer[100];\n    unsigned int timestamp;\n    char acl;\n    short flow;\n    char *parent;\n    void *fifo;\n};</code></pre>	2019-12-30 17:00:49.3+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
41	Reading arguments	<p>When you execute a C program, its function <code>main()</code> is called with, as parameters, the name of the program and the arguments after the executable's name.</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
42	malloc, realloc et free INCOMPLETE	<p>La type de la plupart des variables en C est facile à déterminer. Néanmoins, le C contient aussi des types qui ne diffèrent que de façons subtiles, comme les</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
43	Multiplication de matrices	<p>Écrivez une fonction <code>int access(int *A, int taille, int ordonnee, int abscisse)</code> qui renvoie l'élément d'abscisse et d'ordonnée indiquées dans une matrice carrée taille x taille d'entiers (il s'agit donc de l'élément <span class="title-ref">A[ordonnee][abscisse]</span>). Les indices <span class="title-ref">ordonnee</span> et <span class="title-ref">abscisse</span> vont de 1 à <span class="title-ref">taille</span>.</p>\n<p>Écrivez une fonction qui effectue la multiplication de deux matrices carrées taille x taille d'entiers. Le prototype de la fonction est la suivante : <span class="title-ref">void mult(int *A, int *B, int *C, int taille)</span> et elle calcule C = A x B. Les trois matrices sont stockées sous forme de tableau ligne par ligne et la place de la matrice C est déjà allouée.</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
44	strlen, strcat et strcasecmp	<p>La libraire <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/string.3.html">string(3)</a> implémente un grand nombre de fonctions de manipulation des strings qui vous seront utiles lors de différents projets de programmation.</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
51	Palindrome	<p>Palindrome are strings of text which read the same backward as forward, i.e. : "racecar", "a man a plan a canal panama" or "kayak".</p>	2019-12-30 17:00:49.303+00	2019-12-30 17:00:49.303+00	0	1	DRAFT	\N	\N
82	Exponentially static counter - REVIEWED	<p>A variable declared inside a function with the keyword <em>static</em> implies that the value of this variable will be kept across the different calls to this function.</p>\n<p>For example, the first call to your function should return <code>1</code>. The next call <code>2</code>, then <code>4</code>, ..., <code>4096</code>, <code>1</code>, ...</p>	2019-12-30 17:00:49.308+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
146	Binary trees - combineWith	<p>Write a method combineWith that could be added to the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeCombineWith/Tree.java">Tree</a> class (Node class can be found <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeCombineWith/Node.java">here</a>).</p>\n<p>The method accepts another binary tree of integers as a parameter and combines the two trees into a new third tree which is returned. The new tree's structure should be a union of the structures of the two original trees.</p>\n<p>It should have a node in any location where there was a node in either of the original trees (or both).</p>\n<p>The nodes of the new tree should store an integer indicating the sum of the values at that position of the original trees if possible. (else only the value of the not null node)</p>\n<p>For example, suppose Tree variables t1 and t2 have been initialized and store the following trees:</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeCombineWith/example-part1.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>Then the following call:</p>\n<pre class="java"><code>Tree t3 = t1.combineWith(t2);</code></pre>\n<p>Will return a reference to the following tree:</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeCombineWith/example-part2.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>You may define private helper methods to solve this problem but in any case, your method should not change the structure or contents of either of the two trees being compared.</p>\n<p>(This exercise was partialy inspired by this <a href="https://practiceit.cs.washington.edu/problem/view/cs2/exams/finals/final4/combineWith">source</a>)</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeCombineWith/LEPL1402_TreeCombineWith.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
147	Binary trees - Inorder traversal	<p>In this task, we ask you to implement two different version of an "in-order" tree traversal : a recursive version and an iterative version. Both function will take a <code>Node</code> representing the root of the tree itself and a <code>List&lt;Integer&gt;</code> that you have to fill with the tree nodes' <code>val</code> respecting the "in-order" traversal.</p>\n<p><strong>Example</strong>: the following tree, when explored in an in-order fashion, will give <code>A,B,C,D,E,F,G,H,I</code>. This type of tree traversal is thus very useful to retrieve all nodes from a tree as an ordered list, provided that the tree itself is "sorted", i.e, for each node, its left subtree only contain "smaller" nodes and its right subtree only contain "greater" nodes (which is the case in the example, considering the alphabetical order).</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeInorder/inorder.png" class="align-center" width="240" height="218" alt="image" /></p>\n<p>Here are the skeleton of the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeInorder/Node.java">Node</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeInorder/Traversal.java">Traversal</a> classes:</p>\n<pre class="java"><code>public class Node {\n\n    public int val;\n\n    public Node left;\n    public Node right;\n\n    public Node(int val){\n        this.val = val;\n    }\n\n    public boolean isLeaf(){\n        return this.left == null &amp;&amp; this.right == null;\n    }\n}\n\n\nimport java.util.List;\nimport java.util.Stack; // this should give you a hint for the iterative version\n\npublic class Traversal {\n\n    public static void recursiveInorder(Node root, List&lt;Integer&gt; res) {\n        // YOUR CODE HERE\n    }\n\n\n    public static void iterativeInorder(Node root, List&lt;Integer&gt; res){\n        // YOUR CODE HERE\n    }\n\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeInorder/LEPL1402_TreeInorder.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.135+00	2020-03-01 15:41:59.367+00	2	1	VALIDATED	\N	\N
148	Binary trees - equals	<p>In this task, we will ask you to implement the mehtod <code>equals(Object o)</code> for both classes <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeSame/Tree.java">Tree</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeSame/Node.java">Node</a>. Two instances of <code>Tree</code> are considered equal when they both have the exact same structure (same number of nodes, each node at the same place in <strong>both</strong> trees) and when every node has the same <code>val</code>. Here are the skeleton of both classes:</p>\n<pre class="java"><code>public class Node {\n\n    public int val;\n    public Node left;\n    public Node right;\n\n    public Node(int val){\n        this.val = val;\n    }\n\n    public boolean isLeaf(){\n        return this.left == null &amp;&amp; this.right == null;\n    }\n\n    @Override\n    public boolean equals(Object o){\n        // YOUR CODE HERE\n    }\n}\n\npublic class Tree {\n\n    public Node root;\n\n    public Tree(Node root){\n        this.root = root;\n    }\n\n    @Override\n    public boolean equals(Object o){\n        // YOUR CODE HERE\n    }\n\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/TreeSame/LEPL1402_TreeSame.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.135+00	2019-12-30 17:02:49.135+00	0	1	DRAFT	\N	\N
150	Visitor design pattern - Calculator	<p>In this task, we will ask you to implement a basic calculator (+,-,*,/) using the visitor design pattern. Every expression you will compute will be represented as a tree. A tree contains at least one node and every node of the tree is either :</p>\n<ul>\n<li>a parent node containing two sub nodes (an operand)</li>\n<li>a leaf (a value)</li>\n</ul>\n<p>Here is an example of how your code is supposed to run:</p>\n<pre class="java"><code>Node root = new Add(                                            //((6-2)/(1+1))+(5*2)\n                    new Div(                                   //(6-2)/(1+1)\n                        new Sub(new Leaf(6),new Leaf(2))         //6-2\n                        new Add(new Leaf(1), new Leaf(1))),      //1+1\n                    new Mult(new Leaf(5), new Leaf(2)));         //5*2\nVisitor calculator = new Evaluation();\n\ncalculator.visit((Add)root); // 12</code></pre>\n<p><strong>We provide you a set of class you have to complete</strong> <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Visitor/source.zip">here</a></p>\n<p>There are a lot of classes but please don't panick, this exercise shouldn't require more than 50ish lines of code from you.</p>\n<p>A special case needs you to throw an <code>IllegalArgumentException</code>.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Visitor/LEPL1402_Visitor.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.135+00	2019-12-30 17:02:49.135+00	0	1	DRAFT	\N	\N
83	Improved strcpy	<p>The classic function <code>char *strcpy(char *destination, const char *source);</code> <a href="https://linux.die.net/man/3/strcpy">strcpy(3)</a> needs a destination buffer where the source string is copied. We ask you to code a function which allocates a buffer itself, and then performs the copy.</p>\n<p>The use of copy functions as <code>memcpy</code> is not allowed.</p>\n<p><em>Hint</em> : use <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/malloc.3.html">malloc(3)</a></p>	2019-12-30 17:00:49.308+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
151	Visitor design pattern - List Filtering	<p>In this task, we will ask you to implement a list filtering using the visitor design pattern. More precisely, your visitor will need to traverse a list full of objects of different kind. At the end of its traversal, your observer should have a filtered list containing only <code>Integer</code> elements from the original list. To succeed this task, you'll have to give us the implementation of these two classes :</p>\n<pre class="java"><code>public class VisitorList extends Visitor {\n    // YOUR CODE HERE\n}\n\npublic class VisitableList extends Visitable {\n    // YOUR CODE HERE\n}</code></pre>\n<p>These two classes must extends <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/VisitorBasic/Visitable.java">Visitable</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/VisitorBasic/Visitor.java">Visitor</a>. These are abstract classes, pay attention to implement all abstract methods these classes contain.</p>\n<p>Here is an example of how your code is supposed to run:</p>\n<pre class="java"><code>Visitor visitor = new VisitorList(Integer.class);\nVisitable visitable = new VisitableList(new Object[]{1, 2, 3, 3.1, 4, &quot;HELLO&quot;});\n\nvisitor.visit(visitable);\n\nList&lt;Object&gt; lst = visitor.getFiltered(); // [1, 2, 3, 4]</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/VisitorBasic/LEPL1402_VisitorBasic.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.135+00	2019-12-30 17:02:49.135+00	0	1	DRAFT	\N	\N
154	LinearProbing	<p>Dans ce exercice il vous est demandé d'implémenter les fonctions <code>resize</code>, <code>put</code> et <code>get</code> d'une table de symbole basé sur le hashage par Linear Probing.</p>\n<p>Pour cela la classe suivant vous a été donné. Vous devez completer les <em>TODO</em>.</p>\n<pre class="java"><code>import java.util.Arrays;\n\n/**\n* Symbol-table implementation with linear-probing hash table.\n*/\npublic class LinearProbingHashST&lt;Key, Value&gt; {\n\nprivate int n;           // number of key-value pairs in the symbol table\nprivate int m;           // size of linear probing table\nprivate Key[] keys;      // the keys\nprivate Value[] vals;    // the values\n\n\n/**\n * Initializes an empty symbol table.\n */\npublic LinearProbingHashST() {this(16);}\n\n /**\n * Initializes an empty symbol table with the specified initial capacity.\n */\npublic LinearProbingHashST(int capacity) {\n    m = capacity;\n    n = 0;\n    keys = (Key[])   new Object[m];\n    vals = (Value[]) new Object[m];\n}\n\npublic int size() {return n;}\npublic boolean isEmpty() {return size() == 0;}\n\n// hash function for keys - returns value between 0 and M-1\nprivate int hash(Key key) {\n    return (key.hashCode() &amp; 0x7fffffff) % m;\n}\n\n/**\n* resizes the hash table to the given capacity by re-hashing all of the keys\n*/\nprivate void resize(int capacity) {\n    //TODO STUDENT\n}\n\n/**\n* Inserts the specified key-value pair into the symbol table, overwriting the old\n* value with the new value.\n*/\npublic void put(Key key, Value val) {\n    //TODO STUDENT\n}\n\n/**\n* Returns the value associated with the specified key.\n*/\npublic Value get(Key key) {\n    //TODO STUDENT\n}\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/EXAM0119LinearProbing/LSINF1121_EXAM0119_LinearProbing.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.958+00	2020-03-02 21:38:45.942+00	1	1	VALIDATED	\N	\N
155	Binary Search Tree (implem)	<p>Etant donné un arbre de recherche binaire, dont les noeuds implémentent l'interface Node:</p>\n<pre class="java"><code>interface Node {\n    /**\n      * @return the value contained in this node\n      */\n    int getValue();\n\n    /**\n     * @return the node on the left (whose value is &lt; than the current value)\n     * if it exists, null if not\n     */\n    Node getLeft();\n\n    /**\n      * @return the node on the right (whose value is &gt; than the current value)\n      * if it exists, null if not\n      */\n    Node getRight();\n}</code></pre>\n<p>L'on vous demande de fournir le <strong>corps</strong> de la fonction <em>ceil</em>, qui trouve dans l'arbre le plus petit élément plus grand ou égal à <span class="title-ref">value</span> (donc soit l'élément lui-même soit l'élément situé directement après par ordre de grandeur). Si un tel élément n'existe pas, elle doit retourner <span class="title-ref">null</span>.</p>\n<p>Par exemple si on a ce BST,</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3Bst/bst.png" class="align-centeralign-center" alt="" />\n</figure>\n<ul>\n<li>ceil(11) nous renverra 11,</li>\n<li>ceil(4) nous renverra 8,</li>\n<li>et ceil(21) nous renverra null.</li>\n</ul>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3Bst/LSINF1121_PART3_BinarySearchTree.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.958+00	2020-03-02 21:38:45.943+00	2	1	VALIDATED	\N	\N
65	make basics - calculator	<p><em>Estimated time: 5 minutes</em></p>\n<p>You have just built a simple calculator. When typing <code>ls</code> in your command line, the source folder has the following structure:</p>\n<pre class="console"><code>calc.c    calc.h    Makefile    operations.c    operations.h</code></pre>\n<p><code>calc.c</code> contains the calculator which handles the 4 basic operations: addition, substraction, multiplication, and division. These 4 operations are implemented in <code>operations.c</code>.</p>\n<p>As you might have noticed, there are also two other files: <code>calc.h</code> and <code>operations.h</code>. These are the corresponding <strong>header</strong> files of <code>calc.c</code> and <code>operations.c</code>. These headers contain the function prototypes and specifications, but not their definitions. They can also contain <code>extern</code> declarations of variables. For more on that, see <a href="https://www.tutorialspoint.com/cprogramming/c_header_files.htm">this page</a> or chapter 4 in <a href="#kernighan2006c" class="citation">[kernighan2006c]</a>.</p>\n<p>When compiling this calculator, you need to specify in the <code>Makefile</code> rules the header files needed by <code>calc.c</code>, that is both <code>calc.h</code> and <code>operations.h</code>.</p>\n<hr />\n<div id="citations">\n<dl>\n<dt><span id="kernighan2006c" class="citation-label">kernighan2006c</span></dt>\n<dd><p>Kernighan, B. W., &amp; Ritchie, D. M. (2006). The C programming language.</p>\n</dd>\n</dl>\n</div>\n	2019-12-30 17:00:49.306+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
61	grep	<p>The <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/grep.1.html">grep(1) command</a> can be used to detect or extract lots of information from text files. When working with source code, <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/grep.1.html">grep(1)</a> can help you to find in which files some functions or constants have been defined. For this exercise, we will use the source code of the <a href="http://cunit.sourceforge.net">CUnit</a> testing framework that you can download as a <a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_grep/CUnit.tar">tar archive</a>.</p>	2019-12-30 17:00:49.305+00	2019-12-30 17:00:49.305+00	0	1	DRAFT	\N	\N
68	make more basics	<p><em>Estimated time: 20 minutes</em></p>\n<p>First, read <a href="https://www.gnu.org/software/make/manual/make.html#Variables-Simplify">sections 2.4 to 2.7. in the GNU make manual</a>. It will only take you 10 minutes (included in the above given estimated time) and will help you understand how to <code>make</code> more magic happen.</p>\n<p>As you have just read, one very useful use of Makefiles is to use variables. You can use a variable to define the C compiler you will use and the flags you want it to use.</p>\n<p>For instance, let us consider the following excerpt of a Makefile:</p>\n<pre class="console"><code># See gcc/clang manual to understand all flags\nCFLAGS += -std=c99 # Define which version of the C standard to use\nCFLAGS += -Wall # Enable the &#39;all&#39; set of warnings\nCFLAGS += -Werror # Treat all warnings as error\nCFLAGS += -Wshadow # Warn when shadowing variables\nCFLAGS += -Wextra # Enable additional warnings\nCFLAGS += -O2 -D_FORTIFY_SOURCE=2 # Add canary code, i.e. detect buffer overflows\nCFLAGS += -fstack-protector-all # Add canary code to detect stack smashing\n\n# Object files\nOBJ = # TODO\n\n## all        : Build calculator (by default)\n# Default target\nall: calc\n\n## calc        : Build calculator\ncalc: # TODO\n\ncalc.o: # TODO\n\noperations.o: # TODO\n\n.PHONY: clean mrproper help\n\n## clean        : Remove auto-generated files\nclean:\n    @rm -f src/*.o\n\n## mrproper    : Remove both auto-generated &amp; built files\nmrproper: clean\n    @rm -f calc\n\n## help        : Show different make options\nhelp: Makefile\n    @sed -n &#39;s/^##//p&#39; $&lt;</code></pre>\n<p>In this file we used 3 variables: <code>CC</code> to define the C Compiler; <code>CFLAGS</code> to define the C Compiler flags; <code>OBJ</code> to define the object files. This is a common use of variables to both simplify the Makefile and easily change the settings of the compiler.</p>\n<p>Notice the use of two <code>.PHONY</code> targets: <code>clean</code> which will remove auto-generated files, e.g. object files; <code>mrproper</code> which will remove both auto-generated &amp; built files, e.g. executable files; <code>help</code> which will search for lines starting with <code>##</code> and print them on <code>stdout</code> without the <code>##</code>. Try it out by tipping <code>make help</code>.</p>\n	2019-12-30 17:00:49.306+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
69	make more basics - multiple choice questions	<p><em>Estimated time: 15 minutes</em></p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
70	make tests	<p><em>Estimated time: 15 minutes</em></p>\n<p>This week, we will see how to automate the testing process. You have the following project folder structure:</p>\n<pre class=""><code>src/\n    calc.c\n    calc.h\n    operations.c\n    operations.h\ntest/\n    calc_test.c\n    operations_test.c\nMakefile</code></pre>\n<p>The <code>Makefile</code> is partially done, but somehow the target <code>test</code> for building the tests was lost.</p>\n<pre class=""><code>CC = gcc\n# See gcc/clang manual to understand all flags\nCFLAGS += -std=c99 # Define which version of the C standard to use\nCFLAGS += -Wall # Enable the &#39;all&#39; set of warnings\nCFLAGS += -Werror # Treat all warnings as error\nCFLAGS += -Wshadow # Warn when shadowing variables\nCFLAGS += -Wextra # Enable additional warnings\nCFLAGS += -O2 -D_FORTIFY_SOURCE=2 # Add canary code, i.e. detect buffer overflows\nCFLAGS += -fstack-protector-all # Add canary code to detect stack smashing\n\n# We have no libraries to link against except libc, but we want to keep\n# the symbols for debugging\nLDFLAGS= -rdynamic -lcunit\n\n## all        : Build calc (by default)\n# Default target\nall: calc\n\n## debug        : Build calc in debug mode\n# If we run `make debug` instead, keep the debug symbols for gdb\n# and define the DEBUG macro.\ndebug: CFLAGS += -g -DDEBUG -Wno-unused-parameter -fno-omit-frame-pointer\ndebug: clean calc\n\n## calc        : Build calc\n# We use an implicit rule: look for the files {calc,operations}.{c,h},\n# compile them and link the resulting *.o into an executable named calc\ncalc: calc.o operations.o\n    $(CC) $(CFLAGS)  -o calc {calc,operations}.o\n\n# We use an implicit rule: look for the files calc.{c,h},\n# compile them w/out linking\ncalc.o: src/calc.c src/calc.h\n    $(CC) $(CFLAGS) -c src/calc.{c,h}\n# We use an implicit rule: look for the files operations.{c,h},\n# compile them w/out linking\noperations.o: src/operations.c src/operations.h\n    $(CC) $(CFLAGS) -c src/operations.{c,h}\n\n# YOUR CODE HERE #\n\n# Declare clean, mrproper and help as a phony targets\n.PHONY: clean mrproper help\n\n## clean        : Remove auto-generated files from build\nclean:\n    @rm -f *.o\n\n## clean-debug        : Removve auto-generated files from debug mode build\nclean-debug:\n    @rm -f src/*.gch\n## mrproper    : Remove both auto-generated &amp; built files\nmrproper: clean clean-debug\n    @rm -f calc\n\n## help        : Show different make options\nhelp: Makefile\n    @sed -n &#39;s/^##//p&#39; $&lt;</code></pre>\n<p>To try locally, you can download the project folder <span class="title-ref">_here &lt;&gt;</span></p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
72	Reading integers in a binary file	<p><em>Estimated time: 25 minutes</em></p>\n<p>Given a binary file containing some (possibly none) positive integers (<code>int</code>) that were stored in the file by successive calls of <code>write(fd,&amp;num,sizeof(int))</code> write code that computes the sum of all integers that were stored in the file. The function returns the sum when there are no errors. In case of errors, it returns.</p>\n<ul>\n<li>If <code>open()</code> fails, return <code>-1</code>.</li>\n<li>If <code>read()</code> fails, return <code>-2</code>.</li>\n<li>If <code>close()</code> fails, return <code>-3</code>.</li>\n</ul>\n<p>You can only use <code>open(2)</code>, <code>read(2)</code>, <code>write(2)</code> and <code>close(2)</code>.</p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
73	Get and set on array stored in binary file	<p><em>Estimated time: 30 minutes</em></p>\n<p>Given a file containing a large array of integers, you have to write a function to edit the element at a given index in the array and another function to retrieve a specific element from this array.</p>\n<p>Since the array is huge, you cannot load it completely in memory. Consequently, you have to naviguate directly through the array in the file by using <code>lseek(2)</code>.</p>\n<p>You may want to use <code>fstat(2)</code> to obtain informations about a given file.</p>\n<p>Use only <code>open(2)</code>, <code>read(2)</code>, <code>write(2)</code>, <code>close(2)</code> and <code>lseek(2)</code>.</p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
74	File copy	<p><em>Estimated time: 30 minutes</em></p>\n<p>Given a file containing arbitrary bytes, you must write a function that copies the file. Obviously, your function cannot modify the content of the original file. Beware that the copied file should have the same permissions as the original file.</p>\n<p>Use only <code>open(2)</code>, <code>read(2)</code>, <code>write(2)</code>, <code>stat(2)</code> and <code>close(2)</code>.</p>\n<p><em>Hint: you may need either to go through the file or to get the total size to copy all of it.</em></p>\n	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.307+00	0	1	DRAFT	\N	\N
160	Write Unit tests Red Black Tree	<p>Il vous est demandé d'écrire des tests unitaire (en utilisant JUnit) afin de vérifier si une implémentation particulière d'un <code>Red-Black Tree</code> est correcte.</p>\n<p>Voici un modèle simple que vous pouvez utiliser pour écrire vos tests :</p>\n<blockquote>\n<pre class="java"><code>import org.junit.Test;\nimport static org.junit.Assert.assertEquals;\n\npublic class RedBlackTests {\n\n    @Test\n    public void firstTest() {\n        // ... TODO ...\n    }\n\n    @Test\n    public void secondTest() {\n        // ... TODO ...\n    }\n\n}</code></pre>\n</blockquote>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3WriteUnittestsRedBlackTree/LSINF1121_PART3_UnitTestsRedBlackTree.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.959+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
81	Global and local variables	<p>In a C program, variables are stored in different regions in memory, depending on where the variables have been initialized. Each memory region has different properties about how the variables can be accessed, modified, ... This exercise will show you how global variables and variables on the stack are managed.</p>\n<pre class="c"><code>int result;\n\nvoid sum1(int a1, int b1) {\n    a1 = a1 + b1;\n}\n\nvoid main(int argc, char **argv) {\n    int a1 = 5, b1 = 6;\n\n    sum1(a1, b1);\n    printf(&quot;sum1: %d\\n&quot;, a1);\n\n    int a2 = 3, b2 = 7;\n    sum2(a2, b2)\n    printf(&quot;sum2: %d\\n&quot;, result);\n\n    int a3 = 1, b3 = 8;\n    sum3(&amp;a3, &amp;b3);\n    printf(&quot;sum3: %d\\n&quot;, a3);\n}</code></pre>	2019-12-30 17:00:49.308+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
161	Binary Heap Push (implem)	<p>Dans cette tâche on vous propose d'implémenter la fonction d'insertion <code>push()</code> d'un heap binaire.</p>\n<blockquote>\n<p>La fonction push agit sur un tableau, nommé <code>contenu</code>, qui représente un arbre, selon la méthode vue au cours: le noeud n°i de l'arbre a pour enfant les indices 2*i et 2*i+1.</p>\n</blockquote>\n<p>il faut noter que dans le livre à la page 318 a été proposée le <code>MaxPQ</code> mais ici nous vous proposons de plutot réfléchir aux changements à apporter à ce code pour implémenter un <code>MinPQ</code> notamment à la fonction d'insertion.</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART5BinaryHeapPush/LSINF1121_PART5_BinaryHeapPush.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.959+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
162	Circular linkedlist (Implem)	<p>On s’intéresse à l'implémentation d'une <code>liste simplement chaînée circulaire</code>, c’est-à-dire une liste pour laquelle la dernière position de la liste fait référence, comme position suivante, à la première position de la liste.</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/p1circularlinkedlist/CircularLinkedList.png" alt="image" /></p>\n<p>L’ajout d’un nouvel élément dans la file (méthode <code>enqueue</code>) se fait en fin de liste et le retrait (méthode <code>remove</code>) se fait a un <span class="title-ref">index</span> particulier de la liste. Une (seule) référence sur la fin de la liste (<code>last</code>) est nécessaire pour effectuer toutes les opérations sur cette file.</p>\n<p>Il vous est donc demander d'implémenter cette liste simplement chaînée circulaire à partir de la classe <code>CircularLinkedList.java</code> où vous devez completer (<em>TODO STUDENT</em>) les méthodes d'ajout (<code>enqueue</code>) et de retrait (<code>remove</code>) ainsi qu'un itérateur (<code>ListIterator</code>) qui permet de parcourir la liste en FIFO. <em>Attention:</em> un itérateur ne peut être modifié au cours de son utilisation.</p>\n<pre class="java"><code>package student;\n\nimport java.util.ConcurrentModificationException;\nimport java.util.Iterator;\nimport java.util.NoSuchElementException;\n\npublic class CircularLinkedList&lt;Item&gt; implements Iterable&lt;Item&gt; {\n private long nOp = 0; // count the number of operations\n private int n;          // size of the stack\n private Node  last;   // trailer of the list\n\n // helper linked list class\n private class Node {\n     private Item item;\n     private Node next;\n }\n\n public CircularLinkedList() {\n     last = null;\n     n = 0;\n }\n\n public boolean isEmpty() { return n == 0; }\n\n public int size() { return n; }\n\n private long nOp() { return nOp; }\n\n /**\n  * Append an item at the end of the list\n  * @param item the item to append\n  */\n public void enqueue(Item item) {\n     // TODO STUDENT: Implement add method\n }\n\n /**\n  * Removes the element at the specified position in this list.\n  * Shifts any subsequent elements to the left (subtracts one from their indices).\n  * Returns the element that was removed from the list.\n  */\n public Item remove(int index) {\n     // TODO STUDENT: Implement remove method\n }\n\n /**\n  * Returns an iterator that iterates through the items in FIFO order.\n  * @return an iterator that iterates through the items in FIFO order.\n  */\n public Iterator&lt;Item&gt; iterator() {\n     return new ListIterator();\n }\n\n /**\n  * Implementation of an iterator that iterates through the items in FIFO order.\n  *\n  */\n private class ListIterator implements Iterator&lt;Item&gt; {\n     // TODO STUDDENT: Implement the ListIterator\n }\n\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/p1circularlinkedlist/LSINF1121CircularLinkedList.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.959+00	2020-03-02 21:38:45.943+00	1	1	VALIDATED	\N	\N
167	Union Intervals (implem)	<p>Etant donné un tableau d'intervalles (fermés), Il vous est demandé d'implémenter l'opération <code>union</code>. Cette opération retournera le tableau minimal d'intervalles triés couvrant exactement l'union des points couverts par les intervalles d'entrée.</p>\n<p>Par exemple, l'union des intervalles <em>[7,9],[5,8],[2,4]</em> est <em>[2,4],[5,9]</em>.</p>\n<p>La classe <code>Interval</code> permetant de stocker les intervalles vous est fourni et se présente comme suit (vous pouvez l'utiliser directement dans votre code):</p>\n<pre class="java"><code>public class Interval implements Comparable&lt;Interval&gt; {\n\n    final int min, max;\n    public Interval(int min, int max) {\n        assert(min &lt;= max);\n        this.min = min;\n        this.max = max;\n    }\n\n    @Override\n    public boolean equals(Object obj) {\n        return ((Interval) obj).min == min &amp;&amp; ((Interval) obj).max == max;\n    }\n\n    @Override\n    public String toString() {\n        return &quot;[&quot;+min+&quot;,&quot;+max+&quot;]&quot;;\n    }\n\n    @Override\n    public int compareTo(Interval o) {\n        if (min &lt; o.min) return -1;\n        else if (min == o.min) return max - o.max;\n        else return 1;\n    }\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part2UnionIntervals/LSINF1121_PART2_UnionIntervals.zip">Le projet IntelliJ est disponible ici</a>.</p>\n<p>Nous vous conseillons de le télécharger d'implémenter/tester avant de soumettre ce qui vous est demandé.</p>	2019-12-30 17:05:18.959+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
168	Incremental Hash (implem)	<p>La fonction de Hash calculée sur le sous tableau <span class="math inline"><em>t</em>[<em>f</em><em>r</em><em>o</em><em>m</em>, ..., <em>f</em><em>r</em><em>o</em><em>m</em> + <em>M</em> − 1]</span> est calculée comme suit:</p>\n<p><span class="math inline">$hash([from,...,from+M-1])= \\left( \\sum_{i=0}^{M-1} t[from+i] \\cdot R^{(M-1-i)}\\right)\\%Q$</span></p>\n<p>Le code pour calculer cette fonction de hash vous est donné. Nous vous demandons de calculer <span class="math inline"><em>h</em><em>a</em><em>s</em><em>h</em>([<em>f</em><em>r</em><em>o</em><em>m</em>, ..., <em>f</em><em>r</em><em>o</em><em>m</em> + <em>M</em> − 1])</span> au départ de <span class="math inline"><em>h</em><em>a</em><em>s</em><em>h</em>([<em>f</em><em>r</em><em>o</em><em>m</em> − 1, ..., <em>f</em><em>r</em><em>o</em><em>m</em> + <em>M</em> − 2])</span> en O(1).</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part4IncrementalHash/LSINF1121_PART4_IncrementalHash.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.959+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
171	Rabin Karp of k patterns (implem)	<p>On s'intéresse à l'algorithme de Rabin-Karp. On voudrait le modifier quelque peu pour déterminer si un mot parmi une liste (tous les mots sont de même longueur) est présent dans le texte.</p>\n<p>Pour cela, vous devez modifier l'algorithme de Rabin-Karp qui se trouve ci-dessous (Page 777 du livre).</p>\n<p>Plus précisément, on vous demande de modifier cette classe de manière à avoir un constructeur de la forme:</p>\n<pre class="java"><code>public RabinKarp(String[] pat)</code></pre>\n<p>De plus la fonction <code>search</code> doit retourner l'indice du début du premier mot (parmi le tableau <code>pat</code>) trouvé dans le texte ou la taille du texte si aucun mot n'aparait dans le texte.</p>\n<p>Exemple: Si txt = “Here find interresting exercise for Rabin Karp” et pat={“have”, “find”, “Karp”} la fonction <code>search</code> doit renvoyer 5 car le mot "find" présent dans le texte et dans la liste commence à l'indice 5.</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part4RabinKarp/LSINF1121_PART4_RabinKarp.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.96+00	2019-12-30 17:05:18.96+00	0	1	DRAFT	\N	\N
92	Coverage Testing	<p>Example of Task using Coverage testing</p>\n	2019-12-30 17:02:49.129+00	2019-12-30 17:02:49.129+00	0	1	DRAFT	\N	\N
93	JavaGrading Testing	<p>Example of Task using JavaGrading</p>\n	2019-12-30 17:02:49.129+00	2019-12-30 17:02:49.129+00	0	1	DRAFT	\N	\N
101	Type Casting - theoretical questions	\n	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
80	Soumission du projet fractale	<p>Cette tâche vous permet de soumettre votre projet. Elle va également valider le format de votre archive, la présence des fichiers requis, la présence des cibles requises dans votre Makefile et la bonne compilation de votre projet. Le format requis est décrit dans l'énoncé disponible sur Moodle.</p>\n<p>Votre archive doit respecter le format de nommage <span class="title-ref">fractal_NUMGroupe_NOM1_NOM2.zip</span>. <strong>Un seul des deux membres du groupe doit soumettre.</strong></p>\n<p>La dernière soumission <strong>valide</strong> sera considérée pour l'évaluation. En l'absence de telle soumission (donc si votre soumission comporte une erreur), votre projet <strong>ne sera pas considéré pour l'évaluation</strong>.</p>	2019-12-30 17:00:49.308+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
84	Manipulation de chaines de caractères	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
140	MCQ Sieve of Eratosthenes	<p>The following mcq will introduce you to the next exercise, we strongly recommend you to answer and understand them before starting the exercise Sieve Of Eratosthene implementation.</p>\n<p>The sieve of Eratosthene is an algorithm that helps you determine how many/which of the number are prime numbers in a set of integer from 0 to <span class="math inline"><em>n</em></span>.</p>\n<p>To implement this algorithm we want you to use a <a href="https://docs.oracle.com/javase/8/docs/api/java/util/BitSet.html">BitSet</a>, the idea here is to force you to read and understand the java documentation. Thus, we will ask you questions about the different method you might need in the implementation of the sieve.</p>\n<p>The difficulty will increase each question and ask you to read the doc a <em>bit</em> more.</p>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
174	Huffman (implem)	<p>Vous devez calculer un arbre de Huffman au départ de la fréquence donnée pour chacune des R lettres (characters).</p>\n<p>Pour rappel, dans un arbre de Huffman nous avons que <em>la somme de la fréquence associée à chaque feuille multipliée par la profondeur de celle-ci est minimale</em>.</p>\n<p>Par exemple, étant donné les fréquences suivantes:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5Huffman/huffmanin.png" class="align-center" width="500" alt="Input frequencies" /></p>\n<p>un arbre de Huffman pourrait être:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5Huffman/huffmanout.png" class="align-center" width="500" alt="Huffman tree" /></p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5Huffman/LSINF1121_PART5_Huffman.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.96+00	2019-12-30 17:05:18.96+00	0	1	DRAFT	\N	\N
176	PART 6  - Breadth First Paths (implem)	<p>Considérez cette classe, <code>BreadthFirstShortestPaths</code>, qui calcule le chemin le plus court entre plusieurs sources de nœuds et n'importe quel nœud dans un graphe non dirigé en utilisant un parcours BFS.</p>\n<pre class="java"><code>// TODO\n\npublic class BreadthFirstShortestPaths {\n\n    private static final int INFINITY = Integer.MAX_VALUE;\n    private boolean[] marked; // marked[v] = is there an s-v path\n    private int[] distTo;     // distTo[v] = number of edges shortest s-v path\n\n    /**\n     * Computes the shortest path between any\n     * one of the sources and very other vertex\n     * @param G the graph\n     * @param sources the source vertices\n     */\n     public BreadthFirstShortestPaths(Graph G, Iterable&lt;Integer&gt; sources) {\n         marked = new boolean[G.V()];\n         distTo = new int[G.V()];\n         for (int v = 0;v &lt; G.V();v++) {\n             distTo[v] = INFINITY;\n         }\n         bfs(G, sources);\n     }\n\n     // Breadth-first search from multiple sources\n     private void bfs(Graph G, Iterable&lt;Integer&gt; sources) {\n         // TODO\n     }\n\n     /**\n      * Is there a path between (at least one of) the sources and vertex v?\n      * @param v the vertex\n      * @return true if there is a path, and false otherwise\n      */\n     public boolean hasPathTo(int v) {\n         // TODO\n     }\n\n     /**\n      * Returns the number of edges in a shortest path\n      * between one of the sources and vertex v?\n      * @param v the vertex\n      * @return the number of edges in a shortest path\n      */\n     public int distTo(int v) {\n         // TODO\n     }\n}</code></pre>\n<p>La classe <code>Graph</code> est déjà implémentée et la voici :</p>\n<pre class="java"><code>public class Graph {\n    // @return the number of vertices\n    public int V() { }\n\n    // @return the number of edges\n    public int E() { }\n\n    // Add edge v-w to this graph\n    public void addEdge(int v, int w) { }\n\n    // @return the vertices adjacent to v\n    public Iterable&lt;Integer&gt; adj(int v) { }\n\n    // @return a string representation\n    public String toString() { }\n}</code></pre>\n<p><strong>Note:</strong> Les questions suivantes vous demanderont d'implémenter tous les <code>TODO</code> de la classe <code>BreadthFirstShortestPaths</code>. Vous n'avez pas besoin de mettre les accolades (<code>{ }</code>) entourant le corps de la fonction dans votre réponse.</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6BreadthFirstPaths/LSINF1121_PART6_BreadthFirstShortestPaths.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2020-03-02 21:38:45.943+00	1	1	VALIDATED	\N	\N
177	Connected Components (implem)	<p>Il vous ait demandé d'implémenter la classe des composants connexes <code>ConnectedComponent</code> étant donnée un graphe. La classe <a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6ConnectedComponents/javadoc.zip">Graph</a> disponible dans le code est celle de l'API de la classe <a href="https://docs.oracle.com/javase/8/docs/api/">Java</a>.</p>\n<pre class="java"><code>public class ConnectedComponents {\n  /**\n   * @return the number of connected components in g\n   */\n  public static int numberOfConnectedComponents(Graph g) {\n    // TODO\n    return 0;\n  }\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6ConnectedComponents/LSINF1121_PART6_ConnectedComponents.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2020-03-02 21:38:45.944+00	1	1	VALIDATED	\N	\N
110	Space Complexity MCQ	<p>Multiple choice questions about space complexity</p>\n	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
178	Depth First Paths (implem)	<p>Considérez cette classe, <code>DepthFirstPaths</code>, qui calcule les chemins vers n'importe quel noeud connecté à partir d'un noeud source <code>s</code> dans un graphe non dirigé en utilisant un parcours DFS.</p>\n<pre class="java"><code>// TODO\n\npublic class DepthFirstPaths {\n    private boolean[] marked; // marked[v] = is there an s-v path?\n    private int[] edgeTo;     // edgeTo[v] = last edge on s-v path\n    private final int s;\n\n    /**\n     * Computes a path between s and every other vertex in graph G\n     * @param G the graph\n     * @param s the source vertex\n     */\n     public DepthFirstPaths(Graph G, int s) {\n         this.s = s;\n         edgeTo = new int[G.V()];\n         marked = new boolean[G.V()];\n         dfs(G, s);\n     }\n\n     // Depth first search from v\n     private void dfs(Graph G, int v) {\n         // TODO\n     }\n\n     /**\n      * Is there a path between the source s and vertex v?\n      * @param v the vertex\n      * @return true if there is a path, false otherwise\n      */\n     public boolean hasPathTo(int v) {\n         // TODO\n     }\n\n     /**\n      * Returns a path between the source vertex s and vertex v, or\n      * null if no such path\n      * @param v the vertex\n      * @return the sequence of vertices on a path between the source vertex\n      *         s and vertex v, as an Iterable\n      */\n     public Iterable&lt;Integer&gt; pathTo(int v) {\n         // TODO\n     }\n}</code></pre>\n<p>La classe <code>Graph</code> est déjà implémentée. En voici la spécification :</p>\n<pre class="java"><code>public class Graph {\n    // @return the number of vertices\n    public int V() { }\n\n    // @return the number of edges\n    public int E() { }\n\n    // Add edge v-w to this graph\n    public void addEdge(int v, int w) { }\n\n    // @return the vertices adjacent to v\n    public Iterable&lt;Integer&gt; adj(int v) { }\n\n    // @return a string representation\n    public String toString() { }\n}</code></pre>\n<p><strong>Note:</strong> Les questions suivantes vous demanderont d'implémenter tous les <code>TODO</code> de la classe <code>DepthFirstPaths</code>. Vous n'avez pas besoin de mettre les accolades (<code>{ }</code>) entourant le corps de la fonction dans votre réponse.</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6DepthFirstPaths/LSINF1121_PART6_DepthFirstPaths.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2020-03-02 21:38:45.944+00	1	1	VALIDATED	\N	\N
108	Array Search	<p>In this task, you have to implement a method <code>search</code> that looks for an element in an ascending sorted array. Your method must return the <strong>index</strong> of the element in the array or <strong>-1</strong> if you can't find the element in the array.</p>\n<p>We'll test the complexity of your code so try to find the best possible algorithm.</p>\n<pre class="java"><code>public class Search {\n\n    /**\n     * @param tab is an ordered array of int.\n     * @return index of elem or -1\n     */\n    public static int search(int[] tab, int elem){\n        //TODO YOUR CODE HERE\n    }\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ComplexityArraySearch/LEPL1402_ComplexityArraySearch.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
179	Digraph (implem)	<p>Implémentez l'interface <code>Digraph.java</code> dans la classe <code>DigraphImplem.java</code> à l'aide d'une structure de donnée de type <code>liste d'adjacence</code> pour représenter les graphes dirigés.</p>\n<pre class="java"><code>package student;\n\npublic interface Digraph {\n\n    /**\n     * The number of vertices\n     */\n    public int V();\n\n    /**\n     * The number of edges\n     */\n    public int E();\n\n    /**\n     * Add the edge v-&gt;w\n     */\n    public void addEdge(int v, int w);\n\n    /**\n     * The nodes adjacent to edge v\n     */\n    public Iterable&lt;Integer&gt; adj(int v);\n\n    /**\n     * A copy of the digraph with all edges reversed\n     */\n    public Digraph reverse();\n\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6Digraph/LSINF1121_PART6_Digraph.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2019-12-30 17:05:18.961+00	0	1	DRAFT	\N	\N
103	quick sort code accuracy - Pre, Post conditions and Invariants	\n	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
182	PART 6 : Maze (implem)	<p>Nous sommes intéressés par la résolution de labyrinthe (labyrinthe) représenté par une matrice d'entiers 0-1 de taille <span class="title-ref">nxm</span>. Cette matrice est un tableau à deux dimensions. Une entrée égale à '1' signifie qu'il y a un mur et que cette position n'est donc pas accessible, tandis que '0' signifie que la position est libre.</p>\n<p>Nous vous demandons d'écrire un code Java pour découvrir le chemin le plus court entre deux coordonnées sur cette matrice de (x1, y1) à (x2, y2).</p>\n<p>Les déplacements ne peuvent être que verticaux ou horizontaux (pas en diagonale), un pas à la fois.</p>\n<p>Le résultat du chemin est un <code>Iterable</code> de coordonnées de l'origine à la destination. Ces coordonnées sont représentées par des entiers compris entre 0 et <span class="title-ref">n * m-1</span>, où un entier 'a' représente la position <span class="title-ref">x =a/m</span> et <span class="title-ref">y=a%m</span>.</p>\n<p>Si la position de début ou de fin est un mur ou s’il n’ya pas de chemin, il faut renvoyer un <code>Iterable</code> vide. Il en va de même s'il n'y a pas de chemin entre l'origine et la destination.</p>\n<pre class="java"><code>import java.util.LinkedList;\n\npublic class Maze {\n    public static Iterable&lt;Integer&gt; shortestPath(int [][] maze,  int x1, int y1, int x2, int y2) {\n        //TODO\n        return new LinkedList&lt;&gt;();\n    }\n\n    public static int ind(int x,int y, int lg) {return x*lg + y;}\n\n    public static int row(int pos, int mCols) { return pos / mCols; }\n\n    public static int col(int pos, int mCols) { return pos % mCols; }\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part6Maze/LSINF1121_PART6_Maze.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2020-03-02 21:38:45.944+00	1	1	VALIDATED	\N	\N
105	Game of 9 common Java programming errors	\n	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
192	Linked List Stack (Implem)	<p>Il vous est demandé d'implémenter l'interface suivante, représentant une pile, en utilisant une liste simplement chainée. Vous devriez avoir au moins un constructeur sans argument, créant une pile vide.</p>\n<p>Note: utiliser <em>java.util.Stack&lt;E&gt;</em> est interdit!</p>\n<pre class="java"><code>import java.util.EmptyStackException;\n\npublic interface Stack&lt;E&gt; {\n\n    public boolean empty();\n\n    public E peek() throws EmptyStackException;\n\n    public E pop() throws EmptyStackException;\n\n    public void push(E item);\n\n}</code></pre>\n<pre class="java"><code>import java.util.EmptyStackException;\n\npublic class MyStack&lt;E&gt; implements Stack&lt;E&gt; {\n\n    private Node&lt;E&gt; top;        // the node on the top of the stack\n    private int size;        // size of the stack\n\n    // helper linked list class\n    private class Node&lt;E&gt; {\n        private E item;\n        private Node&lt;E&gt; next;\n\n        public Node(E element, Node&lt;E&gt; next) {\n            this.item = element;\n            this.next = next;\n        }\n    }\n\n    /**\n    * Tests if this stack is empty\n    */\n    @Override\n    public boolean empty() {\n        // TODO STUDENT: Implement empty method\n    }\n\n    /**\n    * Looks at the object at the top of this stack\n    * without removing it from the stack\n    */\n    @Override\n    public E peek() throws EmptyStackException {\n        // TODO STUDENT: Implement peek method\n    }\n\n    /**\n    * Removes the object at the top of this stack\n    * and returns that object as the value of this function\n    */\n    @Override\n    public E pop() throws EmptyStackException {\n        // TODO STUDENT: Implement pop method\n    }\n\n    /**\n    * Pushes an item onto the top of this stack\n    * @param item the item to append\n    */\n    @Override\n    public void push(E item) {\n        // TODO STUDENT: Implement push method\n\n    }\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/m1stack/LSINF1121_PART1_Stack.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
190	Global Warming	<h1 id="context">Context</h1>\n<p>Assume the following 5x5 matrix:</p>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};</code></pre>\n<p>represented in the array here under:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/globalwarming_graph/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n<p>Each entry of the matrix represents an altitude. The objective is to implement a class <span class="title-ref">GlobalWarmingImpl</span> that implements all the methods described in <span class="title-ref">GlobalWarming</span> given next.</p>\n<p>A global water level specified in the constructor models the fact that all the positions of the matrix with a value &lt;= the water level are flooded (under the water) and thus unsafe. In the above example, the water level is 3, all the safe points are green.</p>\n<p>The method you must implement is the computation of the shortest path between two positions on a same island</p>\n<p>we assume that points are <strong>only connected vertially or horizontally</strong>.</p>\n<pre class="java"><code>import java.util.List;\n\nabstract class GlobalWarming {\n\n    /**\n     * A class to represent the coordinates on the altitude matrix\n     */\n    public static class Point {\n\n        final int x, y;\n\n        Point(int x, int y) {\n            this.x = x;\n            this.y = y;\n        }\n\n        @Override\n        public boolean equals(Object obj) {\n            Point p = (Point) obj;\n            return p.x == x &amp;&amp; p.y == y;\n        }\n    }\n\n    final int[][] altitude;\n    final int waterLevel;\n\n\n    /**\n     * In the following, we assume that the points are connected to\n     * horizontal or vertical neighbors but not to the diagonal ones\n     * @param altitude is a n x n matrix of int values representing altitudes (positive or negative)\n     * @param waterLevel is the water level, every entry &lt;= waterLevel is flooded\n     */\n    public GlobalWarming(int[][] altitude, int waterLevel) {\n        this.altitude = altitude;\n        this.waterLevel = waterLevel;\n    }\n\n\n    /**\n     *\n     * @param p1 a safe point with valid coordinates on altitude matrix\n     * @param p2 a safe point (different from p1) with valid coordinates on altitude matrix\n     * @return the shortest simple path (vertical/horizontal moves) if any between from p1 to p2 using only vertical/horizontal moves on safe points.\n     *         an empty list if not path exists (i.e. p1 and p2 are not on the same island).\n     */\n    public abstract List&lt;Point&gt; shortestPath(Point p1, Point p2);\n\n}</code></pre>\n<h1 id="preliminary-exercises">Preliminary exercises</h1>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};\nGlobalWarming gw = new MyGlobalWarming(tab,3);</code></pre>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/globalwarming_graph/matrix.png" class="align-center" width="200" alt="matrix example" /></p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
129	Largest Sum Contiguous Subarray	<p>In this exercise you must write a method <code>maxSubArray</code> that finds the largest sum in a contiguous subarray :</p>\n<dl>\n<dt>Given:</dt>\n<dd><ul>\n<li>an array <span class="math inline"><em>s</em></span>,</li>\n<li><span class="math inline">(<em>i</em>, <em>j</em>)</span>, two indexes defining the start and the end of a subarray <span class="math inline"><em>s</em><em>u</em><em>b</em></span> such that <span class="math inline">0 ≤ <em>i</em> ≤ <em>j</em> &lt; <em>s</em>.<em>l</em><em>e</em><em>n</em><em>g</em><em>t</em><em>h</em></span></li>\n<li><span class="math inline"><em>s</em><em>u</em><em>m</em>(<em>s</em><em>u</em><em>b</em>)</span> the sum of all elements of the subarray <span class="math inline"><em>s</em><em>u</em><em>b</em></span>.</li>\n</ul>\n</dd>\n</dl>\n<p><span class="math inline">∀<em>s</em><em>u</em><em>b</em> ∈ <em>s</em></span> such that <span class="math inline"><em>s</em><em>u</em><em>b</em> ≠ <em>s</em><em>u</em><em>b</em><sub><em>o</em><em>p</em><em>t</em><em>i</em><em>m</em><em>a</em><em>l</em></sub></span>; <span class="math inline"><em>s</em><em>u</em><em>b</em><sub><em>o</em><em>p</em><em>t</em><em>i</em><em>m</em><em>a</em><em>l</em></sub></span> is the maximum subarray of <span class="math inline"><em>s</em></span> if and only if <span class="math inline"><em>s</em><em>u</em><em>m</em>(<em>s</em><em>u</em><em>b</em><sub><em>o</em><em>p</em><em>t</em><em>i</em><em>m</em><em>a</em><em>l</em></sub>) &gt; <em>s</em><em>u</em><em>m</em>(<em>s</em><em>u</em><em>b</em>)</span>.</p>\n<p>What it means is that given an array, your program should find the <strong>first</strong> subarray that produces the maximum result.</p>\n<dl>\n<dt>Your method must return an array of three integers :</dt>\n<dd><ul>\n<li>The sum of the subarray</li>\n<li>The index of the start of the subarray</li>\n<li>The index of the end of the subarray</li>\n</ul>\n</dd>\n</dl>\n<pre class="java"><code>/*\n*    Given the array [-2,1,-3,4,-1,2,1,-5,4]\n*    The contiguous subarray that produces the best result is [4,-1,2,1]\n*    For this array your method should return [6, 3, 6]\n*/\npublic static int[] maxSubArray(int[] a){\n\n    //TODO By Student\n\n}</code></pre>\n<p>Note that the length of the array <strong>a</strong> is strictly greater than 0.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
191	Global Warming	<h1 id="context">Context</h1>\n<p>Assume the following 5x5 matrix:</p>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};</code></pre>\n<p>represented in the array here under:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/globalwarming_unionfind/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n<p>Each entry of the matrix represents an altitude. The objective is to implement a class <span class="title-ref">GlobalWarmingImpl</span> that implements all the methods described in <span class="title-ref">GlobalWarming</span> given next.</p>\n<p>A global water level specified in the constructor models the fact that all the positions of the matrix with a value &lt;= the water level are flooded (under the water) and thus unsafe. In the above example, the water level is 3, all the safe points are green.</p>\n<p>The methods you must implement are</p>\n<ul>\n<li>the number of islands</li>\n<li>a test to verify if two positions are on the same island</li>\n</ul>\n<p>we assume that points are <strong>only connected vertially or horizontally</strong>.</p>\n<pre class="java"><code>import java.util.List;\n\nabstract class GlobalWarming {\n\n    /**\n     * A class to represent the coordinates on the altitude matrix\n     */\n    public static class Point {\n\n        final int x, y;\n\n        Point(int x, int y) {\n            this.x = x;\n            this.y = y;\n        }\n\n        @Override\n        public boolean equals(Object obj) {\n            Point p = (Point) obj;\n            return p.x == x &amp;&amp; p.y == y;\n        }\n    }\n\n    final int[][] altitude;\n    final int waterLevel;\n\n\n    /**\n     * In the following, we assume that the points are connected to\n     * horizontal or vertical neighbors but not to the diagonal ones\n     * @param altitude is a n x n matrix of int values representing altitudes (positive or negative)\n     * @param waterLevel is the water level, every entry &lt;= waterLevel is flooded\n     */\n    public GlobalWarming(int[][] altitude, int waterLevel) {\n        this.altitude = altitude;\n        this.waterLevel = waterLevel;\n    }\n\n\n    /**\n     * An island is a connected components of safe points wrt to waterLevel\n     * @return the number of islands\n     */\n    public abstract int nbIslands();\n\n    /**\n     *\n     * @param p1 a point with valid coordinates on altitude matrix\n     * @param p2 a point with valid coordinates on altitude matrix\n     * @return true if p1 and p2 are on the same island, that is both p1 and p2 are safe wrt waterLevel\n     *        and there exists a path (vertical/horizontal moves) from p1 to p2 using only safe positions\n     */\n    public abstract boolean onSameIsland(Point p1, Point p2);\n\n\n}</code></pre>\n<h1 id="preliminary-exercises">Preliminary exercises</h1>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};\nGlobalWarming gw = new MyGlobalWarming(tab,3);</code></pre>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/globalwarming_unionfind/matrix.png" class="align-center" width="200" alt="matrix example" /></p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
202	Merge Sort	<p>Consider the (top-down) sorting algorithm <code>Merge Sort</code></p>\n<pre class="java"><code>public class MergeSort {\n    /**\n     * Pre-conditions: a[lo..mid] and a[mid+1..hi] are sorted\n     * Post-conditions: a[lo..hi] is sorted\n     */\n    private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi) {\n        for (int k = lo; k &lt;= hi; k++) {\n            aux[k] = a[k];\n        }\n\n        int i = lo;\n        int j = mid + 1;\n        for (int k = lo; k &lt;= hi; k++) {\n            if (i &gt; mid) {\n                a[k] = aux[j++];\n            } else if (j &gt; hi) {\n                a[k] = aux[i++];\n            } else if (aux[j].compareTo(aux[i]) &lt; 0) {\n                a[k] = aux[j++];\n            } else {\n                a[k] = aux[i++];\n            }\n        }\n    }\n\n    // Mergesort a[lo..hi] using auxiliary array aux[lo..hi]\n    private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi) {\n        // TODO\n    }\n\n    /**\n     * Rearranges the array in ascending order, using the natural order\n     */\n    public static void sort(Comparable[] a) {\n        // TODO\n    }\n}</code></pre>\n<p><strong>Note:</strong> The following questions will ask you to implement the function left out. You don't need to put the brackets (<code>{ }</code>) surrounding the function body in your answer.</p>	2019-12-30 17:05:18.963+00	2020-03-01 15:41:59.367+00	1	1	VALIDATED	\N	\N
197	Règles de participation aux cours	<h1 id="ce-qui-est-interdit">Ce qui est interdit</h1>\n<p>Il est interdit de partager son code avec un autre groupe et même avec son propre groupe pour les parties individuelles des missions.</p>\n<p>Il est interdit de publier son code de manière publique (<code>GitHub</code>, <code>Bitbucket</code>, <code>Dropbox</code> ou <code>Drive</code> partagé, etc) pendant et après le quadrimestre. Nous vous fournirons un repository <code>Git</code> pour vos travaux de groupes, qui sera seulement visible par les membres de votre groupe.</p>\n<p>Il est interdit de prendre le code de quelqu’un d’autre (même partiellement), y compris du code disponible sur le web. Seul le code fourni dans le livre de référence peut être utilisé.</p>\n<h1 id="ce-qui-est-autorisé">Ce qui est autorisé</h1>\n<p>Échanger et discuter des idées avec des collègues (y compris d’un autre groupe) est autorisé (oralement autour d’un tableau, sur un forum, etc). Mais il est interdit de demander et/ou fournir une réponse toute faite ou du code source.</p>\n<p>Exemple de ce qui est interdit :</p>\n<ul>\n<li>Tu as mis quoi à la réponse à la question 1 ?</li>\n</ul>\n<p>Exemple de ce qui est autorisé :</p>\n<ul>\n<li>J’hésite entre la méthode 1 et la méthode 2 pour réaliser l’objectif 1, je pense que la méthode 1 est meilleure pour la raison x, que penses-tu de cet argument ?</li>\n</ul>\n<h1 id="pourquoi">Pourquoi ?</h1>\n<p>Car le matériel pédagogique mis en place s’améliore chaque année et prend beaucoup de temps à développer. Le copyright de celui-ci appartient d’ailleurs à l’UCL et non aux étudiants.</p>\n<p>Contourner les outils pédagogiques mis en place (par exemple en empruntant du code déjà écrit) ne vous rend pas service. C’est même le meilleur moyen d’échouer à l’examen qui visera précisément à évaluer les compétences acquises: programmation, réponses aux questions, etc.</p>\n<p>En partageant du code ou des réponses (dans le meilleur des cas approximativement correctes...) vous inciteriez certains étudiants à ne pas réfléchir par eux-mêmes, voir pire, à apprendre des réponses potentiellement erronées.</p>\n<p>La note de participation ne vise pas l’exactitude des productions (réponses, codes) mais l’attitude et la motivation de l’étudiant à s’améliorer et acquérir les compétences visées.</p>\n<h1 id="risque">Risque</h1>\n<p>Tout manquement à un de ces points sera sanctionné comme un acte de tricherie et sera dès lors reporté au président des jurys. Pour rappel, en cas de tricherie, l'étudiant peut se voir attribuer un zéro pour le cours, voire se voir attribuer zéro pour l'ensemble des cours de la session.</p>\n<p>Vos codes sont analysés par des outils de détection de plagiat. Un étudiant averti en vaut deux.</p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
196	Circular linkedlist (Implem)	<p>On s’intéresse à l'implémentation d'une <code>liste simplement chaînée circulaire</code>, c’est-à-dire une liste pour laquelle la dernière position de la liste fait référence, comme position suivante, à la première position de la liste.</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/p1circularlinkedlist/CircularLinkedList.png" alt="image" /></p>\n<p>L’ajout d’un nouvel élément dans la file (méthode <code>enqueue</code>) se fait en fin de liste et le retrait (méthode <code>remove</code>) se fait a un <span class="title-ref">index</span> particulier de la liste. Une (seule) référence sur la fin de la liste (<code>last</code>) est nécessaire pour effectuer toutes les opérations sur cette file.</p>\n<p>Il vous est donc demander d'implémenter cette liste simplement chaînée circulaire à partir de la classe <code>CircularLinkedList.java</code> où vous devez completer (<em>TODO STUDENT</em>) les méthodes d'ajout (<code>enqueue</code>) et de retrait (<code>remove</code>) ainsi qu'un itérateur (<code>ListIterator</code>) qui permet de parcourir la liste en FIFO. <em>Attention:</em> un itérateur ne peut être modifié au cours de son utilisation.</p>\n<pre class="java"><code>package student;\n\nimport java.util.ConcurrentModificationException;\nimport java.util.Iterator;\nimport java.util.NoSuchElementException;\n\npublic class CircularLinkedList&lt;Item&gt; implements Iterable&lt;Item&gt; {\n private long nOp = 0; // count the number of operations\n private int n;          // size of the stack\n private Node  last;   // trailer of the list\n\n // helper linked list class\n private class Node {\n     private Item item;\n     private Node next;\n }\n\n public CircularLinkedList() {\n     last = null;\n     n = 0;\n }\n\n public boolean isEmpty() { return n == 0; }\n\n public int size() { return n; }\n\n private long nOp() { return nOp; }\n\n /**\n  * Append an item at the end of the list\n  * @param item the item to append\n  */\n public void enqueue(Item item) {\n     // TODO STUDENT: Implement add method\n }\n\n /**\n  * Removes the element at the specified position in this list.\n  * Shifts any subsequent elements to the left (subtracts one from their indices).\n  * Returns the element that was removed from the list.\n  */\n public Item remove(int index) {\n     // TODO STUDENT: Implement remove method\n }\n\n /**\n  * Returns an iterator that iterates through the items in FIFO order.\n  * @return an iterator that iterates through the items in FIFO order.\n  */\n public Iterator&lt;Item&gt; iterator() {\n     return new ListIterator();\n }\n\n /**\n  * Implementation of an iterator that iterates through the items in FIFO order.\n  *\n  */\n private class ListIterator implements Iterator&lt;Item&gt; {\n     // TODO STUDDENT: Implement the ListIterator\n }\n\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/p1circularlinkedlist/LSINF1121CircularLinkedList.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
139	Sieve of Eratosthenes Implementation	<p>In this task you are asked to implement the method <code>numberOfPrime(int n)</code> that returns the number of prime numbers between <span class="math inline">0</span> and <span class="math inline"><em>n</em></span> using the <a href="https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes">Eratosthene algorithm</a>. To implement this we force you to use a <a href="https://docs.oracle.com/javase/8/docs/api/java/util/BitSet.html">BitSet</a>, you are not allowed to use an array: you must work with the <code>bits</code> variable.</p>\n<p>The goal of this exercise is to introduce you to the <a href="https://docs.oracle.com/javase/8/docs/api/">java documentation</a> and to make sure that you are able to read, understand and use class that are defined and documented in java.</p>\n<pre class="java"><code>public static BitSet bits; //You should work on this BitSet\n\npublic static int numberOfPrime(int n){\n    //TODO By Student\n}</code></pre>	2019-12-30 17:02:49.134+00	2019-12-30 17:02:49.134+00	0	1	DRAFT	\N	\N
125	Introduction to java, exercises	<p>Welcome to the first task of a long series!</p>\n<p>This serie of inginious tasks will accompany you throughout the quadrimester to learn java and apprehend the material seen in class. Successful completion of all tasks is a major step towards the success of this course. We encourage you to try to do them yourself without going on the Internet.</p>\n<p>We also encourage you to try your solutions by yourself on you computer. To do so take a look at <a href="https://lepl1402.readthedocs.io/en/latest/tools/index.html">this tutorial</a> on the tools you will need.</p>\n<p>This first task will cover the basics of java step by step. In most exercises we want you to paste the <strong>signature</strong> and the <strong>body</strong> of the methods you create. In other cases we just wan to you paste the <strong>body</strong> and we give you the <strong>signature</strong>.</p>\n<p>Here is the class that you must implements in this task. The context of all variable must be static and the modifier public. You must find the return type by yourself.</p>\n<pre class="java"><code>public class IntroductionExercises {\n\n    public static int variable = 0;\n\n    public static int[] squares;\n\n    //TODO\n\n}</code></pre>\n	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
124	Inheritance : Fill the gaps (Small Exercise)	<p>Will you be able to fill the gaps inside these three source files ( <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Inheritance/Animal.java">Animal</a> , <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Inheritance/Cat.java">Cat</a> , <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Inheritance/SuperCat.java">SuperCat</a> ) so that it compiles and passes our tests ?</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Inheritance/LEPL1402_Inheritance.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
130	Merge Sort Implementation	<p>In this exercise we ask you to implement the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/MergeSortImplementation/topdown.png">top-down</a> merge sort algorithm on an array of integer. You have to use <strong>2 methods</strong>:</p>\n<blockquote>\n<ul>\n<li>Sort, this method has to divide the array and apply merge.</li>\n<li>Merge, this method has to merge the array given the 2 index, it receives from sort 3 index, lower bound, middle and high. It also receives a copy of the first array.</li>\n</ul>\n</blockquote>\n<p>The tests are build to make you able to test the two methods separly but we <strong>recommand</strong> you to test them by yourself.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/MergeSortImplementation/LEPL1402_MergeSortImplementation.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<p>Here is the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/MergeSortImplementation/MergeSort.java">MergeSort</a>:</p>\n<pre class="java"><code>public class MergeSort {\n\n    /**\n     * Pre-conditions: a[lo..mid] and a[mid+1..hi] are sorted\n     * Post-conditions: a[lo..hi] is sorted\n     */\n    private static void merge(int[] a, int[] aux, int lo, int mid, int hi) {\n        // TODO By Student\n    }\n    /**\n     * Rearranges the array in ascending order, using the natural order\n     */\n    public static void sort(int[] a) {\n        // TODO By Student\n    }\n\n    //TODO Optionnal additionnal method\n}</code></pre>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
149	Value Or Reference	<p>Try to answer the following question without actually testing the shown code on your computer.</p>	2019-12-30 17:02:49.135+00	2019-12-30 17:02:49.135+00	0	1	DRAFT	\N	\N
175	Union find	<p>Considérons un graphe composé de 10 nœuds disjoints (numérotés de 0 à 9). Nous utilisons une structure de données union-find pour représenter ce graphe. Dans un premier temps, chaque nœud est contenu dans une partition qui porte son nom. Ainsi, la représentation du graphique dans le tableau <code>id[]</code> est :</p>\n<pre><code>0 1 2 3 4 5 6 7 8 9</code></pre>\n<p>Les questions suivantes vous demanderont de donner la représentation du graphe après avoir utilisé l'algorithme <strong>quick-find</strong> pour ajouter une arête entre 2 noeuds. Vous devez donner cette représentation de la même manière qu'elle a été donnée ci-dessus.</p>\n<p><strong>Note:</strong> Lorsque nous joignons <code>p-q</code> avec l'algorithme quick-find, la convention est de changer <code>id[p]</code> (et éventuellement d'autres entrées) mais pas <code>id[q]</code>.</p>	2019-12-30 17:05:18.96+00	2019-12-30 17:05:18.961+00	0	1	DRAFT	\N	\N
183	Bilan Hashing	<p>Etant donné une fonction de hachage <span class="math inline">$h(\\left[v_0 \\cdots v_n \\right]) = \\sum_{i=0}^{n} v_i R^{(n-i-1)} \\% M$</span> dans laquelle <span class="math inline">[<em>v</em><sub>0</sub>⋯<em>v</em><sub><em>n</em></sub>]</span> dénote un vecteur de bit et <span class="math inline"><em>R</em></span> et <span class="math inline"><em>M</em></span> sont des facteurs constants.</p>\n	2019-12-30 17:05:18.961+00	2019-12-30 17:05:18.961+00	0	1	DRAFT	\N	\N
152	Time Complexity MCQ (trees, tsp, sort, lists)	<p>The three first questions will be time complexity questions about trees, the trees we are talking about is a complete ordered binary tree. Like the example you see here under:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LEPL1402/complexityMCQ2/binaryTree.png" class="align-center" width="392" height="225" alt="image" /></p>\n<p>The rest of the questions are harder question about the time complexity of operations on list and arrays. Some questions will be about simple linked list, other about double linked list and some about circular linked list.</p>\n	2019-12-30 17:02:49.135+00	2019-12-30 17:02:49.135+00	0	1	DRAFT	\N	\N
153	Longest Valley	<p>A geologist is trying to find the deepest valley and the biggest mountain between 2 locations and he thinks you can help him! He'll give you an array of integer like this one:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LEPL1402/valley/arraytest.png" class="align-center" width="620" height="64" alt="image" /></p>\n<p>The negative values mean the slope is negative and the positive ones mean it's positive. Thus previous array looks like this:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LEPL1402/valley/schema.png" class="align-center" width="620" height="319" alt="image" /></p>\n<p>Your method will return an array containing the depth of the deepest valley at index 0 and the biggest mountain at index 1. In this example, the depth is 5 and the summit is at 3.</p>\n<p>We can define a valley by saying it is sequence of negative number followed by a sequence of positive number with the same amount of numbers. The depth is the length of the sequence.</p>\n<p>Here is the mathematical definition:</p>\n<p>Given <span class="math inline"><em>A</em></span> an Array of integer <span class="math inline">∀<em>i</em>, 0 ≤ <em>i</em> &lt; |<em>A</em>|,<em>A</em>[<em>i</em>] ≠ 0</span>, Given <span class="math inline"><em>v</em></span> the length of the longest valley, <span class="math inline">∃!<em>i</em>, <em>j</em></span> with <span class="math inline">0 ≤ <em>i</em> &lt; <em>j</em> ≤ |<em>A</em>|</span> so that <span class="math inline">∀<em>m</em></span> , <span class="math inline"><em>i</em> ≤ <em>m</em> &lt; (<em>j</em> − <em>i</em>)/2</span> , <span class="math inline"><em>A</em>[<em>m</em>] &lt; 0</span> and <span class="math inline">∀<em>n</em></span> , <span class="math inline">(<em>j</em> − <em>i</em>)/2 &lt; <em>m</em> ≤ <em>j</em></span> , <span class="math inline"><em>A</em>[<em>n</em>] &gt; 0</span> , <span class="math inline"><em>j</em> − <em>i</em> &gt; <em>v</em> * 2</span></p>\n<p>We can define a mountain by saying it is sequence of positive number followed by a sequence of negative number with the same amount of numbers. The height is the length of the sequence.</p>\n<p>Here is the mathematical definition:</p>\n<p>Given <span class="math inline"><em>A</em></span> an Array of integer <span class="math inline">∀<em>i</em>, 0 ≤ <em>i</em> &lt; |<em>A</em>|,<em>A</em>[<em>i</em>] ≠ 0</span>, Given <span class="math inline"><em>v</em></span> the length of the longest valley, <span class="math inline">∃!<em>i</em>, <em>j</em></span> with <span class="math inline">0 ≤ <em>i</em> &lt; <em>j</em> ≤ |<em>A</em>|</span> so that <span class="math inline">∀<em>m</em></span> , <span class="math inline"><em>i</em> ≤ <em>m</em> &lt; (<em>j</em> − <em>i</em>)/2</span> , <span class="math inline"><em>A</em>[<em>m</em>] &gt; 0</span> and <span class="math inline">∀<em>n</em></span> , <span class="math inline">(<em>j</em> − <em>i</em>)/2 &lt; <em>m</em> ≤ <em>j</em></span> , <span class="math inline"><em>A</em>[<em>n</em>] &lt; 0</span> , <span class="math inline"><em>j</em> − <em>i</em> &gt; <em>v</em> * 2</span></p>\n<p>Consider that the array is never gonna be empty and your method should have a theta(n) complexity Here is the class you have to fill:</p>\n<pre class="java"><code>public class Valley{\n    /*\n     * Example:\n     * [1, 1, 1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, -1, -1]\n     * Should return\n     * [5, 3]\n     */\n\n     public static int[] valley ( int[] array){\n     //TODO By Student\n\n    }\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/valley/LEPL1402_valley.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.135+00	2019-12-30 17:02:49.135+00	0	1	DRAFT	\N	\N
164	Median (implem)	<p>Nous vous donnons l'API d'une classe Vector permettant d'accéder, modifier et interchanger deux élements en temps constant. Votre tâche est d'implémenter une méthode permettant de calculer la médiane d'un Vecteur.</p>\n<pre class="java"><code>public interface Vector {\n    // taille du vecteur\n    public int size();\n    // mets la valeur v à l&#39;indice i du vecteur\n    public void set(int i, int v);\n    // renvoie la valeur à l&#39;indice i du vecteur\n    public int get(int i);\n    // échange les valeurs aux positions i et j\n    public void swap(int i, int j);\n\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part2Median/LSINF1121_PART2_Median.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.959+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
165	Merge Sort (implem)	<p>Considérons l'algorithme de tri (descendant) <code>Merge Sort</code>.</p>\n<pre class="java"><code>public class MergeSort {\n    /**\n     * Pre-conditions: a[lo..mid] and a[mid+1..hi] are sorted\n     * Post-conditions: a[lo..hi] is sorted\n     */\n    private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi) {\n        for (int k = lo; k &lt;= hi; k++) {\n            aux[k] = a[k];\n        }\n\n        int i = lo;\n        int j = mid + 1;\n        for (int k = lo; k &lt;= hi; k++) {\n            if (i &gt; mid) {\n                a[k] = aux[j++];\n            } else if (j &gt; hi) {\n                a[k] = aux[i++];\n            } else if (aux[j].compareTo(aux[i]) &lt; 0) {\n                a[k] = aux[j++];\n            } else {\n                a[k] = aux[i++];\n            }\n        }\n    }\n\n    // Mergesort a[lo..hi] using auxiliary array aux[lo..hi]\n    private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi) {\n        // TODO\n    }\n\n    /**\n     * Rearranges the array in ascending order, using the natural order\n     */\n    public static void sort(Comparable[] a) {\n        // TODO\n    }\n}</code></pre>\n<p><strong>Note:</strong> Les questions suivantes vous demanderont d'implémenter la fonction left out. Vous n'avez pas besoin de mettre les accolades (<code>{ }</code>) entourant le corps de la fonction dans votre réponse.</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part2MergeSort/LSINF1121_PART2_MergeSort.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.959+00	2019-12-30 17:05:18.959+00	0	1	DRAFT	\N	\N
172	Global Warming (implem)	<h1 id="context">Context</h1>\n<p>Supposons la matrice 5x5 suivante:</p>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};</code></pre>\n<p>représentée dans le tableau ci-dessous :</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5GlobalWarming/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n<p>Chaque entrée de la matrice représente une altitude. L'objectif est d'implémenter une classe <span class="title-ref">GlobalWarmingImpl</span> qui implémente toutes les méthodes décrites dans <span class="title-ref">GlobalWarming</span> données ci-dessous.</p>\n<p>Un niveau d'eau global spécifié dans le constructeur modélise le fait que toutes les positions de la matrice avec une valeur &lt;= le niveau d'eau sont inondées (sous l'eau) et donc dangereuses. Dans l'exemple ci-dessus, le niveau d'eau est de 3, tous les points sûrs sont en vert.</p>\n<p>Les méthodes que vous devez implémenter sont les suivantes</p>\n<ul>\n<li>le nombre d'îles</li>\n<li>un test pour vérifier si deux positions sont sur la même île</li>\n</ul>\n<p>nous supposons que les points sont <strong>uniquement connectés verticalement ou horizontalement</strong>.</p>\n<p><a href="/course/LSINF1121-2016/Part5GlobalWarming/LSINF1121_PART5_GlobalWarming.zip">Le projet IntelliJ est disponible ici</a>.</p>\n<pre class="java"><code>import java.util.List;\n\nabstract class GlobalWarming {\n\n    /**\n     * A class to represent the coordinates on the altitude matrix\n     */\n    public static class Point {\n\n        final int x, y;\n\n        Point(int x, int y) {\n            this.x = x;\n            this.y = y;\n        }\n\n        @Override\n        public boolean equals(Object obj) {\n            Point p = (Point) obj;\n            return p.x == x &amp;&amp; p.y == y;\n        }\n    }\n\n    final int[][] altitude;\n    final int waterLevel;\n\n\n    /**\n     * In the following, we assume that the points are connected to\n     * horizontal or vertical neighbors but not to the diagonal ones\n     * @param altitude is a n x n matrix of int values representing altitudes (positive or negative)\n     * @param waterLevel is the water level, every entry &lt;= waterLevel is flooded\n     */\n    public GlobalWarming(int[][] altitude, int waterLevel) {\n        this.altitude = altitude;\n        this.waterLevel = waterLevel;\n    }\n\n\n    /**\n     * An island is a connected components of safe points wrt to waterLevel\n     * @return the number of islands\n     */\n    public abstract int nbIslands();\n\n    /**\n     *\n     * @param p1 a point with valid coordinates on altitude matrix\n     * @param p2 a point with valid coordinates on altitude matrix\n     * @return true if p1 and p2 are on the same island, that is both p1 and p2 are safe wrt waterLevel\n     *        and there exists a path (vertical/horizontal moves) from p1 to p2 using only safe positions\n     */\n    public abstract boolean onSameIsland(Point p1, Point p2);\n\n\n}</code></pre>\n<h1 id="preliminary-exercises">Preliminary exercises</h1>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};\nGlobalWarming gw = new MyGlobalWarming(tab,3);</code></pre>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part5GlobalWarming/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n	2019-12-30 17:05:18.96+00	2019-12-30 17:05:18.96+00	0	1	DRAFT	\N	\N
173	Heap	<p>Considérons la structure de données <code>Heap</code> dans laquelle on ajoute progressivement des nombres.</p>\n<p>Les questions suivantes vous demanderont d'écrire une représentation du <code>Heap</code> au fur et à mesure que nous y ajoutons des objets. Vous devez écrire le <code>Heap</code> comme s'il était stocké dans un tableau. Par exemple, si votre réponse est :</p>\n<pre><code>9\n/ \\\n5   8\n/ \\\n4   3</code></pre>\n<p>Vous devriez écrire:</p>\n<pre><code>9 5 8 4 3</code></pre>	2019-12-30 17:05:18.96+00	2019-12-30 17:05:18.96+00	0	1	DRAFT	\N	\N
186	Incremental Hash	<p>La fonction de Hash calculée sur le sous tableau <span class="math inline"><em>t</em>[<em>f</em><em>r</em><em>o</em><em>m</em>, ..., <em>f</em><em>r</em><em>o</em><em>m</em> + <em>M</em> − 1]</span> est calculée comme suit:</p>\n<p><span class="math inline">$hash([from,...,from+M-1])= \\left( \\sum_{i=0}^{M-1} t[from+i] \\cdot R^{(M-1-i)}\\right)\\%Q$</span></p>\n<p>Le code pour calculer cette fonction de hash vous est donné. Nous vous demandons de calculer <span class="math inline"><em>h</em><em>a</em><em>s</em><em>h</em>([<em>f</em><em>r</em><em>o</em><em>m</em>, ..., <em>f</em><em>r</em><em>o</em><em>m</em> + <em>M</em> − 1])</span> au départ de <span class="math inline"><em>h</em><em>a</em><em>s</em><em>h</em>([<em>f</em><em>r</em><em>o</em><em>m</em> − 1, ..., <em>f</em><em>r</em><em>o</em><em>m</em> + <em>M</em> − 2])</span> en O(1).</p>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/Part4IncrementalHash/LSINF1121_PART4_IncrementalHash.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.961+00	2019-12-30 17:05:18.961+00	0	1	DRAFT	\N	\N
184	Circular LinkedList	<h1 id="context">Context</h1>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/bilan_m1/bilan_m1.pdf">Description</a> of the implementation exercise and interesting questions to improve your skills.</p>\n<p>Fill-in the body of each method (TODO) below in the corresponding textfield. grade: 50% for the correctness of your implementation (correct or not), 50% for the efficiency (efficient or not).</p>\n<pre class="java"><code>public class NodeQueue&lt;E&gt; implements Queue&lt;E&gt; {\n\n    // Variables d’instance\n\n    private Node&lt;E&gt; marker;\n    private int size;\n\n\n    @Override\n    public int size() {\n        // TODO\n        return 0;\n    }\n\n    @Override\n    public boolean isEmpty() {\n        // TODO\n        return true;\n    }\n\n    @Override\n    public E front() throws QueueEmptyException {\n        // TODO\n        return null;\n    }\n\n    @Override\n    public void enqueue(E element) {\n        // TODO\n\n    }\n\n    @Override\n    public E dequeue() throws QueueEmptyException {\n        // TODO\n        return null;\n    }\n}</code></pre>	2019-12-30 17:05:18.961+00	2019-12-30 17:05:18.961+00	0	1	DRAFT	\N	\N
185	Global Warming	<h1 id="context">Context</h1>\n<p>Assume the following 5x5 matrix:</p>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};</code></pre>\n<p>represented in the array here under:</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/bilan_m2_global_warming/matrix.png" class="align-center" width="200" alt="matrix example" /></p>\n<p>Each entry of the matrix represents an altitude. The objective is to implement a class <span class="title-ref">GlobalWarmingImpl</span> that the method described in <span class="title-ref">GlobalWarming</span> given next.</p>\n<p>Given a global water level, all the positions of the matrix with a value &lt;= the water level are flooded (under the water) and thus unsafe. So assuming the water level is 3, all the safe points are green.</p>\n<p>The methods you must implement is</p>\n<ul>\n<li>the computations of the number of safe-points given a specified water level</li>\n</ul>\n<pre class="java"><code>import java.util.List;\n\nabstract class GlobalWarming {\n\n\n    final int[][] altitude;\n\n    /**\n     * @param altitude is a n x n matrix of int values representing altitudes (positive or negative)\n     */\n    public GlobalWarming(int[][] altitude) {\n        this.altitude = altitude;\n    }\n\n    /**\n     *\n     * @param waterLevel\n     * @return the number of entries in altitude matrix that would be above\n     *         the specified waterLevel.\n     *         Warning: this is not the waterLevel given in the constructor/\n     */\n    public abstract int nbSafePoints(int waterLevel);\n\n}</code></pre>\n<h1 id="preliminary-exercises">Preliminary exercises</h1>\n<pre class="java"><code>int [][] tab = new int[][] {{1,3,3,1,3},\n                          {4,2,2,4,5},\n                          {4,4,1,4,2},\n                          {1,4,2,3,6},\n                          {1,1,1,6,3}};\nGlobalWarming gw = new MyGlobalWarming(tab);</code></pre>	2019-12-30 17:05:18.961+00	2019-12-30 17:05:18.961+00	0	1	DRAFT	\N	\N
188	Connected Components	<p>L'API de la classe <a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/bilan_m6_cc/javadoc.zip">Graph</a>.</p>\n<p>L'API de <a href="https://docs.oracle.com/javase/8/docs/api/">Java</a>.</p>\n<pre class="java"><code>public class ConnectedComponents {\n  /**\n   * @return the number of connected components in g\n   */\n  public static int numberOfConnectedComponents(Graph g) {\n    // TODO\n    return 0;\n  }\n}</code></pre>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
189	Quizz: Closest Pair	<p>Implémentez un algorithme qui reçoit en entrée un tableau d'entiers et qui trouve deux valeurs issues de tableau dont la somme se rapproche le plus d'une valeur entière donnée <span class="math inline"><em>x</em></span>. Soiet <span class="math inline">(<em>a</em>, <em>b</em>)</span> les deux valeurs trouvées, celles-ci doivent donc minimiser <span class="math inline">|<em>x</em> − (<em>a</em> + <em>b</em>)|</span>. Les deux valeurs peuvent correspondre à la même entrée du tableau.</p>\n<p>Par exemple pour le tableau suivant</p>\n<pre class="java"><code>int [] input = new int [] {5,10,1,75,150,151,155,18,75,50,30};</code></pre>\n<ul>\n<li>x=20, il faut retourner [10,10].</li>\n<li>x=153, il faut retrouner [1,151]</li>\n<li>x=13, il faut retrouner [1,10]</li>\n<li>x=140 il faut retourner [75,75]</li>\n<li>x=170 il faut retourner [18,151]</li>\n</ul>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/closestpair/project.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.962+00	2020-02-03 17:29:17.212+00	1	1	DRAFT	\N	\N
213	Tri des élèves	<p>A la séance dernière, vous vous êtes triés selon la première lettre de vos noms de famille. On va maintenant programmer ce tri ensemble !</p>\n<p><strong>Petit rappel de la méthode utilisée</strong></p>\n<ul>\n<li>Il y a une file d'attente avec tous les enfants et une rangée qui est vide au départ.</li>\n<li>Le premier de la file d'attente va comparer la première lettre de son nom de famille avec la personne de la rangée en face de lui, si il y en a une.</li>\n<li>Si la lettre du premier de la file d'attente est plus petite (donc se trouve avant dans l'alphabet), alors le reste de la rangée se décale et le premier de la file d'attente prend la place de celui avec qui il a fait la comparaison</li>\n<li>Sinon, le premier de la file d'attente se décale pour faire face à l'enfant suivant (si il y en a un) et lui pose la même question.</li>\n</ul>\n	2019-12-30 17:05:33.853+00	2020-02-05 14:20:28.294+00	1	1	DRAFT	\N	\N
193	Write Unit tests Stack (Implem)	<p>Rappelez-vous de l'interface Stack :</p>\n<pre class="java"><code>import java.util.EmptyStackException;\n\npublic interface Stack&lt;E&gt; {\n\n    public boolean empty();\n\n    public E peek() throws EmptyStackException;\n\n    public E pop() throws EmptyStackException;\n\n    public void push(E item);\n\n}</code></pre>\n<p>Il vous est demandé d'écrire des tests unitaire (en utilisant JUnit) afin de vérifier si une implémentation particulière de cette interface est correcte.</p>\n<p>Voici un modèle simple que vous pouvez utiliser pour écrire vos tests (vous pouvez utiliser d'autres types que des String, bien sûr !) :</p>\n<pre class="java"><code>import org.junit.Test;\nimport static org.junit.Assert.assertEquals;\n\npublic class StackTests {\n\n    @Test\n    public void firstTest() {\n        Stack&lt;Integer&gt; stack = new MyStack&lt;Integer&gt;();\n        stack.push(1);\n        assertEquals(new Integer(1), stack.pop());\n    }\n\n    @Test\n    public void secondTest() {\n        // ... TODO ...\n    }\n\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/m1stacktests/LSINF1121_PART1_Stack.zip">Le projet IntelliJ est disponible ici</a>.</p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
195	Median	<p>Nous vous donnons l'API d'une classe Vector permettant d'accéder, modifier et interchanger deux élements en temps constant. Votre tâche est d'implémenter une méthode permettant de calculer la médiane d'un Vecteur.</p>\n<pre class="java"><code>public interface Vector {\n    // taille du vecteur\n    public int size();\n    // mets la valeur v à l&#39;indice i du vecteur\n    public void set(int i, int v);\n    // renvoie la valeur à l&#39;indice i du vecteur\n    public int get(int i);\n    // échange les valeurs aux positions i et j\n    public void swap(int i, int j);\n\n}</code></pre>\n<p><a href="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/median/project.zip">Un projet Eclipse contenant des tests basiques vous est fourni en cliquant sur ce lien.</a></p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
201	Heap	<p>Consider the <code>Heap</code> data structure in which we progressively add numbers.</p>\n<p>The following questions will ask you to write a representation of the <code>Heap</code> as we add objects in it. You must write the <code>Heap</code> as if it was stored in an array. For example, if your answer is:</p>\n<pre><code>9\n/ \\\n5   8\n/ \\\n4   3</code></pre>\n<p>You would write:</p>\n<pre><code>9 5 8 4 3</code></pre>	2019-12-30 17:05:18.963+00	2019-12-30 17:05:18.963+00	0	1	DRAFT	\N	\N
203	Red Black Tree	<p>Prenons l'exemple d'un <code>Red-Black Tree</code> vide dans lequel on ajoute progressivement des chiffres.</p>\n<p>Les questions suivantes vous demanderont d'écrire une représentation du <code>Red-Black Tree</code> au fur et à mesure que nous y ajouterons des objets.</p>\n<p>Écrivez la réponse comme si vous lisiez le <code>Red-Black Tree</code> de gauche à droite et de haut en bas (en ignorant les blancs possibles). Par exemple, si votre réponse est :</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LSINF1121-2016/PART3Rbt/rbt.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>Vous écririez:</p>\n<pre><code>6 24 7 1 3 5 9</code></pre>\n<p>Remarquez comment le nœud 2-3 composé de <code>2</code>et <code>4</code> est écrit d'une manière fusionnée (<code>24</code>).</p>\n	2019-12-30 17:05:18.963+00	2019-12-30 17:05:18.963+00	0	1	DRAFT	\N	\N
209	Les conditions	<p>C'est fatiguant de devoir regarder l'arbre de décision pour chaque gâteau. Et si on faisait un programme qui peut déterminer si un gâteau a bien été fait selon l'arbre de décision ou pas? T'es partant ? Allons-y !</p>\n<p>Pour rappel, l'arbre de décision ressemblait à ceci :</p>\n<blockquote>\n<p><img src="https://inginious.org/course/primaire/arbre/arbre.png" height="300" alt="image" /></p>\n</blockquote>\n<p>Utilise les blocs pour programmer l'arbre de décision. Pour t'aider, on a déjà mis les premiers blocs. Tu dois simplement déterminer les cas où le gâteau est valide.</p>\n	2019-12-30 17:05:33.852+00	2020-02-05 14:18:46.416+00	2	1	DRAFT	\N	\N
212	Initiation à INGInious	<p>Cet exercice est simple, mais il te permettra de comprendre comment fonctionne INGInious. Réorganise les différents blocs pour reformer la recette de la tartine au chocolat. La recette est la suivante :</p>\n<ul>\n<li>Ouvrir le sachet de pain</li>\n<li>Prendre une tartine</li>\n<li>Poser la tartine sur l'assiette</li>\n<li>Ouvrir le pot de chocolat</li>\n<li>Prendre le couteau</li>\n<li>Tremper le couteau dans le chocolat</li>\n<li>Tartiner le chocolat sur la tartine</li>\n<li>Poser le couteau</li>\n<li>Plier la tartine</li>\n<li>La manger !</li>\n</ul>\n<p>N'hésite pas à faire des erreurs pour voir ce que fait INGInious dans ce cas-là.</p>\n	2019-12-30 17:05:33.853+00	2020-03-01 15:41:59.367+00	2	1	VALIDATED	\N	\N
198	Breadth First Paths	<p>Consider this class, <code>BreadthFirstShortestPaths</code>, that computes the shortest path between multiple node sources and any node in an undirected graph.</p>\n<pre class="java"><code>// TODO\n\npublic class BreadthFirstShortestPaths {\n\n    private static final int INFINITY = Integer.MAX_VALUE;\n    private boolean[] marked; // marked[v] = is there an s-v path\n    private int[] distTo;     // distTo[v] = number of edges shortest s-v path\n\n    /**\n     * Computes the shortest path between any\n     * one of the sources and very other vertex\n     * @param G the graph\n     * @param sources the source vertices\n     */\n     public BreadthFirstShortestPaths(Graph G, Iterable&lt;Integer&gt; sources) {\n         marked = new boolean[G.V()];\n         distTo = new int[G.V()];\n         for (int v = 0;v &lt; G.V();v++) {\n             distTo[v] = INFINITY;\n         }\n         bfs(G, sources);\n     }\n\n     // Breadth-first search from multiple sources\n     private void bfs(Graph G, Iterable&lt;Integer&gt; sources) {\n         // TODO\n     }\n\n     /**\n      * Is there a path between (at least one of) the sources and vertex v?\n      * @param v the vertex\n      * @return true if there is a path, and false otherwise\n      */\n     public boolean hasPathTo(int v) {\n         // TODO\n     }\n\n     /**\n      * Returns the number of edges in a shortest path\n      * between one of the sources and vertex v?\n      * @param v the vertex\n      * @return the number of edges in a shortest path\n      */\n     public int distTo(int v) {\n         // TODO\n     }\n}</code></pre>\n<p>The class <code>Graph</code> is already implemented. Here is its specification:</p>\n<pre class="java"><code>public class Graph {\n    // @return the number of vertices\n    public int V() { }\n\n    // @return the number of edges\n    public int E() { }\n\n    // Add edge v-w to this graph\n    public void addEdge(int v, int w) { }\n\n    // @return the vertices adjacent to v\n    public Iterable&lt;Integer&gt; adj(int v) { }\n\n    // @return a string representation\n    public String toString() { }\n}</code></pre>\n<p><strong>Note:</strong> The following questions will ask you to implement the function left out. You don't need to put the brackets (<code>{ }</code>) surrounding the function body in your answer.</p>	2019-12-30 17:05:18.962+00	2019-12-30 17:05:18.962+00	0	1	DRAFT	\N	\N
205	Union find	<p>Considérons un graphe composé de 10 nœuds disjoints (numérotés de 0 à 9). Nous utilisons une structure de données union-find pour représenter ce graphe. Dans un premier temps, chaque nœud est contenu dans une partition qui porte son nom. Ainsi, la représentation du graphique dans le tableau <code>id[]</code> est :</p>\n<pre><code>0 1 2 3 4 5 6 7 8 9</code></pre>\n<p>Les questions suivantes vous demanderont de donner la représentation du graphe après avoir utilisé l'algorithme <strong>quick-find</strong> pour ajouter une arête entre 2 noeuds. Vous devez donner cette représentation de la même manière qu'elle a été donnée ci-dessus.</p>\n<p><strong>Note:</strong> Lorsque nous joignons <code>p-q</code> avec l'algorithme quick-find, la convention est de changer <code>id[p]</code> (et éventuellement d'autres entrées) mais pas <code>id[q]</code>.</p>\n	2019-12-30 17:05:18.963+00	2020-02-03 17:29:17.212+00	1	1	DRAFT	\N	\N
4	Manipulation de liste	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>	2019-12-30 17:00:49.294+00	2020-03-01 15:41:59.366+00	1	1	VALIDATED	\N	\N
6	Producteurs/Consommateurs	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LSINF1252/PC/buffer.png" alt="image" /></p>	2019-12-30 17:00:49.294+00	2020-03-01 15:41:59.366+00	1	1	VALIDATED	\N	\N
10	Advanced queue	<p>You must implement the <code>enqueue</code> and <code>dequeue</code> functions of a <span class="title-ref">Queue</span> that is implemented as a simple circular list. This <a href="https://en.wikipedia.org/wiki/Linked_list#Circularly_linked_vs._linearly_linked">Wikipedia page</a> describes such a list as follows:</p>\n<p>"With a circular list, a pointer to the last node gives easy access also to the first node, by following one link. Thus, in applications that require access to both ends of the list (e.g., in the implementation of a queue), a circular structure allows one to handle the structure by a single pointer, instead of two."</p>\n<p><img src="https://upload.wikimedia.org/wikipedia/commons/d/df/Circularly-linked-list.svg" alt="image" /></p>\n<p>Assume that the head of the queue is the leftmost node and that the tail of the queue is the rightmost node. In the previous example, the head and the tail are respectively <code>12</code> and <code>37</code>. So in this case, the only pointer you can use will point to the <code>37</code> node.</p>\n<p>You can use the following datastructures for this exercise:</p>\n<pre class="c"><code>typedef struct node{\n  struct node* next;\n  int value;\n} node_t;\n\ntypedef struct queue{\n  struct node* tail;\n  int size;\n} queue_t  ;</code></pre>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.296+00	0	1	DRAFT	\N	\N
11	ArrayList	<p>Vous devez modifier une librairie qui implémente une ArrayList en y ajoutant une fonction. Cette ArrayList s'utilise comme suit</p>\n<pre class="c"><code>int main(void) {\n     struct array_list *head = arraylist_init((size_t) 2, (size_t) sizeof(int));\n     int first = 5;\n     int second = 6;\n     int third = 7;\n     int tmp;\n\n     int ret;\n\n     if (!head)\n             return 0;\n\n     set_element(head, 0, (void *)&amp;first);\n     set_element(head, 1, (void *)&amp;second);\n\n     get_element(head, 1, (void *)&amp;tmp);\n     // tmp contient 6\n     add_tail(head, (void *)&amp;third);\n     get_element(head, 2, (void *)&amp;tmp);\n     // tmp contient 7\n     printf(&quot;array-list size: %d element-size %d\\n&quot;, get_size(head), get_elem_size(head));\n     // affiche array-list size: 3 element-size 4\n     array_list_destroy(head);\n     return 0;\n}</code></pre>\n<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<p>Les pages de manuel sont accessibles depuis les URLs suivants : - <a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes) - <a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes) - <a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions librairies)</p>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.296+00	0	1	DRAFT	\N	\N
12	Get an array from a binary file using mmap	<p>Given a file containing a linked list of the structure <em>student_t</em> following, you have to write a function to load the entire linked list from the file and to return a pointer to the head of this linked list. Assume that, in the file, if <strong>a</strong> is followed by <strong>b</strong>, you will have <code>a-&gt;next = b</code>.</p>\n<pre class="c"><code>typedef struct student{\n    struct student* next;\n    int noma;\n} student_t;</code></pre>\n<p>In this exercice, you <strong>cannot</strong> use <em>fopen</em>, <em>read</em>, <em>fread</em>, <em>fgetc</em>, <em>fgets</em>, which means that you must use <a href="https://sites.uclouvain.be/SystInfo/manpages/man2/mmap.2.html">mmap(2).</a></p>\n<p>In case of error (using malloc), you have to free <strong>all</strong> the memory you have allocated.</p>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.296+00	0	1	DRAFT	\N	\N
13	Traduction de code assembleur	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<p>Les pages de manuel sont accessibles depuis les URLs suivants :</p>\n<ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions librairies)</li>\n</ul>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.296+00	0	1	DRAFT	\N	\N
14	Traduction de code assembleur	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<p>Les pages de manuel sont accessibles depuis les URLs suivants :</p>\n<ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.296+00	0	1	DRAFT	\N	\N
15	Traduction de code assembleur	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.296+00	0	1	DRAFT	\N	\N
16	Traduction de code assembleur	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>	2019-12-30 17:00:49.296+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
18	Bitwise operation: high order bits	<p>In this exercise, we will work with operation on bits. When we speak about the position of a bit, index 0 corresponds to lowest order bit, 1 to the second-lowest order bit, ...</p>\n<p>In C source code, you can write a number in binary (base 2) by prefixing it via 0b., e.g. 0b11010 = 26.</p>\n<p>This exercise will introduce some non-standard data types which guarantee that the variable has a fixed number of bits. Indeed, on some machines, a <em>int</em> could use 2, 4 or 8 bytes. Hence, if we want to perform bitwise operations, we have to know first on how many bits we are working.</p>\n<p>For this, C introduces a new class of variable types :</p>\n<ul>\n<li><em>int8_t</em> (signed integer of 8 bits)</li>\n<li><em>uint8_t</em> (unsigned integer of 8 bits)</li>\n<li><em>uint16_t</em> (unsigned integer of 16 bits)</li>\n</ul>\n<p>You can mix <em>uint</em> or <em>int</em> with bit-lengths 8, 16, 32 and 64). These types are defined in &lt;stdint.h&gt;</p>	2019-12-30 17:00:49.297+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
19	Bitwise operation: extract low order bits	<p>In this exercise, we will work with operations on bits. When we speak about the position of a bit, index 0 corresponds to lowest order bit, 1 to the second-lowest order bit, ...</p>\n<p>In C source code, you can write a number in binary (base 2) by prefixing it via 0b., e.g. <code>0b11010</code> = 26.</p>\n<p>This exercise will introduce some non-standard data types which guarantee that the variable has a fixed number of bits. Indeed, on some machines, a <em>int</em> could use 2, 4 or 8 bytes. Hence, if we want to perform bitwise operations, we have to know first on how many bits we are working.</p>\n<p>For this, C introduces a new class of variable types :</p>\n<ul>\n<li><em>int8_t</em> (signed integer of 8 bits)</li>\n<li><em>uint8_t</em> (unsigned integer of 8 bits)</li>\n<li><em>uint16_t</em> (unsigned integer of 16 bits)</li>\n</ul>\n<p>You can mix <em>uint</em> or <em>int</em> with bit-lengths 8, 16, 32 and 64). These types are defined in &lt;stdint.h&gt;</p>	2019-12-30 17:00:49.297+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
20	Bitwise operation: cycling bits	<p>In this exercise, we will work with operations on bits. When we speak about the position of a bit, index 0 corresponds to lowest order bit, 1 to the second-lowest order bit, ...</p>\n<p>In C source code, you can write a number in binary (base 2) by prefixing it via 0b., e.g. 0b11010 = 26.</p>\n<p>This exercise will introduce some non-standard data types which guarantee that the variable has a fixed number of bits. Indeed, on some machines, a <em>int</em> could use 2, 4 or 8 bytes. Hence, if we want to perform bitwise operations, we have to know first on how many bits we are working.</p>\n<p>For this, C introduces a new class of variable types :</p>\n<ul>\n<li><em>int8_t</em> (signed integer of 8 bits)</li>\n<li><em>uint8_t</em> (unsigned integer of 8 bits)</li>\n<li><em>uint16_t</em> (unsigned integer of 16 bits)</li>\n</ul>\n<p>You can mix <em>uint</em> or <em>int</em> with bit-lengths 8, 16, 32 and 64). These types are defined in &lt;stdint.h&gt;</p>	2019-12-30 17:00:49.297+00	2019-12-30 17:00:49.297+00	0	1	DRAFT	\N	\N
23	Opérations sur les bits	<p>On souhaite effectuer des opérations spécifiques sur certains bits d'un entier non-signé de 32 bits. Lorsque l'on parle de position, l'indice 0 correspond au bit le plus faible, et 31 au bit le plus fort. Dans cet exercice, un <span class="title-ref">unsigned char</span> représente toujours un seul bit et ne pourra donc que prendre les valeurs numériques 0 ou 1 (et non '0' et '1')</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned char get_bit(unsigned int x, unsigned int pos)</span> qui renvoie le bit à la position <span class="title-ref">pos</span> de x.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned int set_bit(unsigned int x, unsigned int pos, unsigned char value)</span> qui met le bit à la position <span class="title-ref">pos</span> de x à la valeur <span class="title-ref">value</span>.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned char get_3_leftmost_bits(unsigned int x)</span> qui renvoie les 3 bits les plus à gauches de x. Par exemple, si on a la séquence 11011001, la fonction doit renvoyer la valeur correspondant à 00000110.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned char get_4_rightmost_bits(unsigned int x)</span> qui renvoie les 4 bits les plus à droite de x.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned int unset_last_bit(unsigned int x)</span> qui met à 0 le premier bit de poids fort à 1 qu'il trouve, et ne fait rien s'il n'y a pas de bit mis à 1.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned int cycle_bits(unsigned int x, unsigned int n)</span> qui déplace tous les bits de n places vers la gauche selon la formule x[(i+n)%32] = x[i] où x[i] représente le ième bit de x.</p>\n<p>Vous pouvez faire appel aux fonctions <span class="title-ref">get_bit</span> et <span class="title-ref">set_bit</span> dans les autres.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
24	Gestion d'une librairie	<p>On souhaite gérer le catalogue d'une librairie dans lequel chaque livre est identifié par son auteur et son titre. La structure de données choisie est la suivante : il y a une liste chaînée d'auteurs dont chaque élément pointe vers une liste chaînée d'ouvrages.</p>\n<pre class="c"><code>typedef struct cellAuteur {\n    char *auteur;\n    struct cellLivre *Livres;\n    struct cellAuteur *next;\n} cellAuteur;\n\ntypedef struct cellLivre {\n    char *titre;\n    struct cellLivre *suiv;\n} cellLivre;</code></pre>\n<p>Écrivez une fonction <span class="title-ref">cellAuteur *existe(cellAuteur *librairie, char *strAuteur)</span> qui teste si un auteur existe dans la liste librairie et dans ce cas renvoie un pointeur sur sa cellule de la liste (et NULL sinon).</p>\n<p>Écrivez une fonction <span class="title-ref">int compteOuvrage(cellAuteur *librairie, char *strAuteur)</span> qui compte le nombre de livres d'un auteur dans la liste librairie.</p>\n<p>Écrivez une fonction <span class="title-ref">void add(cellAuteur *librairie, char *strAuteur, char *strTitre)</span> qui ajoute dans le catalogue un livre de l'auteur indiqué. L'auteur existe dans le catalogue. Un même livre ne peut pas être présent 2 fois dans la catalogue.</p>\n<p>Écrivez une fonction <span class="title-ref">void supprimer(cellAuteur **librairie, char *strAuteur)</span> qui supprime du catalogue un auteur et tous ses livres. L'auteur existe dans le catalogue.</p>\n<p>Vous avez accès aux fonctions de <span class="title-ref">string.h</span>.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
26	Coder calloc en utilisant malloc	<p>Ecrire la fonction <code>calloc2</code>, ayant le même prototype et le même fonctionnement que <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/calloc.3.html">calloc(3)</a> mais qui utilise <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/malloc.3.html">malloc(3)</a> pour allouer la mémoire.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
28	Le programme test	<p>La commande <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/test.1.html">test(1)</a> permet d'évaluer une expression passée en paramètre. Elle retourne:</p>\n<ul>\n<li><code>0</code> si l'expression passée en argument est vraie</li>\n<li><code>1</code> si l'expression passée en argument est fausse</li>\n</ul>\n<p>On vous demande d'écrire un sous-ensemble de la commande <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/test.1.html">test(1)</a> en C. Les expressions à implémenter sont <code>-eq</code>, <code>-ge</code>, <code>-gt</code>, <code>-le</code>, <code>-lt</code> et <code>-ne</code>.</p>\n<p>Pour rappel, la commande <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/test.1.html">test(1)</a> est décrite dans la <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/test.1.html">page de manuel</a> qui lui est consacrée.</p>\n<p>Pour répondre à cette question, vous devez structurer votre programme avec des appels de sous-fonction et donc de ne pas faire toute l'exécution dans la fonction <code>main()</code>.</p>\n<p>Il existe plusieurs façons pour tester votre code, une de ces façons est de regarder dans le shell le contenu de la variable <code>$?</code> après chaque exécution de votre programme. Une autre façon est de profiter de l'instruction conditionnelle <code>if-then-else</code> du shell.</p>	2019-12-30 17:00:49.298+00	2019-12-30 17:00:49.298+00	0	1	DRAFT	\N	\N
32	Déterminer la valeur de retour d'un programme exécutable	<p>Dans un programme similaire à un shell, on vous demander d'écrire une fonction qui permet de lancer un exécutable et d'indiquer si :</p>\n<ul>\n<li>le programme ne s'est pas exécuté ou a retourné une valeur de retour positive</li>\n<li>le programme s'est exécuté correctement et a retourné une valeur de retour =0</li>\n<li>le programme a été interrompu par un signal</li>\n</ul>\n<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>	2019-12-30 17:00:49.299+00	2019-12-30 17:00:49.299+00	0	1	DRAFT	\N	\N
33	Threads : plus grand commun diviseur	<p>On cherche à calculer le plus grand commun diviseur de deux très grands nombres. Pour ce faire, on calcule tous les diviseurs de chacun des 2 nombres, et on regarde quel est leur PGCD. Pour ce faire, on déclare la liste chaînée suivante, permettant d'enregistrer en mémoire les diviseurs d'un nombre :</p>\n<pre class="c"><code>struct Node {\n    unsigned int divisor;\n    struct Node *next;\n};</code></pre>\n<p>Écrivez une fonction <span class="title-ref">void *factorize(void *n)</span> qui retourne un pointeur vers une liste chaînée contenant tous les diviseurs dans l'ordre décroissant du nombre de type <span class="title-ref">unsigned int</span> vers lequel n pointe.</p>\n<p>Écrivez une fonction <span class="title-ref">unsigned int gcd(unsigned int a, unsigned int b)</span> qui va lancer l'exécution de <span class="title-ref">factorize</span> pour a et b dans 2 threads différents et va extraire des deux listes renvoyées le PGCD. Le nombre 1 est considéré comme un diviseur. Cette fonction renvoie 0 si une erreur s'est produite.</p>	2019-12-30 17:00:49.299+00	2019-12-30 17:00:49.299+00	0	1	DRAFT	\N	\N
35	Indexation d'un texte	<p>On souhaite indexer un texte afin de savoir quels mots reviennent le plus fréquemment dans un corpus. Le processus d'indexation se fait en 2 phases : on compte d'abord le nombre d'occurrences de chaque mot, et on supprime ensuite de la table d'indexation tous les mots qui n'ont pas été indexés au moins N fois. Le corpus est une chaîne de caractères composées uniquement de minuscules et où le seul délimiteur est un espace (pas de ponctuation). Votre programme n'est jamais censé produire d'erreurs de segmentation.</p>\n<p>On définit la structure suivante représentant une entrée de l'index :</p>\n<pre class="c"><code>typedef struct indexEntry {\n    char word[26];\n    int count; //nombre de fois qu&#39;un mot est apparu dans le corpus\n    struct indexEntry *next;\n} Entry;</code></pre>\n<p>Écrivez une fonction <span class="title-ref">Entry *build_index(char *corpus)</span> qui renvoie l'index associé au corpus passé en paramètre. Vous pouvez modifier la chaine passée en argument.</p>\n<p>Écrivez une fonction <span class="title-ref">void filter_index(Entry **index_head, int treshold)</span> qui supprime de l'index tous les mots qui n'ont pas été recensés au moins treshold fois.</p>\n<p>Vous avez accès aux fonctions de <span class="title-ref">string.h</span> et de <span class="title-ref">stdlib.h</span>.</p>	2019-12-30 17:00:49.299+00	2019-12-30 17:00:49.299+00	0	1	DRAFT	\N	\N
36	Tri par insertion	<p>On désire implémenter un algorithme de tri par insertion sur un tableau de N entiers, le tableau et sa taille étant passés en argument.</p>\n<p>L'algorithme de tri est le suivant : Pour chaque élément d'indice i (i variant de 1 à N-1)</p>\n<ul>\n<li>cet élément devient la clé</li>\n<li>on la compare avec l'élément d'indice i-1</li>\n<li>si la clé est plus petite, on les échange et on recommence la comparaison avec l'élément précédent (d'indice i-2) et ainsi de suite, tant que la clé est plus petite que l'élément qui lui précède (ou qu'on est revenu au début du tableau)</li>\n<li>quand la clé est à sa place (c'est-à-dire qu'elle est plus grande que ou égale à l'élément qui lui précède), la boucle intérieure est finie et on passe à l'élément d'indice i+1.</li>\n</ul>	2019-12-30 17:00:49.3+00	2019-12-30 17:00:49.3+00	0	1	DRAFT	\N	\N
37	Intersection de fichiers	<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<dl>\n<dt>Les pages de manuel sont accessibles depuis les URLs suivants :</dt>\n<dd><ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</li>\n</ul>\n</dd>\n</dl>\n<p><strong>Attention:</strong> veuillez utiliser la version <strong>HTML</strong> du syllabus</p>	2019-12-30 17:00:49.3+00	2019-12-30 17:00:49.3+00	0	1	DRAFT	\N	\N
46	Manipulate the memory	<p>Given the following structure <em>university_t</em>:</p>\n<pre class="c"><code>typedef struct university {\n    char* city;\n    int creation;\n    person_t* rector;\n} university_t;</code></pre>\n<p>And the structure <em>person_t</em>:</p>\n<pre class="c"><code>typedef struct person {\n    char* name;\n    int salary;\n    int age;\n} person_t;</code></pre>\n<p>You are asked to implement the functions <code>init_all</code> and <code>free_all</code>, which respectively initialises the structure <em>universiy_t</em> and frees all the memory associated with it.</p>\n<p>The <em>name</em> and the <em>city</em> have been allocated with <em>malloc</em>.</p>\n<p><em>Hint:</em> all the data may not have been initialised correctly. Therefore, you have to handle all the cases (e.g. some pointers can be already NULL, and don't need to be freed).</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.301+00	0	1	DRAFT	\N	\N
47	Mes propres sémaphores	<p>On souhaite écrire notre propre type de sémaphore à l'aide de mutex. On déclare pour ce faire les 2 structures suivantes :</p>\n<pre class="c"><code>typedef struct semProcess {\n    pthread_mutex_t mutex;\n    struct semProcess *next;\n} sem_process_t;\n\ntypedef struct mySem {\n    int value;\n    int capacity;\n    sem_process_t *blocked_procs;\n    pthread_mutex_t mutex;\n} mysem_t;</code></pre>\n<p>Chaque sémaphore contient une valeur et une liste de processus bloqués. Le mutex de mySem devra être utilisé pour éviter que des appels concurrents des fonctions sousmentionnées sur la même sémaphore ne soient pas exécutés simultanément.</p>\n<p>Écrivez une fonction <span class="title-ref">int mysem_wait(mysem_t *sem)</span> qui bloque le fil d'exécution si <span class="title-ref">value</span> de <span class="title-ref">sem</span> vaut 0 et ajoute le processus à la fin de la liste des processus bloqués. Pour bloquer un processus, vous devrez ajouter un <span class="title-ref">sem_process_t</span> à <span class="title-ref">blocked_procs</span> du sémaphore et verrouiller le mutex de <span class="title-ref">sem_process_t</span>. Si <span class="title-ref">value</span> est plus grand que 0, il est décrémenté.</p>\n<p>Écrivez une fonction <span class="title-ref">int mysem_post(mysem_t *sem)</span> qui incrémente <span class="title-ref">value</span> de <span class="title-ref">sem</span> si aucun autre processus n'est bloqué, et sinon débloque le premier processus de la liste des processus bloqués. <span class="title-ref">value</span> ne peut jamais excéder <span class="title-ref">capacity</span>. <strong>ATTENTION</strong> : Ne libérez pas la structure sem_process_t d'un processus libéré, contentez-vous de supprimer son mutex. Considérez que la fonction <span class="title-ref">mysem_close</span> que vous n'avez pas à implémenter s'occupe de la libération des ressources.</p>	2019-12-30 17:00:49.301+00	2019-12-30 17:00:49.303+00	0	1	DRAFT	\N	\N
48	My strlen - REVIEWED	<p>Your objective is to implement <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/strlen.3.html">strlen</a> one of the basic functions of the C library that deals with strings.</p>	2019-12-30 17:00:49.303+00	2019-12-30 17:00:49.303+00	0	1	DRAFT	\N	\N
49	Ordered  linked list	<p>Given the provided implementation of a linked list, you need to implement the <code>insert</code> function based on a specific order relation. The goal is to implement an ordered list similar to a <span class="title-ref">LinkedList</span> with a <span class="title-ref">Comparator</span> in Java.</p>	2019-12-30 17:00:49.303+00	2019-12-30 17:00:49.303+00	0	1	DRAFT	\N	\N
50	Soumission du projet de seconde session	<p>Cette tâche permet de vérifier la validité de l'archive à soumettre pour le projet de seconde session sur les matrices creuses. Une archive ne passant pas le test ne sera pas corrigée.</p>	2019-12-30 17:00:49.303+00	2019-12-30 17:00:49.303+00	0	1	DRAFT	\N	\N
128	Make Mistake To Understand Them	<p>Although it will seem a bit weird, we will ask you to write code generating Exception. But why? The reason is simple, when you start programming in a new language it sometimes is really hard to understand why your code won't run properly. We made this exercise to help you understand what your mistake can be.</p>\n<p>Before starting this exercise we recommend you to read about <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/NullPointerException.html">NullPointerException</a>, <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/ArrayIndexOutOfBoundsException.html">ArrayIndexOutOfBoundsException</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/ConcurrentModificationException.html">ConcurrentModificationException</a>.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
53	Polynômes	<p>On souhaite gérer des polynômes réels de degré inférieur ou égal à 10 en utilisant la structure suivante :</p>\n<p><span class="title-ref">typedef struct { double coeff[10]; } poly;</span></p>\n<p>qui servira à représenter le polynôme où coeff[0] est le coefficient du terme indépendant, coeff[1] le coefficient du terme en x, etc.</p>\n<p>Écrivez une fonction <span class="title-ref">double eval(poly *P, double x)</span> qui calcule la valeur du polynôme P au point x. On pourra se servir de la formule de Horner : P(x) = ((...(a_9*x + a_8)<em>x + a_7)</em>x + ...)x + a_1)*x + a_0 où a_i est coeff[i].</p>\n<p>Écrivez une fonction <span class="title-ref">void derivee(poly *P, poly *Pderiv)</span> qui inscrit dans <span class="title-ref">Pderiv</span> la dérivée du polynôme P.</p>\n<p>Écrivez une fonction double <span class="title-ref">racine(poly *P, double x0)</span> qui calcule via la méthode de Newton la racine du polynôme P. La méthode est la suivante : on part d'un point initial, et on construit une suite de points qui se rapprochent de la racine en calculant à chaque étape un nouveau point à partir de la valeur du polynôme et de sa dérivée : x_n+1 = x_n - P(x_n)/P'(x_n). La fonction s'arrête lorsque abs(P(x_n)) &lt; 0.0001. On suppose que le calcul converge toujours vers une racine.</p>	2019-12-30 17:00:49.304+00	2019-12-30 17:00:49.304+00	0	1	DRAFT	\N	\N
54	Printing data	<p>In this exercise, you will familiarize yourself with the functions <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/printf.3.html">printf(3)</a> (printing on the standard output) and <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/sprintf.3.html">sprintf(3)</a> (text formatting).</p>	2019-12-30 17:00:49.304+00	2019-12-30 17:00:49.304+00	0	1	DRAFT	\N	\N
55	Modification de fichier	<p>La fonction <code>reverse</code>, dont les spécifications sont reprises ci-dessous, permet de manipuler les données dans un fichier.</p>\n<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a> Les pages de manuel sont accessibles depuis les URLs suivants :</p>\n<ul>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes)</li>\n<li><a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions librairies)</li>\n</ul>	2019-12-30 17:00:49.304+00	2019-12-30 17:00:49.304+00	0	1	DRAFT	\N	\N
56	Calculatrice en notation polonaise inversée	<p>La notation polonaise inversée permet d'écrire de façon non-ambigüe sans parenthèses des formules arithmétiques. Par exemple, le calcul ((1 + 2) × 4) + 3 peut être noté 1 2 + 4 * 3 + en notation polonaise inverse, ou encore 3 4 1 2 + * +. L'avantage de cette notation est qu'elle est très facilement compréhensible par un ordinateur : on imagine une pile où on peut soit ajouter un élément sur la pile, soit retirer le dernier élément ajouté. En parcourant la formule arithmétique, si on rencontre un nombre, on l'ajoute à la pile, si on rencontre une opérande (par ex. le symbole '+'), on retire les 2 derniers éléments de la pile, on en fait la somme et on ajoute le résultat à la pile.</p>\n<p>Pour ce problème, vous ne pourrez utiliser que la variable globale <span class="title-ref">double stack[STACK_SIZE]</span>, représentant la pile, et <span class="title-ref">int stack_height</span>, représentant la hauteur actuelle de la pile, qui seront déjà initialisées à 0 et accessibles par vos fonctions. Vous pouvez supposer que les exemples utilisés par les tests feront en sorte que le nombre d'éléments actuels dans la pile ne dépassera jamais <span class="title-ref">STACK_SIZE</span>.</p>\n<p>Écrivez une fonction void push(double value)` qui permet d'ajouter l'élément value à la pile.</p>\n<p>Écrivez une fonction <span class="title-ref">double pop(void)</span> qui enlève et retourne l'élément au sommet de la pile.</p>\n<p>Écrivez une fonction <span class="title-ref">double rpn(char *expr)</span> qui calcule l'expression en notation polonaise inverse contenue dans expr et retourne le résultat. Vous pouvez supposer que <span class="title-ref">expr</span> contiendra toujours une expression correcte où il ne restera jamais qu'un seul élément sur la pile à la fin de l'exécution. Indice : utilisez la fonction strtok(3) pour séparer les différents éléments de la chaîne et la fonction atof(3) pour convertir l'éventuel nombre rencontré en double. Exemple : "4 2 5 * + 1 3 2 * + /" est censé renvoyer 2. Les opérandes possibles sont + (addition), - (soustraction), * (multiplication) et / (division).</p>	2019-12-30 17:00:49.304+00	2019-12-30 17:00:49.304+00	0	1	DRAFT	\N	\N
57	Redirection des flux de sortie et d'erreur standards	<p>Dans un shell, il est parfois nécessaire d'exécuter des programmes en redirigeant leurs flux standards de sortie et d'erreur vers un fichier.</p>\n<p>Le syllabus est accessible depuis l'URL <a href="http://sites.uclouvain.be/SystInfo">http://sites.uclouvain.be/SystInfo</a></p>\n<p>Les pages de manuel sont accessibles depuis les URLs suivants : - <a href="http://sites.uclouvain.be/SystInfo/manpages/man1">http://sites.uclouvain.be/SystInfo/manpages/man1</a> (commandes) - <a href="http://sites.uclouvain.be/SystInfo/manpages/man2">http://sites.uclouvain.be/SystInfo/manpages/man2</a> (appels systèmes) - <a href="http://sites.uclouvain.be/SystInfo/manpages/man3">http://sites.uclouvain.be/SystInfo/manpages/man3</a> (fonctions des librairies)</p>	2019-12-30 17:00:49.304+00	2019-12-30 17:00:49.305+00	0	1	DRAFT	\N	\N
59	Capture The Flag 2	<p>Téléchargez <a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_ctf2/CTF2.tar.gz">cette archive</a>. Placez son contenu dans un dossier de votre choix, lisez le fichier <code>FirstMission</code> et suivez les consignes.</p>	2019-12-30 17:00:49.305+00	2019-12-30 17:00:49.305+00	0	1	DRAFT	\N	\N
60	Diff	<p>3 students are suspected of doing illegal things with computers of the university. They know that the computers send logs to the server and so hid their activity from the server. But they don't know that logs are also saved on the different computers. There are the logs from the server and from the students, use <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/diff.1.html">diff(1)</a> to compare them and find which students are innocent.</p>\n<ul>\n<li><a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_diff/syslog.log">syslog</a></li>\n<li><a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_diff/student1.log">student 1</a></li>\n<li><a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_diff/student2.log">student 2</a></li>\n<li><a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_diff/student3.log">student 3</a></li>\n</ul>	2019-12-30 17:00:49.305+00	2019-12-30 17:00:49.305+00	0	1	DRAFT	\N	\N
62	Pipes	<p>In this exercise you will learn to use pipes, refer to <a href="https://sites.uclouvain.be/SystInfo/notes/Theorie/html/intro.html#shell">this section</a> for their use.</p>\n<p>Download the following <a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_pipes/input.txt">input</a> from where you want to extract an alphabetically <strong>sorted</strong> list of <strong>unique</strong> hashtags. This can easily be done with pipes. To only select hashtags from the input, you can either use <code>sed '/ [^{#}]/d'</code> or <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/grep.1.html">grep(1)</a>.</p>	2019-12-30 17:00:49.305+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
63	tar	<p>Unix users often need to backup files and directories or send them over the Internet. <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/tar.1.html">tar(1)</a> is a very useful tool which can be used to create compressed archives of directories and all the files that they contain. At the end of a project, you will have created the following files (you can download them from <a href="https://inginious.info.ucl.ac.be/course/LSINF1252/s1_tar/Enonce.zip">here</a>)</p>\n<pre class="console"><code>/\n    file\n    folder1/\n        file1.c\n        file2.c\n        file3.c\n    folder2/\n        file1.h\n        fime2.h\n        file3.h</code></pre>\n<p>Using <a href="https://sites.uclouvain.be/SystInfo/manpages/man1/tar.1.html">tar(1)</a>, create a <code>.tar.gz</code> compressed archive which contains all these files and directories and submit it below.</p>	2019-12-30 17:00:49.306+00	2019-12-30 17:00:49.306+00	0	1	DRAFT	\N	\N
76	Bitwise operation: setting a bit	<p>In this exercise, we will work with operations on bits. When we speak about the position of a bit, index 0 corresponds to lowest order bit, 1 to the second-lowest order bit, ...</p>\n<p>In C source code, you can write a number in binary (base 2) by prefixing it via 0b., e.g. 0b11010 = 26.</p>\n<p>This exercise will introduce some non-standard data types which guarantee that the variable has a fixed number of bits. Indeed, on some machines, a <em>int</em> could use 2, 4 or 8 bytes. Hence, if we want to perform bitwise operations, we have to know first on how many bits we are working.</p>\n<p>For this, C introduces a new class of variable types :</p>\n<ul>\n<li><em>int8_t</em> (signed integer of 8 bits)</li>\n<li><em>uint8_t</em> (unsigned integer of 8 bits)</li>\n<li><em>uint16_t</em> (unsigned integer of 16 bits)</li>\n</ul>\n<p>You can mix <em>uint</em> or <em>int</em> with bit-lengths 8, 16, 32 and 64). These types are defined in &lt;stdint.h&gt;</p>	2019-12-30 17:00:49.307+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
78	Simple stack	<p>You are asked to implement the <code>pop</code> and <code>push</code> functions of the following <a href="https://en.wikipedia.org/wiki/Stack_(abstract_data_type)">stack</a> interface :</p>\n<pre class="c"><code>struct node {\n    node *next;\n    char *name;\n};</code></pre>\n<p><img src="https://upload.wikimedia.org/wikipedia/commons/b/b4/Lifo_stack.png" class="align-right" width="386" height="270" alt="image" /></p>\n<p><em>Hints</em> :</p>\n<ul>\n<li><code>char *name</code> is also a pointer, memory must be allocated by using <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/malloc.3.html">malloc(3)</a> to copy the string on the stack.</li>\n<li>Other useful commands: <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/strncpy.3.html">strncpy(3)</a> and <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/strlen.3.html">strlen(3)</a>.</li>\n<li>Do not forget to free <strong>all</strong> the allocated space when popping one element.</li>\n</ul>	2019-12-30 17:00:49.308+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
79	Sleepy malloc	<p>The <a href="https://sites.uclouvain.be/SystInfo/manpages/man3/malloc.3.html">malloc(3)</a> function may fail, for instance if the OS has no free memory remaining. In this case, it may be possible that some other processes may free some memory after some time.</p>\n<p>In our program, instead of reporting an error immediately if no free memory is available, we will wait some time to see if the OS has freed memory for us.</p>	2019-12-30 17:00:49.308+00	2019-12-30 17:00:49.308+00	0	1	DRAFT	\N	\N
85	Echange de valeurs de fractions	<p>Soit la définition de la structure représentant des fractions entières suivante:</p>\n<pre class="c"><code>struct fract_t {\n        int num;\n        int denum;\n};</code></pre>\n<p>On veut pouvoir swapper (échanger) les valeurs de deux fractions en utilisant la fonction <code>void swap(struct fract_t *a, struct fract_t *b)</code>. Ecrivez le code de cette fonction.</p>	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
87	Through the array	<p>In C, an array is a set of variables sharing the same data type : <code>int array[3] = {42, 1337, 0};</code>.</p>\n<p>An item of an array can be retrieved through its index. For example <code>array[1]</code> gives the second element of the array (here <code>1337</code>).</p>	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
88	Trier une liste chainée	<p>Le but de cet exercice est de trier une liste chaînée. Pour ce faire, on vous laisse le choix de l'algorithme que vous souhaitez implémenter. La seule contrainte est que la liste se décrit comme suit :</p>\n<pre class="c"><code>struct list {\n    struct node* head;\n}\nstruct node {\n    int elem;\n    struct node* next;\n}</code></pre>	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
90	Les types (1/2)	<p>Le type de la plupart des variables en C est facile à déterminer. Néanmoins, le C contient aussi des types qui diffèrent de façons parfois subtiles.</p>	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.309+00	0	1	DRAFT	\N	\N
91	Les types (2/2)	<p>Le type de la plupart des variables en C est facile à déterminer. Néanmoins, le C contient aussi des types qui diffèrent de façons parfois subtiles.</p>	2019-12-30 17:00:49.309+00	2019-12-30 17:00:49.31+00	0	1	DRAFT	\N	\N
94	ASCII Decoder	<p>For this exercise we want you to make a method able to decode a set of ASCII (decimal) codes into a String. Please, read carefully the signature and the comments above the method's signature below :</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ASCIIDecoder/LEPL1402_ASCIIDecoder.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>/*\n* Forbidden characters are passed as an array of int.\n* Each element of this array correspond to the decimal ASCII code\n* of a forbidden character OR null if there&#39;s no forbidden character\n* If you encounter one of these forbidden character\n* you must ignore it when you translate your sentence.\n*\n* the 2D array &quot;sentences&quot; contain a set of decimal ASCII code we want you\n* to translate. Each sub-element of this array is a different sentence.\n* Ex : if we pass this array : { {&quot;42&quot;, &quot;72&quot;, &quot;88&quot;}, {&quot;98&quot;, &quot;99&quot;, &quot;111&quot;, &quot;47&quot;, &quot;55&quot;} }\n* to your decode method, you should return : { &quot;*HX&quot;, &quot;bco/7&quot; }\n*\n* You should NEVER return null or an array containing null\n*/\npublic static String [] decode(int[] forbidden, String[][] sentences){\n    // YOUR CODE HERE\n}</code></pre>\n<p>We also highly suggest you to have a look at the <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuilder.html">StringBuilder</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html">ArrayList</a> APIs. We strongly encourage you to use them for this exercise.</p>	2019-12-30 17:02:49.129+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
95	Abstract Class	<p>In this task, you have to implement the following code represented by this UML diagram :</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/AbstractClass/AbstractClass.jpg" class="align-centeralign-center" alt="" />\n</figure>\n<dl>\n<dt>Before jumping to the code, a few things to keep in mind :</dt>\n<dd><ul>\n<li>Shape and all its methods are abstract (since instantiating a Shape class doesn't make sense )</li>\n<li>Don't forget every needed modifier, keywords, etc (abstract, public, ...) as your classes are stored inside another package that the one for the testing</li>\n<li>No need of instance variables in your code as we pass you the needed parameter to apply your computation</li>\n<li>Use Math.PI in your Circle implementation</li>\n<li>Advanced feedback are available only if your code has complied</li>\n</ul>\n</dd>\n</dl>	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
97	Arrays 2D and Matrix	<p>In order to understand the differences between a matrix and a multidimensional array, you have to implement the functions of the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Array2D/MyBuilder.java">MyBuilder</a> class that implements the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Array2D/Array2DBuilderInterface.java">Array2DBuilderInterface</a>:</p>\n<pre class="java"><code>package src;\n\npublic interface Array2DBuilderInterface {\n// from a String of int, build and return a array of 2D\n// integers are separated by spaces ; lines by the \\n character\n// As array 2d aren&#39;t always regular matrix, you may build a Irregular matrix with the given input\n// Example :\n//      String s = &quot;1 2 3 \\n 4 5 \\n 42 \\n&quot;;\n// Gives :\n//      int[][] array2d = { {1, 2, 3}, {4, 5}, {42} };\n// hint: there is a method in java that removes space at the start and end of a string\npublic int[][] buildFrom(String s);\n\n// Compute the sum of all integers in the 2d array (not necessarily a regular matrix )\npublic int sum(int[][] array);\n\n// return the transpose of the matrix (the given parameter is a regular matrix)\npublic int[][] transpose(int[][] matrix);\n\n// return the product of : matrix1 X matrix2\n// (row1 X column1) X (row2 X column2) (row1 and column2 not necessarily the same but regular matrices)\npublic int[][] product(int[][] matrix1, int[][] matrix2);\n}</code></pre>\n<p>Your job:</p>\n<pre class="java"><code>public class MyBuilder implements Array2DBuilderInterface {\n    public int[][] buildFrom(String s){\n        //TODO\n    }\n    public int sum(int[][] array){\n        //TODO\n    }\n    public int[][] transpose(int[][] matrix){\n        //TODO\n    }\n    public int[][] product(int[][] matrix1, int[][] matrix2){\n        //TODO\n    }\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Array2D/LEPL1402_Array2D.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
98	BlackBox Testing - Binary Search	<p>In this task, you will need to provide a JUnit4 TestSuite for the <strong>static method</strong> <code>binarySearch</code> located in the <strong>class</strong> <code>Exercise</code> :</p>\n<pre class="java"><code>/*\n * This method returns:\n *             index of elem if it is between the &quot;low&quot; and &quot;high&quot; indexes.\n *             -1 if elem is not the there\n *             -2 if the parameters do not respect the preconditions.\n *\n * @pre low &gt;= 0, high &lt; |arr|, low &lt;= high\n * @post returns :\n *            index in which the searched element is located,\n *            -1 if it is not present.\n *            -2 if it does not respect @pre\n */\npublic static int binarySearch(int [] arr, int low, int high, int elem) {\n    ...\n}</code></pre>\n<p>Based on the specifications provided, create test cases for different input and possible outputs. We strongly suggest you to read the <a href="https://junit.org/junit4/javadoc/4.12/org/junit/Assert.html">Junit4</a> asserts documentation. Here is a signature to start your test suite:</p>\n<pre class="java"><code>import org.junit.Test;\nimport static org.junit.Assert.*;\n\npublic class TestSuite{\n\n    @Test\n    public void test(){\n        Exercise.binarySearch(...)\n    }\n\n    // Add more tests here.\n\n}</code></pre>	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
99	Bounded Buffer	<p>A bounded buffer is a way for multiple producers and consumers to synchronised. Indeed multiple producers are going to fill the buffer while consumers are going to clear out this buffer.</p>\n<p>You have to implement the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/BoundedBuffer/BoundedBuffer.java">BoundedBuffer</a>. In a bounded buffer, the element window grows to the right, shrinks to the left and slides t the right on the buffer. Here is a little example about the fonctioning of a bounded buffer :</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LEPL1402/BoundedBuffer/BoundedBuffer.png" class="align-center" width="801" height="461" alt="image" /></p>\n<p>Before submitting don't hesitate to create a producer and a consumer and to test your code.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/BoundedBuffer/LEPL1402_BoundedBuffer.zip">IntelliJ Project</a>:</p>	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
100	Bubble Sort Invariant (MCQ)	<p>In this exercise, the questions will be about the bubble sort algorithm, its complexities and invariant.</p>\n<p>Here its implementation in java:</p>\n<pre class="java"><code>public static void bubbleSort(Comparable[] array){\n    int n = array.length;\n    Comparable temp = 0;\n    for(int i=0; i &lt; n; i++){\n        for(int j=1; j &lt; (n-i); j++){\n            if(array[j-1].compareTo(array[j])&gt;0){\n                //swap elements\n                temp = array[j-1];\n                array[j-1] = array[j];\n                array[j] = temp;\n            }\n        }\n    }\n}</code></pre>	2019-12-30 17:02:49.13+00	2019-12-30 17:02:49.13+00	0	1	DRAFT	\N	\N
102	Circular Linked list	<p>In this task, you have to implement a Circular linked list : a list where the last element points to the first element. In this exercise, the list must maintain a reference to the last of its elements. Each time you want to add an element, you must append it at the end of the list. Removing an element is a bit different: you need to specify an index to choose which element of the list you want to remove (<code>remove(0)</code> for the first ... <code>remove(size()-1)</code> for the last). <strong>Pay attention</strong>: your <code>remove</code> method must throw an <code>IndexOutOfBoundsException</code> if the index parameter is smaller than <code>0</code> or greater than <code>size()-1</code></p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/CircularLL/CircularLinkedList.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>You also need to implement the <code>ListIterator</code> class. <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Iterator.html">Iterator</a> is an interface you have to implement in order to make the class implementing it able to enumerate/browse/iterate over an object : here, we want you to implement a FIFO order iterator over your <code>CircularLinkedList</code>. <strong>Pay attention</strong>:</p>\n<blockquote>\n<ul>\n<li>Your iterator don't have to implement the <code>remove</code> method from <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Iterator.html">Iterator</a>.</li>\n<li>Your iterator must throw a <code>ConcurrentModificationException</code> when you want to get the next element but some other element has been added to the list meanwhile.</li>\n</ul>\n</blockquote>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/CircularLL/LEPL1402_CircularLL.zip">IntelliJ Project</a>:</p>\n<p>Here is the class (downloadable <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/CircularLL/CircularLinkedList.java">here</a>) where we will insert your code :</p>\n<pre class="java"><code>import java.util.ConcurrentModificationException;\nimport java.util.Iterator;\n\n\npublic class CircularLinkedList&lt;Item&gt; implements Iterable&lt;Item&gt; {\n\n    private int n;          // size of the list\n    private Node last;   // trailer of the list\n\n    // helper linked list class\n    private class Node {\n\n        private Item item;\n        private Node next;\n\n        private Node(Item item){\n            this.item = item;\n            this.next = null;\n        }\n\n    }\n\n    public CircularLinkedList() {\n        last = null;\n        n = 0;\n    }\n\n    public boolean isEmpty() {\n        return n == 0;\n    }\n\n    public int size() {\n        return n;\n    }\n\n    public Node getLast(){\n        return last;\n    }\n\n    public Item getItem(Node n){\n        return n.item;\n    }\n\n\n\n    /**\n    * Append an item at the end of the list\n    * @param item the item to append\n    */\n    public void enqueue(Item item) {\n        // YOUR CODE HERE\n    }\n\n    /**\n    * Removes the element at the specified position in this list.\n    * Shifts any subsequent elements to the left (subtracts one from their indices).\n    * Returns the element that was removed from the list.\n    */\n    public Item remove(int index) {\n        // YOUR CODE HERE\n    }\n\n\n    /**\n    * Returns an iterator that iterates through the items in FIFO order.\n    * @return an iterator that iterates through the items in FIFO order.\n    */\n    public Iterator&lt;Item&gt; iterator() {\n        return new ListIterator();\n    }\n\n    /**\n    * Implementation of an iterator that iterates through the items in FIFO order.\n    *\n    */\n    private class ListIterator implements Iterator&lt;Item&gt; {\n        // YOUR CODE HERE\n    }\n\n\n}</code></pre>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
104	Quick Sort - Implem exercise	<p>In order to discover the importance of pre/post conditions and invariants in your programs, we will take the example of QuickSort.</p>\n<p>Quicksort is a divide-and-conquer method for sorting. It works by partitioning an array into two parts, then sorting the parts independently. It takes the first element of the Array, then it determines its position in the array by iterating through it. If an element is lower, it moves the element to its left and increment its own position. Then it recursivly do the same operation for each sub array (left and right of the pivot).</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/CodeAccuracy2/quicksort-overview.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>The crux of the method is the partitioning process , which can be summarized as follows :</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/CodeAccuracy2/partitioning-overview.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>Even with this simple algorithm, mistakes can occur and that is why we ask you to complete the implementation contained in this <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/CodeAccuracy2/QuickSort.java">file</a> , without forgetting to add assert statements in each method (as they will be tested separately in INGINIOUS).</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/CodeAccuracy2/LEPL1402_CodeAccuracy2.zip">IntelliJ Project</a>.</p>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
106	Comparator and Collections	<p>In this task, the challenge is to sort a custom class <strong>Person</strong> described as :</p>\n<pre class="java"><code>public class Person {\n\n    public String name;\n    public int age;\n\n    public Person(String name, int age) {\n        this.name = name;\n        this.age = age;\n    }\n\n    @Override\n    public String toString() {\n        return name + &quot; &quot; + age;\n    }\n}</code></pre>\n<p>Your task is to implement the function <code>public static void sortPerson(ArrayList&lt;Person&gt; persons)</code> that should sort an ArrayList of Persons as follows :</p>\n<ul>\n<li>sort in the lexicographical order of their name</li>\n<li>If two persons have the same name, they should be classified according to their age (ascending order).</li>\n</ul>\n<p>In order to succeed this task (whose solution is contained on 8 lines), we invite you to discover the following JavaDoc resource : <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html">Collections</a> (method sort)</p>\n<p>Given this example :</p>\n<pre class="java"><code>public class Main\n\n  public static void main(String[] args) {\n    ArrayList&lt;Person&gt; persons = new ArrayList&lt;&gt;();\n    persons.add(new Person(&quot;Guillaume&quot;,20));\n    persons.add(new Person(&quot;John&quot;,50));\n    persons.add(new Person(&quot;Guillaume&quot;,10));\n    persons.add(new Person(&quot;John&quot;,10));\n    persons.add(new Person(&quot;Luc&quot;,5));\n\n    sortPerson(persons);\n    System.out.println(persons);\n\n  }\n}</code></pre>\n<p>You should get this on the output :</p>\n<pre class="java"><code>[Guillaume 10, Guillaume 20, John 10, John 20, Luc 5]</code></pre>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
107	Comparator vs Comparable	<p>In this exercise, you have to answer questions about <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Comparator.html">Comparator</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/Comparable.html">Comparable</a>.</p>\n<p>We are going to work on the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ComparatorvsComparable/Plant.java">Plant</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ComparatorvsComparable/Tree.java">Tree</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ComparatorvsComparable/Flower.java">Flower</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ComparatorvsComparable/Sorter.java">Sorter</a> classes. Read and understand the code in this classes before doing this is exercise!</p>\n<p>All the information on how the different method should work are given in comments in each class.</p>\n<div class="warning">\n<div class="title">\n<p>Warning</p>\n</div>\n<p>In the code, when we write "in that order", we mean that you must first sort in function of the first criterion, and in case of equality, sort in function of the second, and so on.</p>\n</div>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/ComparatorvsComparable/LEPL1402_ComparatorvsComparable.zip">IntelliJ Project</a>.</p>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
111	Coverage Testing	<p>In this task, you should provide a TestSuite for coverage check of the following class :</p>\n<pre class="java"><code>public class BigDecimal {\n    /*\n     * parse exponent\n     */\n    public static long parseExp(char[] in, int offset, int len){\n        long exp = 0;\n        offset++;\n        char c = in[offset];\n        len--;\n        boolean negexp = (c == &#39;-&#39;);\n        // optional sign\n        if (negexp || c == &#39;+&#39;) {\n            offset++;\n            c = in[offset];\n            len--;\n        }\n        if (len &lt;= 0) // no exponent digits\n            throw new NumberFormatException();\n        // skip leading zeros in the exponent\n        while (len &gt; 10 &amp;&amp; (c==&#39;0&#39; || (Character.digit(c, 10) == 0))) {\n            offset++;\n            c = in[offset];\n            len--;\n        }\n        if (len &gt; 10) // too many nonzero exponent digits\n            throw new NumberFormatException();\n        // c now holds first digit of exponent\n        for (;; len--) {\n            int v;\n            if (c &gt;= &#39;0&#39; &amp;&amp; c &lt;= &#39;9&#39;) {\n                v = c - &#39;0&#39;;\n            } else {\n                v = Character.digit(c, 10);\n                if (v &lt; 0) // not a digit\n                    throw new NumberFormatException();\n            }\n            exp = exp * 10 + v;\n            if (len == 1)\n                break; // that was final character\n            offset++;\n            c = in[offset];\n        }\n        if (negexp) // apply sign\n            exp = -exp;\n        return exp;\n    }\n}</code></pre>\n<p>In order to succeed this task, you must cover all the different execution cases. To grade your tests, we use the tool <code>Jacoco</code>, it checks wether you navigate among the entire code that was given. First understand what this code does, then you should write tests that will navigate through each condition, loop etc.</p>\n<p>Take a look at this <a href="https://www.eclemma.org/jacoco/trunk/doc/counters.html">link</a> to understand the feedback you'll be given.</p>\n<p>To start your test suite :</p>\n<pre class="java"><code>import org.junit.Test;\nimport static org.junit.Assert.*;\n\npublic class TestSuite{\n\n    @Test\n    public void test(){\n         // parameters for parseExp\n         char[] in = new char[]{/*Some chars here*/};\n         // also possible to use .toCharArray from String class for that :\n         // char[] in = myString.toCharArray();\n         int offset = /*Some value HERE*/;\n         int len = /*Some value HERE*/;\n         // run the program with the given situation\n         BigDecimal.parseExp(in, offset, len);\n    }\n\n    // Add more tests here.\n\n}</code></pre>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.131+00	0	1	DRAFT	\N	\N
112	Cyclic Barrier	<p>A Cyclic barrier in concurrent programming is a synchronization construct that helps you synchronize threads every once in a while. The idea is simple, after a thread finished executing a certain amount of operation, it waits until the barrier thread recover the result to restart. Note that the barrier recover this result when every thread is waiting, it thus recover all the results and then the threads can restart their computing before stopping at the next checkpoint.</p>\n<p>In this exercise we ask you to compute the highest sum in a set of array. Imagine that you have a large set of 2D-arrays stored as one 3D-array. We ask you to use a fixed amount of threads, and a small buffer. Each thread is going to compute the sum of the values in a 2D-array and store this sum in the shared buffer. Once every thread has finished computing the sum of his array, the barrier recovers the maximum. When you don't need to compute sums the threads stop and the barrier returns the final result (the index of the maximal sum).</p>\n<p>We give you the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/CyclicBarrier/MaxFinder.java">MaxFinder</a> that you must complete, read the code carefully before you start writing any line of code.</p>\n<p>You should also read the class <a href="https://docs.oracle.com/javase/8/docs/api/index.html?java/util/concurrent/CyclicBarrier.html">CyclicBarrier</a> in the java api.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/CyclicBarrier/LEPL1402_CyclicBarrier.zip">IntelliJ Project</a>.</p>	2019-12-30 17:02:49.131+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
113	Functional list implementation	<p>Functional <a href="https://en.wikipedia.org/wiki/Functional_programming">programming</a> is an increasingly important programming paradigm. In this paradigm, data structures are <a href="https://en.wikipedia.org/wiki/Purely_functional_data_structure">immutable</a>. You are asked to implement an immutable list called FList that can be used in functionnal programming.</p>\n<p>You should first make sure that you understood the code that is given to you and what is asked to you before trying any implementation.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FList/LEPL1402_FList.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<p>Here is the API of an <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FList/FList.java">FList</a> and the FList <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FList/FListClass.java">class</a> you have to implement:</p>\n<pre class="java"><code>public abstract class FList&lt;A&gt; implements Iterable&lt;A&gt; {\n\n    // creates an empty list\n    public static &lt;A&gt; FList&lt;A&gt; nil();\n\n    // prepend a to the list and return the new list\n    public final FList&lt;A&gt; cons(final A a);\n\n    public final boolean isNotEmpty();\n\n    public final boolean isEmpty();\n\n    public final int length();\n\n    // return the head element of the list\n    public abstract A head();\n\n    // return the tail of the list\n    public abstract FList&lt;A&gt; tail();\n\n    // return a list on which each element has been applied function f\n    public final &lt;B&gt; FList&lt;B&gt; map(Function&lt;A,B&gt; f);\n\n    // return a list on which only the elements that satisfies predicate are kept\n    public final FList&lt;A&gt; filter(Predicate&lt;A&gt; f);\n\n    // return an iterator on the element of the list\n    public Iterator&lt;A&gt; iterator();\n\n}</code></pre>\n<p>Here is an example of how we could test your code:</p>\n<pre class="java"><code>FList&lt;Integer&gt; list = FList.nil();\n\nfor (int i = 0; i &lt; 10; i++) {\n    list = list.cons(i);\n}\n\nlist = list.map(i -&gt; i+1);\n// will print 1,2,...,11\nfor (Integer i: list) {\n    System.out.println(i);\n}\n\nlist = list.filter(i -&gt; i%2 == 0);\n// will print 2,4,6,...,10\nfor (Integer i: list) {\n    System.out.println(i);\n}</code></pre>\n<p>Since you know how your code should work, we <strong>strongly</strong> recommend you to test it on your computer before trying any submission. The iterator is the most critical part, if it doesn't work, most of the test will not work.</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
114	FList MergeSort	<p>To complete this task you must implement a mergesort for FList using only FList. Arrays, ArrayList, etc. are prohibited for this exercise.</p>\n<p>Here is the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FListMergeSort/FList.java">FList</a> you will be using. Try first to implement the FList by yourself in this <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FList">exercise</a> before starting this one.</p>\n<p>And here is the method you must implement: note that you have to implement merge recursivly and you are allowed to create other methods.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FListMergeSort/LEPL1402_FListMergeSort.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>public class FListMerge {\n\n\n    /*\n    * This method receives an FList and returns the FList containing the same values but sorted with the smallest value to the highest one.\n    *\n    */\n    public static FList&lt;Integer&gt; mergeSort(FList&lt;Integer&gt; fList){\n        //TODO By Student\n    }\n\n    //TO Complete if needed\n}</code></pre>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
115	Functional immutable tree	<p>In this exercise you have to complete the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/FTree.java">FTree</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/Node.java">Node</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/Leaf.java">Leaf</a>. <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/FTree.java">Ftree</a> is an abstract class that represents a binary true, it is extended by Node and Leaf. A <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/Node.java">Node</a> is a <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/FTree.java">FTree</a> with two children (left and right) and a value. A <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/Leaf.java">Leaf</a> is terminal, so it has a value but no children.</p>\n<dl>\n<dt>In the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/FTree.java">FTree</a> class you must <em>recursivly</em> implement:</dt>\n<dd><ul>\n<li>depth : returns the depth of the tree (we assume that the tree is balanced)</li>\n<li>map : receives a function as argument and apply it to all the values contained in the tree</li>\n</ul>\n</dd>\n<dt>To complete the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/Node.java">Node</a> class you must:</dt>\n<dd><ul>\n<li>implement the constructor</li>\n<li>extend <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/FTree.java">FTree</a></li>\n</ul>\n</dd>\n<dt>To complete the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/Leaf.java">Leaf</a> class you must :</dt>\n<dd><ul>\n<li>implement the constructor</li>\n<li>extend <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/FTree.java">FTree</a></li>\n</ul>\n</dd>\n</dl>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/FTree/LEPL1402_FTree.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
116	Factory design pattern - Level generator	<p>In this task, we will ask you to implement a labyrinth mini-game level builder using The factory design pattern. Each level consists in a set of <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/Wall.java">Wall</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/Key.java">Key</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/Floor.java">Floor</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/Door.java">Door</a>, all of them implementing the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/LevelComponent.java">LevelComponent</a> interface. Your objective is thus to implement the two following classes:</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/LEPL1402_Factory.zip">IntelliJ Project</a>.</p>\n<pre class="java"><code>public class ElementFactory extends Factory {\n\n    // YOUR CODE HERE\n\n    public static ElementFactory getInstance() {\n        // YOUR SINGLETON HERE\n    }\n\n}\n\n\npublic class Level extends AbstractLevel {\n\n    public Level(String input){\n        // YOUR CODE HERE\n    }\n\n    /* Example of level building with this String : String s = &quot;#-K\\n-D-\\n#-K\\n&quot;\n     * Gives : LevelComponent[][] componentsObjects = {\n     *                                        {new Wall(), new Floor(), new Key()},\n     *                                        {new Floor(), new Door(), new Floor()},\n     *                                        {new Wall(), new Floor(), new Key()}}\n     */\n\n\n    // YOUR CODE HERE\n}</code></pre>\n<p>Note that these two classes extends the abstract classes <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/Factory.java">Factory</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Factory/AbstractLevel.java">AbstractLevel</a>. Pay attention, we add a small constraint to this exercise: your ElementFactory <strong>must</strong> be a singleton (i.e, it should not be possible to instantiate your factory with java's <code>new</code> keyword). For your <code>Level</code> class, what we want you to do is, given a String, create a <code>Level</code> object whose <code>components</code> is a 2D array where each cell represent a <code>LevelComponent</code> and whose <code>size</code> is the total number of components in the level. Note that all sub-arrays in <code>components</code> will have the same size as we will only ask you to create "square" labyrinths. If a character does not correspond to one of the component, your code should throw an <code>IllegalArgumentException</code>.</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
117	Introduction to recursion in Java - Fibonacci	<p>In this task, we will ask you to implement two different versions of the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Fibonacci/Fibonacci.java">Fibonacci</a> sequence number: a recursive one and an iterative one. The objective of this exercise is to make you aware of what a call stack is and what problem could occur. We strongly suggest you to test your code with various input : what will happen if you test your recursive implementation with a very large index. Why ? Will the same thing happen with your iterative implementation ? Why ?</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Fibonacci/LEPL1402_Fibonacci.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>public class Fibonacci {\n\n    /*\n     * Returns the index-th element of the fibonnaci sequence, computed recursively\n     */\n    public static int fiboRecursive(int index){\n        // YOUR CODE HERE\n    }\n\n    /*\n     * Returns the index-th element of the fibonnaci sequence, computed iteratively\n     */\n    public static int fiboIterative(int index){\n        // YOUR CODE HERE\n    }\n\n}</code></pre>\n<p>Reminder : Fibonacci's sequence is computed as follows</p>\n<p><br /><span class="math display">$$\\begin{aligned}\nf(n) =\\begin{cases}0 &amp; n=0 \\\\1 &amp; n = 1\\\\ f(n-1) + f(n-2) &amp; n &gt; 1\\end{cases}\n\\end{aligned}$$</span><br /></p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
118	Future	<p>For this task you will learn use <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Future.html">Future</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ExecutorService.html">ExecutorService</a> in order to load a web page with images asynchronously. Indeed html is lightweight compared to the images so we want the images to be downloaded asynchronously while the html is displayed without the images.</p>\n<p>In this task we give you the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Future/WebPage.java">WebPage</a> class to complete and three other class to use : <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Future/URL.java">URL</a>, <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Future/Image.java">Image</a> and <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Future/HTML.java">HTML</a>.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Future/LEPL1402_Future.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<pre class="java"><code>import java.util.ArrayList;\nimport java.util.List;\nimport java.util.concurrent.ExecutionException;\nimport java.util.concurrent.ExecutorService;\nimport java.util.concurrent.Executors;\nimport java.util.concurrent.Future;\n\npublic class WebPage {\n\n    private ExecutorService executor;\n    private HTML html;\n\n    /*\n     * Bound executor to a fixed thread pool size\n     */\n    public WebPage(int threadNumber, HTML html){\n        //TODO\n    }\n\n    /*\n     * submit the download of the image specified by the url\n     * to be executed by thread pool\n     */\n    public Future&lt;Image&gt; loadImage(URL url){\n        //TODO\n    }\n\n    /*\n     * Download the image specified by the url\n     */\n    public Image downloadImageFromURL(URL url){\n        //HIDDEN\n    }\n\n    /*\n     * Load all images of the page\n     */\n    public List&lt;Future&lt;Image&gt;&gt; loadImages(List&lt;URL&gt; urls){\n        //TODO\n    }\n\n    /*\n     * Load the page while images are being downloaded\n     */\n    private void displayPageWithoutImage(){\n        //HIDDEN\n    }\n\n    /*\n     * Display all images on the page\n     */\n    private void displayImages(List&lt;Image&gt; images){\n        //HIDDEN\n    }\n\n    /*\n     * load the page\n     */\n    public void loadPage(){\n        // First the image are downloaded asynchronously\n        List&lt;Future&lt;Image&gt;&gt; futures = loadImages(this.html.getUrls());\n        // While the image are being downloaded, we display the page without them\n        displayPageWithoutImage();\n        // Then we need all images to display them\n        List&lt;Image&gt; images = new ArrayList&lt;Image&gt;(futures.size());\n        try{\n            for(Future&lt;Image&gt; future : futures){\n                // the &quot;get()&quot; function is waiting for the result of the future task (here download the images)\n                images.add(future.get());\n            }\n        } catch(InterruptedException e){\n\n        } catch (ExecutionException e){\n\n        }\n        // we can display now images on the page\n        displayImages(images);\n        // shut down the executor service now\n        executor.shutdown();\n\n    }\n\n}</code></pre>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
119	Map, Filter, Cons	<p>In this task, you have to implement the map / filter functions of the following class :</p>\n<pre class="java"><code>public class Cons {\n    // the item inside this list node\n    public int v;\n    // The next element, null if nothing\n    public Cons next;\n    // creates a new Cons that applies function f on all elements\n    public Cons map(F f) {\n        // TODO by student\n    }\n    // creates a new Cons with all elements that matches predicate p\n    public Cons filter(P p) {\n        // TODO by student\n    }\n    // Constructor\n    public Cons(int v, Cons next) {\n        this.v = v;\n        this.next = next;\n    }\n}</code></pre>\n<p>Here are the interfaces for the object parameter for filter/map</p>\n<pre class="java"><code>interface F {\n    int apply(int v);\n}\n\ninterface P {\n    boolean filter(int v);\n}</code></pre>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics/LEPL1402_Generics.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<p>( You can find all the required files here : <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics/Cons.java">Cons</a> , <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics/F.java">Function</a> , <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics/P.java">Predicate</a> )</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
120	Map, Filter, Cons with Generics	<p>In this task, you have to implement the generic map / filter functions of the following class :</p>\n<pre class="java"><code>import java.util.function.Predicate;\nimport java.util.function.Function;\n\npublic class Cons &lt; E &gt; {\n    // the item inside this list node\n    public E v;\n    // The next element, null if nothing\n    public Cons&lt;E&gt; next;\n    // creates a new Cons that applies function f on all elements\n    public &lt;R&gt; Cons &lt;R&gt; map(Function &lt;E,R&gt; function) {\n        // TODO by student\n    }\n    // creates a new Cons with all elements that matches predicate p\n    public Cons &lt;E&gt; filter(Predicate &lt;E&gt; predicate) {\n        // TODO by student\n    }\n    // Constructor\n    public Cons(E v, Cons &lt; E &gt; next) {\n        this.v = v;\n        this.next = next;\n    }\n}</code></pre>\n<p>To help you understand how Predicate and Function works, check the <a href="https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html">documentation</a>. You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics2/LEPL1402_Generics2.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<p>(You can find here all documents : <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics2/Cons.java">Cons</a>)</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
121	Logical Circuit Functional	<p>In this task, you have to implement the solver of this well-known logic circuit :</p>\n<figure>\n<img src="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics3/full-adder-circuit.png" class="align-centeralign-center" alt="" />\n</figure>\n<p>Instead of directly using a chain of logical operators ( that can lead you to a error prone code sometimes), we will be using <a href="https://docs.oracle.com/javase/8/docs/api/java/util/function/BiFunction.html">BiFunction</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html">Function</a> to implement the logic gates. Your task is thus to implement the following class : <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics3/Evaluator.java">Evaluator</a> . You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/Generics3/LEPL1402_Generics3.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
122	Hanoi Tower	<p>The tower of Hanoi is a mathematical puzzle, it consists of three rods and a number of disk of different size which can slide onto any rod. The game starts with all the disks in an ascending order forming a stack on the first rod. The objective of this puzzle is to move the entire stack to another rod. We know, it sounds easy, but there are 3 simple rules that make the game harder than you think.</p>\n<dl>\n<dt>Here they are :</dt>\n<dd><ul>\n<li>You can only move one disk at a time.</li>\n<li>Each move consists of taking the upper disk from one stack and moving it to another stack or on an empty rod.</li>\n<li>No larger disk may be placed on top of a smaller disk.</li>\n</ul>\n</dd>\n</dl>\n<p>To help you a little bit, here is an example of how you can solve the problem with a stack of size 3.</p>\n<p><img src="https://inginious.info.ucl.ac.be/course/LEPL1402/HanoiTower/tower-of-hanoi.png" class="align-center" width="684" height="384" alt="image" /></p>\n<p>In this exercise, you are asked to solve this puzzle for any size of stack by implementing this method and this method only! We are using <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Stack.html">Stack</a>, to get the first element of a stack, use the method <code>pop</code>, and to add an element use the method <code>push</code>. The object <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/HanoiTower/Disk.java">Disk</a> is here to make sure you will not solve the exercise by just creating another stack.</p>\n<p>Here is the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/HanoiTower/TowerOfHanoi.java">TowerOfHanoi</a> you must implement, you can create disk by yourself to test your method but it will not compile on Inginious if you try to do it.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/HanoiTower/LEPL1402_HanoiTower.zip">IntelliJ Project</a> that contains few tests to help you.</p>\n<p><strong>hint:</strong> you can call <code>towerOfHanoi</code> inside itself</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.132+00	0	1	DRAFT	\N	\N
123	Infinite Streams	<p>The <a href="https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html">Stream</a> interface of java allows to create infinite streams. In order to understand how it works, we will create our own infinite streams.</p>\n<p>For this task we give you an incomplete interface named <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/IStream.java">IStream</a> that represents an infinite stream. You first have to complete the three default methods of this interface. Since IStream is an interface, you have to complete the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/Cons.java">Cons</a> that implements <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/IStream.java">IStream</a>.</p>\n<p>Since an infinite stream is not always usefull, we give you the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/Empty.java">Empty</a> that implements <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/IStream.java">IStream</a> and marks the end of a stream.</p>\n<p>Finally you will use all of it to create different finite and infinite streams in the class <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/PlayWithStreams.java">PlayWithStreams</a>.</p>\n<p>There may seem like a lot to do, but most functions can be implemented in one line.</p>\n<p>Note that you will need to use the <a href="https://docs.oracle.com/javase/8/docs/api/java/util/function/Supplier.html">Supplier</a> object in order to make the creation of your stream (so the tail of a Cons) lazy.</p>\n<p>You can download the <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/InfiniteStreams/LEPL1402_InfiniteStreams.zip">IntelliJ Project</a> that contains few tests to help you.</p>	2019-12-30 17:02:49.132+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
126	Lambda Expression in Java	<p>In this exercise you will learn to use basic lambda expression. Since you are going to use them later, they are worth a small introduction exercise.</p>\n<p>Since we work with lambda, we have decided to block the <code>return</code> statement.</p>\n<p>Here you can find the java documentation about <a href="https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html">Function</a>, <a href="https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html">Predicate</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/Comparator.html">Comparator</a>.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
127	Learn Exception in Java	<p>In this task we ask you to implement method throwing and catching exceptions. In Java, Exceptions are handled using <code>try</code> and <code>catch</code> statement like the example below</p>\n<pre class="java"><code>try{\n    String s = methodThatCanThrowException();\n}catch(ExceptionCaught e){\n    //Do something\n}\n\n//Continue</code></pre>\n<p>When a method can throw an exception, it has to be specified in the signature like the example below:</p>\n<pre class="java"><code>public static double divide(int i1, int i2) throws ArithmeticException</code></pre>\n<p>It means that it is possible that the method uses a statement like this:</p>\n<pre class="java"><code>throw new ArithmeticException();</code></pre>\n<p>Download <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/LearnException/Divider.java">Divider</a> and read the comment to know what you have to do. Download <a href="https://inginious.info.ucl.ac.be/course/LEPL1402/LearnException/LEPL1402_LearnException.zip">intellij project</a> with tests.</p>	2019-12-30 17:02:49.133+00	2019-12-30 17:02:49.133+00	0	1	DRAFT	\N	\N
\.


--
-- Data for Name: Exercises_Metrics; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Exercises_Metrics" (id, vote_count, avg_vote_score, tags_ids, exercise_id) FROM stdin;
92	0	0.00	{1,7,50,51,52,53,54,55,56,57}	92
93	0	0.00	{1,7,50,51,52,53,54,55,56,57}	93
7	0	0.00	{1,2,3,4,7,8,13,15}	7
8	0	0.00	{1,2,3,4,12,7,8,13,14}	8
10	0	0.00	{1,2,3,4,5,6,7,8,9}	10
11	0	0.00	{1,2,3,4,12,7,8,13,15}	11
13	0	0.00	{1,2,3,4,12,7,8,13,15}	13
14	0	0.00	{1,2,3,4,12,7,8,13,15}	14
15	0	0.00	{1,2,3,4,12,7,8,13,14}	15
16	0	0.00	{1,2,3,4,12,7,8,13,14}	16
17	0	0.00	{1,2,3,4,5,6,7,8,22,10}	17
18	0	0.00	{1,2,3,4,23,7,8,24}	18
19	0	0.00	{1,2,3,4,23,7,8,24}	19
20	0	0.00	{1,2,3,4,23,7,8,24}	20
21	0	0.00	{1,2,3,4,23,7,8,24}	21
22	0	0.00	{1,2,3,4,23,7,8,24}	22
23	0	0.00	{1,2,3,4,25,7,8,26}	23
24	0	0.00	{1,2,3,4,25,7,8,26}	24
25	0	0.00	{1,2,3,4,25,7,8,26}	25
26	0	0.00	{1,2,3,4,25,7,8,10}	26
27	0	0.00	{1,2,3,4,25,5,7,8,9}	27
94	0	0.00	{1,7,50,51,52,54,55,58}	94
95	0	0.00	{1,7,50,51,52,53,54,55,59}	95
96	0	0.00	{1,35,50,51,52,53,54,58}	96
97	0	0.00	{1,7,50,51,52,53,54,55,58}	97
98	0	0.00	{1,7,50,51,52,53,54,55,56}	98
99	0	0.00	{1,7,50,51,52,55,60,61,62}	99
100	0	0.00	{1,35,50,51,52,60,61,63}	100
101	0	0.00	{1,35,50,51,52,53,54,58}	101
102	0	0.00	{1,7,50,51,52,53,54,55,63}	102
103	0	0.00	{1,35,50,51,52,53,54,63}	103
104	0	0.00	{1,7,50,51,52,53,54,55,63}	104
105	0	0.00	{1,35,50,51,52,53,54,58}	105
106	0	0.00	{1,7,50,51,52,55,58,64}	106
107	0	0.00	{1,7,50,51,52,55,59,60,61,65}	107
3	1	3.00	{1,2,3,4,12,7,8,13,14}	3
1	1	3.00	{1,2,3,4,5,6,7,8,9,10}	1
4	1	4.00	{1,2,3,4,7,8,13,14}	4
2	2	4.50	{1,2,3,4,11,7,8}	2
5	1	2.00	{1,2,3,4,12,7,8}	5
6	1	4.00	{1,2,3,4,12,7,8,13,14}	6
9	1	4.00	{1,2,3,4,7,8,16}	9
12	0	0.00	{1,2,3,4,17,7,8,18,20,21}	12
28	0	0.00	{1,2,3,4,27,28,7,8,10}	28
30	0	0.00	{1,2,3,4,30,31}	30
31	0	0.00	{1,2,3,4,25,7,8,16}	31
32	0	0.00	{1,2,3,4,12,7,8,13,15}	32
33	0	0.00	{1,2,3,4,25,7,8,26}	33
34	0	0.00	{1,2,3,4,25,7,8,26}	34
35	0	0.00	{1,2,3,4,25,7,8,26}	35
36	0	0.00	{1,2,3,4,25,7,8,26}	36
37	0	0.00	{1,2,3,4,12,7,8,13,14}	37
38	0	0.00	{1,2,3,4,32,7,8}	38
39	0	0.00	{1,2,3,4,32,7,8}	39
40	0	0.00	{1,2,3,4,25,6,7,8,9}	40
41	0	0.00	{1,2,3,4,23,7,8,24}	41
42	0	0.00	{1,2,3,4,32,7,8}	42
43	0	0.00	{1,2,3,4,25,7,8,26}	43
44	0	0.00	{1,2,3,4,25,7,8,20,24}	44
45	0	0.00	{1,2,3,4,25,5,7,8,20,10}	45
46	0	0.00	{1,2,3,4,17,11,7,8,10}	46
47	0	0.00	{1,2,3,4,25,7,8,26}	47
48	0	0.00	{1,2,3,4,6,7,8,24}	48
49	0	0.00	{1,2,3,4,5,6,7,8,9}	49
50	0	0.00	{1,2,3,4,31}	50
51	0	0.00	{1,2,3,4,23,7,8,24}	51
52	0	0.00	{1,2,3,4,5,7,8,10}	52
53	0	0.00	{1,2,3,4,25,7,8,26}	53
54	0	0.00	{1,2,3,4,25,7,8,31,24}	54
55	0	0.00	{1,2,3,4,12,7,8,13,15}	55
56	0	0.00	{1,2,3,4,25,7,8,26}	56
57	0	0.00	{1,2,3,4,7,8,13,15}	57
58	0	0.00	{1,2,3,4,33,31,34,16}	58
59	0	0.00	{1,2,3,4,33,31,16}	59
60	0	0.00	{1,2,3,4,33,35,34,16}	60
61	0	0.00	{1,2,3,4,33,31,16}	61
62	0	0.00	{1,2,3,4,33,31,34,16}	62
63	0	0.00	{1,2,3,4,33,31,34,16}	63
67	0	0.00	{1,2,3,4,31,39,10,9}	67
75	0	0.00	{1,2,3,4,40,7,8,41,42}	75
76	0	0.00	{1,2,3,4,23,7,8,24}	76
78	0	0.00	{1,2,3,4,5,6,7,8,9}	78
79	0	0.00	{1,2,3,4,25,5,7,8,10}	79
80	0	0.00	{1,2,3,4,45,31}	80
81	0	0.00	{1,2,3,4,6,25,7,8,31,20,10}	81
82	0	0.00	{1,2,3,4,25,7,8,24}	82
83	0	0.00	{1,2,3,4,6,7,8,22,10}	83
84	0	0.00	{1,2,3,4,12,7,8,13,14}	84
85	0	0.00	{1,2,3,4,28,46,7,8,24}	85
86	0	0.00	{1,2,3,4,23,7,8,20,24}	86
87	0	0.00	{1,2,3,4,40,7,8,16}	87
88	0	0.00	{1,2,3,4,47,48,7,8,49}	88
89	0	0.00	{1,2,3,4,7,8,26}	89
90	0	0.00	{1,2,3,4,32,7,8,10}	90
91	0	0.00	{1,2,3,4,32,7,8,10}	91
108	0	0.00	{1,7,50,51,52,55,60,61,63}	108
109	0	0.00	{1,35,50,51,52,60,61,63}	109
110	0	0.00	{1,35,50,51,52,60,61,63}	110
111	0	0.00	{1,7,50,51,52,53,54,55,56}	111
112	0	0.00	{1,7,50,51,52,55,60,61,62}	112
113	0	0.00	{1,7,50,51,52,55,60,61,66}	113
114	0	0.00	{1,7,50,51,52,55,60,61,66}	114
115	0	0.00	{1,7,50,51,52,55,60,61,66}	115
116	0	0.00	{1,7,50,51,52,53,54,55,56}	116
117	0	0.00	{1,7,50,51,52,53,54,55,63}	117
118	0	0.00	{1,7,50,51,52,55,62,67,68}	118
119	0	0.00	{1,7,50,51,52,53,54,55,66}	119
120	0	0.00	{1,7,50,51,52,53,54,55,66}	120
121	0	0.00	{1,7,50,51,52,53,54,55,66}	121
122	0	0.00	{1,7,50,51,52,55,60,61,63}	122
123	0	0.00	{1,7,50,51,52,55,66,67,68}	123
124	0	0.00	{1,7,50,51,52,53,54,55,59}	124
29	0	0.00	{1,2,3,4,17,7,8,24}	29
64	0	0.00	{1,2,3,4,36,7,37,31,24,9}	64
65	0	0.00	{1,2,3,4,36,7,37,24,9}	65
71	0	0.00	{1,2,3,4,40,7,8,18,41,42}	71
73	0	0.00	{1,2,3,4,40,7,8,18,42}	73
74	0	0.00	{1,2,3,4,40,7,8,18,43,42}	74
125	0	0.00	{1,7,50,51,52,55,58,60,61}	125
126	0	0.00	{1,7,50,51,52,55,60,61,66}	126
127	0	0.00	{1,7,50,51,52,55,58,60,61}	127
128	0	0.00	{1,7,50,51,52,55,58,60,61}	128
129	0	0.00	{1,7,50,51,52,55,60,61,63}	129
130	0	0.00	{1,7,50,51,52,55,63}	130
131	0	0.00	{1,7,50,51,52,53,54,55,63}	131
132	0	0.00	{1,7,50,51,52,53,54,55,56}	132
133	0	0.00	{1,7,50,51,52,55,66,67,68}	133
134	0	0.00	{1,7,50,51,52,55,60,61,62}	134
135	0	0.00	{1,7,50,51,52,53,54,55,59}	135
136	0	0.00	{1,7,50,51,52,53,54,55,62}	136
137	0	0.00	{1,7,50,51,52,53,54,55,63}	137
138	0	0.00	{1,7,50,51,52,53,54,55,62}	138
139	0	0.00	{1,7,50,51,52,55,58,61}	139
140	0	0.00	{1,35,50,51,52,58,61}	140
141	0	0.00	{1,7,50,51,52,53,54,55,63}	141
142	0	0.00	{1,7,50,51,52,53,54,55,66}	142
143	0	0.00	{1,7,50,51,52,53,54,55,66}	143
144	0	0.00	{1,7,50,51,52,53,54,55,58}	144
145	0	0.00	{1,7,50,51,52,53,54,55,62}	145
146	0	0.00	{1,7,50,51,52,53,54,55,59}	146
148	0	0.00	{1,7,50,51,52,53,54,55,59}	148
149	0	0.00	{1,35,50,51,52,58,60,61}	149
150	0	0.00	{1,7,50,51,52,53,54,55,56}	150
151	0	0.00	{1,7,50,51,52,53,54,55,56}	151
152	0	0.00	{1,35,50,51,52,59,60,61}	152
153	0	0.00	{1,7,50,51,52,55,60,61,63}	153
147	1	5.00	{1,7,50,51,52,53,54,55,59}	147
154	0	0.00	{1,69,51,70,71,7,55,13}	154
155	0	0.00	{1,69,51,70,72,73,71,7,55}	155
156	0	0.00	{1,69,51,70,71,7,55}	156
159	0	0.00	{1,69,51,70,75,71,31}	159
160	0	0.00	{1,69,51,70,73,31}	160
161	0	0.00	{1,69,51,70,7,55,31}	161
162	0	0.00	{1,69,51,70,76,71,7,55}	162
163	0	0.00	{1,69,51,70,76,71,7,55,31}	163
164	0	0.00	{1,69,51,70,76,7,55}	164
165	0	0.00	{1,69,51,70,75,7,55}	165
167	0	0.00	{1,69,51,70,7,55,31}	167
168	0	0.00	{1,69,51,70,76,7,55}	168
171	0	0.00	{1,69,51,70,7,55}	171
172	0	0.00	{1,69,51,70,7,55,31}	172
173	0	0.00	{1,69,51,70,75,31}	173
174	0	0.00	{1,69,51,70,7,55}	174
175	0	0.00	{1,69,51,70,75,31}	175
176	0	0.00	{1,69,51,70,75,71,7,55}	176
179	0	0.00	{1,69,51,70,76,7,55}	179
180	0	0.00	{1,69,51,70,71,7,55}	180
181	0	0.00	{1,69,51,70,71,7,55,31}	181
182	0	0.00	{1,69,51,70,71,7,55}	182
183	0	0.00	{1,69,51,70,77,35}	183
184	0	0.00	{1,69,51,70,76,7,55,80}	184
185	0	0.00	{1,69,51,70,76,7,55,31,81}	185
186	0	0.00	{1,69,51,70,76,7,55,82}	186
187	0	0.00	{1,69,51,70,7,55,83}	187
188	0	0.00	{1,69,51,70,79,7,55,31,84}	188
189	0	0.00	{1,69,51,70,7,55,85}	189
190	0	0.00	{1,69,51,70,7,55,31,84}	190
191	0	0.00	{1,69,51,70,7,55,31,83}	191
192	0	0.00	{1,69,51,70,86,75,7,55}	192
193	0	0.00	{1,69,51,70,86,75,31}	193
195	0	0.00	{1,69,51,70,76,7,55,87}	195
196	0	0.00	{1,69,51,70,76,7,55}	196
197	0	0.00	{1,69,51,70,88,31}	197
198	0	0.00	{1,69,51,70,75,7,55,84}	198
199	0	0.00	{1,69,51,70,78,76,35,13}	199
201	0	0.00	{1,69,51,70,75,31,83}	201
203	0	0.00	{1,69,51,70,75,31,81}	203
205	0	0.00	{1,69,51,70,75,31,83}	205
202	1	4.00	{1,69,51,70,75,7,55,87}	202
200	2	4.50	{1,69,51,70,7,55,84}	200
177	1	4.00	{1,69,51,70,79,71,7,55,31}	177
178	1	5.00	{1,69,51,70,71,7,55}	178
207	0	0.00	{1,69,51,70,72,7,55,81}	207
209	0	0.00	{1,89,90,91,31}	209
210	0	0.00	{1,89,90,91,31}	210
213	0	0.00	{1,89,90,91,31}	213
211	1	4.00	{1,89,90,91,31}	211
206	1	5.00	{1,69,51,70,78,35,82}	206
214	1	4.00	{53,114,120}	214
212	1	4.00	{1,89,90,91,31}	212
66	0	0.00	{1,2,3,4,36,35,24,9}	66
68	0	0.00	{1,2,3,4,36,31,10,9}	68
69	0	0.00	{1,2,3,4,35,10,9}	69
70	0	0.00	{1,2,3,4,36,7,37,10,9}	70
72	0	0.00	{1,2,3,4,40,7,8,18,41,42}	72
\.


--
-- Data for Name: Exercises_Tags; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Exercises_Tags" (exercise_id, tag_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
1	7
1	8
1	9
1	10
2	1
2	2
2	3
2	4
2	11
2	7
2	8
3	1
3	2
3	3
3	4
3	12
3	7
3	8
3	13
3	14
4	1
4	2
4	3
4	4
4	7
4	8
4	13
4	14
5	1
5	2
5	3
5	4
5	12
5	7
5	8
6	1
6	2
6	3
6	4
6	12
6	7
6	8
6	13
6	14
7	1
7	2
7	3
7	4
7	7
7	8
7	13
7	15
8	1
8	2
8	3
8	4
8	12
8	7
8	8
8	13
8	14
9	1
9	2
9	3
9	4
9	7
9	8
9	16
10	1
10	2
10	3
10	4
10	5
10	6
10	7
10	8
10	9
11	1
11	2
11	3
11	4
11	12
11	7
11	8
11	13
11	15
12	1
12	2
12	3
12	4
12	17
12	7
12	8
12	18
12	20
12	21
13	1
13	2
13	3
13	4
13	12
13	7
13	8
13	13
13	15
14	1
14	2
14	3
14	4
14	12
14	7
14	8
14	13
14	15
15	1
15	2
15	3
15	4
15	12
15	7
15	8
15	13
15	14
16	1
16	2
16	3
16	4
16	12
16	7
16	8
16	13
16	14
17	1
17	2
17	3
17	4
17	5
17	6
17	7
17	8
17	22
17	10
18	1
18	2
18	3
18	4
18	23
18	7
18	8
18	24
19	1
19	2
19	3
19	4
19	23
19	7
19	8
19	24
20	1
20	2
20	3
20	4
20	23
20	7
20	8
20	24
21	1
21	2
21	3
21	4
21	23
21	7
21	8
21	24
22	1
22	2
22	3
22	4
22	23
22	7
22	8
22	24
23	1
23	2
23	3
23	4
23	25
23	7
23	8
23	26
24	1
24	2
24	3
24	4
24	25
24	7
24	8
24	26
25	1
25	2
25	3
25	4
25	25
25	7
25	8
25	26
26	1
26	2
26	3
26	4
26	25
26	7
26	8
26	10
27	1
27	2
27	3
27	4
27	25
27	5
27	7
27	8
27	9
28	1
28	2
28	3
28	4
28	27
28	28
28	7
28	8
28	10
29	1
29	2
29	3
29	4
29	17
29	7
29	8
29	24
30	1
30	2
30	3
30	4
30	30
30	31
31	1
31	2
31	3
31	4
31	25
31	7
31	8
31	16
32	1
32	2
32	3
32	4
32	12
32	7
32	8
32	13
32	15
33	1
33	2
33	3
33	4
33	25
33	7
33	8
33	26
34	1
34	2
34	3
34	4
34	25
34	7
34	8
34	26
35	1
35	2
35	3
35	4
35	25
35	7
35	8
35	26
36	1
36	2
36	3
36	4
36	25
36	7
36	8
36	26
37	1
37	2
37	3
37	4
37	12
37	7
37	8
37	13
37	14
38	1
38	2
38	3
38	4
38	32
38	7
38	8
39	1
39	2
39	3
39	4
39	32
39	7
39	8
40	1
40	2
40	3
40	4
40	25
40	6
40	7
40	8
40	9
41	1
41	2
41	3
41	4
41	23
41	7
41	8
41	24
42	1
42	2
42	3
42	4
42	32
42	7
42	8
43	1
43	2
43	3
43	4
43	25
43	7
43	8
43	26
44	1
44	2
44	3
44	4
44	25
44	7
44	8
44	20
44	24
45	1
45	2
45	3
45	4
45	25
45	5
45	7
45	8
45	20
45	10
46	1
46	2
46	3
46	4
46	17
46	11
46	7
46	8
46	10
47	1
47	2
47	3
47	4
47	25
47	7
47	8
47	26
48	1
48	2
48	3
48	4
48	6
48	7
48	8
48	24
49	1
49	2
49	3
49	4
49	5
49	6
49	7
49	8
49	9
50	1
50	2
50	3
50	4
50	31
51	1
51	2
51	3
51	4
51	23
51	7
51	8
51	24
52	1
52	2
52	3
52	4
52	5
52	7
52	8
52	10
53	1
53	2
53	3
53	4
53	25
53	7
53	8
53	26
54	1
54	2
54	3
54	4
54	25
54	7
54	8
54	31
54	24
55	1
55	2
55	3
55	4
55	12
55	7
55	8
55	13
55	15
56	1
56	2
56	3
56	4
56	25
56	7
56	8
56	26
57	1
57	2
57	3
57	4
57	7
57	8
57	13
57	15
58	1
58	2
58	3
58	4
58	33
58	31
58	34
58	16
59	1
59	2
59	3
59	4
59	33
59	31
59	16
60	1
60	2
60	3
60	4
60	33
60	35
60	34
60	16
61	1
61	2
61	3
61	4
61	33
61	31
61	16
62	1
62	2
62	3
62	4
62	33
62	31
62	34
62	16
63	1
63	2
63	3
63	4
63	33
63	31
63	34
63	16
64	1
64	2
64	3
64	4
64	36
64	7
64	37
64	31
64	24
64	9
65	1
65	2
65	3
65	4
65	36
65	7
65	37
65	24
65	9
66	1
66	2
66	3
66	4
66	36
66	35
66	24
66	9
67	1
67	2
67	3
67	4
67	31
67	39
67	10
67	9
68	1
68	2
68	3
68	4
68	36
68	31
68	10
68	9
69	1
69	2
69	3
69	4
69	35
69	10
69	9
70	1
70	2
70	3
70	4
70	36
70	7
70	37
70	10
70	9
71	1
71	2
71	3
71	4
71	40
71	7
71	8
71	18
71	41
71	42
72	1
72	2
72	3
72	4
72	40
72	7
72	8
72	18
72	41
72	42
73	1
73	2
73	3
73	4
73	40
73	7
73	8
73	18
73	42
74	1
74	2
74	3
74	4
74	40
74	7
74	8
74	18
74	43
74	42
75	1
75	2
75	3
75	4
75	40
75	7
75	8
75	41
75	42
76	1
76	2
76	3
76	4
76	23
76	7
76	8
76	24
78	1
78	2
78	3
78	4
78	5
78	6
78	7
78	8
78	9
79	1
79	2
79	3
79	4
79	25
79	5
79	7
79	8
79	10
80	1
80	2
80	3
80	4
80	45
80	31
81	1
81	2
81	3
81	4
81	6
81	25
81	7
81	8
81	31
81	20
81	10
82	1
82	2
82	3
82	4
82	25
82	7
82	8
82	24
83	1
83	2
83	3
83	4
83	6
83	7
83	8
83	22
83	10
84	1
84	2
84	3
84	4
84	12
84	7
84	8
84	13
84	14
85	1
85	2
85	3
85	4
85	28
85	46
85	7
85	8
85	24
86	1
86	2
86	3
86	4
86	23
86	7
86	8
86	20
86	24
87	1
87	2
87	3
87	4
87	40
87	7
87	8
87	16
88	1
88	2
88	3
88	4
88	47
88	48
88	7
88	8
88	49
89	1
89	2
89	3
89	4
89	7
89	8
89	26
90	1
90	2
90	3
90	4
90	32
90	7
90	8
90	10
91	1
91	2
91	3
91	4
91	32
91	7
91	8
91	10
92	1
92	50
92	51
92	52
92	53
92	54
92	7
92	55
92	56
92	57
93	1
93	50
93	51
93	52
93	53
93	54
93	7
93	55
93	56
93	57
94	1
94	50
94	51
94	52
94	54
94	7
94	55
94	58
95	1
95	50
95	51
95	52
95	53
95	54
95	7
95	55
95	59
96	1
96	50
96	51
96	52
96	53
96	54
96	35
96	58
97	1
97	50
97	51
97	52
97	53
97	54
97	7
97	55
97	58
98	1
98	50
98	51
98	52
98	53
98	54
98	7
98	55
98	56
99	1
99	50
99	51
99	52
99	60
99	61
99	7
99	55
99	62
100	1
100	50
100	51
100	52
100	60
100	61
100	35
100	63
101	1
101	50
101	51
101	52
101	53
101	54
101	35
101	58
102	1
102	50
102	51
102	52
102	53
102	54
102	7
102	55
102	63
103	1
103	50
103	51
103	52
103	53
103	54
103	35
103	63
104	1
104	50
104	51
104	52
104	53
104	54
104	7
104	55
104	63
105	1
105	50
105	51
105	52
105	53
105	54
105	35
105	58
106	1
106	50
106	51
106	52
106	64
106	7
106	55
106	58
107	1
107	50
107	51
107	52
107	60
107	61
107	7
107	55
107	59
107	65
108	1
108	50
108	51
108	52
108	60
108	61
108	7
108	55
108	63
109	1
109	50
109	51
109	52
109	60
109	61
109	35
109	63
110	1
110	50
110	51
110	52
110	60
110	61
110	35
110	63
111	1
111	50
111	51
111	52
111	53
111	54
111	7
111	55
111	56
112	1
112	50
112	51
112	52
112	60
112	61
112	7
112	55
112	62
113	1
113	50
113	51
113	52
113	60
113	61
113	7
113	55
113	66
114	1
114	50
114	51
114	52
114	60
114	61
114	7
114	55
114	66
115	1
115	50
115	51
115	52
115	60
115	61
115	7
115	55
115	66
116	1
116	50
116	51
116	52
116	53
116	54
116	7
116	55
116	56
117	1
117	50
117	51
117	52
117	53
117	54
117	7
117	55
117	63
118	1
118	50
118	51
118	52
118	67
118	68
118	7
118	55
118	62
119	1
119	50
119	51
119	52
119	53
119	54
119	7
119	55
119	66
120	1
120	50
120	51
120	52
120	53
120	54
120	7
120	55
120	66
121	1
121	50
121	51
121	52
121	53
121	54
121	7
121	55
121	66
122	1
122	50
122	51
122	52
122	60
122	61
122	7
122	55
122	63
123	1
123	50
123	51
123	52
123	67
123	68
123	7
123	55
123	66
124	1
124	50
124	51
124	52
124	53
124	54
124	7
124	55
124	59
125	1
125	50
125	51
125	52
125	60
125	61
125	7
125	55
125	58
126	1
126	50
126	51
126	52
126	60
126	61
126	7
126	55
126	66
127	1
127	50
127	51
127	52
127	60
127	61
127	7
127	55
127	58
128	1
128	50
128	51
128	52
128	60
128	61
128	7
128	55
128	58
129	1
129	50
129	51
129	52
129	60
129	61
129	7
129	55
129	63
130	1
130	50
130	51
130	52
130	7
130	55
130	63
131	1
131	50
131	51
131	52
131	53
131	54
131	7
131	55
131	63
132	1
132	50
132	51
132	52
132	53
132	54
132	7
132	55
132	56
133	1
133	50
133	51
133	52
133	67
133	68
133	7
133	55
133	66
134	1
134	50
134	51
134	52
134	60
134	61
134	7
134	55
134	62
135	1
135	50
135	51
135	52
135	53
135	54
135	7
135	55
135	59
136	1
136	50
136	51
136	52
136	53
136	54
136	7
136	55
136	62
137	1
137	50
137	51
137	52
137	53
137	54
137	7
137	55
137	63
138	1
138	50
138	51
138	52
138	53
138	54
138	7
138	55
138	62
139	1
139	50
139	51
139	52
139	61
139	7
139	55
139	58
140	1
140	50
140	51
140	52
140	61
140	35
140	58
141	1
141	50
141	51
141	52
141	53
141	54
141	7
141	55
141	63
142	1
142	50
142	51
142	52
142	53
142	54
142	7
142	55
142	66
143	1
143	50
143	51
143	52
143	53
143	54
143	7
143	55
143	66
144	1
144	50
144	51
144	52
144	53
144	54
144	7
144	55
144	58
145	1
145	50
145	51
145	52
145	53
145	54
145	7
145	55
145	62
146	1
146	50
146	51
146	52
146	53
146	54
146	7
146	55
146	59
147	1
147	50
147	51
147	52
147	53
147	54
147	7
147	55
147	59
148	1
148	50
148	51
148	52
148	53
148	54
148	7
148	55
148	59
149	1
149	50
149	51
149	52
149	60
149	61
149	35
149	58
150	1
150	50
150	51
150	52
150	53
150	54
150	7
150	55
150	56
151	1
151	50
151	51
151	52
151	53
151	54
151	7
151	55
151	56
152	1
152	50
152	51
152	52
152	60
152	61
152	35
152	59
153	1
153	50
153	51
153	52
153	60
153	61
153	7
153	55
153	63
154	1
154	69
154	51
154	70
154	71
154	7
154	55
154	13
155	1
155	69
155	51
155	70
155	72
155	73
155	71
155	7
155	55
156	1
156	69
156	51
156	70
156	71
156	7
156	55
159	1
159	69
159	51
159	70
159	75
159	71
159	31
160	1
160	69
160	51
160	70
160	73
160	31
161	1
161	69
161	51
161	70
161	7
161	55
161	31
162	1
162	69
162	51
162	70
162	76
162	71
162	7
162	55
163	1
163	69
163	51
163	70
163	76
163	71
163	7
163	55
163	31
164	1
164	69
164	51
164	70
164	76
164	7
164	55
165	1
165	69
165	51
165	70
165	75
165	7
165	55
167	1
167	69
167	51
167	70
167	7
167	55
167	31
168	1
168	69
168	51
168	70
168	76
168	7
168	55
171	1
171	69
171	51
171	70
171	7
171	55
172	1
172	69
172	51
172	70
172	7
172	55
172	31
173	1
173	69
173	51
173	70
173	75
173	31
174	1
174	69
174	51
174	70
174	7
174	55
175	1
175	69
175	51
175	70
175	75
175	31
176	1
176	69
176	51
176	70
176	75
176	71
176	7
176	55
177	1
177	69
177	51
177	70
177	79
177	71
177	7
177	55
177	31
178	1
178	69
178	51
178	70
178	71
178	7
178	55
179	1
179	69
179	51
179	70
179	76
179	7
179	55
180	1
180	69
180	51
180	70
180	71
180	7
180	55
181	1
181	69
181	51
181	70
181	71
181	7
181	55
181	31
182	1
182	69
182	51
182	70
182	71
182	7
182	55
183	1
183	69
183	51
183	70
183	77
183	35
184	1
184	69
184	51
184	70
184	76
184	7
184	55
184	80
185	1
185	69
185	51
185	70
185	76
185	7
185	55
185	31
185	81
186	1
186	69
186	51
186	70
186	76
186	7
186	55
186	82
187	1
187	69
187	51
187	70
187	7
187	55
187	83
188	1
188	69
188	51
188	70
188	79
188	7
188	55
188	31
188	84
189	1
189	69
189	51
189	70
189	7
189	55
189	85
190	1
190	69
190	51
190	70
190	7
190	55
190	31
190	84
191	1
191	69
191	51
191	70
191	7
191	55
191	31
191	83
192	1
192	69
192	51
192	70
192	86
192	75
192	7
192	55
193	1
193	69
193	51
193	70
193	86
193	75
193	31
195	1
195	69
195	51
195	70
195	76
195	7
195	55
195	87
196	1
196	69
196	51
196	70
196	76
196	7
196	55
197	1
197	69
197	51
197	70
197	88
197	31
198	1
198	69
198	51
198	70
198	75
198	7
198	55
198	84
199	1
199	69
199	51
199	70
199	78
199	76
199	35
199	13
200	1
200	69
200	51
200	70
200	7
200	55
200	84
201	1
201	69
201	51
201	70
201	75
201	31
201	83
202	1
202	69
202	51
202	70
202	75
202	7
202	55
202	87
203	1
203	69
203	51
203	70
203	75
203	31
203	81
205	1
205	69
205	51
205	70
205	75
205	31
205	83
206	1
206	69
206	51
206	70
206	78
206	35
206	82
207	1
207	69
207	51
207	70
207	72
207	7
207	55
207	81
209	1
209	89
209	90
209	91
209	31
210	1
210	89
210	90
210	91
210	31
211	1
211	89
211	90
211	91
211	31
212	1
212	89
212	90
212	91
212	31
213	1
213	89
213	90
213	91
213	31
214	53
214	114
214	120
\.


--
-- Data for Name: Notations; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Notations" (id, note, exercise_id, user_id) FROM stdin;
2	5.00	2	2
3	3.00	3	2
1	3.00	1	2
4	4.00	214	2
5	4.00	4	2
6	4.00	2	1
7	2.00	5	2
8	4.00	6	1
9	4.00	9	1
10	5.00	200	1
11	4.00	202	1
12	4.00	200	2
13	4.00	211	2
15	5.00	206	1
16	5.00	147	1
17	4.00	212	2
18	4.00	177	2
19	5.00	178	2
\.


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."SequelizeMeta" (name) FROM stdin;
20191024150545-default_migration.js
20191202130021-addTitleInConfiguration.js
20191204204139-addPropertiesInExercise.js
20191227002857-replaceIsValidatedByStatusInExercise.js
20200116145402-addNewEnumValues.js
20200226152253-replaceIsValidatedByState.js
20200307114926-addMaterializedViewForTagsSummary.js
\.


--
-- Data for Name: Tag_Categories; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Tag_Categories" (id, kind) FROM stdin;
5	langage
6	auteur
2	cours
7	Misconception
3	type d'exercice
9	Mots clés
1	plateforme
10	licence
14	niveau
15	learning time
17	public ciblé
16	difficulté
4	source
8	thématique
\.


--
-- Data for Name: Tags; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Tags" (id, text, "createdAt", "updatedAt", version, category_id, state) FROM stdin;
31	match	2019-12-30 17:00:49.203+00	2020-03-01 16:59:13.184+00	4	3	DEPRECATED
21	Beta, S5	2019-12-30 17:00:49.203+00	2019-12-30 17:00:49.203+00	0	9	NOT_VALIDATED
125	Scala	2020-03-04 11:48:58.716+00	2020-03-04 11:48:58.716+00	0	5	VALIDATED
127	SQL	2020-03-04 11:50:18.759+00	2020-03-04 11:50:18.759+00	0	5	VALIDATED
26	Beta	2019-12-30 17:00:49.203+00	2019-12-30 17:00:49.203+00	0	9	NOT_VALIDATED
129	PHP	2020-03-04 11:50:44.74+00	2020-03-04 11:50:44.74+00	0	5	VALIDATED
132	Go	2020-03-04 11:51:30.549+00	2020-03-04 11:51:30.549+00	0	5	VALIDATED
85	midterm	2019-12-30 17:05:18.931+00	2020-03-04 12:03:02.693+00	1	3	VALIDATED
134	listes chaînées	2020-03-04 12:07:50.427+00	2020-03-04 12:07:50.427+00	0	8	VALIDATED
136	non spécifié	2020-03-04 12:09:49.534+00	2020-03-04 12:09:49.534+00	0	5	VALIDATED
20	pointeurs	2019-12-30 17:00:49.203+00	2020-03-04 12:10:28.097+00	1	8	VALIDATED
41	fichiers	2019-12-30 17:00:49.203+00	2020-03-04 12:11:52.447+00	1	8	VALIDATED
42	S5	2019-12-30 17:00:49.203+00	2020-03-04 12:12:52.625+00	1	9	VALIDATED
24	S2	2019-12-30 17:00:49.203+00	2020-03-04 12:12:52.627+00	1	9	VALIDATED
10	S3	2019-12-30 17:00:49.203+00	2020-03-04 12:12:52.628+00	1	9	VALIDATED
16	S1	2019-12-30 17:00:49.203+00	2020-03-04 12:12:52.632+00	1	9	VALIDATED
9	S4	2019-12-30 17:00:49.203+00	2020-03-04 12:12:52.632+00	1	9	VALIDATED
56	Module 4	2019-12-30 17:02:49.099+00	2020-03-04 12:13:43.915+00	1	9	VALIDATED
49	StudentJob	2019-12-30 17:00:49.203+00	2019-12-30 17:00:49.203+00	0	9	NOT_VALIDATED
34	CLI	2019-12-30 17:00:49.203+00	2020-03-04 12:16:40.495+00	1	8	VALIDATED
22	malloc	2019-12-30 17:00:49.203+00	2020-03-04 12:17:43.659+00	1	8	VALIDATED
138	expert	2020-03-04 12:21:49.691+00	2020-03-04 12:21:49.691+00	0	16	VALIDATED
57	Example	2019-12-30 17:02:49.099+00	2019-12-30 17:02:49.099+00	0	9	NOT_VALIDATED
43	permission	2019-12-30 17:00:49.203+00	2020-03-04 13:01:29.589+00	1	8	VALIDATED
39	CUnit	2019-12-30 17:00:49.203+00	2020-03-04 13:02:14.849+00	1	8	VALIDATED
18	Close	2019-12-30 17:00:49.203+00	2020-02-04 13:21:55.77+00	2	9	NOT_VALIDATED
90	Algorithmes et recettes de cuisine	2019-12-30 17:05:33.846+00	2020-01-18 15:04:38.312+00	1	2	VALIDATED
1	INGINIOUS	2019-12-30 17:00:49.203+00	2020-01-18 15:36:49.055+00	9	1	VALIDATED
4	[LSINF1252] Systèmes informatiques	2019-12-30 17:00:49.203+00	2020-01-18 15:05:33.415+00	1	2	VALIDATED
70	[LSINF1121] Algorithmique et structures de données	2019-12-30 17:05:18.931+00	2020-01-18 15:05:33.418+00	1	2	VALIDATED
52	[LEPL1402] Informatique 2	2019-12-30 17:02:49.099+00	2020-01-18 15:14:53.002+00	1	2	VALIDATED
93	Google	2019-12-31 12:19:09.863+00	2020-01-31 13:53:59.392+00	9	1	VALIDATED
7	code	2019-12-30 17:00:49.203+00	2020-02-04 13:10:31.592+00	1	3	VALIDATED
63	Module 2	2019-12-30 17:02:49.099+00	2020-02-04 13:14:27.7+00	1	9	VALIDATED
35	QCM	2019-12-30 17:00:49.203+00	2020-02-04 13:09:52.277+00	1	3	VALIDATED
13	examen	2019-12-30 17:00:49.203+00	2020-02-04 13:10:11.635+00	1	3	VALIDATED
89	https://github.com/lin3out/cuisine-algorithmique	2019-12-30 17:05:33.846+00	2020-02-04 13:10:50.541+00	1	4	VALIDATED
50	https://github.com/UCL-INGI/LEPL1402	2019-12-30 17:02:49.099+00	2020-02-04 13:10:50.543+00	1	4	VALIDATED
69	https://github.com/UCL-INGI/LSINF1121-Data-Structures-And-Algorithms	2019-12-30 17:05:18.931+00	2020-02-04 13:10:50.545+00	1	4	VALIDATED
2	https://github.com/UCL-INGI/LSINF1252	2019-12-30 17:00:49.203+00	2020-02-04 13:10:50.547+00	1	4	VALIDATED
95	C++	2020-01-15 13:17:47.449+00	2020-02-04 13:11:18.541+00	1	5	VALIDATED
112	Python	2020-02-04 13:08:09.159+00	2020-02-04 13:11:18.545+00	1	5	VALIDATED
37	makefile	2019-12-30 17:00:49.203+00	2020-02-04 13:11:18.562+00	1	5	VALIDATED
91	Charline Outters	2019-12-30 17:05:33.846+00	2020-02-04 13:12:10.318+00	1	6	VALIDATED
113	Alexandre Dewit	2020-02-04 13:08:09.159+00	2020-02-04 13:12:10.318+00	1	6	VALIDATED
88	Kaczynski Frédéric	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.323+00	1	6	VALIDATED
79	psc	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.324+00	1	6	VALIDATED
78	Xavier Gillard	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.355+00	1	6	VALIDATED
75	Frédéric Kaczynski	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.357+00	1	6	VALIDATED
77	xgillard	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.357+00	1	6	VALIDATED
76	Pierre Schaus	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.357+00	1	6	VALIDATED
74	Antoine Cailliau	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.377+00	1	6	VALIDATED
73	Simon Teugels	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.378+00	1	6	VALIDATED
72	Guillaume Derval	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.38+00	1	6	VALIDATED
71	John Aoga	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.38+00	1	6	VALIDATED
68	Piron H.	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.398+00	1	6	VALIDATED
67	Bastin J.	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.4+00	1	6	VALIDATED
64	Jacques Yakoub	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.4+00	1	6	VALIDATED
61	Piron H	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.4+00	1	6	VALIDATED
60	Bastin J	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.417+00	1	6	VALIDATED
54	Rucquoy A	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.422+00	1	6	VALIDATED
48	Aurélie Massart	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.423+00	1	6	VALIDATED
53	Yakoub J	2019-12-30 17:02:49.099+00	2020-02-04 13:12:10.424+00	1	6	VALIDATED
47	Cécile Hautecoeur	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.431+00	1	6	VALIDATED
46	Christoph Paasch	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.446+00	1	6	VALIDATED
45	Quentin De Coninck	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.448+00	1	6	VALIDATED
40	Olivier Martin	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.449+00	1	6	VALIDATED
36	Pablo Gonzalez Alvarez	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.451+00	1	6	VALIDATED
33	Tom Rousseaux	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.469+00	1	6	VALIDATED
32	Kilian Verhetsel	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.469+00	1	6	VALIDATED
30	David Lebrun	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.472+00	1	6	VALIDATED
28	Fabien Duchêne	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.472+00	1	6	VALIDATED
27	Gregory Detal	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.49+00	1	6	VALIDATED
23	Arthur van Stratum	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.492+00	1	6	VALIDATED
25	Mathieu Xhonneux	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.492+00	1	6	VALIDATED
17	Louis Navarre	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.492+00	1	6	VALIDATED
12	Olivier Bonaventure	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.505+00	1	6	VALIDATED
11	Alexandre Gobeaux	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.517+00	1	6	VALIDATED
5	Maxime Mawait	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.518+00	1	6	VALIDATED
6	Nicolas Rybowski	2019-12-30 17:00:49.203+00	2020-02-04 13:12:10.519+00	1	6	VALIDATED
86	Simon Hardy	2019-12-30 17:05:18.931+00	2020-02-04 13:12:10.523+00	1	6	VALIDATED
51	CC-BY-NC-SA-4.0	2019-12-30 17:02:49.099+00	2020-02-04 13:13:52.017+00	1	10	VALIDATED
66	Module 5	2019-12-30 17:02:49.099+00	2020-02-04 13:14:27.702+00	1	9	VALIDATED
80	Mission 1	2019-12-30 17:05:18.931+00	2020-02-04 13:14:27.702+00	1	9	VALIDATED
81	Mission 3	2019-12-30 17:05:18.931+00	2020-02-04 13:14:27.72+00	1	9	VALIDATED
82	Mission 4	2019-12-30 17:05:18.931+00	2020-02-04 13:14:27.721+00	1	9	VALIDATED
83	Mission 5	2019-12-30 17:05:18.931+00	2020-02-04 13:14:27.721+00	1	9	VALIDATED
84	Mission 6	2019-12-30 17:05:18.931+00	2020-02-04 13:14:27.721+00	1	9	VALIDATED
87	Mission 2	2019-12-30 17:05:18.931+00	2020-02-04 13:14:27.738+00	1	9	VALIDATED
15	Juin 2016	2019-12-30 17:00:49.203+00	2020-02-04 13:14:27.74+00	1	9	VALIDATED
58	Module 1	2019-12-30 17:02:49.099+00	2020-02-04 13:14:27.74+00	1	9	VALIDATED
14	Septembre 2016	2019-12-30 17:00:49.203+00	2020-02-04 13:14:27.74+00	1	9	VALIDATED
59	Module 3	2019-12-30 17:02:49.099+00	2020-02-04 13:14:27.753+00	1	9	VALIDATED
62	Module 6	2019-12-30 17:02:49.099+00	2020-02-04 13:14:27.754+00	1	9	VALIDATED
117	bachelier	2020-02-08 17:35:31.317+00	2020-02-08 17:35:31.317+00	0	14	VALIDATED
118	master	2020-02-08 17:35:39.746+00	2020-02-08 17:35:39.746+00	0	14	VALIDATED
119	secondaire	2020-02-08 17:35:48.303+00	2020-02-08 17:35:48.303+00	0	14	VALIDATED
124	Erlang	2020-03-03 16:54:16.708+00	2020-03-03 16:54:44.562+00	1	5	VALIDATED
8	C	2019-12-30 17:00:49.203+00	2020-03-04 11:46:41.433+00	2	5	VALIDATED
120	Javascript	2020-02-08 17:37:11.039+00	2020-03-04 11:48:16.785+00	2	5	VALIDATED
55	Java	2019-12-30 17:02:49.099+00	2020-03-04 11:48:27.72+00	2	5	VALIDATED
126	Ruby	2020-03-04 11:49:27.499+00	2020-03-04 11:49:27.499+00	0	5	VALIDATED
128	HTML/CSS	2020-03-04 11:50:29.644+00	2020-03-04 11:50:29.644+00	0	5	VALIDATED
130	TypeScript	2020-03-04 11:51:15.026+00	2020-03-04 11:51:15.026+00	0	5	VALIDATED
131	R	2020-03-04 11:51:18.399+00	2020-03-04 11:51:18.399+00	0	5	VALIDATED
133	didacticiel	2020-03-04 12:06:12.706+00	2020-03-04 12:06:12.706+00	0	3	VALIDATED
135	algorithme	2020-03-04 12:08:02.456+00	2020-03-04 12:08:02.456+00	0	8	VALIDATED
65	Module 3	2019-12-30 17:02:49.099+00	2020-03-04 12:13:26.608+00	2	9	VALIDATED
137	primaire	2020-03-04 12:18:56.76+00	2020-03-04 12:18:56.76+00	0	14	VALIDATED
3	GPL 3.0+	2019-12-30 17:00:49.203+00	2020-03-04 13:07:37.74+00	2	10	VALIDATED
115	intermédiaire	2020-02-08 17:35:03.337+00	2020-03-04 12:22:13.6+00	2	16	VALIDATED
114	novice	2020-02-08 17:34:56.222+00	2020-03-04 12:22:33.537+00	2	16	VALIDATED
116	avancé	2020-02-08 17:35:14.378+00	2020-03-04 12:23:01.236+00	2	16	VALIDATED
177	domaine public	2020-03-04 13:03:59.251+00	2020-03-04 13:03:59.251+00	0	10	VALIDATED
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: exercises_library; Owner: -
--

COPY exercises_library."Users" (id, email, password, "fullName", role) FROM stdin;
1	yolo24@uclouvain.be	$2b$10$CxoeRF8aM1J42U4LR/r2huHOBApKbVIbcV3MCisHdjHwN2PnBtQtO	Eric Cartman	super_admin
2	test@sourcecode.be	$2b$10$HIYVXLqqfey/gwF9zLxzxuhmCAANPArDRHMhRGqTF76c0ee481UqS	Alexandre D.	admin
\.


--
-- Name: Configurations_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Configurations_id_seq"', 12, true);


--
-- Name: Exercises_Metrics_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Exercises_Metrics_id_seq"', 223, true);


--
-- Name: Exercises_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Exercises_id_seq"', 223, true);


--
-- Name: Notations_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Notations_id_seq"', 19, true);


--
-- Name: Tag_Categories_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Tag_Categories_id_seq"', 20, true);


--
-- Name: Tags_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Tags_id_seq"', 177, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: exercises_library; Owner: -
--

SELECT pg_catalog.setval('exercises_library."Users_id_seq"', 3, true);


--
-- Name: Configurations_Tags Configurations_Tags_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Configurations_Tags"
    ADD CONSTRAINT "Configurations_Tags_pkey" PRIMARY KEY (configuration_id, tag_id);


--
-- Name: Configurations Configurations_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Configurations"
    ADD CONSTRAINT "Configurations_pkey" PRIMARY KEY (id);


--
-- Name: Exercises_Metrics Exercises_Metrics_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises_Metrics"
    ADD CONSTRAINT "Exercises_Metrics_pkey" PRIMARY KEY (id);


--
-- Name: Exercises_Tags Exercises_Tags_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises_Tags"
    ADD CONSTRAINT "Exercises_Tags_pkey" PRIMARY KEY (exercise_id, tag_id);


--
-- Name: Exercises Exercises_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises"
    ADD CONSTRAINT "Exercises_pkey" PRIMARY KEY (id);


--
-- Name: Notations Notations_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Notations"
    ADD CONSTRAINT "Notations_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: Tag_Categories Tag_Categories_kind_key; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Tag_Categories"
    ADD CONSTRAINT "Tag_Categories_kind_key" UNIQUE (kind);


--
-- Name: Tag_Categories Tag_Categories_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Tag_Categories"
    ADD CONSTRAINT "Tag_Categories_pkey" PRIMARY KEY (id);


--
-- Name: Tags Tags_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Tags"
    ADD CONSTRAINT "Tags_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Configurations_Tags Configurations_Tags_configuration_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Configurations_Tags"
    ADD CONSTRAINT "Configurations_Tags_configuration_id_fkey" FOREIGN KEY (configuration_id) REFERENCES exercises_library."Configurations"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Configurations_Tags Configurations_Tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Configurations_Tags"
    ADD CONSTRAINT "Configurations_Tags_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES exercises_library."Tags"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Configurations Configurations_user_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Configurations"
    ADD CONSTRAINT "Configurations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES exercises_library."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Exercises_Metrics Exercises_Metrics_exercise_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises_Metrics"
    ADD CONSTRAINT "Exercises_Metrics_exercise_id_fkey" FOREIGN KEY (exercise_id) REFERENCES exercises_library."Exercises"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Exercises_Tags Exercises_Tags_exercise_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises_Tags"
    ADD CONSTRAINT "Exercises_Tags_exercise_id_fkey" FOREIGN KEY (exercise_id) REFERENCES exercises_library."Exercises"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Exercises_Tags Exercises_Tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises_Tags"
    ADD CONSTRAINT "Exercises_Tags_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES exercises_library."Tags"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Exercises Exercises_user_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Exercises"
    ADD CONSTRAINT "Exercises_user_id_fkey" FOREIGN KEY (user_id) REFERENCES exercises_library."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notations Notations_exercise_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Notations"
    ADD CONSTRAINT "Notations_exercise_id_fkey" FOREIGN KEY (exercise_id) REFERENCES exercises_library."Exercises"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notations Notations_user_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Notations"
    ADD CONSTRAINT "Notations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES exercises_library."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Tags Tags_category_id_fkey; Type: FK CONSTRAINT; Schema: exercises_library; Owner: -
--

ALTER TABLE ONLY exercises_library."Tags"
    ADD CONSTRAINT "Tags_category_id_fkey" FOREIGN KEY (category_id) REFERENCES exercises_library."Tag_Categories"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

