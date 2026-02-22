-- Courses types
CREATE TYPE course_type AS ENUM ('Bachelor', 'Master', 'SingleCycleMaster');

CREATE TABLE courses (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    unibo_id        INTEGER NOT NULL UNIQUE,   -- ID in UniBo system
    title           VARCHAR(500) NOT NULL,
    course_type     course_type NOT NULL,
    campus          VARCHAR(255),
    languages       VARCHAR(255)[],             -- ['Italian', 'English', 'French']
    duration_years  SMALLINT,
    academic_year   VARCHAR(10),               -- '2025/2026'
    url             TEXT,
    area            VARCHAR(255),
    timetable_hash      VARCHAR(64),           -- all events hash from scraper
    timetable_updated_at TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Study plans (curriculum): code and year
CREATE TABLE curricula (
    id             UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    course_id      UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    code           VARCHAR(50) NOT NULL,           -- 'B69-000', 'B69-PDS'
    academic_year  SMALLINT NOT NULL,              -- 1, 2, 3, ...
    label          VARCHAR(255) NOT NULL,
    is_default     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(course_id, code, academic_year),
    CHECK(academic_year >= 1)
);

CREATE TABLE subjects (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    curriculum_id   UUID NOT NULL REFERENCES curricula(id) ON DELETE CASCADE,
    unibo_id        INTEGER,
    title           VARCHAR(500) NOT NULL,
    subject_code    VARCHAR(50),
    module_id       VARCHAR(50),
    group_id        VARCHAR(50),
    credits         SMALLINT,                   -- CFU
    professor       VARCHAR(255),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_courses_unibo_id ON courses(unibo_id);
CREATE INDEX idx_courses_title_trgm ON courses USING gin(title gin_trgm_ops);
CREATE INDEX idx_courses_timetable_updated ON courses(timetable_updated_at);
CREATE INDEX idx_curricula_course_id ON curricula(course_id);
CREATE INDEX idx_curricula_course_code_year ON curricula(course_id, code, academic_year);
CREATE INDEX idx_subjects_curriculum_id ON subjects(curriculum_id);
CREATE INDEX idx_subjects_unibo_id ON subjects(unibo_id);
