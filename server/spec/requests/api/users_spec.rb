require 'rails_helper'

RSpec.describe 'Api Users', type: :request do
  def read_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'success', 'users', "#{filename}.json")))
  end

  def read_error_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'error', 'users', "#{filename}.json")))
  end

  describe '/api/users' do
    context '正常系' do
      subject do
        travel_to '2018-01-01' do
          post '/api/users', params: read_json_file('normal'), as: :json
        end
      end

      it '登録される' do
        expect { subject }.to change(User, :count).by(1)
        expect(response).to be_successful
        response_json = JSON.parse(response.body)
        expect(response_json['status']).to eq 0
        identifier = response_json['data']
        expect(identifier).to be_present
        expect(identifier.class).to be String
        user = User.last
        expect(user.male?).to be true
        expect(user.year_of_birth).to eq 2018
        expect(user.tokyo?).to be true
        expect(user.identifier).to eq identifier
      end
    end

    context '異常系' do
      context '性別不正' do
        subject do
          post '/api/users', params: read_error_json_file('invalid_gender'), as: :json
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 1
        end
      end

      context '生年不正' do
        subject do
          travel_to '2018-01-01' do
            post '/api/users', params: read_error_json_file('invalid_year_of_birth'), as: :json
          end
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context '生年不正' do
        subject do
          post '/api/users', params: read_error_json_file('invalid_year_of_birth_unnumeric'), as: :json
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context '都道府県不正' do
        subject do
          post '/api/users', params: read_error_json_file('invalid_prefecture'), as: :json
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 1
        end
      end

      context '性別なし' do
        subject do
          post '/api/users', params: read_error_json_file('no_gender'), as: :json
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context '生年なし' do
        subject do
          post '/api/users', params: read_error_json_file('no_year_of_birth'), as: :json
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context '都道府県なし' do
        subject do
          post '/api/users', params: read_error_json_file('no_prefecture'), as: :json
        end

        it '登録されない' do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end
    end
  end
end
