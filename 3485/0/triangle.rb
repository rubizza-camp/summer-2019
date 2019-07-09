# frozen_string_literal: true

# Triangle Project Code.
# rubocop:disable Performance/RedundantSortBy
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
def triangle(a_side, b_side, c_side)
  # in wiki is written is it better sort_by
  a_side, b_side, c_side = [a_side, b_side, c_side].sort_by { |obj| obj }

  raise TriangleError if a_side.negative?
  raise TriangleError unless a_side + b_side > c_side

  return :equilateral if a_side == c_side

  return :isosceles if a_side == b_side || b_side == c_side

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Performance/RedundantSortBy
