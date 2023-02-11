# frozen_string_literal: true

FactoryBot.define do
  factory :attendee do
    sequence(:full_name) { |n| "Attendee #{n}" }
    sequence(:email) { |n| "test_email_#{n}@test.com" }
  end
end
