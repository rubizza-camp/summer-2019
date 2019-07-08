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
def triangle(a_side, b_side, c_side)
  a_side, b_side, c_side = [a_side, b_side, c_side].sort
  raise TriangleError unless a_side.positive?
  raise TriangleError unless (a_side + b_side) > c_side

  if a_side == b_side && b_side == c_side
    :equilateral
  elsif a_side == b_side || a_side == c_side || b_side == c_side
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
