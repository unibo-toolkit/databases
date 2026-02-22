CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_subjects_updated_at
    BEFORE UPDATE ON subjects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_calendar_links_updated_at
    BEFORE UPDATE ON calendar_links
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_timetable_events_updated_at
    BEFORE UPDATE ON timetable_events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
