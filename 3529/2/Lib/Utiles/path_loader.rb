require 'fileutils'

class PathLoader
  def initialize(user_id, chat_id)
    @session_id = "#{user_id}:#{chat_id}"
    @date = Time.now.strftime('%m:%d:%Y:%H')
  end

  def create_directory(in_or_out, file_name)
    path = "public/#{@session_id}/check#{in_or_out}s/#{@date}/"
    dirname = File.dirname(path + file_name)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    path + file_name
  end
end
