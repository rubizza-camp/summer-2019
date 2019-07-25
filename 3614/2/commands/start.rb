require './auth'

module Start

  def start!(*)
    # puts from_
    save_context :check_list_id
    respond_with :message, text: "Hello, #{from['first_name']}, @#{from['username']}."
    respond_with :message, text: 'U can check list of command using /help'
    #lalalal
  end
end