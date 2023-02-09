module Reports
  class ConferencesController < ::ApplicationController
    def attendees
      @conference = Conference.find(attendee_params[:conference_id])
    end

    private

    def attendee_params
      params.permit(:conference_id)
    end
  end
end
