# frozen_string_literal: true

$LOAD_PATH.unshift '.'
require 'config/environment'

use Rack::Static, urls: %w[/css /fonts /images /js], root: 'public'
run MainController
