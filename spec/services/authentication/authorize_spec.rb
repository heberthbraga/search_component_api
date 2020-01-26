require 'rails_helper'

describe Authentication::Authorize, type: :service do

  let(:user) { create(:api_user) }

  before do
    @auth_command = Authentication::Authenticate.call(user.email, user.password)

    expect(@auth_command).not_to be_nil
  end

  context 'when there is a missing token' do
    it 'return errors' do
      command = described_class.call({})

      expect(command.errors).not_to be_empty
      expect(command.errors[:token]).not_to be_nil
      expect(command.errors[:token].first).to eq 'Missing Token'
      expect(command.result).to be_nil
    end
  end

  context 'when user is authorized with success' do
    it 'returns the current user' do
      command = described_class.call({'Authorization' => @auth_command.result})

      authenticated_user = command.result

      expect(authenticated_user).not_to be_nil
      expect(authenticated_user.email).to eq user.email
    end
  end

end