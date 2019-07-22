require_relative 'top_gem'
require_relative 'gem_file_loader'
require_relative 'gem_statistics'
require 'optparse'
# :reek:UtilityFunction
class Top
  def create_top(gem_list)
    (0...gem_list.size).map do |gem_number|
      gem_list[gem_number] = GemStatistics.new(gem_list[gem_number]).gem_info
    end

    TopGem.new.call(gem_list)
  end
end

Top.new.create_top(GemfileLoader.new('gems_list.yaml').gem_list) if ARGV.empty?

OptionParser.new do |options|
  options.on('-t', '--top NUMBER', Integer,
             'Top of Ruby gems from gems.yml file') do |max_num_gems|
    Top.new.create_top(GemfileLoader.new('gems_list.yaml').gem_list[0...max_num_gems])
  end

  options.on('-n', '--name NAME', String,
             'Shows all the gems from gems.yml, whose name contains the specified word') do |text|
    Top.new.create_top(GemfileLoader.new('gems_list.yaml')
        .gem_list.select { |gem_| gem_.include?(text) })
  end

  options.on('-f', '--file FILE', String,
             'Specify gems.yml containing a list of gem names') do |file|
    Top.new.create_top(GemfileLoader.new(file).gem_list)
  end
end.parse!
