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

# :reek:FeatureEnvy
def triangle(arg_a, arg_b, agg_c)
  arg_a, arg_b, agg_c = [arg_a, arg_b, agg_c].sort
  raise TriangleError if (arg_a <= 0) || (arg_a + arg_b <= agg_c)
  return :equilateral if arg_a == agg_c
  return :isosceles if (arg_a == arg_b) || (arg_b == agg_c)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
