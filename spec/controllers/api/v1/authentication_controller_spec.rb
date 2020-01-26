require 'rails_helper'

describe Api::V1::AuthenticationController, type: :request do

  context 'when user authenticates with success' do
    let (:user) { create(:api_user) }

    it 'returns the token' do
      post '/api/v1/authenticate', params: { email: user.email, password: user.password }

      auth_token = json_response

      expect(auth_token).not_to be_nil
    end
  end
end