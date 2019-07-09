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

# :reek:FeatureEnvy
def triangle(a_side, b_side, c_side)
  # WRITE THIS CODE
  a_side, b_side, c_side = [a_side, b_side, c_side].sort
  raise TriangleError if (a_side <= 0) || (a_side + b_side <= c_side)
  return :equilateral if a_side == c_side # proverka
  return :isosceles if (a_side == b_side) || (b_side == c_side)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
