module ImageLoader
  API_FILE_ID = 'https://api.telegram.org/botTOKEN/getFile?file_id=file_id_real'.freeze
  FILE_PATH = 'https://api.telegram.org/file/botTOKEN/filepath'.freeze

  def load_image
    API_FILE_ID.gsub!('TOKEN', TOKEN)
    API_FILE_ID.gsub!('file_id_real', payload['photo'].first['file_id'])
    response = HTTParty.get(API_FILE_ID)
    API_FILE_ID.gsub!('TOKEN', TOKEN)
    API_FILE_ID.gsub!('filepath', response['result']['file_path'])
  end
end
