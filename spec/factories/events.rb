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

    factory :event_with_many_conferences do
      conferences { [build(:conference), build(:event_with_many_speakers), build(:conference_with_duplicate_speaker)] }
    end

    factory :event_with_attendees do
      conferences { [build(:conference_with_attendees)] }
    end

    factory :event_with_conferences_and_attendees do
      conferences do
        [build(:conference_with_attendees),
         build(:conference_with_attendees)]
      end
    end

    factory :event_with_conferences_and_duplicate_attendees do
      conferences do
        [build(:conference_with_attendees),
         build(:conference_with_repeat_attendees),
         build(:conference_with_repeat_attendees)]
      end
    end
  end
end
