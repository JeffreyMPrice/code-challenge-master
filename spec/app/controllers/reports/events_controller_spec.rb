# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Reports::EventsController, type: :controller do
  render_views

  describe 'GET speakers' do
    let(:ends_at) { (DateTime.tomorrow + 4.days).strftime('%FT%T.0000+0000') }
    let(:starts_at) { DateTime.tomorrow.strftime('%FT%T.0000+0000') }

    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'handes events with only one speaker' do
      expected = { 'event' => { 'description' => 'Test case for code challenge', 'ends_at' => ends_at.to_s, 'speakers_total' => 1, 'starts_at' => starts_at.to_s, 'title' => 'Test Event' },
                   'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker',
                                    'job_title' => 'CEO' }] }

      event = create(:event)

      get :speakers, params: { event_id: event.id }

      expect(JSON.parse(response.body)).to eq expected
    end

    it 'handles events with more than one speaker' do
      expected = { 'event' => { 'description' => 'Test case for code challenge', 'ends_at' => ends_at.to_s, 'speakers_total' => 2, 'starts_at' => starts_at.to_s, 'title' => 'Test Event' },
                   'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker', 'job_title' => 'CEO' },
                                  { 'company' => 'Test Company', 'email' => 'test_speaker@email.com', 'full_name' => 'Test Speaker',
                                    'job_title' => 'CTO' }] }

      event = create(:event_with_many_speakers)

      get :speakers, params: { event_id: event.id }

      expect(JSON.parse(response.body)).to eq expected
    end

    it 'handles duplicate speakers by showing only one per email' do
      expected = { 'event' => { 'description' => 'Test case for code challenge', 'ends_at' => ends_at.to_s, 'speakers_total' => 1, 'starts_at' => starts_at.to_s, 'title' => 'Test Event' },
                   'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker',
                                    'job_title' => 'CEO' }] }

      event = create(:event_with_duplicate_speaker)

      get :speakers, params: { event_id: event.id }

      expect(JSON.parse(response.body)).to eq expected
    end

    it 'handles events with many conferences, removing duplicate speakers' do
      expected = { 'event' => { 'description' => 'Test case for code challenge', 'ends_at' => ends_at.to_s, 'speakers_total' => 2, 'starts_at' => starts_at.to_s, 'title' => 'Test Event' },
                   'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker', 'job_title' => 'CEO' },
                                  { 'company' => 'Test Company', 'email' => 'test_speaker@email.com', 'full_name' => 'Test Speaker',
                                    'job_title' => 'CTO' }] }

      event = create(:event_with_many_speakers)

      get :speakers, params: { event_id: event.id }

      expect(JSON.parse(response.body)).to eq expected
    end
  end

  describe 'GET attendees' do
    let(:ends_at) { (DateTime.tomorrow + 4.days).strftime('%FT%T.0000+0000') }
    let(:starts_at) { DateTime.tomorrow.strftime('%FT%T.0000+0000') }

    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'shows all attendees for an event' do
      event = create(:event)

      get :attendees, params: { event_id: event.id }

      expect(response).to have_http_status(:success)
    end
  end
end
# rubocop:enable Metrics/BlockLength
