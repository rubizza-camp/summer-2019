require_relative '../../validations/location_validation/location_validation.rb'
require_relative '../../lib/location_methods/location_methods.rb'
require_relative '../../lib/user_methods/user_methods.rb'

module GeopositionCommand
  include LocationValidation
  include LocationMethods
  def geoposition(*)
    if location?
      location_condition(payload['location'], User[from['id']].person_number, session['status'])
      update_user_date
    else
      respond_with :message, text: 'Мне нужна геопозиция!!!!'
      save_context :geoposition
    end
  end

  private

  def update_user_date
    UserMethods.update_user_date(from['id'], session['status'])
  end
end
