def triangle(a_side, b_side, c_side)
  a_s, b_s, c_s = [a_side, b_side, c_side].sort
  side_no_min_zero(a_s)
  two_side_more3(a_s, b_s, c_s)
  angle_model(a_side, b_side, c_side)
end

def side_no_min_zero(a_s)
  raise TriangleError unless a_s.positive?
end

def two_side_more3(a_s, b_s, c_s)
  raise TriangleError if a_s + b_s <= c_s
end

def angle_model(a_side, b_side, c_side)
  return :equilateral if a_side == b_side && b_side == c_side

  isosceles(a_side, b_side, c_side)
end

def isosceles(a_side, b_side, c_side)
  a_side == b_side || a_side == c_side || c_side == b_side ? :isosceles : :scalene
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
