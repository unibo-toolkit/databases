CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_users_updated_at ON users;
CREATE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS trg_subjects_updated_at ON subjects;
CREATE TRIGGER trg_subjects_updated_at
    BEFORE UPDATE ON subjects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS trg_calendar_links_updated_at ON calendar_links;
CREATE TRIGGER trg_calendar_links_updated_at
    BEFORE UPDATE ON calendar_links
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS trg_timetable_events_updated_at ON timetable_events;
CREATE TRIGGER trg_timetable_events_updated_at
    BEFORE UPDATE ON timetable_events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
