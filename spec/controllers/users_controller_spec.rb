require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#POST create user' do
    context 'params is valid' do
      it 'create new user' do
        expect do
          post :create, params: {
            user: {
              name: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password
            }
          }
        end.to change { User.count }.by(1)

        expect(response.status).to eq(201)
      end
    end

    context 'email is invalid' do
      it 'returns error' do
        post :create, params: {
          user: {
            name: Faker::Name.name,
            email: nil,
            password: Faker::Internet.password
          }
        }

        json_resonse = JSON.parse(response.body)['errors']

        expect(response.status).to eq(422)
        expect(json_resonse).to include("Email can't be blank")
        expect(json_resonse).to include('Email is invalid')
      end
    end

    context 'password is invalid' do
      it 'returns error' do
        post :create, params: {
          user: {
            name: Faker::Name.name,
            email: Faker::Internet.email,
            password: '12345'
          }
        }

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['errors']).to include('Password is too short (minimum is 6 characters)')
      end
    end
  end
end
