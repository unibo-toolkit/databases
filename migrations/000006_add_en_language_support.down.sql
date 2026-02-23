ALTER TABLE courses ADD COLUMN title VARCHAR(500);

UPDATE courses SET title = title_it WHERE title_it IS NOT NULL;

ALTER TABLE courses ALTER COLUMN title SET NOT NULL;

ALTER TABLE courses
    DROP COLUMN IF EXISTS title_it,
    DROP COLUMN IF EXISTS title_en;

DROP INDEX IF EXISTS idx_courses_title_it_trgm;
DROP INDEX IF EXISTS idx_courses_title_en_trgm;
CREATE INDEX idx_courses_title_trgm ON courses USING gin(title gin_trgm_ops);

DROP INDEX IF EXISTS idx_courses_timetable_updated;
ALTER TABLE courses
    DROP COLUMN IF EXISTS timetable_hash,
    DROP COLUMN IF EXISTS timetable_updated_at;
