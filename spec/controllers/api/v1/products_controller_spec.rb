require 'rails_helper'

describe Api::V1::ProductsController, type: :request do
  describe '#search' do
    context 'when searching for a given term' do
      let (:user) { create(:api_user) }

      before do
        create_products
      end

      it 'returns a list of the target products' do
        post '/api/v1/products/search', params: {text: 'Asics'}
  
        response = json_response

        expect(response).not_to be_nil

        data = response[:data]

        expect(data).not_to be_nil
        expect(data.size).to eq 3
      end
    end

    context 'when searching for an empty term' do
      let (:user) { create(:api_user) }

      before do
        create_products
      end

      it 'returns all products available' do
        post '/api/v1/products/search', params: {text: ''}
  
        response = json_response
  
        expect(response).not_to be_nil

        data = response[:data]

        expect(data).not_to be_nil

        expect(data.size).to eq 3
      end
    end

    context 'when searching for a term that does not match' do
      let (:user) { create(:api_user) }

      before do
        create_products
      end

      it 'returns an empty list of products' do
        post '/api/v1/products/search', params: {text: 'hal 9000'}
  
        response = json_response

        data = response[:data]

        expect(data).not_to be_nil
        expect(data.size).to eq 0
      end
    end

    context 'when search raises and error' do
      let (:user) { create(:api_user) }
      let (:term) { 'asic' }

      before do
        create_products
      end

      it 'returns an response error' do
        allow(Api::V1::Products::Search).to receive(:call).with(term, {}).and_raise(Errors::StandardError.new)

        post '/api/v1/products/search', params: {text: term}

        response = json_response

        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_nil
        expect(errors.size).to eq 1
        expect(errors.first[:title]).to eq 'Something went wrong'
      end
    end
  end
end