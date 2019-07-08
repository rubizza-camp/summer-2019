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
  raise TriangleError, 'TriangleError' if (a <= 0) || (b <= 0) || (c <= 0)
  raise TriangleError, 'TriangleError' unless is_a_triangle(a, b, c)
  return :equilateral if a.eql?(b) && b.eql?(c)
  if a.eql?(b) || a.eql?(c) || b.eql?(c)
    return :isosceles
  else
    return :scalene
  end
  # WRITE THIS CODE
end

def is_a_triangle(a, b, c)
  if (a + b <= c) || (a + c <= b) || (b + c <= a)
    false
  else
    true
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
