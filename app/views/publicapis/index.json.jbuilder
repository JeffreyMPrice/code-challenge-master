# frozen_string_literal: true

json.categories @categorized_entries do |category, entries|
  json.set! category, entries
end
