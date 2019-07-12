# Triangle Project Code.
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize, Lint/UnneededCopDisableDirective
# rubocop:disable Metrics/PerceivedComplexity
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
# :reek:FeatureEnvy
def triangle(one, two, tre)
  raise TriangleError, 'Side must be > 0' if one <= 0 || two <= 0 || tre <= 0
  raise TriangleError, 'This is an impossible triangle' if one + two <= tre \
  || one + tre <= two || two + tre <= one

  if one == two && one == tre
    :equilateral
  elsif one == two || one == tre || two == tre
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/AbcSize, Lint/UnneededCopDisableDirective
# rubocop:enable Metrics/PerceivedComplexity
