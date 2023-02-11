# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { 'Test Event' }
    description { 'Test case for code challenge' }
    starts_at { Date.tomorrow }
    ends_at { Date.tomorrow + 4.days }
    conferences { [build(:conference)] }

    factory :event_with_many_speakers do
      conferences { [build(:conference_with_many_speakers)] }
    end

    factory :event_with_duplicate_speaker do
      conferences { [build(:conference_with_duplicate_speaker)] }
    end
end
end
