module Registration
  MSG = {
    success: 'Registration done',
    failure: 'There is no such number in my list'
  }.freeze

  def number_check(number, *)
    notify(MSG[:failure]) && return unless FileAccessor.personal_numbers.include? number
    registration(number)
  end

  private

  def registration(number)
    session[:number] = number
    session[:checkout?] = true
    Redis.new.set(number, from['id'])
    notify(MSG[:success])
  end
end
