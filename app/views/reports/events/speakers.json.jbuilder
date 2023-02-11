# frozen_string_literal: true

json.event @event, partial: 'event', as: :event
json.speakers @event.unique_speakers, partial: 'speaker', as: :speaker
