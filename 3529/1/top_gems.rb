require 'terminal-table'
require_relative 'user_communicator'

user = UserCommunicator.new
begin
  file_name = ''
  ARGV.each do |argument|
    file_name = argument.gsub('--file=', '') if argument.include?('file')
  end
  file = YAML.safe_load(File.read(file_name))
  user.find_list(file)
  user.load_arguments
  table = Terminal::Table.new do |t|
    t.headings = ['gem name', 'watched by', 'stars', 'forks', 'used by', 'contributors', 'issues']
    t.rows = user.rows
  end
  puts table
rescue NoMethodError => e
  puts "ERROR: There isn't any gems in your file"
  puts e.backtrace
end
