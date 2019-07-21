module PhotoMethods
  def photo_condition(photo, person_number, folder)
    respond_with :message, text: 'Фоточка получена, теперь скинь свои координаты!'
    FileManager.request_file_path(photo, person_number, folder)
  end
end
