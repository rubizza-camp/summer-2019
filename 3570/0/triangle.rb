# rubocop:disable all
# :reek:FeatureEnvy
def triangle(a_side, b_side, c_side)
  a_side, b_side, c_side = [a_side, b_side, c_side].sort
  raise TriangleError if a_side <= 0 || a_side + b_side <= c_side

  if a_side == b_side && b_side == c_side
    :equilateral
  elsif a_side != b_side && b_side != c_side && a_side != c_side
    :scalene
  else
    :isosceles
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
