require 'terminal-table'

class Output
  def output
    table = Terminal::Table.new do |table|
      table.headings = ['gem', 'used', 'watched', 'stars', 'forks', 'contributors', 'issues']
      @gems_info.each do |gem_name, gem_info|
        table << create_arr_for_table(gem_name, gem_info)
      end
    end
    puts gems_table
  end
end
