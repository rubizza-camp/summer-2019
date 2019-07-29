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
# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
def triangle(a_side, b_side, c_side)
  a, b, c = [a_side, b_side, c_side].sort
  raise TriangleError if a <= 0 || a + b <= c

  return :equilateral if a == c
  return :isosceles if a == b || b == c
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
