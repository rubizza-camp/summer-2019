class DirManager
  def self.create_directory(user, check)
    path = "public/#{user}/#{check}/#{Time.now.strftime('%a, %d %b %Y %H:%M')}"
    FileUtils.mkdir_p(path)
  end
end
