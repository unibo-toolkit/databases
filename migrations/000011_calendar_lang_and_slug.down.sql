ALTER TABLE calendar_links DROP COLUMN lang;

ALTER TABLE calendar_links ALTER COLUMN slug TYPE VARCHAR(16);