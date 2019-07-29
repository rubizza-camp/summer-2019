# class for getting photo
# # frozen_string_literal: true
class PathCreator
  def self.save_path(session, payload, token)
    path_creator = PathCreator.new(session, payload, token)
    return path_creator.checkin_url if session[:status] == :in

    path_creator.checkout_url
  end

  def self.download_path(session, payload, token)
    path_creator = PathCreator.new(session, payload, token)
    "https://api.telegram.org/file/bot#{token}/" + path_creator.photo_url
  end

  attr_reader :session, :token, :payload

  def initialize(session, payload, token)
    @token = token
    @payload = payload
    @session = session
  end

  def checkin_url
    "./public/#{@session[:id]}/checkins/#{session[:timestamp]}/"
  end

  def checkout_url
    "./public/#{@session[:id]}/checkouts/#{session[:timestamp]}/"
  end

  def photo_url
    JSON.parse(uri_open_url, symbolize_names: true)[:result][:file_path]
  end

  def uri_open_url
    photo_id = payload['photo'].first['file_id']
    URI.open("https://api.telegram.org/bot#{token}/getFile?file_id=#{photo_id}").read
  end
end
