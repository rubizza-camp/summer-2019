require_relative 'gemy'

class GemFetcher
  def self.read_file_into_string
    File.open("#{Dir.pwd}/gems.yaml", 'r')
  end

  def self.fill_array_of_gems(array)
    read_file_into_string.each_line do |line|
      next if line.include? 'gems:'
      array << Gemy.new(line.strip[2..-1]) # [2..-1] gets rid of those '- ' before actual gem name
      # i'm using this instead of delete '- ' because it does not work in cases like '- rspec-core'
    end
  end
end
