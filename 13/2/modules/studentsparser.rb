# frozen_string_literal: true

class StudentsParser

  attr_reader :list_numbers

  def parse
    list_numbers = []
    numbers = Nokogiri::HTML(HTTParty.get('https://github.com/rubizza-camp/summer-2019'))
    numbers = numbers.css('span.css-truncate.css-truncate-target a.js-navigation-open').each do |number| 
      number = number.text.to_i
      list_numbers << number if number != 0
    end
    list_numbers
  end
end
