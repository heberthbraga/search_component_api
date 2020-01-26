require 'rails_helper'

describe Authentication::Authenticate, type: :service do

  context 'when user does not exist' do
    let(:email) { Faker::Name.first_name }
    let(:password) { Faker::Internet.password(min_length:8) }

    it 'return errors' do
      command = described_class.call(email, password)

      expect(command.errors).not_to be_empty
      expect(command.result).to be_nil
    end
  end

  context 'when user exists' do
    let(:user) { create(:api_user) }

    it 'returns a valid token' do
      command = described_class.call(user.email, user.password)

      expect(command.result).not_to be_nil
    end
  end

end