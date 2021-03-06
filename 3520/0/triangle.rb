
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
# This method smells of :reek:FeatureEnvy
def triangle(side_a, side_b, side_c)
  # WRITE THIS CODE
  side_a, side_b, side_c = [side_a, side_b, side_c].sort
  raise TriangleError if (side_a <= 0) || (side_a + side_b <= side_c)
  return :equilateral if side_a == side_c
  return :isosceles if (side_a == side_b) || (side_b == side_c)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
