DELETE FROM timetable_events a USING timetable_events b
WHERE a.id > b.id
  AND a.subject_id = b.subject_id
  AND a.start_datetime = b.start_datetime
  AND a.end_datetime = b.end_datetime
  AND a.content_hash = b.content_hash;

ALTER TABLE timetable_events
ADD CONSTRAINT timetable_events_unique_event
UNIQUE (subject_id, start_datetime, end_datetime, content_hash);
