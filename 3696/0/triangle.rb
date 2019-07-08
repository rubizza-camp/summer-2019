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
# :reek:TooManyStatements
def triangle(a_side, b_side, c_side)
  # WRITE THIS CODE
  sum = a_side + b_side + c_side
  minimum = [a_side, b_side, c_side].min
  maximum = [a_side, b_side, c_side].max
  raise TriangleError unless minimum.positive? && (maximum < sum - maximum)

  return :equilateral if equilateral?(a_side, b_side, c_side)

  return :isosceles if isosceles?(a_side, b_side, c_side)

  :scalene
end
# :reek:ControlParameter and :reek:UtilityFunction
def isosceles?(a_side, b_side, c_side)
  (a_side == b_side) || (b_side == c_side) || (a_side == c_side)
end
# :reek:ControlParameter and :reek:UtilityFunction
def equilateral?(a_side, b_side, c_side)
  (a_side == b_side) && (b_side == c_side)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
