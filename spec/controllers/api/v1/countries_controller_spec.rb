require 'rails_helper'

describe Api::V1::CountriesController, type: :request do
  describe '#index' do
    context 'when fetching countries' do
      before do
        create_countries
      end

      it 'returns a list of the existing countries' do
        get '/api/v1/countries'
  
        response = json_response
  
        expect(response).not_to be_nil
        expect(response.size).to eq 2
      end
    end
  end
end