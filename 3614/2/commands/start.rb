require 'yaml'
require './reg'

module Start

  
  def start!(*)
    # session.delete(:id)
    if registr?
      respond_with :message, text: "Hello, #{from['first_name']}."
      respond_with :message, text: 'U can check list of command using /help'
    else
      registration
    end
    puts session.inspect
  end
end