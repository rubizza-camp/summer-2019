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
# :reek:TooManyStatements
def triangle(a_var, b_var, c_var)
  uniq_side_length = [a_var, b_var, c_var].uniq.length
  raise TriangleError if [a_var, b_var, c_var].min <= 0
  x_var, y_var, z_var = [a_var, b_var, c_var].sort
  raise TriangleError if x_var + y_var <= z_var
  return :equilateral if uniq_side_length == 1
  return :isosceles if uniq_side_length == 2
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
