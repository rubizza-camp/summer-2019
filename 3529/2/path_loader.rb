require 'fileutils'

class PathLoader
  def initialize(payload)
    @session_id = "#{payload['from']['id']}:#{payload['chat']['id']}"
    @date = Time.now.asctime
  end

  def load_path(in_or_out)
    if in_or_out == 'in'
      "public/#{@session_id}/checkins/#{@date}/"
    else
      "public/#{@session_id}/checkouts/#{@date}/"
    end
  end

  def create_directory(path)
    dirname = File.dirname(path)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  end
end
