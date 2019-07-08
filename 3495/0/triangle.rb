# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Naming/UncommunicativeMethodParamName
# rubocop:disable Style/RedundantReturn
# rubocop:disable Layout/MultilineOperationIndentation

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
  if side_a <= 0 || side_b <= 0 || side_c <= 0 || (side_a + side_b <= side_c) ||
    (side_a + side_c <= side_b) || (side_c + side_b <= side_a)
    raise TriangleError, 'the triangle does not exist'
  elsif side_a == side_b && side_b == side_c && side_a == side_c
    return :equilateral
  elsif side_a == side_b || side_b == side_c || side_a == side_c
    return :isosceles
  elsif side_a != side_b && side_b != side_c && side_a != side_c
    return :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Naming/UncommunicativeMethodParamName
# rubocop:enable Style/RedundantReturn
# rubocop:enable Lint/UnneededCopDisableDirective
# rubocop:enable Layout/MultilineOperationIndentation
