require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe '#POST create shorten link' do
    context 'success' do
      it 'create new link' do
        valid_url = 'https://google.com/waterfall'

        expect do
          post :create, params: { link: { url: valid_url } }
        end.to change { Link.count }.by(1)

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['data']['url']).to eq(valid_url)
      end

      context 'failed' do
        it 'returns error' do
          invalid_url = 'www://google.com/waterfall'

          expect do
            post :create, params: { link: { url: invalid_url } }
          end.to change { Link.count }.by(0)

          json_response = JSON.parse(response.body)

          expect(json_response['status']).to eq(422)
          expect(json_response['error']).to eq(['Url is invalid'])
        end
      end
    end
  end
end
