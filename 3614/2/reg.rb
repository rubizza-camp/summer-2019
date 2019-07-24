require 'yaml'

module Reg

  def check_list_id(*args)
    list = YAML.load_file('./students.yml')['id']
    list.each do |id|
      return registr? if list.include?(args[0].to_i)
    end
    respond_with :message, text: 'Try one more time'
    save_context :check_list_id
  end

  def registr?
    session.key?(:id)
    save_context :registration
  end

  def registration
    save_context :valid
    respond_with :message, text: 'Enter your camp ID please:'
  end

  def valid
    students words[0].to_i
    respond_with :message, text: 'kk'
  end
end
