require 'spec_helper'
require 'rails_helper'

describe ApplicationHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }

  describe 'back end base url' do
    context 'production' do
      it 'returns heroku url' do
        allow(Rails).to receive(:env) { 'production'.inquiry }

        expect(helper.backend_base_url).to eq('https://shortenurlbe.herokuapp.com')
      end
    end

    context 'development' do
      it 'returns localhost url' do
        allow(Rails).to receive(:env) { 'development'.inquiry }

        expect(helper.backend_base_url).to eq('http://localhost:3000')
      end
    end
  end

  describe 'front end base url' do
    context 'production' do
      it 'returns heroku url' do
        allow(Rails).to receive(:env) { 'production'.inquiry }

        expect(helper.frontend_base_url).to eq('https://blooming-badlands-76554.herokuapp.com')
      end
    end

    context 'development' do
      it 'returns localhost url' do
        allow(Rails).to receive(:env) { 'development'.inquiry }

        expect(helper.frontend_base_url).to eq('http://localhost:3001')
      end
    end
  end
end
