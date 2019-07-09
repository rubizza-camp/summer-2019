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
# :reek:disable
def check_sides_sums(fst, snd, thrd)
  fst + snd > thrd && fst + thrd > snd && snd + thrd > fst
end

def validate_sides(fst, snd, thrd)
  fst.positive? && snd.positive? && thrd.positive?
end

def isosceles?(fst, snd, thrd)
  fst == snd || fst == thrd || snd == thrd
end

def triangle(fst, snd, thrd)
  raise TriangleError if !validate_sides(fst, snd, thrd) || !check_sides_sums(fst, snd, thrd)

  return :equilateral if fst == snd && snd == thrd
  return :isosceles if isosceles?(fst, snd, thrd)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# :reek:enable
