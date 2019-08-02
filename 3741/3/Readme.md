**This simple web app of place ranking**

!Prepare for lunch:
- delete next string in main_controller.rb
      *require 'helpers/view_helper'
      *require 'helpers/user_helper'
      *require 'helpers/review_helper'
      *helpers ViewHelper
      *helpers UserHelper
      *helpers ReviewHelper

- console: 'rake db:create'
- console: 'rake db:migrate'
- console: 'rake db:seed'

!Get back delete string in prepare

!Launch command:
- rackup -p 4567
