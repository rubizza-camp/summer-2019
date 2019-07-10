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
# :reek:all:
def triangle(side_a, side_b, side_c)
  side_a, side_b, side_c = [side_a, side_b, side_c].sort
  raise TriangleError if !side_a.positive? || side_a + side_b <= side_c

  %i[TriangleError equilateral isosceles scalene][[side_a, side_b, side_c].uniq.size]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
