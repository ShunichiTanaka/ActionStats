require 'rails_helper'

RSpec.describe 'Api Reactions', type: :request do
  def read_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'success', 'users_outcomes', "#{filename}.json")))
  end

  def read_error_json_file(filename)
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'jsons', 'error', 'users_outcomes', "#{filename}.json")))
  end

  describe '/api/users_outcomes' do
    before do
      User.destroy_all
      Category.destroy_all
      Outcome.destroy_all
      UsersOutcome.destroy_all
      @user = FactoryBot.create :user, gender: :male, prefecture: :tokyo, year_of_birth: 1998 # 10代
      @user.update identifier: 'b1965b2dfd097f66e8a43732a6da31d520180624193513'
      @other1 = FactoryBot.create :user, gender: :female, prefecture: :kanagawa, year_of_birth: 1997 # 20代
      @other2 = FactoryBot.create :user, gender: :male, prefecture: :saitama, year_of_birth: 1988 # 20代
      @other3 = FactoryBot.create :user, gender: :female, prefecture: :hokkaido, year_of_birth: 1987 # 30代
      category = FactoryBot.create :category
      @outcomes = (1..30).map do |id|
        FactoryBot.create :outcome, id: id, category: category, display_order: (31 - id), name: "行動#{id}"
      end
    end

    context '正常系' do
      before do
        FactoryBot.create :users_outcome, user: @user,   outcome: @outcomes.first,  post_date: '2018-01-01', post_time: 3, reaction: 1, comment: 'A'
        FactoryBot.create :users_outcome, user: @other1, outcome: @outcomes.first,  post_date: '2018-01-01', post_time: 3, reaction: 2
        FactoryBot.create :users_outcome, user: @other2, outcome: @outcomes.first,  post_date: '2018-01-01', post_time: 3, reaction: 3, comment: 'B'
        FactoryBot.create :users_outcome, user: @other3, outcome: @outcomes.first,  post_date: '2018-01-01', post_time: 2, reaction: 4, comment: 'C'
        FactoryBot.create :users_outcome, user: @user,   outcome: @outcomes.last,   post_date: '2018-01-01', post_time: 3, reaction: 1, comment: 'D'
        FactoryBot.create :users_outcome, user: @other1, outcome: @outcomes.last,   post_date: '2018-01-01', post_time: 3, reaction: 2, comment: 'E'
        FactoryBot.create :users_outcome, user: @other2, outcome: @outcomes.last,   post_date: '2018-01-01', post_time: 3, reaction: 3, comment: 'F'
        FactoryBot.create :users_outcome, user: @other3, outcome: @outcomes.last,   post_date: '2018-01-01', post_time: 3, reaction: 4, comment: 'G'
        FactoryBot.create :users_outcome, user: @user,   outcome: @outcomes.second, post_date: '2018-01-01', post_time: 3, reaction: 4, comment: 'G'
      end

      context '絞り込みなし' do
        subject do
          travel_to '2018-01-01 04:00:00' do
            post '/api/users_outcomes', params: read_json_file('normal'), as: :json
          end
        end

        it '取得される' do
          expect { subject }.to change(UsersOutcome, :count).by(0)
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 0
          data = response_json['data']
          expect(data['genders']).to be_nil
          expect(data['generations']).to be_nil
          expect(data['timing']).to eq '03:00 - 05:59'
          users_outcomes = data['users_outcomes']
          expect(users_outcomes.count).to eq 3

          users_outcome = users_outcomes.first
          expect(users_outcome['outcome_name']).to eq '行動30'
          expect(users_outcome['total_count']).to eq 4
          reactions = users_outcome['reactions']
          expect(reactions.count).to eq 4
          reaction = reactions.first
          expect(reaction['reaction']).to eq 1
          expect(reaction['percentage']).to eq '25.0'
          comments = users_outcome['comments']
          expect(comments.count).to eq 4
          comment = comments[0]
          expect(comment['generation']).to eq 30
          comment = comments[1]
          expect(comment['generation']).to eq 20
          comment = comments[2]
          expect(comment['generation']).to eq 20
          comment = comments[3]
          expect(comment['generation']).to eq 10

          users_outcome = users_outcomes.last
          expect(users_outcome['outcome_name']).to eq '行動1'
          expect(users_outcome['total_count']).to eq 3
          reactions = users_outcome['reactions']
          expect(reactions.count).to eq 3
          reaction = reactions.first
          expect(reaction['reaction']).to eq 1
          expect(reaction['percentage']).to eq '33.3'
          comments = users_outcome['comments']
          expect(comments.count).to eq 2
          comment = comments.first
          expect(comment['generation']).to eq 20
          expect(comment['gender']).to eq 1
          expect(comment['prefecture']).to eq '埼玉県'
          expect(comment['reaction']).to eq 3
          expect(comment['comment']).to eq 'B'
        end
      end

      context '絞り込みあり' do
        subject do
          travel_to '2018-01-01 04:00:00' do
            post '/api/users_outcomes', params: read_json_file('filter'), as: :json
          end
        end

        it '取得される' do
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 0
          data = response_json['data']
          expect(data['genders']).to match_array [2]
          expect(data['generations']).to match_array [20, 40]
          users_outcomes = data['users_outcomes']
          expect(users_outcomes.count).to eq 2

          users_outcome = users_outcomes.first
          expect(users_outcome['outcome_name']).to eq '行動30'
          expect(users_outcome['total_count']).to eq 1
          reactions = users_outcome['reactions']
          expect(reactions.count).to eq 1
          reaction = reactions.first
          expect(reaction['reaction']).to eq 2
          expect(reaction['percentage']).to eq '100.0'
          comments = users_outcome['comments']
          expect(comments.count).to eq 1
          comment = comments.first
          expect(comment['prefecture']).to eq '神奈川県'
          expect(comment['generation']).to eq 20
          expect(comment['reaction']).to eq 2
          expect(comment['comment']).to eq 'E'
        end
      end

      context '20代のみ絞り込み' do
        subject do
          travel_to '2018-01-01 04:00:00' do
            post '/api/users_outcomes', params: read_json_file('only_twenties'), as: :json
          end
        end

        it '取得される' do
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 0
          data = response_json['data']
          users_outcomes = data['users_outcomes']
          expect(users_outcomes.count).to eq 2

          users_outcome = users_outcomes.first
          comments = users_outcome['comments']
          expect(comments.first['comment']).to eq 'F'
          expect(comments.last['comment']).to eq 'E'
        end
      end
    end

    context '異常系' do
      context 'ユーザ未登録' do
        subject do
          travel_to '2018-01-01 04:00:00' do
            post '/api/users_outcomes', params: read_error_json_file('invalid_identifier'), as: :json
          end
        end

        it '取得されない' do
          FactoryBot.create :users_outcome, user_id: @user.id, outcome_id: @outcomes.first.id, post_date: '2018-01-01', post_time: 2
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 3
        end
      end

      context 'リアクション未登録' do
        subject do
          travel_to '2018-01-01 03:00:00' do
            post '/api/users_outcomes', params: read_json_file('normal'), as: :json
          end
        end

        it '取得されない' do
          FactoryBot.create :users_outcome, user_id: @user.id, outcome_id: @outcomes.first.id, post_date: '2018-01-01', post_time: 2
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 5
        end
      end

      context 'identifierなし' do
        subject do
          travel_to '2018-01-01 04:00:00' do
            post '/api/users_outcomes', params: read_error_json_file('no_identifier'), as: :json
          end
        end

        it '取得されない' do
          subject
          expect(response).to be_successful
          response_json = JSON.parse(response.body)
          expect(response_json['status']).to eq 2
        end
      end
    end
  end
end
