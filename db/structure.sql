--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: queue_classic_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE queue_classic_jobs (
    id bigint NOT NULL,
    q_name text NOT NULL,
    method text NOT NULL,
    args json NOT NULL,
    locked_at timestamp with time zone,
    locked_by integer,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT queue_classic_jobs_method_check CHECK ((length(method) > 0)),
    CONSTRAINT queue_classic_jobs_q_name_check CHECK ((length(q_name) > 0))
);


--
-- Name: lock_head(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lock_head(tname character varying) RETURNS SETOF queue_classic_jobs
    LANGUAGE plpgsql
    AS $_$
BEGIN
  RETURN QUERY EXECUTE 'SELECT * FROM lock_head($1,10)' USING tname;
END;
$_$;


--
-- Name: lock_head(character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lock_head(q_name character varying, top_boundary integer) RETURNS SETOF queue_classic_jobs
    LANGUAGE plpgsql
    AS $_$
DECLARE
  unlocked bigint;
  relative_top integer;
  job_count integer;
BEGIN
  -- The purpose is to release contention for the first spot in the table.
  -- The select count(*) is going to slow down dequeue performance but allow
  -- for more workers. Would love to see some optimization here...

  EXECUTE 'SELECT count(*) FROM '
    || '(SELECT * FROM queue_classic_jobs '
    || ' WHERE locked_at IS NULL'
    || ' AND q_name = '
    || quote_literal(q_name)
    || ' LIMIT '
    || quote_literal(top_boundary)
    || ') limited'
  INTO job_count;

  SELECT TRUNC(random() * (top_boundary - 1))
  INTO relative_top;

  IF job_count < top_boundary THEN
    relative_top = 0;
  END IF;

  LOOP
    BEGIN
      EXECUTE 'SELECT id FROM queue_classic_jobs '
        || ' WHERE locked_at IS NULL'
        || ' AND q_name = '
        || quote_literal(q_name)
        || ' ORDER BY id ASC'
        || ' LIMIT 1'
        || ' OFFSET ' || quote_literal(relative_top)
        || ' FOR UPDATE NOWAIT'
      INTO unlocked;
      EXIT;
    EXCEPTION
      WHEN lock_not_available THEN
        -- do nothing. loop again and hope we get a lock
    END;
  END LOOP;

  RETURN QUERY EXECUTE 'UPDATE queue_classic_jobs '
    || ' SET locked_at = (CURRENT_TIMESTAMP),'
    || ' locked_by = (select pg_backend_pid())'
    || ' WHERE id = $1'
    || ' AND locked_at is NULL'
    || ' RETURNING *'
  USING unlocked;

  RETURN;
END;
$_$;


--
-- Name: queue_classic_notify(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION queue_classic_notify() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin
  perform pg_notify(new.q_name, '');
  return null;
end $$;


--
-- Name: answered_questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answered_questions (
    id integer NOT NULL,
    correct boolean DEFAULT false,
    user_id integer,
    question_id integer,
    choice_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: answered_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answered_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answered_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answered_questions_id_seq OWNED BY answered_questions.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    choice_id integer NOT NULL,
    item_id integer NOT NULL,
    item_type character varying NOT NULL
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: blogs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE blogs (
    id integer NOT NULL,
    title character varying,
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blogs_id_seq OWNED BY blogs.id;


--
-- Name: careers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE careers (
    id integer NOT NULL,
    name character varying,
    description text,
    image character varying,
    type integer,
    faculty character varying,
    school_id integer,
    university_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: careers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE careers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: careers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE careers_id_seq OWNED BY careers.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sub_categories_count integer DEFAULT 0,
    course_id integer
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: choices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE choices (
    id integer NOT NULL,
    content character varying,
    question_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: choices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: choices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE choices_id_seq OWNED BY choices.id;


--
-- Name: course_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE course_users (
    id integer NOT NULL,
    course_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: course_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE course_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE course_users_id_seq OWNED BY course_users.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE courses (
    id integer NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE licenses (
    id integer NOT NULL,
    user_id integer,
    plan integer DEFAULT 10,
    days_left integer DEFAULT 10,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE licenses_id_seq OWNED BY licenses.id;


--
-- Name: live_classes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE live_classes (
    id integer NOT NULL,
    subject character varying,
    professor character varying,
    url character varying,
    online_now boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "time" timestamp without time zone,
    explanation text,
    "Urlyoutube" character varying,
    course_id integer
);


--
-- Name: live_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE live_classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: live_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE live_classes_id_seq OWNED BY live_classes.id;


--
-- Name: point_actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE point_actions (
    id integer NOT NULL,
    action character varying,
    description character varying,
    points_alloted integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: point_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE point_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: point_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE point_actions_id_seq OWNED BY point_actions.id;


--
-- Name: points; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE points (
    id integer NOT NULL,
    owner_id integer,
    owner_type character varying,
    points integer,
    point_action_id integer,
    recipient_id integer,
    recipient_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE points_id_seq OWNED BY points.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    content character varying,
    choice_id integer,
    sub_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    explanation character varying,
    picture character varying,
    url character varying,
    video_url character varying,
    question_id integer,
    "time" integer,
    total_answered_count integer DEFAULT 0 NOT NULL,
    wrong_answered_count integer DEFAULT 0 NOT NULL,
    parent_id integer,
    parent_type character varying
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: queue_classic_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE queue_classic_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: queue_classic_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE queue_classic_jobs_id_seq OWNED BY queue_classic_jobs.id;


--
-- Name: resource_progresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resource_progresses (
    id integer NOT NULL,
    course_user_id integer,
    section_id integer,
    resource_id integer,
    completed boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: resource_progresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resource_progresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resource_progresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE resource_progresses_id_seq OWNED BY resource_progresses.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resources (
    id integer NOT NULL,
    generic_name character varying,
    tutorial_id integer,
    material_id integer,
    material_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    section_id integer
);


--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE resources_id_seq OWNED BY resources.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: schools; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schools (
    id integer NOT NULL,
    name character varying,
    description text,
    image character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE schools_id_seq OWNED BY schools.id;


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sections (
    id integer NOT NULL,
    name character varying,
    course_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sections_id_seq OWNED BY sections.id;


--
-- Name: simulated_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE simulated_categories (
    id integer NOT NULL,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: simulated_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE simulated_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: simulated_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE simulated_categories_id_seq OWNED BY simulated_categories.id;


--
-- Name: simulator_answered_questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE simulator_answered_questions (
    id integer NOT NULL,
    simulator_id integer,
    question_id integer,
    user_id integer,
    choice_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0,
    marked_status integer DEFAULT 0
);


--
-- Name: simulator_answered_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE simulator_answered_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: simulator_answered_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE simulator_answered_questions_id_seq OWNED BY simulator_answered_questions.id;


--
-- Name: simulator_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE simulator_types (
    id integer NOT NULL,
    name character varying,
    total_questions integer,
    time_duration time without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description character varying,
    "limit" integer,
    points integer
);


--
-- Name: simulator_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE simulator_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: simulator_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE simulator_types_id_seq OWNED BY simulator_types.id;


--
-- Name: simulators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE simulators (
    id integer NOT NULL,
    user_id integer,
    time_left time without time zone DEFAULT '00:00:30'::time without time zone,
    last_started timestamp without time zone DEFAULT '2016-06-08 03:52:34.35742'::timestamp without time zone,
    last_paused timestamp without time zone,
    time_completed timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    simulator_type_id integer,
    status integer DEFAULT 0
);


--
-- Name: simulators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE simulators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: simulators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE simulators_id_seq OWNED BY simulators.id;


--
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sub_categories (
    id integer NOT NULL,
    name character varying,
    user_id integer,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    questions_count integer DEFAULT 0,
    description text
);


--
-- Name: sub_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sub_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sub_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sub_categories_id_seq OWNED BY sub_categories.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    title character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: test_course_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE test_course_users (
    id integer NOT NULL,
    test_id integer,
    course_user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: test_course_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE test_course_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_course_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE test_course_users_id_seq OWNED BY test_course_users.id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tests (
    id integer NOT NULL,
    title character varying,
    description text,
    time_limit integer,
    total_questions integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    completed boolean DEFAULT false,
    course_id integer
);


--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tests_id_seq OWNED BY tests.id;


--
-- Name: tutorials; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tutorials (
    id integer NOT NULL,
    title character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tutorials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tutorials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tutorials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tutorials_id_seq OWNED BY tutorials.id;


--
-- Name: universities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE universities (
    id integer NOT NULL,
    name character varying,
    province character varying,
    city character varying,
    website character varying,
    type integer,
    logo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: universities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE universities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: universities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE universities_id_seq OWNED BY universities.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider character varying,
    uid character varying,
    first_name character varying,
    last_name character varying,
    questions_count integer DEFAULT 0,
    image character varying,
    gender boolean,
    role integer DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE videos (
    id integer NOT NULL,
    name character varying,
    description text,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answered_questions ALTER COLUMN id SET DEFAULT nextval('answered_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blogs ALTER COLUMN id SET DEFAULT nextval('blogs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY careers ALTER COLUMN id SET DEFAULT nextval('careers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY choices ALTER COLUMN id SET DEFAULT nextval('choices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_users ALTER COLUMN id SET DEFAULT nextval('course_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY licenses ALTER COLUMN id SET DEFAULT nextval('licenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY live_classes ALTER COLUMN id SET DEFAULT nextval('live_classes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY point_actions ALTER COLUMN id SET DEFAULT nextval('point_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY points ALTER COLUMN id SET DEFAULT nextval('points_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY queue_classic_jobs ALTER COLUMN id SET DEFAULT nextval('queue_classic_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_progresses ALTER COLUMN id SET DEFAULT nextval('resource_progresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources ALTER COLUMN id SET DEFAULT nextval('resources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections ALTER COLUMN id SET DEFAULT nextval('sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulated_categories ALTER COLUMN id SET DEFAULT nextval('simulated_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulator_answered_questions ALTER COLUMN id SET DEFAULT nextval('simulator_answered_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulator_types ALTER COLUMN id SET DEFAULT nextval('simulator_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulators ALTER COLUMN id SET DEFAULT nextval('simulators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sub_categories ALTER COLUMN id SET DEFAULT nextval('sub_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY test_course_users ALTER COLUMN id SET DEFAULT nextval('test_course_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tests ALTER COLUMN id SET DEFAULT nextval('tests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tutorials ALTER COLUMN id SET DEFAULT nextval('tutorials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY universities ALTER COLUMN id SET DEFAULT nextval('universities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: answered_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answered_questions
    ADD CONSTRAINT answered_questions_pkey PRIMARY KEY (id);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: careers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY careers
    ADD CONSTRAINT careers_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY choices
    ADD CONSTRAINT choices_pkey PRIMARY KEY (id);


--
-- Name: course_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY course_users
    ADD CONSTRAINT course_users_pkey PRIMARY KEY (id);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: live_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY live_classes
    ADD CONSTRAINT live_classes_pkey PRIMARY KEY (id);


--
-- Name: point_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY point_actions
    ADD CONSTRAINT point_actions_pkey PRIMARY KEY (id);


--
-- Name: points_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY points
    ADD CONSTRAINT points_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: queue_classic_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY queue_classic_jobs
    ADD CONSTRAINT queue_classic_jobs_pkey PRIMARY KEY (id);


--
-- Name: resource_progresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resource_progresses
    ADD CONSTRAINT resource_progresses_pkey PRIMARY KEY (id);


--
-- Name: resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: schools_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: simulated_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY simulated_categories
    ADD CONSTRAINT simulated_categories_pkey PRIMARY KEY (id);


--
-- Name: simulator_answered_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY simulator_answered_questions
    ADD CONSTRAINT simulator_answered_questions_pkey PRIMARY KEY (id);


--
-- Name: simulator_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY simulator_types
    ADD CONSTRAINT simulator_types_pkey PRIMARY KEY (id);


--
-- Name: simulators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY simulators
    ADD CONSTRAINT simulators_pkey PRIMARY KEY (id);


--
-- Name: sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: test_course_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY test_course_users
    ADD CONSTRAINT test_course_users_pkey PRIMARY KEY (id);


--
-- Name: tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: tutorials_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tutorials
    ADD CONSTRAINT tutorials_pkey PRIMARY KEY (id);


--
-- Name: universities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY universities
    ADD CONSTRAINT universities_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: idx_qc_on_name_only_unlocked; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_qc_on_name_only_unlocked ON queue_classic_jobs USING btree (q_name, id) WHERE (locked_at IS NULL);


--
-- Name: index_answers_on_choice_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_choice_id ON answers USING btree (choice_id);


--
-- Name: index_answers_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_item_type_and_item_id ON answers USING btree (item_type, item_id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_answers_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_user_id ON answers USING btree (user_id);


--
-- Name: index_live_classes_on_course_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_live_classes_on_course_id ON live_classes USING btree (course_id);


--
-- Name: index_questions_on_parent_type_and_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questions_on_parent_type_and_parent_id ON questions USING btree (parent_type, parent_id);


--
-- Name: index_questions_on_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questions_on_question_id ON questions USING btree (question_id);


--
-- Name: index_resources_on_material_type_and_material_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_resources_on_material_type_and_material_id ON resources USING btree (material_type, material_id);


--
-- Name: index_resources_on_section_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_resources_on_section_id ON resources USING btree (section_id);


--
-- Name: index_resources_on_tutorial_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_resources_on_tutorial_id ON resources USING btree (tutorial_id);


--
-- Name: index_sections_on_course_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sections_on_course_id ON sections USING btree (course_id);


--
-- Name: index_test_course_users_on_course_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_course_users_on_course_user_id ON test_course_users USING btree (course_user_id);


--
-- Name: index_test_course_users_on_test_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_course_users_on_test_id ON test_course_users USING btree (test_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_provider; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_provider ON users USING btree (provider);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_uid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_uid ON users USING btree (uid);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: queue_classic_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER queue_classic_notify AFTER INSERT ON queue_classic_jobs FOR EACH ROW EXECUTE PROCEDURE queue_classic_notify();


--
-- Name: fk_rails_20b1e5de46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT fk_rails_20b1e5de46 FOREIGN KEY (course_id) REFERENCES courses(id);


--
-- Name: fk_rails_3d5ed4418f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_3d5ed4418f FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: fk_rails_584be190c2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_584be190c2 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_5f494521a1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_5f494521a1 FOREIGN KEY (choice_id) REFERENCES choices(id);


--
-- Name: fk_rails_6d1984789f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT fk_rails_6d1984789f FOREIGN KEY (section_id) REFERENCES sections(id);


--
-- Name: fk_rails_83a20e1db0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY test_course_users
    ADD CONSTRAINT fk_rails_83a20e1db0 FOREIGN KEY (test_id) REFERENCES tests(id);


--
-- Name: fk_rails_97ebb10078; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY live_classes
    ADD CONSTRAINT fk_rails_97ebb10078 FOREIGN KEY (course_id) REFERENCES courses(id);


--
-- Name: fk_rails_a8bb78196f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY test_course_users
    ADD CONSTRAINT fk_rails_a8bb78196f FOREIGN KEY (course_user_id) REFERENCES course_users(id);


--
-- Name: fk_rails_c685b1dfea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_c685b1dfea FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20160109172826');

INSERT INTO schema_migrations (version) VALUES ('20160109172929');

INSERT INTO schema_migrations (version) VALUES ('20160115083615');

INSERT INTO schema_migrations (version) VALUES ('20160115083621');

INSERT INTO schema_migrations (version) VALUES ('20160115083629');

INSERT INTO schema_migrations (version) VALUES ('20160115083646');

INSERT INTO schema_migrations (version) VALUES ('20160115083656');

INSERT INTO schema_migrations (version) VALUES ('20160115083704');

INSERT INTO schema_migrations (version) VALUES ('20160115105515');

INSERT INTO schema_migrations (version) VALUES ('20160117124517');

INSERT INTO schema_migrations (version) VALUES ('20160117234812');

INSERT INTO schema_migrations (version) VALUES ('20160118023155');

INSERT INTO schema_migrations (version) VALUES ('20160120004909');

INSERT INTO schema_migrations (version) VALUES ('20160129230305');

INSERT INTO schema_migrations (version) VALUES ('20160202151007');

INSERT INTO schema_migrations (version) VALUES ('20160202153756');

INSERT INTO schema_migrations (version) VALUES ('20160202153818');

INSERT INTO schema_migrations (version) VALUES ('20160205003943');

INSERT INTO schema_migrations (version) VALUES ('20160206215446');

INSERT INTO schema_migrations (version) VALUES ('20160206215458');

INSERT INTO schema_migrations (version) VALUES ('20160207152954');

INSERT INTO schema_migrations (version) VALUES ('20160207153011');

INSERT INTO schema_migrations (version) VALUES ('20160207164622');

INSERT INTO schema_migrations (version) VALUES ('20160207164623');

INSERT INTO schema_migrations (version) VALUES ('20160207164624');

INSERT INTO schema_migrations (version) VALUES ('20160207175425');

INSERT INTO schema_migrations (version) VALUES ('20160208003122');

INSERT INTO schema_migrations (version) VALUES ('20160208103655');

INSERT INTO schema_migrations (version) VALUES ('20160208222320');

INSERT INTO schema_migrations (version) VALUES ('20160209172512');

INSERT INTO schema_migrations (version) VALUES ('20160209182947');

INSERT INTO schema_migrations (version) VALUES ('20160210012929');

INSERT INTO schema_migrations (version) VALUES ('20160210100402');

INSERT INTO schema_migrations (version) VALUES ('20160303000148');

INSERT INTO schema_migrations (version) VALUES ('20160305074513');

INSERT INTO schema_migrations (version) VALUES ('20160305213132');

INSERT INTO schema_migrations (version) VALUES ('20160307003117');

INSERT INTO schema_migrations (version) VALUES ('20160405062817');

INSERT INTO schema_migrations (version) VALUES ('20160412215148');

INSERT INTO schema_migrations (version) VALUES ('20160414013914');

INSERT INTO schema_migrations (version) VALUES ('20160414014155');

INSERT INTO schema_migrations (version) VALUES ('20160415213820');

INSERT INTO schema_migrations (version) VALUES ('20160415213904');

INSERT INTO schema_migrations (version) VALUES ('20160416213957');

INSERT INTO schema_migrations (version) VALUES ('20160416214513');

INSERT INTO schema_migrations (version) VALUES ('20160416214633');

INSERT INTO schema_migrations (version) VALUES ('20160421185759');

INSERT INTO schema_migrations (version) VALUES ('20160423202928');

INSERT INTO schema_migrations (version) VALUES ('20160425155058');

INSERT INTO schema_migrations (version) VALUES ('20160426193313');

INSERT INTO schema_migrations (version) VALUES ('20160426194020');

INSERT INTO schema_migrations (version) VALUES ('20160427134003');

INSERT INTO schema_migrations (version) VALUES ('20160427134130');

INSERT INTO schema_migrations (version) VALUES ('20160427160225');

INSERT INTO schema_migrations (version) VALUES ('20160428023020');

INSERT INTO schema_migrations (version) VALUES ('20160504232743');

INSERT INTO schema_migrations (version) VALUES ('20160504232814');

INSERT INTO schema_migrations (version) VALUES ('20160504232843');

INSERT INTO schema_migrations (version) VALUES ('20160504233032');

INSERT INTO schema_migrations (version) VALUES ('20160507182837');

INSERT INTO schema_migrations (version) VALUES ('20160511010803');

INSERT INTO schema_migrations (version) VALUES ('20160518174722');

INSERT INTO schema_migrations (version) VALUES ('20160518174952');

INSERT INTO schema_migrations (version) VALUES ('20160523141824');

INSERT INTO schema_migrations (version) VALUES ('20160523191705');

INSERT INTO schema_migrations (version) VALUES ('20160602193801');

INSERT INTO schema_migrations (version) VALUES ('20160602202339');

INSERT INTO schema_migrations (version) VALUES ('20160607164343');

INSERT INTO schema_migrations (version) VALUES ('20160608034434');

