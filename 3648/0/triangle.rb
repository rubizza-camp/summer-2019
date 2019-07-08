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
def triangle(arg, brg, crg)
  raise TriangleError if [arg, brg, crg].min <= 0

  xrb, yrb, zrb = [arg, brg, crg].sort
  raise TriangleError if xrb + yrb <= zrb

  %i[equilateral isosceles scalene].fetch([arg, brg, crg].uniq.size - 1)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
