require 'faker'

task challenge_setup: :environment do
  Conference.all.each do |c|
    total_attendees = rand(9500..9999)
    puts "Adding #{total_attendees} attendees to conference #{c.id}..."
    (0..total_attendees).each { |idx|
      Attendee.create(
        conference: c,
        full_name: Faker::Name.name,
        email: Faker::Internet.email,
        requires_certification: (idx % 100) == 0 ? true : false
      )
    }
  end
end
