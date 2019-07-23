require 'ruby-progressbar'

module GemsProgressbar
  def self.create(size)
    @progressbar = ProgressBar.create(total: size)
  end

  def self.progress
    @progressbar.increment
    sleep 0.2
  end
end
