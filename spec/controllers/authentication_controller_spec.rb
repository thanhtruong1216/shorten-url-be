require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe '#POST create user' do
    let(:user) { FactoryBot.create(:user) }

    context 'success' do
      it 'returns JWT token' do
        post :login, params: { user: { email: user.email, password: user.password } }

        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response['token'].present?).to eq(true)
        expect(json_response['name']).to eq(user.name)
      end
    end

    context 'failed' do
      it 'returns error' do
        post :login, params: { user: { email: Faker::Internet.email, password: user.password } }

        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)['errors']).to eq(['Invalid email or password'])
      end
    end
  end
end
