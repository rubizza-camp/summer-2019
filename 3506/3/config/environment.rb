require 'bundler/setup'
require 'tilt/erb'

Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

Truemail.configure do |config|
  config.verifier_email = 'xaxah@newtmail.com'
end

Dir[File.join(__dir__, '..', 'app', '**', '*.rb')].each { |file| require file }
