DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id serial NOT NULL,
    username character varying(10) NOT NULL,
    password character varying(16) NOT NULL,
    active boolean NOT NULL DEFAULT TRUE,
    role character varying(10) NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.students;

CREATE TABLE IF NOT EXISTS public.students
(
    id serial NOT NULL,
    name character varying(20) NOT NULL,
    user_id integer NOT NULL,
    batch_id smallint NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.mentors;

CREATE TABLE IF NOT EXISTS public.mentors
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    user_id integer NOT NULL,
    PRIMARY KEY (None)
);

DROP TABLE IF EXISTS public.admins;

CREATE TABLE IF NOT EXISTS public.admins
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    user_id integer NOT NULL,
    PRIMARY KEY (None)
);

DROP TABLE IF EXISTS public.classes;

CREATE TABLE IF NOT EXISTS public.classes
(
    id smallserial,
    name character varying(20),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.batches;

CREATE TABLE IF NOT EXISTS public.batches
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    class_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.courses;

CREATE TABLE IF NOT EXISTS public.courses
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    class_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.subjects;

CREATE TABLE IF NOT EXISTS public.subjects
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    course_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.lessons;

CREATE TABLE IF NOT EXISTS public.lessons
(
    id smallserial NOT NULL,
    name character varying(20) NOT NULL,
    media_url character varying(255),
    subject_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.schedules;

CREATE TABLE IF NOT EXISTS public.schedules
(
    id smallserial NOT NULL,
    schedule_date date NOT NULL,
    lesson_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.student_attendances;

CREATE TABLE IF NOT EXISTS public.student_attendances
(
    id serial NOT NULL,
    student_id smallint NOT NULL,
    schedule_id smallint NOT NULL,
    check_in time with time zone NOT NULL,
    check_out time with time zone NOT NULL,
    grade smallint,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.mentor_attendances;

CREATE TABLE IF NOT EXISTS public.mentor_attendances
(
    id serial NOT NULL,
    mentor_id smallint NOT NULL,
    schedule_id smallint NOT NULL,
    check_in time with time zone NOT NULL,
    check_out time with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.weekly_grades;

CREATE TABLE IF NOT EXISTS public.weekly_grades
(
    id serial NOT NULL,
    subject_id smallint NOT NULL,
    student_id integer NOT NULL,
    grade smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.announcements;

CREATE TABLE IF NOT EXISTS public.announcements
(
    id smallserial NOT NULL,
    content character varying(1024) NOT NULL,
    admin_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.students
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.students
    ADD FOREIGN KEY (batch_id)
    REFERENCES public.batches (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.mentors
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.admins
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.courses
    ADD FOREIGN KEY (class_id)
    REFERENCES public.classes (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.subjects
    ADD FOREIGN KEY (course_id)
    REFERENCES public.courses (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.lessons
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subjects (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.schedules
    ADD FOREIGN KEY (lesson_id)
    REFERENCES public.lessons (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.student_attendances
    ADD FOREIGN KEY (student_id)
    REFERENCES public.students (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.student_attendances
    ADD FOREIGN KEY (schedule_id)
    REFERENCES public.schedules (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.mentor_attendances
    ADD FOREIGN KEY (mentor_id)
    REFERENCES public.mentors (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.mentor_attendances
    ADD FOREIGN KEY (schedule_id)
    REFERENCES public.schedules (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.weekly_grades
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subjects (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.weekly_grades
    ADD FOREIGN KEY (student_id)
    REFERENCES public.students (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.announcements
    ADD FOREIGN KEY (admin_id)
    REFERENCES public.admins (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;