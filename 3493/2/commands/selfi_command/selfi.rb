require_relative '../../validations/photo_validation/photo_validation.rb'
require_relative '../../support_methods/photo_methods/photo_methods.rb'

module SelfiCommand
  include PhotoValidation
  include PhotoMethods
  def selfi(*)
    if photo?
      photo_condition(payload['photo'], User[from['id']].person_number,
                      session['status'])
      save_context :geoposition
    else
      respond_with :message, text: 'Ну где же ваше фото, давай же сделаем фото и
                                    будем продолжать!!'
      save_context :selfi
    end
  end
end
