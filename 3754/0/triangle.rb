# rubocop:disable Lint/MissingCopEnableDirective, Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity, Style/GuardClause
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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
# :reek:all
def triangle(first_side_length, second_side_length, third_side_length)
  raise TriangleError if (first_side_length <= 0) ||
                         (second_side_length <= 0) ||
                         (third_side_length <= 0)
  raise TriangleError if (first_side_length + second_side_length <= third_side_length) ||
                         (first_side_length + third_side_length <= second_side_length) ||
                         (second_side_length + third_side_length <= first_side_length)

  if (first_side_length == second_side_length) && (second_side_length == third_side_length)
    return :equilateral
  elsif (first_side_length == second_side_length) ||
        (first_side_length == third_side_length) ||
        (second_side_length == third_side_length)
    return :isosceles
  end
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
