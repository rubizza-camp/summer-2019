require_relative './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use ApplicationController
use UserController
use PlacesContoller
use CommentsContoller
run ApplicationController
