# frozen_string_literal: true

require 'rails_helper'

describe Event do
  describe '#new' do
    it 'creates an Event object' do
      expect(Event.new.class).to be Event
    end
  end
end
