require 'sinatra/flash'

module FlashHelper
  def flash_info(text)
    flash[:info] = text
  end

  def flash_danger(text)
    flash[:danger] = text
  end
end
