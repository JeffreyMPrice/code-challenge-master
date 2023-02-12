# frozen_string_literal: true

json.title event.title
json.description event.description
json.starts_at event.starts_at.to_datetime.to_timestamp
json.ends_at event.ends_at.to_datetime.to_timestamp
json.speakers_total event.unique_speakers_count
json.attendees_total event.unique_attendees_count
json.conferences event.conferences, partial: 'conference', as: :conference
