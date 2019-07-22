require_relative 'lib/conversation'
require_relative 'commands/start'
require_relative 'commands/checkin'
require_relative 'commands/checkout'
require_relative 'commands/register'

class Dialog < Conversation
  include Start
  include CheckIn
  include CheckOut
  include Register

  def validate
    puts "STATUS: #{status}"
    puts "You said #{user_said}"
    case user_said
    when '/start'
      start(self)
    when '/check_in'
      check_in(self)
    when '/check_out'
      check_out(self)
    when '/help'
      help
    else
      user_said.to_i.positive? ? register(self) : repeat_please
    end
  end
end
