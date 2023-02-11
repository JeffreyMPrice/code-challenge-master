# frozen_string_literal: true

module Reports
  class ConferencesController < ::ApplicationController
    MAX_LIMIT = 100

    def attendees
      @conference = Conference.find(attendee_params[:conference_id])
      @attendees = @conference.attendees.limit(limit).offset(attendee_params[:offset])
    end

    private

    def limit
      # take the minimum of MAX and user supplied limit
      # we use fetch here, because a nil will blow up Array.min
      [attendee_params.fetch(:limit, MAX_LIMIT).to_i, MAX_LIMIT].min
    end

    def attendee_params
      params.permit(:conference_id, :limit, :offset)
    end
  end
end
