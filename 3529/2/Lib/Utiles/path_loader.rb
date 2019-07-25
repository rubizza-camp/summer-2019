require 'fileutils'

class PathLoader
  def initialize(id)
    @id = id
    @number = find_number_by_id(id)
    @date = Time.now.strftime('%m:%d:%Y:%H')
  end

  def find_number_by_id
    file = YAML.safe_load(File.read('Data/camp_participants.yaml'))
    file['participents'].each do |participant|
      @number = participant.keys.first.to_s if participant['telegram_id'] == id
    end
  end

  def create_directory(in_or_out, file_name)
    path = "public/#{@number}/check#{in_or_out}s/#{@date}/"
    FileUtils.mkdir_p(path)
    path + file_name
  end
end
