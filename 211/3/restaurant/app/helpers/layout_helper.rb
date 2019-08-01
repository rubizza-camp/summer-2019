module LayoutHelper
  def flash_messages(hash)
    type = hash.keys.first
    message = hash[type]
    case type
    when :notice
      role = 'info'
    when :error
      role = 'danger'
      message = message.join(', ')
    end
    "<div class='alert alert-#{role}'> #{message} </div>"
  end
end
