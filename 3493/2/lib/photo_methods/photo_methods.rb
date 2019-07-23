require_relative '../file_methods'

module PhotoMethods
  def photo_condition(photo, person_number, folder)
    respond_with :message, text: 'Фото получено, теперь скинь свои координаты!'
    FileMethods.request_file_path(photo.last['file_id'], person_number, folder)
  end
end
