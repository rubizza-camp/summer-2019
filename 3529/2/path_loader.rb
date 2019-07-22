require 'fileutils'

class PathLoader

  def initialize(payload)
    @session_id = "#{payload["from"]["id"]}:#{payload["chat"]["id"]}"
    @date = Time.now.asctime
  end

  def load_path_checkin
    return "public/#{@session_id}/checkins/#{@date}/"
  end

  def load_path_checkout
    return "public/#{@session_id}/checkouts/#{@date}/"
  end
end
