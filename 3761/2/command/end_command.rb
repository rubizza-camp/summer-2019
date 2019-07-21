module EndCommand
  def end!(*)
    response = 'You\'re done'
    respond_with :message, text: response
  end
end
