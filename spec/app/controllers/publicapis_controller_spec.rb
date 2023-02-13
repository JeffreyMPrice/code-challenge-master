# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength, Layout/LineLength:
RSpec.describe PublicapisController, type: :controller do
  render_views

  describe 'GET index' do
    it 'gets data from public apis' do
      response_dbl = instance_double('Faraday::Response')

      allow(Faraday).to receive(:get)
                    .with('https://api.publicapis.org/entries?auth=apiKey')
        .and_return(response_dbl)

      allow(response_dbl).to receive(:body)
        .and_return('{"entries": [
            {
            "API": "AdoptAPet",
            "Description": "Resource to help get pets adopted",
            "Auth": "apiKey",
            "HTTPS": true,
            "Cors": "yes",
            "Link": "https://www.adoptapet.com/public/apis/pet_list.html",
            "Category": "Animals"
            },
            {
            "API": "Axolotl",
            "Description": "Collection of axolotl pictures and facts",
            "Auth": "",
            "HTTPS": true,
            "Cors": "no",
            "Link": "https://theaxolotlapi.netlify.app/",
            "Category": "Animals"
            },
            {
            "API": "Walltime",
            "Description": "To retrieve Walltime\'s market info",
            "Auth": "",
            "HTTPS": true,
            "Cors": "unknown",
            "Link": "https://walltime.info/api.html",
            "Category": "Blockchain"
            },
            {
            "API": "Watchdata",
            "Description": "Provide simple and reliable API access to Ethereum blockchain",
            "Auth": "apiKey",
            "HTTPS": true,
            "Cors": "unknown",
            "Link": "https://docs.watchdata.io",
            "Category": "Blockchain"
            }]}')

      get :index

      results = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(results).to eq(
        {
          'categories' => [{ 'Animals' => [{ 'API' => 'AdoptAPet', 'Auth' => 'apiKey', 'Category' => 'Animals', 'Cors' => 'yes', 'Description' => 'Resource to help get pets adopted', 'HTTPS' => true, 'Link' => 'https://www.adoptapet.com/public/apis/pet_list.html' },
                                           { 'API' => 'Axolotl', 'Auth' => '', 'Category' => 'Animals', 'Cors' => 'no', 'Description' => 'Collection of axolotl pictures and facts', 'HTTPS' => true,
                                             'Link' => 'https://theaxolotlapi.netlify.app/' }] },
                           { 'Blockchain' => [{ 'API' => 'Walltime', 'Auth' => '', 'Category' => 'Blockchain', 'Cors' => 'unknown', 'Description' => "To retrieve Walltime's market info", 'HTTPS' => true, 'Link' => 'https://walltime.info/api.html' },
                                              { 'API' => 'Watchdata', 'Auth' => 'apiKey', 'Category' => 'Blockchain', 'Cors' => 'unknown',
                                                'Description' => 'Provide simple and reliable API access to Ethereum blockchain', 'HTTPS' => true, 'Link' => 'https://docs.watchdata.io' }] }]
        }
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength, Layout/LineLength:
