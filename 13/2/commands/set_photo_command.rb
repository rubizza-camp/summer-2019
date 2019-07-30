# frozen_string_literal: true

require_relative 'base_command'
# class process and saves photo from Telegram
class SetPhotoCommand < BaseCommand
  attr_reader :bot_api

  def initialize(user, bot_api)
    @user = user
    @bot_api = bot_api
  end

  def call(photos)
    return if photos.empty?
    return unless save(photos.last.file_id)

    user.sate = user.state == :wait_photo ? :wait_checkout : :wait_start
  end

  private

  def save_file(file_id)
    Kernel.open("https://api.telegram.org/file/bot#{TOKEN}/#{file_path(file_id)}") do |image|
      File.open("public/#{user.student_id}/#{folder}/#{user.timestamp}/selfie.jpg", 'wb') do |file|
        file.write(image.read)
      end
    end
  end

  def file_path(file_id)
    file_path = bot_api.get_file(file_id: photo_id).dig('result', 'file_path')
  end

  def folder
    user.state == :wait_photo ? 'checkins' : 'checkouts'
  end
end
