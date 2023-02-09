module Reports
  class EventsController < ::ApplicationController
    def speakers
      @event = Event.find events_params[:event_id]
    end

    private

    def events_params
      params.permit(:event_id)
    end
  end
end
