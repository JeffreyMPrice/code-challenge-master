# frozen_string_literal: true

FactoryBot.define do
  factory :speaker, aliases: [:speaker_demo] do
    full_name { 'Demo Speaker' }
    email { 'demo_speaker@email.com' }
    company { 'Test Company' }
    job_title { 'CEO' }

    factory :speaker_test do
      full_name { 'Test Speaker' }
      email { 'test_speaker@email.com' }
      company { 'Test Company' }
      job_title { 'CTO' }
    end
  end
end
