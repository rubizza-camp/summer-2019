# frozen_string_literal: true

require_relative 'base_command'
# class checks number from students_list
class SetNumberCommand < BaseCommand
  def call(student_id, students_list)
    return unless students_list.include?(student_id)
    
    user.student_id = student_id
    user.state = :wait_checkin
  end
end
