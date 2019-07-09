# frozen_string_literal: true

# rubocop:disable all
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
  res = 0
  raise TriangleError unless [a, b, c].reject(&:positive?).empty?

  x, y, z = [a, b, c].sort
  raise TriangleError if x + y <= z

  [a, b, c].each do |i|
    if [a, b, c].select { |num| i == num }.length == 3
      res = :equilateral
    elsif [a, b, c].select { |num| i == num }.length == 2
      res = :isosceles
    end
  end
  res = :scalene if res == 0

  res
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
