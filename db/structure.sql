--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: answered_questions; Type: TABLE; Schema: public; Owner: -
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
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sub_categories_count integer DEFAULT 0
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
-- Name: licenses; Type: TABLE; Schema: public; Owner: -
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
    explanation text
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
    user_id integer,
    sub_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    answered_questions_count integer DEFAULT 0,
    explanation character varying,
    picture character varying,
    url character varying
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
-- Name: resources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resources (
    id integer NOT NULL,
    generic_name character varying,
    tutorial_id integer,
    material_id integer,
    material_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
-- Name: simulated_categories; Type: TABLE; Schema: public; Owner: -
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
-- Name: simulator_answered_questions; Type: TABLE; Schema: public; Owner: -
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
-- Name: simulator_types; Type: TABLE; Schema: public; Owner: -
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
-- Name: simulators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE simulators (
    id integer NOT NULL,
    user_id integer,
    time_left time without time zone DEFAULT '00:00:30'::time without time zone,
    last_started timestamp without time zone DEFAULT '2016-04-08 01:29:40.429433'::timestamp without time zone,
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
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: -
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
-- Name: tutorials; Type: TABLE; Schema: public; Owner: -
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
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answered_questions ALTER COLUMN id SET DEFAULT nextval('answered_questions_id_seq'::regclass);


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

ALTER TABLE ONLY resources ALTER COLUMN id SET DEFAULT nextval('resources_id_seq'::regclass);


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

ALTER TABLE ONLY tutorials ALTER COLUMN id SET DEFAULT nextval('tutorials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: answered_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answered_questions
    ADD CONSTRAINT answered_questions_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY choices
    ADD CONSTRAINT choices_pkey PRIMARY KEY (id);


--
-- Name: licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: live_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY live_classes
    ADD CONSTRAINT live_classes_pkey PRIMARY KEY (id);


--
-- Name: point_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY point_actions
    ADD CONSTRAINT point_actions_pkey PRIMARY KEY (id);


--
-- Name: points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY points
    ADD CONSTRAINT points_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: queue_classic_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY queue_classic_jobs
    ADD CONSTRAINT queue_classic_jobs_pkey PRIMARY KEY (id);


--
-- Name: resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: simulated_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulated_categories
    ADD CONSTRAINT simulated_categories_pkey PRIMARY KEY (id);


--
-- Name: simulator_answered_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulator_answered_questions
    ADD CONSTRAINT simulator_answered_questions_pkey PRIMARY KEY (id);


--
-- Name: simulator_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulator_types
    ADD CONSTRAINT simulator_types_pkey PRIMARY KEY (id);


--
-- Name: simulators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY simulators
    ADD CONSTRAINT simulators_pkey PRIMARY KEY (id);


--
-- Name: sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: tutorials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tutorials
    ADD CONSTRAINT tutorials_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: idx_qc_on_name_only_unlocked; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_qc_on_name_only_unlocked ON queue_classic_jobs USING btree (q_name, id) WHERE (locked_at IS NULL);


--
-- Name: index_resources_on_material_type_and_material_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resources_on_material_type_and_material_id ON resources USING btree (material_type, material_id);


--
-- Name: index_resources_on_tutorial_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resources_on_tutorial_id ON resources USING btree (tutorial_id);


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
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: queue_classic_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER queue_classic_notify AFTER INSERT ON queue_classic_jobs FOR EACH ROW EXECUTE PROCEDURE queue_classic_notify();


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

INSERT INTO schema_migrations (version) VALUES ('20160412215148');

INSERT INTO schema_migrations (version) VALUES ('20160415213820');

INSERT INTO schema_migrations (version) VALUES ('20160415213904');

