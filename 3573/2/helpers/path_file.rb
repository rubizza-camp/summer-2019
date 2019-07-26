Dir[File.join('.', ['helpers', '*.rb'])].each { |file| require file }

class PathFile
  attr_reader :payload, :status, :time

  def initialize(payload, status, time)
    @payload = payload
    @status = status
    @time = time
  end

  def self.call(payload:, status:, time:)
    new(payload, status, time).call
  end

  def path_name
    "./public/#{payload}/#{status}/#{Time.at(time).utc}/"
  end

  def call
    create_checkout_path
  end

  def create_checkout_path
    local_path = path_name
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end
end
