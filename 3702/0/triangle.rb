def triangle(a_side, b_side, c_side)
  side_no_min_zero(a_side, b_side, c_side)
  two_side_more3(a_side, b_side, c_side)
  angle_model(a_side, b_side, c_side)
end

def side_no_min_zero(a_side, b_side, c_side)
  if a_side.negative? || b_side.negative? || c_side.negative?
    raise TriangleError, 'сторона не может быть меньше нуля или равной нулю'
  end
end

def two_side_more3(a_side, b_side, c_side)
  if a_side + b_side <= c_side || a_side + c_side <= b_side || b_side + c_side <= a_side
    raise TriangleError, '2 стороны не могут быть меньше третей'
  end
end

def angle_model(a_side, b_side, c_side)
  return :equilateral if a_side == b_side && b_side == c_side && a_side == c_side
  isosceles(a_side, b_side, c_side)
end

def isosceles(a_side, b_side, c_side)
  a_side == b_side || a_side == c_side || c_side == b_side ? :isosceles : :scalene
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
