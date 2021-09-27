require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe '#GET index' do
    let(:user) { FactoryBot.create(:user) }
    let!(:link1) { FactoryBot.create(:link, user: user) }
    let!(:link2) { FactoryBot.create(:link, user: user) }

    before do
      allow(controller).to receive(:authorize_request)
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'returns list of links' do
      get :index

      expect(response.status).to eq(200)
      expect(Link.pluck(:id)).to match_array [link1.id, link2.id]
    end
  end

  describe '#POST create shorten link' do
    let!(:user) { FactoryBot.create(:user) }

    before do
      allow(controller).to receive(:authorize_request)
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'success' do
      it 'create new link' do
        valid_url = Faker::Internet.url

        expect do
          post :create, params: { link: { url: valid_url, user_id: user.id } }
        end.to change { Link.count }.by(1)

        expect(response.status).to eq(200)
      end

      context 'failed' do
        it 'returns error' do
          expect do
            post :create, params: { link: { url: '//google.com/waterfall' } }
          end.to change { Link.count }.by(0)

          json_response = JSON.parse(response.body)

          expect(json_response['status']).to eq(422)
          expect(json_response['errors']).to eq(['Url is invalid'])
        end
      end
    end
  end

  describe '#UPDATE slug' do
    let(:user) { FactoryBot.create(:user) }
    let(:link) { FactoryBot.create(:link, user: user) }

    before { allow(controller).to receive(:authorize_request) }

    context 'params is valid' do
      it 'update slug' do
        put :update, params: { link: { slug: 'winter' }, id: link.id }

        expect(response.status).to eq(200)
        expect(link.reload.slug).to eq('winter')
      end
    end

    context 'params is invalid' do
      it 'cannot update slug' do
        put :update, params: { link: { slug: '12345678910' }, id: link.id }

        expect(link.slug).to eq(link.slug)
        expect(JSON.parse(response.body)['errors']).to eq(['Slug is too long (maximum is 9 characters)'])
        expect(JSON.parse(response.body)['status']).to eq(422)
      end
    end
  end

  describe '#DELETE url' do
    before { allow(controller).to receive(:authorize_request) }

    it 'delete an url' do
      user = FactoryBot.create(:user)
      link = FactoryBot.create(:link, user: user)

      expect do
        delete :destroy, params: { id: link.id }
      end.to change { Link.count }.by(-1)

      expect(JSON.parse(response.body)['message']).to eq('Url destroyed')
      expect(JSON.parse(response.body)['status']).to eq(200)
    end
  end
end
