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
# :reek:UtilityFunction
def triangle_type(side_a, side_b, side_c)
  arr_side = [side_a, side_b, side_c].uniq.size
  if arr_side == 1
    :equilateral
  elsif arr_side == 2
    :isosceles
  else
    :scalene
  end
end

def triangle(side_a, side_b, side_c)
  side_a, side_b, side_c = [side_a, side_b, side_c].sort
  raise TriangleError if side_c >= side_a + side_b

  triangle_type(side_a, side_b, side_c)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
