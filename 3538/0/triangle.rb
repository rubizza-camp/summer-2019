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
def triangle(side_a, side_b, side_c)
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  sides = [side_a, side_b, side_c].sort
  raise TriangleError if sides.first <= 0
  raise TriangleError if sides.first + sides[1] <= sides.last
  return :equilateral if sides.first == sides.last
  return :isosceles if sides.first == sides[1] || sides[1] == sides.last

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
