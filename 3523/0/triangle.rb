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

def triangle(side_a, side_b, side_c)
  result = :scalene
  result = :isosceles if side_a == side_b || side_b == side_c || side_c == side_a
  result = :equilateral if side_a == side_b && side_b == side_c
  errors(side_a, side_b, side_c)
  result
end

def errors(side_a, side_b, side_c)
  raise TriangleError unless [side_a, side_b, side_c].reject(&:positive?).empty?

  x_s, y_s, z_s = [side_a, side_b, side_c].sort
  raise TriangleError if x_s + y_s <= z_s
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
