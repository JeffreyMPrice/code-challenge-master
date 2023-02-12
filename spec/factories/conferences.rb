# frozen_string_literal: true

FactoryBot.define do
  factory :conference do
    title { 'Test Data Load Conference' }
    description { 'This is a FactorBoy Conference' }
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

    factory :conference_with_attendees do
      attendees { build_list :attendee, 4 }
    end

    factory :conference_with_repeat_attendees do
      attendees { build_list :attendee_dupe, 1 }
    end
  end
end
