# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

require "#{Rails.root}/db/seeds/common.rb" # Commonは最初に読み込む
Dir["#{Rails.root}/db/seeds/*.rb"].each(&method(:require))

Seeds::Categories.exec
Seeds::Outcomes.exec
ActiveRecord::Base.connection.execute("SELECT setval('categories_id_seq', coalesce((SELECT MAX(id)+1 FROM categories), 1), false)")
ActiveRecord::Base.connection.execute("SELECT setval('outcomes_id_seq', coalesce((SELECT MAX(id)+1 FROM outcomes), 1), false)")

if Rails.env.development?
  Seeds::Users.exec
  ActiveRecord::Base.connection.execute("SELECT setval('users_id_seq', coalesce((SELECT MAX(id)+1 FROM users), 1), false)")
  Seeds::UsersOutcomes.exec
end
