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

def triangle(a_s, b_s, c_s)
  res = 0
  raise TriangleError unless [a_s, b_s, c_s].reject(&:positive?).empty?

  x_s, y_s, z_s = [a_s, b_s, c_s].sort
  raise TriangleError if x_s + y_s <= z_s

  [a_s, b_s, c_s].each do |sym|
    if [a_s, b_s, c_s].select { |num| sym == num }.length == 3
      res = :equilateral
    elsif [a_s, b_s, c_s].select { |num| sym == num }.length == 2
      res = :isosceles
    end
  end
  res = :scalene if res == 0

  res
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
