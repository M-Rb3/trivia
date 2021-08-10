--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2021-08-11 00:44:50

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 33124)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    type text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 33130)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 201
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 202 (class 1259 OID 33132)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    question text,
    answer text,
    difficulty integer,
    category integer
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 33138)
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO postgres;

--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 203
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- TOC entry 2858 (class 2604 OID 33140)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2859 (class 2604 OID 33141)
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- TOC entry 2995 (class 0 OID 33124)
-- Dependencies: 200
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (id, type) VALUES (1, 'Science');
INSERT INTO public.categories (id, type) VALUES (2, 'Art');
INSERT INTO public.categories (id, type) VALUES (3, 'Geography');
INSERT INTO public.categories (id, type) VALUES (4, 'History');
INSERT INTO public.categories (id, type) VALUES (5, 'Entertainment');
INSERT INTO public.categories (id, type) VALUES (6, 'Sports');


--
-- TOC entry 2997 (class 0 OID 33132)
-- Dependencies: 202
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (5, 'Whose autobiography is entitled ''I Know Why the Caged Bird Sings''?', 'Maya Angelou', 2, 4);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (9, 'What boxer''s original name is Cassius Clay?', 'Muhammad Ali', 1, 4);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (2, 'What movie earned Tom Hanks his third straight Oscar nomination, in 1996?', 'Apollo 13', 4, 5);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (4, 'What actor did author Anne Rice first denounce, then praise in the role of her beloved Lestat?', 'Tom Cruise', 4, 5);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (6, 'What was the title of the 1990 fantasy directed by Tim Burton about a young man with multi-bladed appendages?', 'Edward Scissorhands', 3, 5);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (10, 'Which is the only team to play in every soccer World Cup tournament?', 'Brazil', 3, 6);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (11, 'Which country won the first ever soccer World Cup in 1930?', 'Uruguay', 4, 6);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (12, 'Who invented Peanut Butter?', 'George Washington Carver', 2, 4);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (13, 'What is the largest lake in Africa?', 'Lake Victoria', 2, 3);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (14, 'In which royal palace would you find the Hall of Mirrors?', 'The Palace of Versailles', 3, 3);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (15, 'The Taj Mahal is located in which Indian city?', 'Agra', 2, 3);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (16, 'Which Dutch graphic artist–initials M C was a creator of optical illusions?', 'Escher', 1, 2);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (17, 'La Giaconda is better known as what?', 'Mona Lisa', 3, 2);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (18, 'How many paintings did Van Gogh sell in his lifetime?', 'One', 4, 2);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (19, 'Which American artist was a pioneer of Abstract Expressionism, and a leading exponent of action painting?', 'Jackson Pollock', 2, 2);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (20, 'What is the heaviest organ in the human body?', 'The Liver', 4, 1);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (21, 'Who discovered penicillin?', 'Alexander Fleming', 3, 1);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (22, 'Hematology is a branch of medicine involving the study of what?', 'Blood', 4, 1);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (23, 'Which dung beetle was worshipped by the ancient Egyptians?', 'Scarab', 4, 4);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (59, 'hello wolrld', 'hey abood', 1, 1);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (60, 'Hello world', 'HEY', 2, 3);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (61, 'hello world', 'HEY', 4, 2);
INSERT INTO public.questions (id, question, answer, difficulty, category) VALUES (62, 'hello wolrld', 'hey abood', 1, 1);


--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 201
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 203
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 62, true);


--
-- TOC entry 2861 (class 2606 OID 33143)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2863 (class 2606 OID 33145)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- TOC entry 2864 (class 2606 OID 33146)
-- Name: questions category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT category FOREIGN KEY (category) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2021-08-11 00:44:50

--
-- PostgreSQL database dump complete
--

