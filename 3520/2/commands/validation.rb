module Validation
  def check_number!(number)
    File.open('./data/numbers.txt').detect { |known| known.chop == number.to_s }.nil?
  end

  def registered?
    session[:number]
  end
end
