require 'bundler/setup'
Bundler.require

# configure :development do
#   ActiveRecord::Base.establish_connection(
#     :adapter => "sqlite3",
#     :database => "db/rest_reviews.sqlite"
#   )
# end

require_all 'app'
