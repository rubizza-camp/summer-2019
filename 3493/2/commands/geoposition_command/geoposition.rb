require_relative '../../validations/location_validation/location_validation.rb'
require_relative '../../support_methods/location_methods/location_methods.rb'
require_relative '../../support_methods/user_methods/user_methods.rb'
module GeopositionCommand
  include LocationValidation
  include LocationMethods
  def geoposition!(*)
    if location?
      location_condition(payload['location'], User[from['id']].person_number, 'checkouts')
      UserMethods.update_user_chekout_date(from['id'])
    else
      respond_with :message, text: 'Мне нужна геопозиция!!!!'
      save_context :geoposition!
    end
  end
end
