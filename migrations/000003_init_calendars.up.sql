CREATE TABLE calendar_links (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug            VARCHAR(16) NOT NULL UNIQUE,   -- 'a7k9m2x5'
    owner_id        UUID REFERENCES users(id) ON DELETE SET NULL,
    name            VARCHAR(255) NOT NULL DEFAULT 'My Calendar',
    description     TEXT,
    is_public       BOOLEAN NOT NULL DEFAULT TRUE,
    access_count    INTEGER NOT NULL DEFAULT 0,
    last_accessed_at TIMESTAMPTZ,
    ttl_expires_at  TIMESTAMPTZ NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE calendar_courses (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    calendar_id     UUID NOT NULL REFERENCES calendar_links(id) ON DELETE CASCADE,
    curriculum_id   UUID NOT NULL REFERENCES curricula(id) ON DELETE RESTRICT,
    position        SMALLINT NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(calendar_id, curriculum_id)
);

CREATE TABLE calendar_subjects (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    calendar_course_id  UUID NOT NULL REFERENCES calendar_courses(id) ON DELETE CASCADE,
    subject_id          UUID NOT NULL REFERENCES subjects(id) ON DELETE RESTRICT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(calendar_course_id, subject_id)
);

CREATE TABLE calendar_subscriptions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    calendar_id     UUID NOT NULL REFERENCES calendar_links(id) ON DELETE CASCADE,
    user_agent      TEXT,
    ip_hash         VARCHAR(64),               -- SHA-256 of IP
    last_request_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    request_count   INTEGER NOT NULL DEFAULT 1,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_calendar_links_slug ON calendar_links(slug);
CREATE INDEX idx_calendar_links_owner_id ON calendar_links(owner_id);
CREATE INDEX idx_calendar_links_ttl ON calendar_links(ttl_expires_at);
CREATE INDEX idx_calendar_courses_calendar_id ON calendar_courses(calendar_id);
CREATE INDEX idx_calendar_subjects_calendar_course_id ON calendar_subjects(calendar_course_id);
CREATE INDEX idx_calendar_subscriptions_calendar_id ON calendar_subscriptions(calendar_id);
