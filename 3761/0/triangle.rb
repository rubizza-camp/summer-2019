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

def check_error(fir, sec, third)
  raise TriangleError if (fir + sec <= third) || (sec + third <= fir) || (third + fir <= sec)
end
# :reek:FeatureEnvy

def triangle(fir, sec, third)
  check_error(fir, sec, third)
  if (fir == sec) && (sec == third)
    :equilateral
  elsif (fir sec) || (fir == third) || (sec == third)
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
