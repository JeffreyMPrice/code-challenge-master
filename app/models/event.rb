class Event < ApplicationRecord
  has_many :conferences
  has_many :speakers, through: :conferences

  validates :title, presence: true, length: { maximum: 255, minimum: 5 }
  validates :starts_at, presence: true, date: { after: Proc.new{ Time.now } }
  validates :ends_at, presence: true, date: { after: :starts_at }

  def unique_speakers
    @unique_speakers ||= speakers.group(:email)
  end

  def unique_speakers_count
    # moved this into a helper function because size and count return group information
    unique_speakers.length
  end
end
