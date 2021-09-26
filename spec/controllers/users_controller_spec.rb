require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#POST create user' do
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
    end
  end
end
