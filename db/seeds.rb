# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
event = Event.create(title: "Test Event", description: "Demo event for code challenge", starts_at: Date.tomorrow, ends_at: Date.today + 5.days)
conference = Event.last.conferences.create(title: "Initial Data Load conference", max_attendees: 500, starts_at: Date.tomorrow, ends_at: Date.tomorrow + 1.days)
conference.speakers.create(full_name: "Demo Speaker", email: "demo_speaker@email.com", company: "Test Company", job_title: "CEO")
conference.speakers.create(full_name: "Demo Speaker", email: "demo_speaker@email.com", company: "Test Company", job_title: "CEO")

1.upto(499) do |counter|
  conference.attendees.create(full_name: "Conference #{counter}", email: "test_email_#{counter}@test.com")
end