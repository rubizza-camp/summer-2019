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
# def triangle(side_a, side_b, side_c)

# :reek:UtilityFunction

def triangle_sides(side_a, side_b, side_c)
  if side_a.eql?(side_b) && side_b.eql?(side_c) && side_c.eql?(side_a)
    :equilateral
  elsif side_a.eql?(side_b) | side_b.eql?(side_c) | side_c.eql?(side_a)
    :isosceles
  else
    :scalene
  end
end

def triangle(side_a, side_b, side_c)
  raise TriangleError if
  [side_a, side_b, side_c].include?(0) ||
  side_a + side_b <= side_c ||
  side_b + side_c <= side_a ||
  side_c + side_a <= side_b

  triangle_sides(side_a, side_b, side_c)
end
# Error class used in part 2.  No need to change this code.

class TriangleError < StandardError; end
