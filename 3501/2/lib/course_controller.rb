class CourseController
  attr_reader :current
  def initialize
    @current = 0
  end

  def course(new_value)
    @current = new_value
  end
end
