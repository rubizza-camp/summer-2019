# frozen_string_literal: true

module BaseCommandHelpers
  private

  def already_registered?
    respond_with :message, text: 'You are registered already, stop it' if session.key?(:number)
    session.key?(:number)
  end

  def need_to_register?
    respond_with :message, text: 'You should register first!' unless session.key?(:number)
    !session.key?(:number)
  end

  def need_to_checkin?
    respond_with :message, text: 'You should checkin first!' unless session[:checkin]
    !session[:checkin]
  end

  def need_to_checkout?
    respond_with :message, text: 'You should checkout first!' if session[:checkin]
    session[:checkin]
  end

  def user_id
    payload['from']['id']
  end
end
