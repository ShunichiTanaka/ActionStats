require 'rails_helper'

RSpec.describe 'Api Reactions', type: :request do
  def read_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'success', 'reactions', "#{filename}.json")))
  end

  def read_error_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'error', 'reactions', "#{filename}.json")))
  end

  describe '/api/reactions' do
    before do
      User.destroy_all
      Category.destroy_all
      Outcome.destroy_all
      UsersOutcome.destroy_all
      @user = FactoryBot.create :user
      @user.update identifier: 'b1965b2dfd097f66e8a43732a6da31d520180624193513'
      category = FactoryBot.create :category
      @outcomes = (1..30).map { |id| FactoryBot.create :outcome, id: id, category_id: category.id, published: true }
      FactoryBot.create :outcome, id: 31, category_id: category.id
    end

    context '正常系' do
      context 'コメントあり' do
        subject do
          travel_to '2018-01-01 03:00:00' do
            post '/api/reactions', params: read_json_file('with_comments'), as: :json
          end
        end

        it '登録される' do
          FactoryBot.create :users_outcome, user_id: @user.id, outcome_id: @outcomes.first.id, post_date: '2018-01-01', post_time: 2
          expect { subject }.to change(UsersOutcome, :count).by(4)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 0
          data = response_json['data']
          expect(data['genders']).to be_nil
          expect(data['generations']).to be_nil
          expect(data['timing']).to eq '03:00 - 05:59'
          users_outcomes = data['users_outcomes']
          expect(users_outcomes.class).to eq Array
          users_outcome = users_outcomes.first
          expect(users_outcome['outcome_name']).to be_present
          expect(users_outcome['total_count'].class).to eq Integer
          reactions = users_outcome['reactions']
          reaction = reactions.first
          expect(reaction['reaction'].class).to eq Integer
          expect(reaction['percentage']).to eq '100.0'
          comments = users_outcome['comments']
          comment = comments.first
          expect(comment['generation'].class).to eq Integer
          expect(comment['gender'].class).to eq Integer
          expect(comment['prefecture'].class).to eq String
          expect(comment['reaction'].class).to eq Integer
          expect(comment['comment'].class).to eq String
        end
      end

      context 'コメントなし' do
        subject do
          travel_to '2018-01-01 00:00:00' do
            post '/api/reactions', params: read_json_file('no_comments'), as: :json
          end
        end

        it '登録される' do
          expect { subject }.to change(UsersOutcome, :count).by(4)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 0
        end
      end
    end

    context '異常系' do
      context '二重登録' do
        subject do
          travel_to '2018-01-01 04:00:00' do
            post '/api/reactions', params: read_json_file('with_comments'), as: :json
          end
        end

        it '登録されない' do
          FactoryBot.create :users_outcome, user_id: @user.id, outcome_id: @outcomes.first.id, post_date: '2018-01-01', post_time: 3
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 4
        end
      end

      context 'identifierなし' do
        subject do
          travel_to '2018-01-01 00:00:00' do
            post '/api/reactions', params: read_error_json_file('no_identifier'), as: :json
          end
        end

        it '登録されない' do
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context 'outcomes なし' do
        subject do
          travel_to '2018-01-01 00:00:00' do
            post '/api/reactions', params: read_error_json_file('no_outcomes'), as: :json
          end
        end

        it '登録されない' do
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context 'outcome_id なし' do
        subject do
          travel_to '2018-01-01 00:00:00' do
            post '/api/reactions', params: read_error_json_file('no_outcome_id'), as: :json
          end
        end

        it '登録されない' do
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context 'reaction なし' do
        subject do
          travel_to '2018-01-01 00:00:00' do
            post '/api/reactions', params: read_error_json_file('no_reaction'), as: :json
          end
        end

        it '登録されない' do
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end

      context '非公開outcome指定' do
        subject do
          travel_to '2018-01-01 00:00:00' do
            post '/api/reactions', params: read_error_json_file('unpublished_outcome'), as: :json
          end
        end

        it '登録されない' do
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end
    end
  end
end
