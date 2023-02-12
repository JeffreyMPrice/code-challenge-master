# frozen_string_literal: true

json.event @event, partial: 'event', as: :event
json.attendees @event.unique_attendees, partial: 'attendee', as: :attendee
