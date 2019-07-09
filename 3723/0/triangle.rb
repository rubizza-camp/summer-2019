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
  a_s, b_s, c_s = [a_s, b_s, c_s].sort
  raise TriangleError unless a_s.positive?
  raise TriangleError unless a_s + b_s > c_s
  return :equilateral if a_s == c_s
  return :isosceles if a_s == b_s || b_s == c_s

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
