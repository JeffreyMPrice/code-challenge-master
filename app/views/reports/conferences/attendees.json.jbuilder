json.conference @conference, partial: 'conference', as: :conference
json.attendees @conference.attendees, partial: 'attendee', as: :attendee
