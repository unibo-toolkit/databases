ALTER TABLE subjects
    RENAME COLUMN module_code TO module_id;

ALTER TABLE subjects
    ADD COLUMN unibo_id INTEGER,
    ADD COLUMN subject_code VARCHAR(50);

CREATE INDEX idx_subjects_unibo_id ON subjects(unibo_id);