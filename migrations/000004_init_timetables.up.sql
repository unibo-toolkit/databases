CREATE TABLE classrooms (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(255) NOT NULL,
    address     TEXT,
    latitude    DECIMAL(9,6),
    longitude   DECIMAL(9,6),
    UNIQUE(name, address)
);

CREATE TABLE timetable_events (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subject_id      UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
    title           VARCHAR(500) NOT NULL,
    start_datetime  TIMESTAMPTZ NOT NULL,
    end_datetime    TIMESTAMPTZ NOT NULL,
    professor       VARCHAR(255),
    module_code     VARCHAR(50),
    credits         DECIMAL(4,1),
    classroom_id    UUID REFERENCES classrooms(id) ON DELETE SET NULL,
    is_remote       BOOLEAN NOT NULL DEFAULT FALSE,
    teams_link      TEXT,
    notes           TEXT,
    group_id        VARCHAR(50),
    content_hash    VARCHAR(64) NOT NULL,   -- SHA-256
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE calendar_events (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    calendar_id     UUID NOT NULL REFERENCES calendar_links(id) ON DELETE CASCADE,
    timetable_event_id UUID NOT NULL REFERENCES timetable_events(id) ON DELETE CASCADE,
    sequence        INTEGER NOT NULL DEFAULT 0,
    UNIQUE(calendar_id, timetable_event_id)
);

CREATE INDEX idx_timetable_events_subject_id ON timetable_events(subject_id);
CREATE INDEX idx_timetable_events_start ON timetable_events(start_datetime);
CREATE INDEX idx_timetable_events_hash ON timetable_events(content_hash);
CREATE INDEX idx_calendar_events_calendar_id ON calendar_events(calendar_id);
