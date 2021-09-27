require 'rails_helper'

RSpec.describe ClicksController, type: :controller do
  describe '#GET show' do
    let(:user) { FactoryBot.create(:user) }
    let(:link) { FactoryBot.create(:link, user: user) }

    context 'slug is invalid' do
      it 'redirect to origin url' do
        get :show, params: { slug: link.slug }

        expect(response).to redirect_to(link.url)
      end
    end

    context 'slug is invalid' do
      it 'redirect to origin url' do
        get :show, params: { slug: 'invalidslug' }

        expect(response).to redirect_to('http://localhost:3001/not_found')
      end
    end
  end
end
