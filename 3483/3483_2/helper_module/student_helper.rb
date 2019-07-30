require_relative '../check_helper/checker'
require_relative '../registration/student'
# :reek:UtilityFunction
module StudentHelper
  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')

  def student_entered_number_correctly(number)
    Checker.new(number).correct_data?
  end

  def create_user(number)
    Student.create(id: from['id'], number: number, in_camp: 'checkin')
  end

  def not_in_camp_now
    Student[from['id']].in_camp == 'checkin'
  end

  def came_to_camp
    Student[from['id']].update in_camp: 'checkout'
  end

  def in_camp_now
    Student[from['id']].in_camp == 'checkout'
  end

  def left_camp
    Student[from['id']].update in_camp: 'checkin'
  end

  def path_to_save_data
    "public/#{Student[from['id']].number}/#{Student[from['id']].in_camp}/#{TIME}"
  end

  def student_registered(id)
    Student[id]
  end
end
