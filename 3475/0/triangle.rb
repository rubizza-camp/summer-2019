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
# :reek:UncommunicativeParameterName
def triangle(side1, side2, side3)
  invalid_traingle?(side1, side2, side3)
  if side1 == side2 && side2 == side3
    :equilateral
  elsif side1 == side2 || side1 == side3 || side2 == side3
    :isosceles
  else
    :scalene
  end
end

# :reek:UncommunicativeParameterName
# :reek:FeatureEnvy
def invalid_traingle?(side1, side2, side3)
  sum = (side1 + side2 + side3) / 2.0
  sides = (sum - side1) * (sum - side2) * (sum - side3)
  raise TriangleError if side1 <= 0 || side2 <= 0 || side3 <= 0 || sides <= 0
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
