module NumberMethods
  def self.valid_number?(person_number)
    File.open('./data/users.yml', 'r').read.split("\n").include?(person_number)
  end
end
