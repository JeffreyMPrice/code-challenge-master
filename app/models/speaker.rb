# frozen_string_literal: true

class Speaker < ApplicationRecord
  belongs_to :conference

  validates :conference, presence: true
  validates :full_name, presence: true, length: { maximum: 255 }
  validates :email, email: true
end
