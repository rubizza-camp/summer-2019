# frozen_string_literal: true

# class parses Github repo to extract list of students
class StudentsParser
  def self.students_list
    numbers = Nokogiri::HTML(HTTParty.get('https://github.com/rubizza-camp/summer-2019'))
    numbers.css('span.css-truncate.css-truncate-target a.js-navigation-open').map do |number|
      number.text.to_i
    end.select { |number| number > 0 }
  end
end
