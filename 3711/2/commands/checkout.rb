# frozen_string_literal: true

require_relative '../authentification'

# top-level module documentation comment
module CheckOutCommand
  def checkout!(*)
    if registered?
      respond_with :message, text: 'Good bye!'
    else
      registrate
    end
  end
end
