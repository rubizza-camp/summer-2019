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
  end

  def registration(*)
    save_context :valid
    respond_with :message, text: 'Enter your camp ID please:'
  end

  def valid(*words)
    id = words[0].to_i
    if check_list_id(id)
      respond_with :message, text: 'Gratz! You are successfully registered!'
      uppdate_session(id)
    else
      respond_with :message,text:'There is no such ID, use /start to retry!'
    end
  end

  def uppdate_session(id)
    session[:id] = id
  end
end
