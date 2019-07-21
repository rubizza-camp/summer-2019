class FileController
  class << self
    attr_reader :pos, :user_name, :session_data

    def move_user_tmp_photo(pos, user_name, session_data)
      @pos = pos
      @user_name = user_name
      @session_data = session_data

      move_with_path(session_data["user_#{pos}_pic".to_sym], generate_file_path_photo)
    end

    def create_user_geo_txt(pos, user_name, session_data)
      @pos = pos
      @user_name = user_name
      @session_data = session_data

      new_file_path = generate_file_path_geo
      File.write(new_file_path, session_data["user_#{pos}_location".to_sym].to_json.to_s)
    end

    def generate_file_path_photo
      file_part_first = "public/session_#{user_name}/"
      date = session_data["check_#{pos}_date".to_sym]
      file_part_second = "check#{pos}s/#{data_str(date)}/photo.jpg"
      file_part_first + file_part_second
    end

    def generate_file_path_geo
      file_part_first = "public/session_#{user_name}/"
      date = session_data["check_#{pos}_date".to_sym]
      file_part_second = "check#{pos}s/#{data_str(date)}/geo.txt"
      file_part_first + file_part_second
    end

    def data_str(data)
      hour_min_sec = "#{data.hour}.#{data.min}.#{data.sec}"
      "#{data.to_date.strftime('%F')} #{hour_min_sec}"
    end

    def move_with_path(src, dst)
      FileUtils.mkdir_p(File.dirname(dst))
      FileUtils.mv(src, dst)
    end
  end
end
