# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

%w[学校・仕事 趣味・エンターテイメント 移動 食事 家事 その他].each_with_index do |name, i|
  Category.create id: i + 1,name: name
end

[
  [1, '学校'],
  [1, '会社'],
  [1, '勉強'],
  [1, 'バイト'],
  [2, 'デート'],
  [2, 'スポーツ'],
  [2, 'スポーツ観戦'],
  [2, 'ジム'],
  [2, '飲み会'],
  [2, 'ネットサーフィン'],
  [2, '家庭菜園'],
  [2, '散歩'],
  [2, 'コンサート鑑賞'],
  [2, 'ネイル'],
  [2, 'サイクリング'],
  [2, '映画鑑賞'],
  [2, '読書'],
  [2, '音楽鑑賞'],
  [3, '電車'],
  [3, 'ドライブ'],
  [4, '朝食'],
  [4, '昼食'],
  [4, '夕食'],
  [5, '料理'],
  [5, '掃除'],
  [5, '買い物'],
  [6, '昼寝'],
  [6, '美容院'],
  [6, '通院']
].each do |category_id, name|
  Outcome.create category_id: category_id, name: name
end
