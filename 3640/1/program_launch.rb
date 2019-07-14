class ProgramLaunch
  def self.play_program(selector)
    fetcher = new
    selector.key?(:file) ? fetcher.get_path_file(selector[:file]) : Table.new.table_output(selector)
  end

  def get_path_file(file_name)
    if file_name == 'gems.yaml'
      puts "Path to directory of gems list is:\n" + Dir.pwd + "/#{file_name}"
    else
      puts 'Invalid file name entered'
    end
  end
end
