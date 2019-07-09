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
# :reek:ClassVariable
# :reek:TooManyStatements
# :reek:UncommunicativeMethodName
# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
# rubocop:disable Layout/TrailingWhitespace, Layout/EmptyLineBetweenDefs

def triangle(a_side, b_side, c_side)
  raise TriangleError if negative?(a_side, b_side, c_side)
  raise TriangleError unless a_triangle?(a_side, b_side, c_side)
  return :equilateral if a_side.eql?(b_side) && b_side.eql?(c_side)
  return :isosceles if a_side.eql?(b_side) || a_side.eql?(c_side) || b_side.eql?(c_side)
  
  :scalene
  # WRITE THIS CODE
end
# :reek:UtilityFunction
def negative?(a_side, b_side, c_side)
  (a_side <= 0) || (b_side <= 0) || (c_side <= 0)
end
# :reek:UtilityFunction
def a_triangle?(a_side, b_side, c_side)
  !((a_side + b_side <= c_side) || (a_side + c_side <= b_side) || (b_side + c_side <= a_side))
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
# rubocop:enable Layout/TrailingWhitespace, Layout/EmptyLineBetweenDefs
