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
def triangle(var_a, var_b, var_c)
  side = [var_a, var_b, var_c].sort

  raise TriangleError, 'No negative' if side.any? { |s| s <= 0 }
  raise TriangleError, 'Triangle fails' unless (side[0] + side[1]) > side[2]

  uniqueside = side.uniq.length
  types = [nil, :equilateral, :isosceles, :scalene]
  types[uniqueside]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
