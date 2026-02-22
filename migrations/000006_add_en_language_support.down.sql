ALTER TABLE courses
    ADD COLUMN title_it VARCHAR(500),
    ADD COLUMN title_en VARCHAR(500);

UPDATE courses SET title_it = title WHERE title IS NOT NULL;

ALTER TABLE courses
    ALTER COLUMN title_it SET NOT NULL;

ALTER TABLE courses DROP COLUMN IF EXISTS title;

CREATE INDEX idx_courses_title_it_trgm ON courses USING gin(title_it gin_trgm_ops);
CREATE INDEX idx_courses_title_en_trgm ON courses USING gin(title_en gin_trgm_ops);

DROP INDEX IF EXISTS idx_courses_title_trgm;

ALTER TABLE courses
    ADD COLUMN IF NOT EXISTS timetable_hash VARCHAR(64),
    ADD COLUMN IF NOT EXISTS timetable_updated_at TIMESTAMPTZ;

CREATE INDEX IF NOT EXISTS idx_courses_timetable_updated ON courses(timetable_updated_at);
