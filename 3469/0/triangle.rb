# Triangle Project Code.

# Triangle analyzes the lengths of the sides of triangle_a triangle
# (represented by triangle_a, triangle_b and triangle_c) and returns the type of triangle.
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
def check_variable(tr_a, tr_b, tr_c)
  tr_a * tr_b * tr_c <= 0 || tr_a + tr_b <= tr_c || tr_a + tr_c <= tr_b || tr_c + tr_b <= tr_a
end

def triangle_analyzes(tr_a, tr_b, tr_c)
  if tr_a == tr_b && tr_b == tr_c
    :equilateral
  elsif tr_a != tr_b && tr_b != tr_c && tr_a != tr_c
    :scalene
  else
    :isosceles
  end
end

def triangle(tr_a, tr_b, tr_c)
  return raise TriangleError, 'Wrong parameters' if check_variable(tr_a, tr_b, tr_c)
  triangle_analyzes(tr_a, tr_b, tr_c)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
