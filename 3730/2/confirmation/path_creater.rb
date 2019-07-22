require_relative 'photo'
require_relative 'geoposition'

module PathCreater
  include Photo
  include Geoposition

  def enter_camp_time
    session[:timestamp] = Time.now.utc.to_s
  end

  def leave_camp_time
    session[:timestamp] = Time.now.utc.to_s
  end

  def checkin_dir
    FileUtils.mkdir_p(checkin_path) unless File.exist?(checkin_path)
    checkin_path
  end

  def checkout_dir
    FileUtils.mkdir_p(checkout_path) unless File.exist?(checkout_path)
    checkout_path
  end

  def registred?
    session.key?(:number)
  end

  private

  def checkin_path
    "public/#{user_id}/checkins/#{session[:timestamp]}/"
  end

  def checkout_path
    "public/#{user_id}/checkouts/#{session[:timestamp]}/"
  end

  def user_id
    payload['from']['id']
  end
end
