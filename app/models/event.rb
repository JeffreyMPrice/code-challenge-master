class Event < ApplicationRecord
  has_many :conferences
  has_many :speakers, through: :conferences

  validates :title, presence: true, length: { maximum: 255, minimum: 5 }
  validates :starts_at, presence: true, date: { after: Proc.new{ Time.now } }
  validates :ends_at, presence: true, date: { after: :starts_at }
end
