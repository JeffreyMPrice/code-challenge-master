# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Reports::ConferencesController, type: :controller do
  render_views

  describe 'GET /report/conferences/:conference_id/attendees' do
    let(:ends_at) { (DateTime.tomorrow + 1.days).strftime('%FT%T.0000+0000') }
    let(:starts_at) { DateTime.tomorrow.strftime('%FT%T.0000+0000') }

    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'returns all the attendees for a conference' do
      conf = create(:event_with_attendees).conferences.first

      get :attendees, params: { conference_id: conf.id }

      results = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(results['attendees'].size).to eq(4)
      expect(results['conference']['attendees_count']).to eq(4)
      expect(results).to eq(
        { 'attendees' => [{ 'email' => 'test_email_1@test.com',
                            'full_name' => 'Attendee 1',
                            'requires_certification' => false },
                          { 'email' => 'test_email_2@test.com',
                            'full_name' => 'Attendee 2',
                            'requires_certification' => false },
                          { 'email' => 'test_email_3@test.com',
                            'full_name' => 'Attendee 3',
                            'requires_certification' => false },
                          { 'email' => 'test_email_4@test.com',
                            'full_name' => 'Attendee 4',
                            'requires_certification' => false }],
          'conference' => { 'attendees_count' => 4,
                            'description' => 'This is a FactorBoy Conference',
                            'ends_at' => ends_at.to_s,
                            'starts_at' => starts_at.to_s,
                            'title' => 'Test Data Load Conference' } }
      )
    end

    it 'returns only some of the records based on pagination' do
        conf = create(:event_with_attendees).conferences.first
        attendees = conf.attendees

        get :attendees, params: { conference_id: conf.id, limit: 1 }

        results = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(results['attendees'].size).to eq(1)
        expect(results['conference']['attendees_count']).to eq(4)
        expect(results).to eq(
          { 'attendees' => [{ 'email' => attendees.first.email,
                              'full_name' => attendees.first.full_name,
                              'requires_certification' => attendees.first.requires_certification}],
            'conference' => { 'attendees_count' => attendees.count,
                              'description' => conf.description,
                              'ends_at' => ends_at.to_s,
                              'starts_at' => starts_at.to_s,
                              'title' => conf.title } }
        )
    end
  end
end
