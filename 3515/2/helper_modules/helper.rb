module Helper
  def user_authorized?
    !current_user.to_s.empty?
  end

  def current_user
    User[from['id']]
  end

  def self.dir_maker(path)
    FileUtils.mkdir_p path
  end

  def photo_download_uri_method(photo_path)
    URI("#{ENV['API_URL_FILE']}#{ENV['TOKEN']}/#{photo_path}")
  end

  def self.file_write(photo_path, uri)
    File.write(photo_path, Kernel.open(uri).read, mode: 'wb')
  end

  def photo_path_uri_method(photo_id)
    URI("#{ENV['API_URL']}#{ENV['TOKEN']}/getFile?file_id=#{photo_id}")
  end
end
