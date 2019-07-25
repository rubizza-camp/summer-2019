require_relative './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Run db:migrate first'
end

use Rack::MethodOverride
# use another controller
run ApplicationController
