CREATE TABLE calendar_excluded_families (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    calendar_id UUID NOT NULL REFERENCES calendar_links(id) ON DELETE CASCADE,
    family_hash VARCHAR(64) NOT NULL CHECK (family_hash ~ '^[0-9a-f]{64}$'),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE (calendar_id, family_hash)
);
