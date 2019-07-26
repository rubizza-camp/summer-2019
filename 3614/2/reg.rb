require 'yaml'

module Reg

  def load_list_id
    list = YAML.load_file('./students.yml')['id']
  end

  def check_list_id(id)
    load_list_id.include?(id.to_i)
  end

  def registr?
    session.key?(:id)
  end

  def registration(*)
    from['id']
    save_context :valid
    respond_with :message, text: 'Enter your camp ID please:'
  end

  def valid(*words)
    id = words[0]
    if check_list_id(id)
      uppdate_session(id)
      respond_with :message, text: 'Gratz! You are successfully registered!'
    else
      respond_with :message, text: 'There is no such ID, use /start to retry!'
    end
  end

  def uppdate_session(id)
    session[:id] = id
  end
end
