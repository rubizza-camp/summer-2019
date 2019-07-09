# frozen_string_literal:true

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

def triangle(aaa, bbb, ccc)
  raise TriangleError if (aaa <= 0) || (bbb <= 0) || (ccc <= 0)
  raise TriangleError if (aaa + bbb <= ccc) || (bbb + ccc <= aaa) || (ccc + aaa <= bbb)

  if (aaa == bbb) & (bbb == ccc)
    :equilateral
  elsif (aaa == bbb) || (bbb == ccc) || (aaa == ccc)
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# comment for hound check commit
