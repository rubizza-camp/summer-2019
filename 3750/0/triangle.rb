# Triangle Project Code.
# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
# rubocop:disable all
def triangle(a_side, b_side, c_side)
# rubocop:enable all  
  array = [a_side, b_side, c_side].sort
  raise TriangleError if array.min <= 0 || array[0] + array[1] <= array[2]
  return :equilateral if (a_side == b_side) & (a_side == c_side)
  return :isosceles if (a_side == b_side) | (a_side == c_side) | (b_side == c_side)
# rubocop:disable all
  return :scalene
# rubocop:enable all
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
