# frozen_string_literal: true

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
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# :reek:ControlParameter
# :reek:UtilityFunction
def sides_equal_zero(first, second, third)
  first.zero? && second.zero? && third.zero?
end

# :reek:UtilityFunction
def sides_arent_good(first, second, third)
  first + second <= third || first + third <= second || second + third <= first
end

# :reek:FeatureEnvy
def triangle(first, second, third)
  # WRITE THIS CODE
  if sides_equal_zero(first, second, third) || sides_arent_good(first, second, third)
    raise TriangleError, "Triangle Doesn't Exist!!!!!!!!!!!"
  end
  if (first == second) && (second == third)
    :equilateral
  elsif (first == second) || (first == third) || (second == third)
    :isosceles
  else
    :scalene
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
