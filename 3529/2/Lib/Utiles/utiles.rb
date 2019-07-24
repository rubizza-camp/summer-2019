class Statements
  def self.all
    [Coordinates, Selfie]
  end
end

Statement = Struct.new(:message)

class Selfie < Statement
  def self.match?(_message)
    true
  end
end

class Coordinates < Statement
  def self.match?(message)
    message
  end
end

class StatementFactory
  def self.build(message)
    Statements.all.detect { |massage| massage.match?(message) }.new(message)
  end
end
