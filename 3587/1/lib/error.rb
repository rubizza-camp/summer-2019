class FileError < StandardError
  def initialize(msg = 'Error')
    super
    abort msg
  end
end

class MechanizeError < StandardError
  def initialize(msg = 'Error')
    super(msg)
    puts msg
  end
end
