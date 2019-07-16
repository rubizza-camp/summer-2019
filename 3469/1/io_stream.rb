module IoStream
  HEADER = %w[Name Used_by Watchers Stars Forks Contributors Issues].freeze

  private

  def information_from_file
    read_parameters_about_file_name
    begin
     information = YAML.load_file(@parameters[:file])
     @gems_names = information['gems']
   rescue StandardError
     puts 'Invalid file name.'
     exit
   end
  end

  def read_parameters_about_file_name
    @parameters[:file] = ARGV.grep(/--file=(.+)/).to_s[9..-3]
    @parameters[:file] ||= 'top_gems.yml'
  end

  def input_data
    @parameters[:top]  = ARGV.grep(/--top=(\d+)/).to_s[8..-3]
    @parameters[:name] = ARGV.grep(/--name=(.+)/).to_s[9..-3]
    @parameters[:top] ||= @gems_names.count
    @parameters[:name] ||= @gems_names
  end

  def print_top(array_of_top_gems)
    create_rows_for_output(array_of_top_gems)
    puts Terminal::Table.new headings: HEADER, rows: @rows
  end

  def create_rows_for_output(array_of_top_gems)
    @rows = []
    array_of_top_gems.each do |gem|
      next unless appropriate_name?(gem)
      break if @rows.size >= @parameters[:top]
      create_new_position_in_top(gem.array_of_information)
    end
  end

  def create_new_position_in_top(gem)
    all_fields = %i[name used_by watchers stars forks contributors issues]
    @rows << all_fields.each_with_object([]) { |field, row| row << gem[field] }
  end

  def appropriate_name?(gem)
    gem.name =~ /#{@contains_in_name}/
  end
end
