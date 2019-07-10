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
# :reek:FeatureEnvy
def triangle(fir, sec, thi)
  invalid_traingle?(fir, sec, thi)
  if fir == sec && sec == thi
    :equilateral
  elsif fir == sec || fir == thi || sec == thi
    :isosceles
  else
    :scalene
  end
end

# :reek:FeatureEnvy
def invalid_traingle?(fir, sec, thi)
  sum = (fir + sec + thi) / 2.0
  sides = (sum - fir) * (sum - sec) * (sum - thi)
  raise TriangleError if fir <= 0 || sec <= 0 || thi <= 0 || sides <= 0
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
