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
# Error class used in part 2.  No need to change this code.
#:reek:FeatureEnvy and...
class TriangleError < StandardError; end
#:reek:FeatureEnvy mm
def chek(one, two, three)
  chek = (one + two + three) / 2.0

  okey = (chek - one) * (chek - two) * (chek - three)

  raise TriangleError if one <= 0 || two <= 0 || three <= 0 || okey <= 0
end
#:reek:FeatureEnvy mm
def triangle(one, two, three)
  chek(one, two, three)

  result = :scalene
  result = :isosceles if one == two || one == three || two == three
  result = :equilateral if one == two && two == three
  result
end
