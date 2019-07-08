# Triangle Project Code.

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
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
def triangle(aside, bside, cside)
  array = [aside, bside, cside].sort
  raise TriangleError if aside <= 0 || bside <= 0 || cside <= 0 || (array[0] + array[1] <= array[2])

  if aside == bside && bside == cside
    :equilateral
  elsif aside == bside || bside == cside || aside == cside
    :isosceles
  else
    :scalene
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
