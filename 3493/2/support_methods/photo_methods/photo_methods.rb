require_relative '../file_methods/file_methods.rb'
module PhotoMethods
  def photo_condition(photo, person_number, folder)
    respond_with :message, text: 'Фоточка получена, теперь скинь свои координаты!'
    FileMethods.request_file_path(photo.last['file_id'], person_number, folder)
  end
end
