# frozen_string_literal: true

# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Naming/UncommunicativeMethodParamName
# rubocop:disable Metrics/AbcSize
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

def triangle(a, b, c)
  raise TriangleError if (a <= 0) || (b <= 0) || (c <= 0)
  raise TriangleError if (a + b <= c) || (b + c <= a) || (a + c <= b)
  return :equilateral if (a == b) && (a == c) && (b == c)
  return :isosceles if (a == b) || (b == c) || (a == c)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Naming/UncommunicativeMethodParamName
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
