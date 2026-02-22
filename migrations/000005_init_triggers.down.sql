DROP TRIGGER IF EXISTS trg_timetable_events_updated_at ON timetable_events;
DROP TRIGGER IF EXISTS trg_calendar_links_updated_at ON calendar_links;
DROP TRIGGER IF EXISTS trg_subjects_updated_at ON subjects;
DROP TRIGGER IF EXISTS trg_users_updated_at ON users;
DROP FUNCTION IF EXISTS update_updated_at();
