# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Reports::EventsController, type: :controller do
  render_views

  describe 'GET speakers' do
    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'handes events with only one speaker' do
      event = create(:event)

      get :speakers, params: { event_id: event.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        { 'event' => { 'title' => event.title,
                       'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000') },
          'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker',
                           'job_title' => 'CEO' }] }
      )
    end

    it 'handles events with more than one speaker' do
      event = create(:event_with_many_speakers)

      get :speakers, params: { event_id: event.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        {
          'event' => { 'title' => event.title,
                       'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000') },
          'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker', 'job_title' => 'CEO' },
                         { 'company' => 'Test Company', 'email' => 'test_speaker@email.com', 'full_name' => 'Test Speaker',
                           'job_title' => 'CTO' }]
        }
      )
    end

    it 'handles duplicate speakers by showing only one per email' do
      event = create(:event_with_duplicate_speaker)

      get :speakers, params: { event_id: event.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        { 'event' => { 'title' => event.title,
                       'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000') },
          'speakers' => [{ 'company' => 'Test Company', 'email' => 'demo_speaker@email.com', 'full_name' => 'Demo Speaker',
                           'job_title' => 'CEO' }] }
      )
    end

    it 'handles events with many conferences, removing duplicate speakers' do
      event = create(:event_with_many_speakers)

      get :speakers, params: { event_id: event.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        { 'event' => { 'title' => event.title,
                       'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000') },
          'speakers' => [{ 'company' => 'Test Company',
                           'email' => 'demo_speaker@email.com',
                           'full_name' => 'Demo Speaker',
                           'job_title' => 'CEO' },
                         { 'company' => 'Test Company',
                           'email' => 'test_speaker@email.com',
                           'full_name' => 'Test Speaker',
                           'job_title' => 'CTO' }] }
      )
    end
  end

  describe 'GET attendees' do
    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'shows all attendees for an event' do
      event = create(:event_with_conferences_and_attendees)
      expected_attendees = event.unique_attendees.map do |a|
        { 'email' => a.email,
          'full_name' => a.full_name,
          'requires_certification' => a.requires_certification }
      end

      get :attendees, params: { event_id: event.id }

      results = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(results.dig('event', 'attendees_total')).to eq 8
      expect(results).to eq(
        {
          'event' => { 'title' => event.title,
                       'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000') },
          'attendees' => expected_attendees
        }
      )
    end

    it 'shows all attendees with duplicates removed for an event' do
      event = create(:event_with_conferences_and_duplicate_attendees)

      expect(event.attendees.count).not_to eq event.unique_attendees_count

      expected_attendees = event.unique_attendees.map do |a|
        { 'email' => a.email,
          'full_name' => a.full_name,
          'requires_certification' => a.requires_certification }
      end

      get :attendees, params: { event_id: event.id }

      results = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(results.dig('event', 'attendees_total')).to eq(event.unique_attendees_count)
      expect(results).to eq(
        {
          'event' => { 'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000'),
                       'title' => event.title },
          'attendees' => expected_attendees
        }
      )
    end
  end

  describe 'GET index' do
    before(:all) do
      # on the very slight chance we are working near midmidnight and the days turns over
      # between creating the expected and the factory generation
      Timecop.freeze
    end

    it 'shows complete information for event' do
      event = create(:event_with_conferences_and_attendees)
      expected_conferences = event.conferences.map do |c|
        expected_speakers = c.unique_speakers.map do |s|
          {
            'full_name' => s.full_name,
            'email' => s.email,
            'company' => s.company,
            'job_title' => s.job_title
          }
        end
        {
          'title' => c.title,
          'description' => c.description,
          'ends_at' => c.ends_at.strftime('%FT%T.0000+0000'),
          'starts_at' => c.starts_at.strftime('%FT%T.0000+0000'),
          'attendees_count' => c.attendees.count,
          'speakers_count' => expected_speakers.count,
          'speakers' => expected_speakers
        }
      end

      get :index, params: { event_id: event.id }

      results = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(results).to eq(
        {
          'event' => { 'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000'),
                       'title' => event.title,
                       'conferences' => expected_conferences }
        }
      )
    end

    it 'shows complete information for an event with duplicates speakers and attendees removed' do
      event = create(:event_with_conferences_and_duplicate_attendees_and_spakers)
      expected_conferences = event.conferences.map do |c|
        expected_speakers = c.unique_speakers.map do |s|
          {
            'full_name' => s.full_name,
            'email' => s.email,
            'company' => s.company,
            'job_title' => s.job_title
          }
        end
        {
          'title' => c.title,
          'description' => c.description,
          'ends_at' => c.ends_at.strftime('%FT%T.0000+0000'),
          'starts_at' => c.starts_at.strftime('%FT%T.0000+0000'),
          'attendees_count' => c.attendees.count,
          'speakers_count' => expected_speakers.count,
          'speakers' => expected_speakers
        }
      end

      expect(event.speakers).not_to eq(event.unique_attendees_count)
      expect(event.attendees).not_to eq(event.unique_speakers_count)

      get :index, params: { event_id: event.id }

      results = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(results.dig('event', 'attendees_total')).to eq(event.unique_attendees_count)
      expect(results.dig('event', 'speakers_total')).to eq(event.unique_speakers_count)
      expect(results).to eq(
        {
          'event' => { 'description' => event.description,
                       'speakers_total' => event.unique_speakers_count,
                       'attendees_total' => event.unique_attendees_count,
                       'starts_at' => event.starts_at.strftime('%FT%T.0000+0000'),
                       'ends_at' => event.ends_at.strftime('%FT%T.0000+0000'),
                       'title' => event.title,
                       'conferences' => expected_conferences }
        }
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength
