module ImageLoader
  def load_image
    file_id =  payload['photo'].first['file_id']
    response = HTTParty.get("https://api.telegram.org/bot#{TOKEN}/getFile?file_id=#{file_id}")
    "https://api.telegram.org/file/bot#{TOKEN}/#{response['result']['file_path']}"
  end
end
