# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::ConferencesController, type: :controller do
  render_views

  describe 'GET attendees' do
    let(:ends_at) { (DateTime.tomorrow + 1.days).strftime('%FT%T.0000+0000') }
    let(:starts_at) { DateTime.tomorrow.strftime('%FT%T.0000+0000') }

    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'returns all the attendees for a conference' do
      expected_conf = { 'attendees_count' => 50, 'description' => 'This is a FactorBoy Conference',
                        'ends_at' => ends_at.to_s, 'starts_at' => starts_at.to_s, 'title' => 'Test Data Load Conference' }

      conf = create(:event_with_attendees).conferences.first

      get :attendees, params: { conference_id: conf.id }

      results = JSON.parse(response.body)
      expect(results['conference']).to eq expected_conf
      expect(results['attendees'].size).to eq conf.attendees.count
    end
  end
end
