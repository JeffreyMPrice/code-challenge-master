# frozen_string_literal: true

FactoryBot.define do
  factory :conference do
    title { 'Test Data Load Conference' }
    max_attendees { 500 }
    starts_at { Date.tomorrow }
    ends_at { Date.tomorrow + 1.day }
    speakers { [build(:speaker)] }

    factory :conference_with_many_speakers do
      speakers { [build(:speaker_demo), build(:speaker_test)] }
    end

    factory :conference_with_duplicate_speaker do
      speakers { [build(:speaker_demo), build(:speaker_demo)] }
    end
  end
end
