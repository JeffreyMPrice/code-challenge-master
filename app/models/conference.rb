class Conference < ApplicationRecord
  belongs_to :event
  has_many :speakers
  has_many :attendees

  validates :event, presence: true
  validates :title, presence: true, length: { maximum: 255, minimum: 5 }
  validates :max_attendees, numericality: { only_integer: true, greater_than_or_equal_to: 10 }
  validates :starts_at, presence: true, date: { after: Proc.new{ Time.now } }
  validates :ends_at, presence: true, date: { after: :starts_at }

  after_validation :check_dates

  private

  def check_dates
    unless self.event_id.nil?
      event = Event.where(id: self.event_id).first
      unless event.nil?
        my_start = self.starts_at.to_i
        my_end = self.ends_at.to_i
        event_start = event.starts_at.to_i
        event_end = event.ends_at.to_i

        ## starts_at should be after event starts_at and before event ends_at
        errors.add(:starts_at, I18n.translate('errors.date.before_event_start')) if my_start < event_start
        errors.add(:starts_at, I18n.translate('errors.date.after_event_end')) if my_start > event_end

        ## ends_at should be before event ends_at
        errors.add(:ends_at, I18n.translate('errors.date.after_event_end')) if my_end > event_end
      end
    end
  end
end
