# frozen_string_literal: true

$LOAD_PATH.unshift '.'
require 'config/environment'

use SessionsController
use PlacesController
use ReviewsController
run MainController
