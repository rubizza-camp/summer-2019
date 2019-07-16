require 'nokogiri'

module Taker
  private

  def score(row)
    row.map do |str|
      str.split(/[^\d]/).join.to_i
    end.sum
  end

  def names(rest)
    rest.css('head > title').text[%r{\/(.*?):}, 1]
  end

  def depen(doc)
    doc.css('.btn-link').css('.selected').text.split(/[^\d]/).join
  end

  def watch(rest)
    rest.css('.social-count').first.text.strip
  end

  def star(rest)
    rest.css('.social-count').css('.js-social-count').last.text.strip
  end

  def forks(rest)
    rest.css('.social-count').last.text.strip
  end

  def contributors(rest)
    rest.css('.num').css('.text-emphasized').last.text.strip
  end

  def issues(rest)
    rest.css('.Counter').first.text.strip
  end
end
