ALTER TABLE courses ADD COLUMN timetable_hash VARCHAR(64);
ALTER TABLE courses ADD COLUMN timetable_updated_at TIMESTAMP WITH TIME ZONE;

DROP INDEX IF EXISTS idx_subjects_is_active;
ALTER TABLE subjects DROP COLUMN IF EXISTS is_active;

DROP INDEX IF EXISTS idx_curricula_timetable_hash;
DROP INDEX IF EXISTS idx_curricula_is_active;
ALTER TABLE curricula ADD COLUMN is_default BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE curricula DROP COLUMN IF EXISTS timetable_updated_at;
ALTER TABLE curricula DROP COLUMN IF EXISTS timetable_hash;
ALTER TABLE curricula DROP COLUMN IF EXISTS is_active;

DROP INDEX IF EXISTS idx_courses_is_active;
ALTER TABLE courses DROP COLUMN IF EXISTS is_active;
