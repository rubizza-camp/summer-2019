# frozen_string_literal: true

# This is helper module
# :reek:UtilityFunction
module Helper
  def gem_name(doc)
    doc.css('.public')[0].text.strip
  end

  def used_by(used_by_link)
    selector = "a[class='btn-link selected']"
    used_by_link.css(selector)[0].text.delete('Repositories').strip
  end

  def watch(doc)
    doc.css('.social-count')[0].text.strip
  end

  def stars(doc)
    doc.css('.social-count')[1].text.strip
  end

  def forks(doc)
    doc.css('.social-count')[2].text.strip
  end

  def contributors(doc)
    doc.css('.text-emphasized')[3].text.strip
  end

  def issues(doc)
    selector = doc.css('.reponav-item')[1].text
    res = selector.strip.delete('Issues') if selector.include?('Issues')
    res.strip
  end

  def delete_comma(strings)
    strings.map! do |string|
      string.delete(',').split(' ')
    end
  end

  def sort(strings)
    str = delete_comma(strings)
    str.sort_by! { |string| string[1].to_i }
  end

  def result_strings(str)
    str.map! do |res|
      part_one = "#{res[0]} | used by #{res[1]} watched by | #{res[2]} |"
      part_two = "| #{res[3]} stars | #{res[4]} forks | #{res[5]} "
      part_three = "contributors | #{res[6]} issues | "
      part_one + part_two + part_three
    end
  end
end
