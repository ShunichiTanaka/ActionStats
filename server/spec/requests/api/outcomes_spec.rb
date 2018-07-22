require 'rails_helper'

RSpec.describe 'Api Outcomes', type: :request do
  def read_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'success', 'outcomes', "#{filename}.json")))
  end

  def read_error_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'error', 'outcomes', "#{filename}.json")))
  end

  describe '/api/outcomes' do
    before :all do
      User.destroy_all
      Category.destroy_all
      Outcome.destroy_all
      @user = FactoryBot.create :user
      @user.update identifier: 'b1965b2dfd097f66e8a43732a6da31d520180624193513'
      @categories = FactoryBot.create_list :category, 5
      @outcomes   = FactoryBot.create_list :outcome, 30, category: @categories.first
    end

    context '正常系' do
      subject do
        post '/api/outcomes', params: read_json_file('normal'), as: :json
      end

      it '取得される' do
        subject
        expect(response).to be_successful
        response_json = JSON.parse(response.body)
        expect(response_json['status']).to eq 0
        outcomes = response_json['data']
        expect(outcomes.class).to eq Array
        expect(outcomes.count).to eq @outcomes.count
        outcome = outcomes.first
        expect(outcome['id'].class).to eq Integer
        expect(outcome['id']).to eq @outcomes.first.id
        expect(outcome['name']).to be_present
        expect(outcome['name'].class).to eq String
        expect(outcome['r']).to be_present
        expect(outcome['r'].class).to eq Integer
        expect(outcome['g']).to be_present
        expect(outcome['g'].class).to eq Integer
        expect(outcome['b']).to be_present
        expect(outcome['b'].class).to eq Integer
        expect(outcome['name']).to eq @outcomes.first.name
      end
    end

    context '異常系' do
      context '未登録' do
        subject do
          post '/api/outcomes', params: read_error_json_file('unregistered_identifier'), as: :json
        end

        it '取得されない' do
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 3
          expect(response_json['data']).to be_blank
        end
      end

      context 'identifier なし' do
        subject do
          post '/api/outcomes', params: read_error_json_file('invalid_identifier'), as: :json
        end

        it '取得されない' do
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
          expect(response_json['data']).to be_blank
        end
      end
    end
  end
end
