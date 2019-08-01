module LayoutHelper
  def flash_notice(hash)
    message = hash.values.first
    "<div class='alert alert-info'> #{message} </div>"
  end

  def flash_error(hash)
    message = hash.values.first.full_messages
    "<div class='alert alert-danger'> #{message.join(', ')} </div>"
  end
end
