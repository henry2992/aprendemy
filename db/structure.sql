--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: queue_classic_jobs; Type: TABLE; Schema: public; Owner: -
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
-- Name: answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE answers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    item_id integer,
    item_type character varying,
    choice_id integer,
    marked integer DEFAULT 0
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
-- Name: area_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE area_questions (
    id integer NOT NULL,
    area_id integer,
    question_id integer,
    timestamps character varying
);


--
-- Name: area_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE area_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE area_questions_id_seq OWNED BY area_questions.id;


--
-- Name: areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE areas (
    id integer NOT NULL,
    name character varying,
    description text,
    timestamps character varying
);


--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE areas_id_seq OWNED BY areas.id;


--
-- Name: blogs; Type: TABLE; Schema: public; Owner: -
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
-- Name: careers; Type: TABLE; Schema: public; Owner: -
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
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
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
-- Name: choices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE choices (
    id integer NOT NULL,
    content character varying,
    question_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    total_answered_count integer DEFAULT 0,
    wrong_answered_count integer DEFAULT 0,
    value_count integer DEFAULT 0
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
-- Name: course_user_plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE course_user_plans (
    id integer NOT NULL,
    course_user_id integer,
    plan_id integer,
    expiration_date date,
    status integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: course_user_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE course_user_plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_user_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE course_user_plans_id_seq OWNED BY course_user_plans.id;


--
-- Name: course_user_tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE course_user_tests (
    id integer NOT NULL,
    course_user_id integer,
    test_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    last_started timestamp without time zone DEFAULT '2017-02-18 23:18:34.257006'::timestamp without time zone,
    last_paused timestamp without time zone,
    time_completed timestamp without time zone,
    time_left bigint,
    status integer
);


--
-- Name: course_user_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE course_user_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_user_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE course_user_tests_id_seq OWNED BY course_user_tests.id;


--
-- Name: course_users; Type: TABLE; Schema: public; Owner: -
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
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE courses (
    id integer NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    author character varying,
    picture character varying
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
-- Name: event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE event_types (
    id integer NOT NULL,
    name character varying,
    color character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: event_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE event_types_id_seq OWNED BY event_types.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE events (
    id integer NOT NULL,
    name character varying,
    start_time timestamp without time zone,
    event_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: live_classes; Type: TABLE; Schema: public; Owner: -
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
-- Name: plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE plans (
    id integer NOT NULL,
    name character varying,
    description text,
    expiration_days integer,
    licence_type integer,
    price numeric(2,0),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plans_id_seq OWNED BY plans.id;


--
-- Name: point_actions; Type: TABLE; Schema: public; Owner: -
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
-- Name: points; Type: TABLE; Schema: public; Owner: -
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
-- Name: questions; Type: TABLE; Schema: public; Owner: -
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
    parent_type character varying,
    area integer DEFAULT 0
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
-- Name: resource_progresses; Type: TABLE; Schema: public; Owner: -
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
-- Name: resources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resources (
    id integer NOT NULL,
    name character varying,
    material_id integer,
    material_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    section_id integer,
    "position" integer DEFAULT 0
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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: schools; Type: TABLE; Schema: public; Owner: -
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
-- Name: sections; Type: TABLE; Schema: public; Owner: -
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
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sub_categories (
    id integer NOT NULL,
    name character varying,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    questions_count integer DEFAULT 0,
    description text,
    picture character varying
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
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
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
-- Name: tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tests (
    id integer NOT NULL,
    title character varying,
    description text,
    time_limit integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    course_id character varying,
    picture character varying,
    test_type integer DEFAULT 0,
    legend text DEFAULT ''::text
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
-- Name: tutorials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tutorials (
    id integer NOT NULL,
    title character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sub_category_id integer,
    material_id integer,
    material_type character varying,
    picture character varying
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
-- Name: universities; Type: TABLE; Schema: public; Owner: -
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
-- Name: user_attitude_tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_attitude_tests (
    id integer NOT NULL,
    user_id integer,
    test_id integer,
    status integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_attitude_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_attitude_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_attitude_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_attitude_tests_id_seq OWNED BY user_attitude_tests.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
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
    image character varying,
    gender boolean,
    role integer DEFAULT 0,
    attitude_test_observation text
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
-- Name: video_classes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE video_classes (
    id integer NOT NULL,
    title character varying,
    link character varying,
    picture character varying,
    sub_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: video_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE video_classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE video_classes_id_seq OWNED BY video_classes.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
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
-- Name: webinars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE webinars (
    id integer NOT NULL,
    subject character varying,
    professor character varying,
    description text,
    "time" timestamp without time zone,
    online boolean,
    link character varying,
    code character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: webinars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE webinars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webinars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE webinars_id_seq OWNED BY webinars.id;


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: area_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY area_questions ALTER COLUMN id SET DEFAULT nextval('area_questions_id_seq'::regclass);


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY areas ALTER COLUMN id SET DEFAULT nextval('areas_id_seq'::regclass);


--
-- Name: blogs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blogs ALTER COLUMN id SET DEFAULT nextval('blogs_id_seq'::regclass);


--
-- Name: careers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY careers ALTER COLUMN id SET DEFAULT nextval('careers_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: choices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY choices ALTER COLUMN id SET DEFAULT nextval('choices_id_seq'::regclass);


--
-- Name: course_user_plans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_user_plans ALTER COLUMN id SET DEFAULT nextval('course_user_plans_id_seq'::regclass);


--
-- Name: course_user_tests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_user_tests ALTER COLUMN id SET DEFAULT nextval('course_user_tests_id_seq'::regclass);


--
-- Name: course_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_users ALTER COLUMN id SET DEFAULT nextval('course_users_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: event_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_types ALTER COLUMN id SET DEFAULT nextval('event_types_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: live_classes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY live_classes ALTER COLUMN id SET DEFAULT nextval('live_classes_id_seq'::regclass);


--
-- Name: plans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY plans ALTER COLUMN id SET DEFAULT nextval('plans_id_seq'::regclass);


--
-- Name: point_actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY point_actions ALTER COLUMN id SET DEFAULT nextval('point_actions_id_seq'::regclass);


--
-- Name: points id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY points ALTER COLUMN id SET DEFAULT nextval('points_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: queue_classic_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY queue_classic_jobs ALTER COLUMN id SET DEFAULT nextval('queue_classic_jobs_id_seq'::regclass);


--
-- Name: resource_progresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_progresses ALTER COLUMN id SET DEFAULT nextval('resource_progresses_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources ALTER COLUMN id SET DEFAULT nextval('resources_id_seq'::regclass);


--
-- Name: schools id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections ALTER COLUMN id SET DEFAULT nextval('sections_id_seq'::regclass);


--
-- Name: sub_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sub_categories ALTER COLUMN id SET DEFAULT nextval('sub_categories_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: tests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tests ALTER COLUMN id SET DEFAULT nextval('tests_id_seq'::regclass);


--
-- Name: tutorials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tutorials ALTER COLUMN id SET DEFAULT nextval('tutorials_id_seq'::regclass);


--
-- Name: universities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY universities ALTER COLUMN id SET DEFAULT nextval('universities_id_seq'::regclass);


--
-- Name: user_attitude_tests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_attitude_tests ALTER COLUMN id SET DEFAULT nextval('user_attitude_tests_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: video_classes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_classes ALTER COLUMN id SET DEFAULT nextval('video_classes_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: webinars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY webinars ALTER COLUMN id SET DEFAULT nextval('webinars_id_seq'::regclass);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: area_questions area_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY area_questions
    ADD CONSTRAINT area_questions_pkey PRIMARY KEY (id);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: blogs blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: careers careers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY careers
    ADD CONSTRAINT careers_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: choices choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY choices
    ADD CONSTRAINT choices_pkey PRIMARY KEY (id);


--
-- Name: course_user_plans course_user_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_user_plans
    ADD CONSTRAINT course_user_plans_pkey PRIMARY KEY (id);


--
-- Name: course_user_tests course_user_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_user_tests
    ADD CONSTRAINT course_user_tests_pkey PRIMARY KEY (id);


--
-- Name: course_users course_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_users
    ADD CONSTRAINT course_users_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: live_classes live_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY live_classes
    ADD CONSTRAINT live_classes_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: point_actions point_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY point_actions
    ADD CONSTRAINT point_actions_pkey PRIMARY KEY (id);


--
-- Name: points points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY points
    ADD CONSTRAINT points_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: queue_classic_jobs queue_classic_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY queue_classic_jobs
    ADD CONSTRAINT queue_classic_jobs_pkey PRIMARY KEY (id);


--
-- Name: resource_progresses resource_progresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_progresses
    ADD CONSTRAINT resource_progresses_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: sub_categories sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: tutorials tutorials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tutorials
    ADD CONSTRAINT tutorials_pkey PRIMARY KEY (id);


--
-- Name: universities universities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY universities
    ADD CONSTRAINT universities_pkey PRIMARY KEY (id);


--
-- Name: user_attitude_tests user_attitude_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_attitude_tests
    ADD CONSTRAINT user_attitude_tests_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video_classes video_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_classes
    ADD CONSTRAINT video_classes_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: webinars webinars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY webinars
    ADD CONSTRAINT webinars_pkey PRIMARY KEY (id);


--
-- Name: idx_qc_on_name_only_unlocked; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_qc_on_name_only_unlocked ON queue_classic_jobs USING btree (q_name, id) WHERE (locked_at IS NULL);


--
-- Name: index_answers_on_choice_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_choice_id ON answers USING btree (choice_id);


--
-- Name: index_answers_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_item_type_and_item_id ON answers USING btree (item_type, item_id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_answers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_user_id ON answers USING btree (user_id);


--
-- Name: index_area_questions_on_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_area_questions_on_area_id ON area_questions USING btree (area_id);


--
-- Name: index_area_questions_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_area_questions_on_question_id ON area_questions USING btree (question_id);


--
-- Name: index_course_user_plans_on_course_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_user_plans_on_course_user_id ON course_user_plans USING btree (course_user_id);


--
-- Name: index_course_user_plans_on_plan_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_user_plans_on_plan_id ON course_user_plans USING btree (plan_id);


--
-- Name: index_events_on_event_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_event_type_id ON events USING btree (event_type_id);


--
-- Name: index_live_classes_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_live_classes_on_course_id ON live_classes USING btree (course_id);


--
-- Name: index_questions_on_parent_type_and_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_parent_type_and_parent_id ON questions USING btree (parent_type, parent_id);


--
-- Name: index_questions_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_question_id ON questions USING btree (question_id);


--
-- Name: index_resources_on_material_type_and_material_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resources_on_material_type_and_material_id ON resources USING btree (material_type, material_id);


--
-- Name: index_resources_on_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resources_on_section_id ON resources USING btree (section_id);


--
-- Name: index_sections_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sections_on_course_id ON sections USING btree (course_id);


--
-- Name: index_tutorials_on_material_type_and_material_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tutorials_on_material_type_and_material_id ON tutorials USING btree (material_type, material_id);


--
-- Name: index_user_attitude_tests_on_test_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_attitude_tests_on_test_id ON user_attitude_tests USING btree (test_id);


--
-- Name: index_user_attitude_tests_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_attitude_tests_on_user_id ON user_attitude_tests USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_provider ON users USING btree (provider);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_uid ON users USING btree (uid);


--
-- Name: index_video_classes_on_sub_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_video_classes_on_sub_category_id ON video_classes USING btree (sub_category_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: queue_classic_jobs queue_classic_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER queue_classic_notify AFTER INSERT ON queue_classic_jobs FOR EACH ROW EXECUTE PROCEDURE queue_classic_notify();


--
-- Name: course_user_plans fk_rails_035e5e1f83; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_user_plans
    ADD CONSTRAINT fk_rails_035e5e1f83 FOREIGN KEY (plan_id) REFERENCES plans(id);


--
-- Name: sections fk_rails_20b1e5de46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT fk_rails_20b1e5de46 FOREIGN KEY (course_id) REFERENCES courses(id);


--
-- Name: answers fk_rails_3d5ed4418f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_3d5ed4418f FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: course_user_plans fk_rails_4268765eb3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course_user_plans
    ADD CONSTRAINT fk_rails_4268765eb3 FOREIGN KEY (course_user_id) REFERENCES course_users(id);


--
-- Name: answers fk_rails_584be190c2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_584be190c2 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: answers fk_rails_5f494521a1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_5f494521a1 FOREIGN KEY (choice_id) REFERENCES choices(id);


--
-- Name: user_attitude_tests fk_rails_6c63bdd4b2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_attitude_tests
    ADD CONSTRAINT fk_rails_6c63bdd4b2 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: resources fk_rails_6d1984789f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT fk_rails_6d1984789f FOREIGN KEY (section_id) REFERENCES sections(id);


--
-- Name: live_classes fk_rails_97ebb10078; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY live_classes
    ADD CONSTRAINT fk_rails_97ebb10078 FOREIGN KEY (course_id) REFERENCES courses(id);


--
-- Name: area_questions fk_rails_bde236fcd3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY area_questions
    ADD CONSTRAINT fk_rails_bde236fcd3 FOREIGN KEY (area_id) REFERENCES areas(id);


--
-- Name: questions fk_rails_c685b1dfea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT fk_rails_c685b1dfea FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: area_questions fk_rails_c9c2a96740; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY area_questions
    ADD CONSTRAINT fk_rails_c9c2a96740 FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: user_attitude_tests fk_rails_cfb9ab956b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_attitude_tests
    ADD CONSTRAINT fk_rails_cfb9ab956b FOREIGN KEY (test_id) REFERENCES tests(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

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

INSERT INTO schema_migrations (version) VALUES ('20160608034434');

INSERT INTO schema_migrations (version) VALUES ('20160614025321');

INSERT INTO schema_migrations (version) VALUES ('20160627132044');

INSERT INTO schema_migrations (version) VALUES ('20160704164427');

INSERT INTO schema_migrations (version) VALUES ('20160704165705');

INSERT INTO schema_migrations (version) VALUES ('20160712051220');

INSERT INTO schema_migrations (version) VALUES ('20160712085620');

INSERT INTO schema_migrations (version) VALUES ('20160712101309');

INSERT INTO schema_migrations (version) VALUES ('20160712171851');

INSERT INTO schema_migrations (version) VALUES ('20160714181425');

INSERT INTO schema_migrations (version) VALUES ('20160714202100');

INSERT INTO schema_migrations (version) VALUES ('20160715201134');

INSERT INTO schema_migrations (version) VALUES ('20160716055112');

INSERT INTO schema_migrations (version) VALUES ('20160718003747');

INSERT INTO schema_migrations (version) VALUES ('20160721110348');

INSERT INTO schema_migrations (version) VALUES ('20160721175000');

INSERT INTO schema_migrations (version) VALUES ('20160726195054');

INSERT INTO schema_migrations (version) VALUES ('20160801020817');

INSERT INTO schema_migrations (version) VALUES ('20160801021612');

INSERT INTO schema_migrations (version) VALUES ('20160808050550');

INSERT INTO schema_migrations (version) VALUES ('20160808202331');

INSERT INTO schema_migrations (version) VALUES ('20160809193149');

INSERT INTO schema_migrations (version) VALUES ('20160809193501');

INSERT INTO schema_migrations (version) VALUES ('20160901013740');

INSERT INTO schema_migrations (version) VALUES ('20160908152902');

INSERT INTO schema_migrations (version) VALUES ('20160916144827');

INSERT INTO schema_migrations (version) VALUES ('20161011143210');

INSERT INTO schema_migrations (version) VALUES ('20161011152718');

INSERT INTO schema_migrations (version) VALUES ('20161018150110');

INSERT INTO schema_migrations (version) VALUES ('20161120182705');

INSERT INTO schema_migrations (version) VALUES ('20161127150842');

INSERT INTO schema_migrations (version) VALUES ('20161130201248');

INSERT INTO schema_migrations (version) VALUES ('20161220212616');

INSERT INTO schema_migrations (version) VALUES ('20170103154140');

INSERT INTO schema_migrations (version) VALUES ('20170105111700');

INSERT INTO schema_migrations (version) VALUES ('20170107185358');

INSERT INTO schema_migrations (version) VALUES ('20170107230553');

INSERT INTO schema_migrations (version) VALUES ('20170108004237');

INSERT INTO schema_migrations (version) VALUES ('20170127015659');

INSERT INTO schema_migrations (version) VALUES ('20170127015845');

