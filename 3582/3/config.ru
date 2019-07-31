require './config/environment'

use Rack::MethodOverride

use RestarauntController
use CommentController
use UserController
run ApplicationController
