module LocationMethods
  def location_condition(location, person_number, folder)
    respond_with :message, text: 'Удачного дня'
    FileManager.save_location_in_file(location, person_number, folder)
  end
end
