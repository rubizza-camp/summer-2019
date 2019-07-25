module PathHelper
  def generate_checkin_path(time)
    "./public/#{user_id_telegram}/checkins/#{time}/"
  end

  def create_checkin_path
    local_path = generate_checkin_path(Time.at(session[:time_checkin]).utc)
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end

  def generate_checkout_path(time)
    "./public/#{user_id_telegram}/checkouts/#{time}/"
  end

  def create_checkout_path
    local_path = generate_checkout_path(Time.at(session[:time_checkout]).utc)
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
