module FileAccessor
  def read_file_into_arr
    array = []
    File.open("#{Dir.pwd}/personal_numbers.yaml", 'r').each_line do |line|
      array << line.chomp
    end
    array
  end
end