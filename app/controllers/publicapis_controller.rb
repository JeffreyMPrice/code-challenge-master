# frozen_string_literal: true

require 'faraday'

class PublicapisController < ::ApplicationController
  def index
    # make call out to publicapis.org with

    response = Faraday.get('https://api.publicapis.org/entries?auth=apiKey')

    results = JSON.parse(response.body)
    @categorized_entries = group_entries(results['entries'])
  end

  private

  def group_entries(entries)
    groups = {}
    entries.each do |e|
      cat = e['Category']
      if groups[cat].present?
        groups[cat] << e
      else
        groups[cat] = [e]
      end
    end
    groups
  end
end
