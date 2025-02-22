# frozen_string_literal: true

module Reports
  class EventsController < ::ApplicationController
    def index
      @event = Event.find events_params[:event_id]
    end

    def speakers
      @event = Event.find events_params[:event_id]
    end

    def attendees
      @event = Event.find events_params[:event_id]
    end

    private

    def events_params
      params.permit(:event_id)
    end
  end
end
