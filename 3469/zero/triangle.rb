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
def check_the_right_variable(a, b, c)
  a * b * c <= 0 || a + b <= c || a + c <= b || c + b <= a ? false : true
end

def triangle_analyzes(a, b, c)
  if a == b && b == c
    :equilateral
  elsif a != b && b != c && a != c
    :scalene
  else
    :isosceles
  end
end

def triangle(a, b, c)
  if check_the_right_variable(a, b, c)
    triangle_analyzes(a, b, c)
  else
    raise TriangleError, 'Wrong parameters'
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
