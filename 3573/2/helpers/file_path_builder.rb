Dir[File.join('.', ['helpers', '*.rb'])].each { |file| require file }

class FilePathBuilder
  attr_reader :payload, :status, :time

  def initialize(payload, status, time)
    @payload = payload
    @status = status
    @time = time
  end

  def call
    create_file_path
  end

  def self.call(payload:, status:, time:)
    new(payload, status, time).call
  end

  private

  def create_file_path
    local_path = "./public/#{payload}/#{status}s/#{Time.at(time).utc}/"
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
