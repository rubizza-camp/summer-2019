# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#

class Triangle
  def initialize(val_a, val_b, val_c)
    @val_a = val_a
    @val_b = val_b
    @val_c = val_c
  end

  private def test_error
    raise TriangleError if negative_sides? || some_condition_again?
  end

  private def negative_sides?
    @val_a <= 0 || @val_b <= 0 || @val_c <= 0
  end

  private def some_condition_again?
    ((sum - @val_a) * (sum - @val_b) * (sum - @val_c)) <= 0
  end

  private def sum
    @sum ||= (@val_a + @val_b + @val_c) / 2.0
  end

  def triangle
    test_error
    if equilateral?
      :equilateral
    elsif isosceles?
      :isosceles
    elsif scalene?
      :scalene
    end
  end

  private def equilateral?
    @val_a == @val_b && @val_a == @val_c
  end

  private def isosceles?
    @val_a == @val_b || @val_a == @val_c || @val_b == @val_c
  end

  private def scalene?
    @val_a != @val_b && @val_a != @val_c
  end
end
# :reek:UtilityFunction

def triangle(val_a, val_b, val_c)
  Triangle.new(val_a, val_b, val_c).triangle
end
# :reek:UtilityFunction

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
