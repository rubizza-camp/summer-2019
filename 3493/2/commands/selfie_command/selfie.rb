require_relative '../../validations/photo_validation/photo_validation'
require_relative '../../lib/photo_methods/photo_methods'

module SelfieCommand
  include PhotoValidation
  include PhotoMethods

  def selfie(*)
    if photo?
      photo_condition(payload['photo'], User[from['id']].person_number,
                      session['status'])
      save_context :geoposition
    else
      respond_with :message, text: 'Пришли фото'
      save_context :selfie
    end
  end
end
