class Base
  def self.call(*args)
    new(*args).call
  end

  def success(value)
    { value: value, success: true }
  end

  def error(value)
    { value: value, success: false }
  end
end
