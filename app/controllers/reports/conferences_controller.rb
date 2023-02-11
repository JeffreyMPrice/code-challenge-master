# frozen_string_literal: true

module Reports
  class ConferencesController < ::ApplicationController
    def attendees
      @conference = Conference.find(attendee_params[:conference_id])
      @attendees = @conference.attendees.limit(attendee_params[:limit].to_i).offset(attendee_params[:offset].to_i)
    end

    private

    def attendee_params
      params.permit(:conference_id, :limit, :offset)
    end
  end
end
