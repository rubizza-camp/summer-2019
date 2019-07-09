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
# rubocop:disable Metrics/LineLength, Naming/UncommunicativeMethodParamName, Style/GuardClause, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def triangle(a, b, c)
  # WRITE THIS CODE
  if a * b * c <= 0 || !(a + b > c && a + c > b && b + c > a)
    raise TriangleError, "Triangle Doesn't Exist!!!!!!!!!!!"
  end
  if (a == b) && (b == c)
    return :equilateral
  elsif (a == b) || (a == c) || (b == c)
    return :isosceles
  else
    return :scalene
  end
end
# rubocop:enable Metrics/LineLength, Naming/UncommunicativeMethodParamName, Style/GuardClause, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
