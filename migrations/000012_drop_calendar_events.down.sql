CREATE TABLE calendar_events (
    id                 UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    calendar_id        UUID NOT NULL REFERENCES calendar_links(id) ON DELETE CASCADE,
    timetable_event_id UUID NOT NULL REFERENCES timetable_events(id) ON DELETE CASCADE,
    sequence           INTEGER NOT NULL DEFAULT 0,
    UNIQUE(calendar_id, timetable_event_id)
);

CREATE INDEX idx_calendar_events_calendar_id ON calendar_events(calendar_id);