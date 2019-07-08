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
def triangle(a, b, c)
  if a == b && a == c
      return :equilateral
    elsif a == b || a == c || b == c
      return :isosceles
    else
      return :scalene
  end
end

def check_triangle(a, b, c)
  zero_side = (a * b * c).zero?
  negative_side = (a.negative? || b.negative? || c.negative?)
  less_sides = (a + b <= c || a + c <= b || b + c <= a)
  return zero_side || negative_side || less_sides
end

def triangles(a, b, c)
  triangle_is_right = false if check_triangle(a, b, c)

  raise TriangleError unless triangle_is_right
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
