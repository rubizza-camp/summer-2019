require 'fileutils'

class PathLoader
  def initialize(payload)
    @session_id = "#{payload['from']['id']}:#{payload['chat']['id']}"
    @date = Time.now.strftime('%m:%d:%Y:%H')
  end

  def create_directory(in_or_out, file_name)
    path = if in_or_out == 'in'
             "public/#{@session_id}/checkins/#{@date}/"
           else
             "public/#{@session_id}/checkouts/#{@date}/"
           end
    dirname = File.dirname(path + file_name)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    path + file_name
  end
end
