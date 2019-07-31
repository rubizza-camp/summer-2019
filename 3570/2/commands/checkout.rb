# frozen_string_literal: true

require_relative '../helpers/file_helper'

module CheckoutCommand
  include FileHelper

  def checkout!(*)
    if session.key?(:cadet_id)
      session[:timestamp] = Time.now.to_s
      save_context :receive_checkout_photo
      respond_with :message, text: 'Сделай и отправь селфи'
    else
      respond_with :message, text: 'Ты не авторизирован'
    end
  end

  def receive_checkout_photo(*)
    save_photo(checkout_directory)
    save_context :recieve_checkout_location
    respond_with :message, text: 'Пришли свою геолокацию'
  end

  def recieve_checkout_location(*)
    if validate_location
      save_location(checkout_directory)
      respond_with :message, text: 'Отлично поработал, кадет. Увидимся завтра'
    else
      respond_with :message, text: 'Ты что, уже не в лагере? Меня не проведешь!'
    end
  end

  private

  def user_id
    payload['from']['id']
  end

  def checkout_directory_path
    "public/#{user_id}/checkouts/#{session[:timestamp]}/"
  end

  def checkout_directory
    FileUtils.mkdir_p(checkout_directory_path) unless File.exist?(checkout_directory_path)
    checkout_directory_path
  end
end
