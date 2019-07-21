class FileController
  def self.move_user_tmp_photo(pos, user_name, session_data)
    old_file_path = session_data["user_#{pos}_pic".to_sym]
    new_file_path = generate_file_path_photo(pos, user_name, session_data)
    move_with_path(old_file_path, new_file_path)
  end

  def self.generate_file_path_photo(pos, user_name, session_data)
    file_part_first = "public/session_#{user_name}/"
    date = session_data["check_#{pos}_date".to_sym]
    file_part_second = "check#{pos}s/#{data_str(date)}/photo.jpg"
    file_part_first + file_part_second
  end

  def self.create_user_geo_txt(pos, user_name, session_data)
    new_file_path = generate_file_path_geo(pos, user_name, session_data)
    File.write(new_file_path, session_data["user_#{pos}_location".to_sym].to_json.to_s)
  end

  def self.generate_file_path_geo(pos, user_name, session_data)
    file_part_first = "public/session_#{user_name}/"
    date = session_data["check_#{pos}_date".to_sym]
    file_part_second = "check#{pos}s/#{data_str(date)}/geo.txt"
    file_part_first + file_part_second
  end

  def self.data_str(data)
    hour_min_sec = "#{data.hour}.#{data.min}.#{data.sec}"
    "#{data.to_date.strftime('%F')} #{hour_min_sec}"
  end

  def self.move_with_path(src, dst)
    FileUtils.mkdir_p(File.dirname(dst))
    FileUtils.mv(src, dst)
  end
end
