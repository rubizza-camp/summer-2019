require './config/environment'
require 'warden'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

run ApplicationController
use UsersController
use ReviewsController
map('/bars') { run BarsController }
map('/auth') { run SessionsController }
