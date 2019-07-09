# frozen_string_literal: true
# rubocop:disable all

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
def triangle(side_a, side_b, side_c)
  minimum = [side_a, side_b, side_c].min
  maximum = [side_a, side_b, side_c].max
  raise TriangleError unless minimum.positive? && (maximum < [side_a, side_b, side_c].inject(:+) - maximum)

  return :equilateral if equilateral?(side_a, side_b, side_c)

  return :isosceles if isosceles?(side_a, side_b, side_c)

  :scalene
end

# :reek:ControlParameter and :reek:UtilityFunction
def isosceles?(side_a, side_b, side_c)
  (side_a == side_b) || (side_b == side_c) || (side_a == side_c)
end

# :reek:ControlParameter and :reek:UtilityFunction
def equilateral?(side_a, side_b, side_c)
  (side_a == side_b) && (side_b == side_c)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:disable all
