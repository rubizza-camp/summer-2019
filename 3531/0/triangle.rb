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
def triangle(a_val, b_val, c_val)
  raise TriangleError if [a_val, b_val, c_val].min <= 0

  x_val, y_val, z_val = [a_val, b_val, c_val].sort

  raise TriangleError if x_val + y_val <= z_val

  %i[equilateral isosceles scalene].fetch([a_val, b_val, c_val].uniq.size - 1)

  define_type(a_val, b_val, c_val)
end

def define_type(a_val, b_val, c_val)
  if a_val.eql?(b_val) && b_val.eql?(c_val) && c_val.eql?(a_val)
    :equilateral
  elsif a_val.eql?(b_val) || b_val.eql?(c_val) || c_val.eql?(a_val)
    :isosceles
  elsif a_val != b_val && b_val != c_val && c_val != a_val
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
