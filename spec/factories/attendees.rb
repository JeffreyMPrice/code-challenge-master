# frozen_string_literal: true

FactoryBot.define do
  sequence(:full_name) { |n| "Attendee #{n}" }
  sequence(:email) { |n| "test_email_#{n}@test.com" }

  factory :attendee do
    email { generate :email }
    full_name { generate :full_name }

    factory :attendee_dupe do
      full_name { 'Attendee 1' }
      email { 'test_email_1@test.com' }
    end
  end
end
