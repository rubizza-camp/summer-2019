# This class expand String class

class String
  def squish!
    gsub!(/\A[[:space:]]+/, '')
    gsub!(/[[:space:]]+\z/, '')
    gsub!(/[[:space:]]+/, ' ')
    self
  end
end
