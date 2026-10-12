ALTER TABLE timetable_events ADD COLUMN family_hash VARCHAT(64);

ALTER TABLE timetable_events DISABLE TRIGGER trg_timetable_events_updated_at;

UPDATE timetable_events
SET family_hash = encode(sha256(convert_to(
    '{"group_id": ' || CASE WHEN group_id IS NULL THEN 'null'
                            ELSE '"' || group_id || '"' END
    || ', "start_bucket": ' || (
           (EXTRACT(HOUR FROM start_datetime AT TIME ZONE 'Europe/Rome')::int * 60
          + EXTRACT(MINUTE FROM start_datetime AT TIME ZONE 'Europe/Rome')::int) / 15
       )::text
    || ', "subject_id": "' || subject_id::text
    || '", "weekday": ' || (EXTRACT(ISODOW FROM start_datetime AT TIME ZONE 'Europe/Rome')::int - 1)::text
    || '}', 'UTF8')), 'hex');

ALTER TABLE timetable_events ENABLE TRIGGER trg_timetable_events_updated_at;
