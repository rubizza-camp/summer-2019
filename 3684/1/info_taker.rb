require 'open-uri'
require 'nokogiri'

class InfoTaker
  attr_reader :adress

  def initialize(adress)
    @adress = adress
    @document = open_doc
    @documnet_for_used_by = open_doc("#{adress}/network/dependents")
    @info = {}
  end

  def take_info
    @info.store(:used_by, used_by)
    parse_adresses
  end

  private

  def open_doc(adress = @adress)
    Nokogiri::HTML(::Kernel.open(adress))
  end

  def parse_adresses
    parse_htm
    @info.each_pair.with_object({}) do |(name, value), obj|
      obj[:gem_name] = gem_name
      obj[name] = value.text.split(' ').first
    end
  end

  def parse_htm
    element_adresses = {
      contributors: { css_path: "span[class='num text-emphasized']", index: 3 },
      issues: { css_path: "span[class='Counter']", index: 0 },
      stars: { css_path: "a[class='social-count js-social-count']", index: 0 },
      watch: { css_path: "a[class='social-count']", index: 0 },
      forks: { css_path: "a[class='social-count']", index: 1 }
    }
    element_adresses.each_pair do |element_name, hash|
      @info[element_name] = @document.css(hash[:css_path])[hash[:index]]
    end
  end

  def gem_name
    @adress.split('/').last
  end

  def used_by
    @documnet_for_used_by.css("a[class='btn-link selected']")[0]
  end
end
