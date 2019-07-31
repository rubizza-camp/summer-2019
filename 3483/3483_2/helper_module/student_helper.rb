require_relative '../check_helper/checker'
require_relative '../registration/student'
# :reek:UtilityFunction
module StudentHelper
  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')

  def student_entered_number_correctly?(number)
    Checker.new(number).correct_data?
  end

  def path_to_save_data
    "public/#{Student[from['id']].number}/#{Student[from['id']].status}/#{TIME}"
  end

  def student_registered(id)
    Student[id]
  end
end
