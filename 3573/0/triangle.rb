# Triangle Project Code.
#
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

def triangle(side_a, side_b, side_c)
  # WRITE THIS CODE
  raise TriangleError if [side_a, side_b, side_c].min <= 0

  s_a, s_b, s_c = [side_a, side_b, side_c].sort
  raise TriangleError if s_a + s_b <= s_c

  %i[equilateral isosceles scalene].fetch([side_a, side_b, side_c].uniq.size - 1)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
