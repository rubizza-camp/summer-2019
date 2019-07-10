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

# :reek:UtilityFunction
def triangle_type(a_value, b_value, c_value)
  uniq_sides_count = [a_value, b_value, c_value].uniq.size
  if uniq_sides_count == 1
    :equilateral
  elsif uniq_sides_count == 2
    :isosceles
  else
    :scalene
  end
end

def triangle(a_value, b_value, c_value)
  a_value, b_value, c_value = [a_value, b_value, c_value].sort
  raise TriangleError if c_value >= a_value + b_value

  triangle_type(a_value, b_value, c_value)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
