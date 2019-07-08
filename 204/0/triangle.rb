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
def triangle(hyp, side1, side2)
  error(hyp, side1, side1)
  if hyp.eql?(side1) && side1.eql?(side2) && side2.eql?(hyp)
    :equilateral
  elsif hyp.eql?(side1) | side1.eql?(side2) | side2.eql?(hyp)
    :isosceles
  else
    :scalene
  end
end

def error(hyp, side1, side2)
  raise TriangleError if
    [hyp, side1, side2].include?(0) ||
    hyp + side1 <= side2 || side1 + side2 <= hyp || side2 + hyp <= side1
end
# Error class used in part 2.  No need to change this code.

class TriangleError < StandardError
end
