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
# This method smells of :reek:UncommunicativeVariableName
def triangle(first_side, second_side, third_side)
  # WRITE THIS CODE
  raise TriangleError if [first_side, second_side, third_side].min <= 0

  x, y, z = [first_side, second_side, third_side].sort
  raise TriangleError if x + y <= z

  %i[equilateral isosceles scalene].fetch([first_side, second_side, third_side].uniq.size - 1)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
