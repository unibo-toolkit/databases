ALTER TABLE courses ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;
CREATE INDEX idx_courses_is_active ON courses(is_active);

ALTER TABLE curricula ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;
ALTER TABLE curricula ADD COLUMN timetable_hash VARCHAR(64);
ALTER TABLE curricula ADD COLUMN timetable_updated_at TIMESTAMP WITH TIME ZONE;
ALTER TABLE curricula DROP COLUMN IF EXISTS is_default;
CREATE INDEX idx_curricula_is_active ON curricula(is_active);
CREATE INDEX idx_curricula_timetable_hash ON curricula(timetable_hash);

ALTER TABLE subjects ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;
CREATE INDEX idx_subjects_is_active ON subjects(is_active);

ALTER TABLE courses DROP COLUMN IF EXISTS timetable_hash;
ALTER TABLE courses DROP COLUMN IF EXISTS timetable_updated_at;
