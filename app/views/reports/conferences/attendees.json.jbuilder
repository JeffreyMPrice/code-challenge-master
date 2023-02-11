# frozen_string_literal: true

json.conference @conference, partial: 'conference', as: :conference
json.attendees @attendees, partial: 'attendee', as: :attendee
