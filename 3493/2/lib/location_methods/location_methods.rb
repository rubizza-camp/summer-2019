require_relative '../file_methods'

module LocationMethods
  def location_condition(location, person_number, folder)
    respond_with :message, text: 'Удачного дня'
    FileMethods.save_location_in_file(location, person_number, folder)
  end
end
