ALTER TABLE subjects
    DROP COLUMN IF EXISTS unibo_id,
    DROP COLUMN IF EXISTS subject_code;

ALTER TABLE subjects
    RENAME COLUMN module_id TO module_code;

DROP INDEX IF EXISTS idx_subjects_unibo_id;