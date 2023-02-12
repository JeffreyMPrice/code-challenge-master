# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :conferences
  has_many :speakers, through: :conferences

  validates :title, presence: true, length: { maximum: 255, minimum: 5 }
  validates :starts_at, presence: true, date: { after: proc { Time.now } }
  validates :ends_at, presence: true, date: { after: :starts_at }

  def unique_speakers
    @unique_speakers ||= speakers.group(:email)
  end

  def unique_speakers_count
    # moved this into a helper function because size and count return group information
    unique_speakers.length
  end

  def attendees
    @attendees ||= Attendee.joins(:conference).where(conferences: {event_id: id})
  end

  def unique_attendees
    @unique_attendees ||= Attendee.joins(:conference).where(conferences: {event_id: id}).group(:email)
  end

  def unique_attendees_count
    unique_attendees.length
  end

end
