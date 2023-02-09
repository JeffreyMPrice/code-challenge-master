json.title event.title
json.description event.description
json.starts_at event.starts_at.to_datetime.to_timestamp
json.ends_at event.ends_at.to_datetime.to_timestamp
json.speakers_total event.speakers.count
