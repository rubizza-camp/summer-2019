require_relative './config/environment'

raise 'Run db:migrate first' if ActiveRecord::Base.connection.migration_context.needs_migration?

use Rack::MethodOverride
use PlaceController
use UserController
run ApplicationController
