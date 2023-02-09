json.title conference.title
json.description conference.description
json.starts_at conference.starts_at.to_datetime.to_timestamp
json.ends_at conference.ends_at.to_datetime.to_timestamp
json.attendees_count conference.attendees.count
