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
def triangle(val_a, val_b, val_c)
  check_on_error(val_a, val_b, val_c)
  if val_a == val_b && val_a == val_c
    :equilateral
  elsif val_a == val_b || val_a == val_c || val_b == val_c
    :isosceles
  else
    :scalene
  end
end

# :reek:FeatureEnvy
def check_on_error(val_a, val_b, val_c)
  raise TriangleError if val_a <= 0 || val_b <= 0 || val_c <= 0
  product = (val_a + val_b + val_c) / 2.0
  raise TriangleError if ((product - val_a) * (product - val_b) * (product - val_c)) <= 0
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
