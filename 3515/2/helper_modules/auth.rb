require 'yaml'
require_relative 'camp_id_checkers'

module Authorization
  attr_reader :user_with_current_id

  def already_registered?
    @user_with_current_id = User.all.select { |user| user.id == from['id'].to_s }
    !user_with_current_id.empty?
  end

  def already_registered_warning(camp_id)
    respond_with :message, text: "Ваш аккаунт авторизован под номером #{camp_id} .\nДоступные
    команды: /checkin, /checkout, /help"
  end

  def user_registration(*)
    save_context :create_user
    respond_with :message, text: I18n.t(:you_are_not_authorized_yet)
  end

  def create_user(*words)
    id = words.first
    if CampIdCheckers.check_camp_id_in_yaml('data/numbers.yml', id) &&
       CampIdCheckers.check_camp_already_defined(id)

      params_for_create_user(id)
      User.create(id: @id, name: @name, camp_id: @camp_id, checkin: @checkin)
      respond_with :message, text: "Вы успешно авторизовались под номером #{id}\nДоступные команды:
       /checkin, /checkout, /help"
    else
      respond_with :message, text: I18n.t(:auth_failed)
    end
  end

  def params_for_create_user(id)
    @id = from['id']
    @name = from['first_name']
    @camp_id = id
    @checkin = 'false'
  end
end
