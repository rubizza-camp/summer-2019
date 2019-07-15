require 'open-uri'
require 'nokogiri'

class InfoTaker
  attr_reader :adress

  def initialize(adress)
    @adress = adress
    @document = open_doc
    @documnet_for_used_by = open_doc("#{adress}/network/dependents")
  end

  def open_doc(adress = @adress)
    Nokogiri::HTML(::Kernel.open(adress))
  end

  def take_info
    infos = [used_by, contributors, issues, stars, watch, forks]
    infos.map! do |value|
      value.text.split(' ').first
    end
    @info = infos.unshift(gem_name)
  end

  def gem_name
    @adress.split('/').last
  end

  def used_by
    @documnet_for_used_by.css("a[class='btn-link selected']")[0]
  end

  def contributors
    @document.css("span[class='num text-emphasized']")[3]
  end

  def issues
    @document.css("span[class='Counter']")[0]
  end

  def stars
    @document.css("a[class='social-count js-social-count']")[0]
  end

  def watch
    @document.css("a[class='social-count']")[0]
  end

  def forks
    @document.css("a[class='social-count']")[1]
  end
end
