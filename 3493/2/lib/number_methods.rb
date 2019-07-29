class NumberMethods
  def self.valid_number?(person_number)
    File.open('data/numbers', 'r').read.split("\n").include?(person_number)
  end
end
